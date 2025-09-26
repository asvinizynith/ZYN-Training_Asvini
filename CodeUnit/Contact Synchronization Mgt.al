codeunit 50128 "ZYN_Contact Synchronize Mgt"
{
    var
        MyCompany: Record "ZYN_Companies Table";
        IsSyncing: Boolean;

    local procedure IsMasterCompany(): Boolean
    var
        MyCompany: Record "ZYN_Companies Table";
    begin
        if MyCompany.Get(CompanyName()) then
            exit(MyCompany.IsMaster); // Assuming "IsMaster" is your Boolean field
        exit(false); // default: not master
    end;

    // Contact Creation //

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnBeforeInsertEvent', '', false, false)]
    local procedure BlockInsertInSlaveCompanies(var Rec: Record Contact; RunTrigger: Boolean)

    begin
        if not MyCompany.Get(CompanyName) then
            Error(CompanyNotFoundErr);

        if not IsMasterCompany() then
            Error(ContactInsertErr);
    end;

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterInsertEvent', '', false, false)]
    local procedure InsertContactToSlavesCompany(var Rec: Record Contact; RunTrigger: Boolean)
    begin

        SyncContactToSlaves(Rec);

    end;

    // Contact Modification //
    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnBeforeModifyEvent', '', false, false)]
    local procedure PreventUserModifyInSlaveCompanies(var Rec: Record Contact; var xRec: Record Contact; RunTrigger: Boolean)
    var
        MyCompany: Record "ZYN_Companies Table";
    begin
        // Get current company setup
        if not MyCompany.Get(CompanyName()) then
            exit;

        // Master company → always allow
        if MyCompany.IsMaster then
            exit;

        // Slave company logic
        if not MyCompany.IsMaster then begin
            // If modification is triggered by user (RunTrigger = true)
            if RunTrigger then
                Error(ContactModifyErr);
        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyContact(var Rec: Record Contact; var xRec: Record Contact; RunTrigger: Boolean)

    var
        SlaveCompany: Record "ZYN_Companies Table";
        MyCompany: Record "ZYN_Companies Table";
        Contact: Record Contact;
        MasterRef: RecordRef;
        SlaveRef: RecordRef;
        FieldMaster: FieldRef;
        FieldSlave: FieldRef;
        i: Integer;
        IsDifferent: Boolean;
    begin
        // 1. Ensure current company exists in your mapping
        if not MyCompany.Get(CompanyName()) then
            exit;
        if not IsMasterCompany() then
            exit;

        // 3. Prevent recursion
        if IsSyncing then
            exit;
        IsSyncing := true;

        // 4. Loop through slave companies
        SlaveCompany.Reset();
        SlaveCompany.SetRange("Master Company Name", MyCompany.Name);
        if SlaveCompany.FindSet() then
            repeat
                if SlaveCompany."Name" <> '' then begin
                    if Contact.ChangeCompany(SlaveCompany."Name") then begin
                        if Contact.Get(Rec."No.") then begin
                            // Open slave record as RecordRef
                            MasterRef.GetTable(Rec);
                            SlaveRef.GetTable(Contact);
                            IsDifferent := false;
                            // Copy all fields except primary key
                            for i := 1 to MasterRef.FieldCount do begin
                                FieldMaster := MasterRef.FieldIndex(i);
                                if FieldMaster.Class <> FieldClass::Normal then
                                    continue;
                                if FieldMaster.Number in [1] then
                                    continue;
                                // Skip primary key "No."
                                FieldSlave := SlaveRef.Field(FieldMaster.Number);
                                if FieldSlave.Value <> FieldMaster.Value then begin
                                    IsDifferent := true;
                                    break;
                                end;
                            end;
                            if IsDifferent then begin

                                Contact.TransferFields(Rec, false);
                                Contact."No." := Rec."No.";
                                Contact.Modify(true);
                            end;

                        end;

                    end;

                end;
            until SlaveCompany.Next() = 0;
        IsSyncing := false;
    end;

    // Contact Deletion Validation//
    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnBeforeDeleteEvent', '', false, false)]
    local procedure PreventDeleteIfOpenOrders(var Rec: Record Contact; RunTrigger: Boolean)
    var
        MyCompany: Record "ZYN_Companies Table";
        SlaveCompany: Record "ZYN_Companies Table";
        ContactBusRel: Record "Contact Business Relation";
        SalesHeader: Record "Sales Header";
        PurchaseHeader: Record "Purchase Header";
    begin
        if not MyCompany.Get(CompanyName()) then
            exit;
        if not IsMasterCompany() then
            Error(ContactDeleteErr);
        if IsSyncing then
            exit; // Prevent recursion
        IsSyncing := true;
        // Loop through all slave companies
        SlaveCompany.SetRange(IsMaster, false);
        SlaveCompany.SetFilter("Master Company Name", '%1', MyCompany.Name);

        if SlaveCompany.FindSet() then
            repeat
                //  Switch context to slave company
                ContactBusRel.ChangeCompany(SlaveCompany.Name);
                SalesHeader.ChangeCompany(SlaveCompany.Name);
                PurchaseHeader.ChangeCompany(SlaveCompany.Name);
                // Check relation for the contact
                ContactBusRel.Reset();
                ContactBusRel.SetRange("Contact No.", Rec."No.");
                if ContactBusRel.FindSet() then
                    repeat
                        case ContactBusRel."Link to Table" of
                            ContactBusRel."Link to Table"::Customer:
                                begin
                                    SalesHeader.Reset();
                                    SalesHeader.SetRange("Sell-to Customer No.", ContactBusRel."No.");
                                    SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
                                    SalesHeader.SetFilter(Status, '%1|%2', SalesHeader.Status::Open, SalesHeader.Status::Released);
                                    if SalesHeader.FindFirst() then
                                        Error(ContactOpenCustomerErr, Rec."No.", SlaveCompany.Name, SalesHeader.Status);
                                end;

                            ContactBusRel."Link to Table"::Vendor:
                                begin
                                    PurchaseHeader.Reset();
                                    PurchaseHeader.SetRange("Buy-from Vendor No.", ContactBusRel."No.");
                                    PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Invoice);
                                    PurchaseHeader.SetFilter(Status, '%1|%2', PurchaseHeader.Status::Open, PurchaseHeader.Status::Released);
                                    if PurchaseHeader.FindFirst() then
                                        Error(ContactOpenVendorErr, Rec."No.", SlaveCompany.Name, PurchaseHeader.Status);
                                end;
                        end;

                    until ContactBusRel.Next() = 0;
            until SlaveCompany.Next() = 0;

        IsSyncing := false;
        //  If no open orders found anywhere → deletion continues //
    end;

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterDeleteEvent', '', false, false)]
    local procedure SyncDeleteToSlaves(var Rec: Record Contact)
    var
        MyCompany: Record "ZYN_Companies Table";
        SlaveCompany: Record "ZYN_Companies Table";
        Contact: Record Contact;
        Customer: Record Customer;
        Vendor: Record Vendor;
        ContactBusRel: Record "Contact Business Relation";
    begin
        if not MyCompany.Get(CompanyName()) then
            exit;
        if not IsMasterCompany() then
            exit;
        if IsSyncing then
            exit; // prevent recursion

        IsSyncing := true;

        SlaveCompany.SetRange(IsMaster, false);
        SlaveCompany.SetFilter("Master Company Name", '%1', MyCompany.Name);

        if SlaveCompany.FindSet() then
            repeat
                // Switch context to each slave company
                Contact.ChangeCompany(SlaveCompany.Name);
                Customer.ChangeCompany(SlaveCompany.Name);
                Vendor.ChangeCompany(SlaveCompany.Name);
                ContactBusRel.ChangeCompany(SlaveCompany.Name);

                // 1️.Delete relations in Contact Business Relation first
                ContactBusRel.Reset();
                ContactBusRel.SetRange("Contact No.", Rec."No.");
                if ContactBusRel.FindSet() then
                    repeat
                        case ContactBusRel."Link to Table" of
                            // 2.Delete related Customer (if exists)
                            ContactBusRel."Link to Table"::Customer:
                                if Customer.get(ContactBusRel."No.") then
                                    Customer.Delete(true);
                            // 3️.Delete related Vendor (if exists)
                            ContactBusRel."Link to Table"::Vendor:
                                if Vendor.get(ContactBusRel."No.") then
                                    Vendor.Delete(true);
                        end;
                        ContactBusRel.Delete(true);
                    until ContactBusRel.Next() = 0;
                // 4️.Delete Contact itself
                if Contact.Get(Rec."No.") then
                    Contact.Delete(true);

            until SlaveCompany.Next() = 0;

        IsSyncing := false;
    end;

    local procedure SyncContactToSlaves(var Rec: Record Contact)
    var
        SlaveCompany: Record "ZYN_Companies Table";
        MyCompany: Record "ZYN_Companies Table";
        Contact: Record Contact;
    begin
        if IsSyncing then
            exit;// already syncing
        if not IsMasterCompany() then
            exit;
        IsSyncing := true;
        if not MyCompany.Get(CompanyName()) then begin
            IsSyncing := false;
            exit;
        end;

        SlaveCompany.SetRange(IsMaster, false);
        SlaveCompany.SetFilter("Master Company Name", '%1', MyCompany.Name);
        if SlaveCompany.FindSet() then
            repeat
                Contact.ChangeCompany(SlaveCompany.Name);
                if not Contact.Get(Rec."No.") then begin
                    Contact.Init();
                    Contact.TransferFields(Rec, true);
                    Contact."No." := Rec."No.";
                    Contact.Insert(true);
                end;

            until SlaveCompany.Next() = 0;
        IsSyncing := false;
    end;

    var
        ContactInsertErr: Label 'Contact creation is only allowed in the Master Company.';
        ContactModifyErr: Label 'Contact Modification is only allowed in the Master Company.';
        ContactDeleteErr: Label 'Contact Deletion is only allowed in the Master Company.';
        CompanyNotFoundErr: Label 'Company Not Found';
        ContactOpenCustomerErr: Label 'Contact %1 cannot be deleted because it has open Sales Orders in company %2.';
        ContactOpenVendorErr: Label 'Contact %1 cannot be deleted because it has open Purchase Orders in company %2.';
}
