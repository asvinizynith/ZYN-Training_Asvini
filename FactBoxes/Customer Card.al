page 50100 "ZYN_Customer Sales FactBox"
{
    PageType = CardPart;
    SourceTable = Customer;
    ApplicationArea = All;
    Caption = 'ZYN_Customer Sales Info';

    layout
    {
        area(content)
        {
            cuegroup(Subscriptions)
            {
                field("Active Subscriptions"; ActiveSubscriptions)
                {
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        Subscription: Record "ZYN_Subscription Table";
                        SubscriptionList: Page "ZYN_Subscription List";
                    begin
                        Subscription.SetRange(Status, Subscription.Status::Active);
                        SubscriptionList.SetTableView(Subscription);
                        SubscriptionList.Run();
                    end;
                }
            }
            group("Contact Info")
            {
                Visible = ContentVisible;
                field("Contact ID"; ContactNo)
                {
                    Caption = 'ID';
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        Contact: Record Contact;
                    begin
                        if ContactNo <> '' then
                            if Contact.Get(ContactNo) then
                                PAGE.Run(PAGE::"Contact Card", Contact);
                    end;
                }
                field("Contact Name"; ContactName)
                {
                    DrillDown = true;
                    Caption = 'Name';
                    trigger OnDrillDown()
                    var
                        Contact: Record Contact;
                    begin
                        if ContactNo <> '' then
                            if Contact.Get(ContactNo) then
                                PAGE.Run(PAGE::"Contact Card", Contact);
                    end;
                }
            }
            cuegroup("Sales Info")
            {
                field("Open Sales Orders"; OpenSalesOrdersCount)
                {
                    DrillDown = true;
                    Caption = 'Open Orders';
                    trigger OnDrillDown()
                    var
                        SalesHeader: Record "Sales Header";
                    begin
                        SalesHeader.SetRange("Sell-to Customer No.", Rec."No.");
                        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                        SalesHeader.SetRange(Status, SalesHeader.Status::Open);
                        PAGE.Run(PAGE::"Sales Order List", SalesHeader);
                    end;
                }
                field("Open Sales Invoices"; "OpenSalesInvoicesCount")
                {
                    DrillDown = true;
                    Caption = 'Open Invoices';
                    trigger OnDrillDown()
                    var
                        SalesHeader: Record "Sales Header";
                    begin
                        SalesHeader.SetRange("Sell-to Customer No.", Rec."No.");
                        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
                        SalesHeader.SetRange(Status, SalesHeader.Status::Open);
                        PAGE.Run(PAGE::"Sales Order List", SalesHeader);
                    end;
                }
            }
        }
    }

    var
        ContactNo: Code[20];
        ContactName: Text[100];
        OpenSalesOrdersCount: Integer;
        OpenSalesInvoicesCount: Integer;
        ContentVisible: Boolean;
        ActiveSubscriptions: Integer;

    trigger OnAfterGetRecord()
    var
        SalesHeader: Record "Sales Header";
        SalesInvHeader: Record "Sales Invoice Header";
        Contact: Record Contact;
        Subscription: Record "ZYN_Subscription Table";
    begin
        // Count active subscriptions dynamically
        Subscription.SetRange(Status, Subscription.Status::Active);
        ActiveSubscriptions := Subscription.Count;
        // Find Contact linked to Customer
        Clear(ContactNo);
        Clear(ContactName);
        ContentVisible := false;
        if Rec."Primary Contact No." <> '' then begin
            ContactNo := Rec."Primary Contact No.";
            if Contact.Get(ContactNo) then
                ContactName := Contact.Name;
            ContentVisible := true;
        end;
        // Count open sales orders
        SalesHeader.Reset();
        SalesHeader.SetRange("Sell-to Customer No.", Rec."No.");
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange(Status, SalesHeader.Status::Open);
        OpenSalesOrdersCount := SalesHeader.Count();
        // Count open sales invoices
        SalesHeader.Reset();
        SalesHeader.SetRange("Sell-to Customer No.", Rec."No.");
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
        SalesHeader.SetRange(Status, SalesHeader.Status::Open);
        OpenSalesInvoicesCount := SalesHeader.Count();
    end;
}