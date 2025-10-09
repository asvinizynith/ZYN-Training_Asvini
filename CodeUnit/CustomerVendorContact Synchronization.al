codeunit 50130 Zyn_CustomerVendorContactSync
{
    var
        SingleInstanceMgt: Codeunit "ZYN_Single Instance Management";

    // Sync Customer to Slave Company

    procedure SyncCustomer(CustomerNo: Code[20]; TargetCompany: Text)
    var
        Customer: Record Customer;
        CustomerInSlave: Record Customer;
        ContactMaster: Record Contact;
        ContactInSlave: Record Contact;
        ContactBusRelInSlave: Record "Contact Business Relation";
        MarketingSetup: Record "Marketing Setup";
    begin
        if not Customer.Get(CustomerNo) then
            exit;

        // Auto-link contact if missing
        AutoLinkCustomerContact(Customer);

        // Insert/Update Customer in slave
        if CustomerInSlave.ChangeCompany(TargetCompany) then begin
            if not CustomerInSlave.Get(Customer."No.") then begin
                CustomerInSlave.Init();
                CustomerInSlave.TransferFields(Customer, true);
                CustomerInSlave."No." := Customer."No.";
                CustomerInSlave.Insert(false);
            end;
        end else
            exit;

        // Sync Contact + Customer Business Relation
        if Customer."Primary Contact No." <> '' then
            SyncCustomerContactBusinessRelation(Customer, TargetCompany);
    end;

    // Sync Vendor to Slave Company

    procedure SyncVendor(VendorNo: Code[20]; TargetCompany: Text)
    var
        Vendor: Record Vendor;
        VendorInSlave: Record Vendor;
        ContactMaster: Record Contact;
        ContactInSlave: Record Contact;
        ContactBusRelInSlave: Record "Contact Business Relation";
        MarketingSetup: Record "Marketing Setup";
    begin
        if not Vendor.Get(VendorNo) then
            exit;

        // Auto-link contact if missing
        AutoLinkVendorContact(Vendor);

        // Insert/Update Vendor in slave
        if VendorInSlave.ChangeCompany(TargetCompany) then begin
            if not VendorInSlave.Get(Vendor."No.") then begin
                VendorInSlave.Init();
                VendorInSlave.TransferFields(Vendor, true);
                VendorInSlave."No." := Vendor."No.";
                VendorInSlave.Insert(false);
            end;
        end else
            exit;

        // Sync Contact + Vendor Business Relation
        if Vendor."Primary Contact No." <> '' then
            SyncVendorContactBusinessRelation(Vendor, TargetCompany);
    end;

    // Helpers for Customer
    local procedure AutoLinkCustomerContact(var Customer: Record Customer)
    var
        ContactMaster: Record Contact;
    begin
        if Customer."Primary Contact No." <> '' then
            exit;

        if ContactMaster.FindSet() then
            repeat
                if UpperCase(ContactMaster.Name) = UpperCase(Customer.Name) then begin
                    Customer.Validate("Primary Contact No.", ContactMaster."No.");
                    Customer.Modify();
                    break;
                end;
            until ContactMaster.Next() = 0;
    end;

    procedure SyncCustomerContactBusinessRelation(var Customer: Record Customer; TargetCompany: Text)
    var
        ContactMaster: Record Contact;
        ContactInSlave: Record Contact;
        ContactBusRelInSlave: Record "Contact Business Relation";
        MarketingSetup: Record "Marketing Setup";
    begin
        if Customer."Primary Contact No." = '' then
            exit;
        if not ContactMaster.Get(Customer."Primary Contact No.") then
            exit;
        // Load Marketing Setup
        if MarketingSetup.ChangeCompany(TargetCompany) then
            MarketingSetup.Get();
        // Insert/Update Contact in slave
        if ContactInSlave.ChangeCompany(TargetCompany) then begin
            if ContactInSlave.Get(ContactMaster."No.") then begin
                ContactInSlave.TransferFields(ContactMaster, true);
                ContactInSlave.Modify(false);
            end else begin
                ContactInSlave.Init();
                ContactInSlave.TransferFields(ContactMaster, true);
                ContactInSlave."No." := ContactMaster."No.";
                ContactInSlave.Insert(false);
            end;
        end else
            exit;
        // Upsert Contact Business Relation
        if ContactBusRelInSlave.ChangeCompany(TargetCompany) then begin
            ContactBusRelInSlave.SetRange("Contact No.", ContactInSlave."No.");
            ContactBusRelInSlave.SetRange("Link to Table", ContactBusRelInSlave."Link to Table"::Customer);
            ContactBusRelInSlave.SetRange("No.", Customer."No.");
            if ContactBusRelInSlave.FindFirst() then begin
                ContactBusRelInSlave."Business Relation Code" := MarketingSetup."Bus. Rel. Code for Customers";
                ContactBusRelInSlave.Modify();
            end else begin
                ContactBusRelInSlave.Init();
                ContactBusRelInSlave."Contact No." := ContactInSlave."No.";
                ContactBusRelInSlave."Link to Table" := ContactBusRelInSlave."Link to Table"::Customer;
                ContactBusRelInSlave."No." := Customer."No.";
                ContactBusRelInSlave."Business Relation Code" := MarketingSetup."Bus. Rel. Code for Customers";
                ContactBusRelInSlave.Insert(false);
            end;
        end;
    end;

    // Helpers for Vendor  
    local procedure AutoLinkVendorContact(var Vendor: Record Vendor)
    var
        ContactMaster: Record Contact;
    begin
        if Vendor."Primary Contact No." <> '' then
            exit;

        if ContactMaster.FindSet() then
            repeat
                if UpperCase(ContactMaster.Name) = UpperCase(Vendor.Name) then begin
                    Vendor.Validate("Primary Contact No.", ContactMaster."No.");
                    Vendor.Modify(true);
                    break;
                end;
            until ContactMaster.Next() = 0;
    end;

    procedure SyncVendorContactBusinessRelation(var Vendor: Record Vendor; TargetCompany: Text)
    var
        ContactMaster: Record Contact;
        ContactInSlave: Record Contact;
        ContactBusRelInSlave: Record "Contact Business Relation";
        MarketingSetup: Record "Marketing Setup";
    begin
        if Vendor."Primary Contact No." = '' then
            exit;
        if not ContactMaster.Get(Vendor."Primary Contact No.") then
            exit;

        // Load Marketing Setup
        if MarketingSetup.ChangeCompany(TargetCompany) then
            MarketingSetup.Get();
        // Insert/Update Contact in slave
        if ContactInSlave.ChangeCompany(TargetCompany) then begin
            if ContactInSlave.Get(ContactMaster."No.") then begin
                // Contact exists → update
                ContactInSlave.TransferFields(ContactMaster, true);
                ContactInSlave.Modify(false);
            end else begin
                // Contact does not exist → insert
                ContactInSlave.Init();
                ContactInSlave.TransferFields(ContactMaster, true);
                ContactInSlave."No." := ContactMaster."No.";
                ContactInSlave.Insert(false);
            end;
        end else
            exit;


        // Upsert Contact Business Relation
        if ContactBusRelInSlave.ChangeCompany(TargetCompany) then begin
            ContactBusRelInSlave.SetRange("Contact No.", ContactInSlave."No.");
            ContactBusRelInSlave.SetRange("Link to Table", ContactBusRelInSlave."Link to Table"::Vendor);
            ContactBusRelInSlave.SetRange("No.", Vendor."No.");
            if ContactBusRelInSlave.FindFirst() then begin
                // Exists → update
                ContactBusRelInSlave."Business Relation Code" := MarketingSetup."Bus. Rel. Code for Vendors";
                ContactBusRelInSlave.Modify();
            end else begin
                // Does not exist → insert
                ContactBusRelInSlave.Init();
                ContactBusRelInSlave."Contact No." := ContactInSlave."No.";
                ContactBusRelInSlave."Link to Table" := ContactBusRelInSlave."Link to Table"::Vendor;
                ContactBusRelInSlave."No." := Vendor."No.";
                ContactBusRelInSlave."Business Relation Code" := MarketingSetup."Bus. Rel. Code for Vendors";
                ContactBusRelInSlave.Insert(false);
            end;
        end;
    end;

    // Event Subscriber: Keep BC relations updated
    [EventSubscriber(ObjectType::Table, Database::"Contact Business Relation", 'OnBeforeUpdateContactBusinessRelation', '', true, true)]
    local procedure OnBeforeUpdateContactBusinessRelation(ContactBusinessRelation: Record "Contact Business Relation"; var IsHandled: Boolean)
    var
        Contact: Record Contact;
    begin
        if SingleInstanceMgt.GetFromCreateAs() then
            IsHandled := true;

        if ContactBusinessRelation."Contact No." <> '' then
            if Contact.Get(ContactBusinessRelation."Contact No.") then begin
                if Contact.UpdateBusinessRelation() then
                    Contact.Modify();

                Contact.SetFilter("No.", '<>%1', ContactBusinessRelation."Contact No.");
                if Contact.FindSet(true) then
                    repeat
                        if Contact.UpdateBusinessRelation() then
                            Contact.Modify();
                    until Contact.Next() = 0;
            end;
    end;
}
