page 50100 "Customer Sales FactBox"
{
    PageType = CardPart;
    SourceTable = Customer;
    ApplicationArea = All;
    Caption = 'Customer Sales Info';

    layout
    {
        area(content)
        {
            cuegroup(Subscriptions)
            {
                field("Active Subscriptions"; ActiveSubscriptions)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        SubscriptionRec: Record "Subscription Table";
                        SubscriptionList: Page "Subscription List";
                    begin
                        SubscriptionRec.SetRange(Status, SubscriptionRec.Status::Active);
                        SubscriptionList.SetTableView(SubscriptionRec);
                        SubscriptionList.Run();
                    end;
                }
            }
            group("Contact Info")
            {
                Visible = ContentVisible;
                field("Contact ID"; ContactNo)
                {

                    ApplicationArea = All;
                    Caption = 'ID';
                    DrillDown = true;
                    // Visible = false; // 
                    trigger OnDrillDown()
                    var
                        ContactRec: Record Contact;
                    begin
                        if ContactNo <> '' then
                            if ContactRec.Get(ContactNo) then
                                PAGE.Run(PAGE::"Contact Card", ContactRec);

                    end;

                }
                field("Contact Name"; ContactName)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Name';
                    trigger OnDrillDown()
                    var
                        ContactRec: Record Contact;
                    begin
                        if ContactNo <> '' then
                            if ContactRec.Get(ContactNo) then
                                PAGE.Run(PAGE::"Contact Card", ContactRec);

                    end;
                }
            }
            cuegroup("Sales Info")
            {
                field("Open Sales Orders"; OpenSalesOrdersCount)
                {
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
        ContactRec: Record Contact;
        SubscriptionRec: Record "Subscription Table";

    begin
        // Count active subscriptions dynamically
        SubscriptionRec.SetRange(Status, SubscriptionRec.Status::Active);
        ActiveSubscriptions := SubscriptionRec.Count;

        // Find Contact linked to Customer
        Clear(ContactNo);
        Clear(ContactName);
        ContentVisible := false;
        if Rec."Primary Contact No." <> '' then begin
            ContactNo := Rec."Primary Contact No.";
            if ContactRec.Get(ContactNo) then
                ContactName := ContactRec.Name;
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