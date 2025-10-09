codeunit 50133 "ZYN_CustVend Synchronize Mgt"
{
    var
        CompanySetup: Record "ZYN_Companies Table";
        IsSyncing: Boolean;
        SyncCU: Codeunit "Zyn_CustomerVendorContactSync";
        SingleInstanceMgt: Codeunit "ZYN_Single Instance Management";

    // ------------------------------
    // Helper: is current company configured as Master
    local procedure IsMasterCompany(): Boolean
    var
        Comp: Record "ZYN_Companies Table";
    begin
        if Comp.Get(CompanyName()) then
            exit(Comp.IsMaster);
        exit(false);
    end;

    //  CUSTOMER: BEFORE INSERT / BEFORE MODIFY
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeInsertEvent', '', false, false)]
    local procedure Customer_OnBeforeInsertSetPrimaryContact(var Rec: Record Customer; RunTrigger: Boolean)
    var
        ContactRec: Record Contact;
    begin
        // Prevent creation in slave companies
        if not CompanySetup.Get(CompanyName()) then
            Error(ErrCompanyNotFound);
        if not CompanySetup.IsMaster then
            Error(ErrCustomerCreation);

        // Auto-link primary contact by Name (set on buffer, no Modify call)
        if Rec."Primary Contact No." = '' then begin
            if ContactRec.FindFirst() then begin
                // We'll loop to find case-insensitive name match
                ContactRec.Reset();
                if ContactRec.FindSet() then
                    repeat
                        if (ContactRec.Name <> '') and (Rec.Name <> '') and (UpperCase(ContactRec.Name) = UpperCase(Rec.Name)) then begin
                            Rec.Validate("Primary Contact No.", ContactRec."No.");
                            break;
                        end;
                    until ContactRec.Next() = 0;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeModifyEvent', '', false, false)]
    local procedure Customer_OnBeforeModifySetPrimaryContact(var Rec: Record Customer; var xRec: Record Customer; RunTrigger: Boolean)
    var
        ContactRec: Record Contact;
    begin
        // Prevent modification in slave companies by users
        if not CompanySetup.Get(CompanyName()) then
            exit;
        if not CompanySetup.IsMaster then begin
            if RunTrigger then
                Error(ErrCustomerModification)
            else
                exit;
            if SingleInstanceMgt.GetFromCreateAs() then begin
                SingleInstanceMgt.ClearCreateAs();
                exit;
            end;
        end;

        // Auto-link primary contact by Name (set on buffer, no Modify call)
        if Rec."Primary Contact No." = '' then begin
            ContactRec.Reset();
            if ContactRec.FindSet() then
                repeat
                    if (ContactRec.Name <> '') and (Rec.Name <> '') and (UpperCase(ContactRec.Name) = UpperCase(Rec.Name)) then begin
                        Rec.Validate("Primary Contact No.", ContactRec."No.");
                        break;
                    end;
                until ContactRec.Next() = 0;
        end;
    end;


    //  CUSTOMER: AFTER INSERT / AFTER MODIFY
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterInsertEvent', '', false, false)]
    local procedure Customer_OnAfterInsertSync(var Rec: Record Customer; RunTrigger: Boolean)
    var
        SlaveCompany: Record "ZYN_Companies Table";
        Mycompany: Record "ZYN_Companies Table";
    begin
        if Rec.IsTemporary then
            exit;
        if not Mycompany.Get(CompanyName()) then
            exit;
        // Only master company should initiate sync
        if not IsMasterCompany() then
            exit;
        if SingleInstanceMgt.GetIsSyncing() then
            exit;
        SingleInstanceMgt.SetIsSyncing(true);
        SlaveCompany.SetRange(IsMaster, false);
        SlaveCompany.SetFilter("Master Company Name", '%1', CompanyName());
        if SlaveCompany.FindSet() then
            repeat
                // call your existing sync codeunit to sync this customer to the slave
                SyncCU.SyncCustomer(Rec."No.", SlaveCompany.Name);
            until SlaveCompany.Next() = 0;
        SingleInstanceMgt.ClearIsSyncing();
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterModifyEvent', '', false, false)]
    local procedure Customer_OnAfterModifySync(var Rec: Record Customer; var xRec: Record Customer; RunTrigger: Boolean)
    var
        SlaveCompany: Record "ZYN_Companies Table";
        MyCompany: Record "ZYN_Companies Table";
        Customer: Record Customer;
        MasterRef: RecordRef;
        SlaveRef: RecordRef;
        FieldMaster: FieldRef;
        FieldSlave: FieldRef;
        i: Integer;
        IsDifferent: Boolean;
    begin
        if Rec.IsTemporary then
            exit;
        // 1. Ensure current company exists in your mapping
        if not MyCompany.Get(CompanyName()) then
            exit;
        if not IsMasterCompany() then
            exit;
        if SingleInstanceMgt.GetIsSyncing() then
            exit;

        // 3. Prevent recursion
        SingleInstanceMgt.SetIsSyncing(true);
        // 4. Loop through slave companies
        SlaveCompany.Reset();
        SlaveCompany.SetRange("Master Company Name", MyCompany.Name);
        if SlaveCompany.FindSet() then
            repeat
                if Customer.ChangeCompany(SlaveCompany."Name") then begin
                    if Customer.Get(Rec."No.") then begin
                        // Open slave record as RecordRef
                        MasterRef.GetTable(Rec);
                        SlaveRef.GetTable(Customer);
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
                            Customer.TransferFields(Rec, true);
                            Customer."No." := Rec."No.";
                            Customer.Modify(false);
                        end;
                    end else begin
                        // Customer doesn't exist in slave → insert
                        Customer.Init();
                        Customer.TransferFields(rec, true);
                        Customer."No." := Rec."No.";
                        Customer.Insert(false);
                    end;
                end;
                if Rec."Primary Contact No." <> '' then
                    SyncCU.SyncCustomerContactBusinessRelation(Rec, SlaveCompany.Name);

            until SlaveCompany.Next() = 0;

        SingleInstanceMgt.ClearIsSyncing();
    end;

    // CUSTOMER: BEFORE DELETE / AFTER DELETE 
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeDeleteEvent', '', false, false)]
    local procedure Customer_OnBeforeDelete(var Rec: Record Customer; RunTrigger: Boolean)
    begin
        if not CompanySetup.Get(CompanyName()) then
            exit;
        if not CompanySetup.IsMaster then
            Error(ErrCustomerDeletion);
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterDeleteEvent', '', false, false)]
    local procedure Customer_OnAfterDelete(var Rec: Record Customer)
    var
        SlaveCompany: Record "ZYN_Companies Table";
        MyCompany: Record "ZYN_Companies Table";
        CustomerSlave: Record Customer;
        ContactBusInSlave: Record "Contact Business Relation";
        MasterContact: Record contact;
        SlaveContact: Record Contact;
        ContactBusInMaster: Record "Contact Business Relation";
    begin
        if not MyCompany.Get(CompanyName()) then
            exit;
        if not IsMasterCompany() then
            exit;
        if SingleInstanceMgt.GetIsSyncing() then
            exit;
        SingleInstanceMgt.SetIsSyncing(true);
        //Delete in all slave companies
        SlaveCompany.SetRange(IsMaster, false);
        SlaveCompany.SetFilter("Master Company Name", '%1', CompanyName());
        if SlaveCompany.FindSet() then
            repeat
                if CustomerSlave.ChangeCompany(SlaveCompany.Name) then
                    if CustomerSlave.Get(Rec."No.") then
                        CustomerSlave.Delete(true); // force delete in slave

                // Also delete Customer business relation in slave
                if ContactBusInSlave.ChangeCompany((SlaveCompany.Name)) then begin
                    ContactBusInSlave.SetRange("Link to Table", ContactBusInSlave."Link to Table"::Customer);
                    ContactBusInSlave.SetRange("No.", Rec."No.");
                    if ContactBusInSlave.FindSet() then
                        repeat
                            if SlaveContact.ChangeCompany(SlaveCompany.Name) then
                                if SlaveContact.Get(ContactBusInSlave."Contact No.") then begin
                                    ContactBusInSlave.Delete();
                                    SlaveContact.UpdateBusinessRelation();
                                    SlaveContact.Modify();
                                end;
                        until ContactBusInSlave.Next() = 0;
                end;
            until SlaveCompany.Next() = 0;

        //  Master: Remove Customer business relation
        ContactBusInMaster.SetRange("Link to Table", ContactBusInMaster."Link to Table"::Customer);
        ContactBusInMaster.SetRange("No.", Rec."No.");
        if ContactBusInMaster.FindSet() then
            repeat
                if MasterContact.Get(ContactBusInMaster."Contact No.") then begin
                    ContactBusInMaster.Delete();
                    MasterContact.UpdateBusinessRelation();
                    MasterContact.Modify();
                end;
            until ContactBusInMaster.Next() = 0;

        SingleInstanceMgt.ClearIsSyncing();
    end;


    //  VENDOR: BEFORE INSERT / BEFORE MODIFY 
    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnBeforeInsertEvent', '', false, false)]
    local procedure Vendor_OnBeforeInsertSetPrimaryContact(var Rec: Record Vendor; RunTrigger: Boolean)
    var
        ContactRec: Record Contact;
    begin
        // Prevent creation in slaves
        if not CompanySetup.Get(CompanyName()) then
            Error(ErrCompanyNotFound);
        if not CompanySetup.IsMaster then
            Error(ErrVendorCreation);

        // Auto-link primary contact by Name (set on buffer)
        if Rec."Primary Contact No." = '' then begin
            ContactRec.Reset();
            if ContactRec.FindSet() then
                repeat
                    if (ContactRec.Name <> '') and (Rec.Name <> '') and (UpperCase(ContactRec.Name) = UpperCase(Rec.Name)) then begin
                        Rec.Validate("Primary Contact No.", ContactRec."No.");
                        break;
                    end;
                until ContactRec.Next() = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnBeforeModifyEvent', '', false, false)]
    local procedure Vendor_OnBeforeModifySetPrimaryContact(var Rec: Record Vendor; var xRec: Record Vendor; RunTrigger: Boolean)
    var
        ContactRec: Record Contact;
    begin
        if not CompanySetup.Get(CompanyName()) then
            exit;
        if not CompanySetup.IsMaster then begin
            if RunTrigger then
                Error(ErrVendorModification)
            else
                exit;
            if SingleInstanceMgt.GetFromCreateAs() then begin
                SingleInstanceMgt.ClearCreateAs();
                exit;
            end;
        end;

        // Auto-link primary contact by Name (set on buffer)
        if Rec."Primary Contact No." = '' then begin
            ContactRec.Reset();
            if ContactRec.FindSet() then
                repeat
                    if (ContactRec.Name <> '') and (Rec.Name <> '') and (UpperCase(ContactRec.Name) = UpperCase(Rec.Name)) then begin
                        Rec.Validate("Primary Contact No.", ContactRec."No.");
                        break;
                    end;
                until ContactRec.Next() = 0;
        end;
    end;


    // VENDOR: AFTER INSERT / AFTER MODIFY
    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnAfterInsertEvent', '', false, false)]
    local procedure Vendor_OnAfterInsertSync(var Rec: Record Vendor; RunTrigger: Boolean)
    var
        SlaveCompany: Record "ZYN_Companies Table";
        MyCompany: Record "ZYN_Companies Table";
    begin
        if Rec.IsTemporary then
            exit;
        if not MyCompany.Get(CompanyName()) then
            exit;
        if not IsMasterCompany() then
            exit;
        if SingleInstanceMgt.GetIsSyncing() then
            exit;
        SingleInstanceMgt.SetIsSyncing(true);

        SlaveCompany.SetRange(IsMaster, false);
        SlaveCompany.SetFilter("Master Company Name", '%1', CompanyName());
        if SlaveCompany.FindSet() then
            repeat
                SyncCU.SyncVendor(Rec."No.", SlaveCompany.Name);
            until SlaveCompany.Next() = 0;

        SingleInstanceMgt.ClearIsSyncing();
    end;

    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnAfterModifyEvent', '', false, false)]
    local procedure Vendor_OnAfterModifySync(var Rec: Record Vendor; var xRec: Record Vendor; RunTrigger: Boolean)
    var
        SlaveCompany: Record "ZYN_Companies Table";
        MyCompany: Record "ZYN_Companies Table";
        Vendor: Record Vendor;
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
        if SingleInstanceMgt.GetIsSyncing() then
            exit;
        SingleInstanceMgt.SetIsSyncing(true);
        // 4. Loop through slave companies
        SlaveCompany.Reset();
        SlaveCompany.SetRange("Master Company Name", MyCompany.Name);
        if SlaveCompany.FindSet() then
            repeat
                if Vendor.ChangeCompany(SlaveCompany."Name") then begin
                    if Vendor.Get(Rec."No.") then begin
                        // Open slave record as RecordRef
                        MasterRef.GetTable(Rec);
                        SlaveRef.GetTable(Vendor);
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
                            Vendor.TransferFields(Rec, true);
                            Vendor."No." := Rec."No.";
                            Vendor.Modify(false);
                        end;

                    end else begin
                        Vendor.Init();
                        Vendor.TransferFields(Rec);
                        Vendor."No." := Rec."No.";
                        Vendor.Insert(false);
                    end;
                end;
                // Sync linked Contact as well if exists
                if Rec."Primary Contact No." <> '' then
                    SyncCU.SyncVendorContactBusinessRelation(Rec, SlaveCompany.Name);
            until SlaveCompany.Next() = 0;
        SingleInstanceMgt.ClearIsSyncing();
    end;


    //VENDOR: BEFORE DELETE / AFTER DELETE 
    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnBeforeDeleteEvent', '', false, false)]
    local procedure Vendor_OnBeforeDelete(var Rec: Record Vendor; RunTrigger: Boolean)
    begin
        if not CompanySetup.Get(CompanyName()) then
            exit;
        if not CompanySetup.IsMaster then
            Error(ErrVendorDeletion);
    end;

    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnAfterDeleteEvent', '', false, false)]
    local procedure Vendor_OnAfterDelete(var Rec: Record Vendor)
    var
        SlaveCompany: Record "ZYN_Companies Table";
        VendorSlave: Record Vendor;
        MyCompany: Record "ZYN_Companies Table";
        ContactBusInSlave: Record "Contact Business Relation";
        ContactBusInMaster: Record "Contact Business Relation";
        SlaveContact: Record Contact;
        MasterContact: Record Contact;
    begin
        if not MyCompany.Get(CompanyName()) then
            exit;
        if not IsMasterCompany() then
            exit;
        if SingleInstanceMgt.GetIsSyncing() then
            exit;
        SingleInstanceMgt.SetIsSyncing(true);
        //  Delete in all slave companies
        SlaveCompany.SetRange(IsMaster, false);
        SlaveCompany.SetFilter("Master Company Name", '%1', CompanyName());
        if SlaveCompany.FindSet() then
            repeat
                if VendorSlave.ChangeCompany(SlaveCompany.Name) then
                    if VendorSlave.Get(Rec."No.") then
                        VendorSlave.Delete(true);
                // Also delete Vendor business relation in slave
                if ContactBusInSlave.ChangeCompany(SlaveCompany.Name) then begin
                    ContactBusInSlave.SetRange("Link to Table", ContactBusInSlave."Link to Table"::Vendor);
                    ContactBusInSlave.SetRange("No.", Rec."No.");
                    if ContactBusInSlave.FindSet() then
                        repeat
                            if SlaveContact.ChangeCompany(SlaveCompany.Name) then
                                if SlaveContact.Get(ContactBusInSlave."Contact No.") then begin
                                    ContactBusInSlave.Delete();
                                    SlaveContact.UpdateBusinessRelation();
                                    SlaveContact.Modify();
                                end;
                        until ContactBusInSlave.Next() = 0;
                end;
            until SlaveCompany.Next() = 0;
        //  Master: Remove Vendor business relation
        ContactBusInMaster.SetRange("Link to Table", ContactBusInMaster."Link to Table"::Vendor);
        ContactBusInMaster.SetRange("No.", Rec."No.");
        if ContactBusInMaster.FindSet() then
            repeat
                if MasterContact.Get(ContactBusInMaster."Contact No.") then begin
                    ContactBusInMaster.Delete();
                    MasterContact.UpdateBusinessRelation();
                    MasterContact.Modify();
                end;
            until ContactBusInMaster.Next() = 0;

        SingleInstanceMgt.ClearIsSyncing();
    end;

    // Labels / Errors
    var
        ErrCompanyNotFound: Label 'Company setup not found.';
        ErrCustomerCreation: Label 'Customer creation is allowed only in the Master Company.';
        ErrCustomerModification: Label 'Customer modification is allowed only in the Master Company.';
        ErrCustomerDeletion: Label 'Customer Deletion is allowed only in the Master Company.';
        ErrVendorCreation: Label 'Vendor creation is allowed only in the Master Company.';
        ErrVendorModification: Label 'Vendor modification is allowed only in the Master Company.';
        ErrVendorDeletion: Label 'Vendor Deletion is allowed only in the Master Company.';
}

