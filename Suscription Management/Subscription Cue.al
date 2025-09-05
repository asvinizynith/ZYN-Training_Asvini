page 50130 "Subscription Cues"
{
    PageType = CardPart;
    SourceTable = "Subscription Table";
    ApplicationArea = All;
    Caption = 'Subscription Cues';

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
                        PAGE.Run(PAGE::"Subscription List", SubscriptionRec);
                    end;
                }
                field("Revenue Generated"; TotalAmount)
                {
                    ApplicationArea = All;
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        InvoiceRec: Record "Sales Header";

                        workmonth: Integer;
                        workyear: Integer;
                    begin
                        // Calculate first and last day of the current month
                        workmonth := Date2DMY(WorkDate(), 2);
                        workyear := Date2DMY(WORKDATE(), 3);
                        InvoiceRec.SetRange(Subscription, true);
                        InvoiceRec.SetFilter("No.", '*SUB*');
                        InvoiceRec.SetRange("Document Date", DMY2Date(1, workmonth, workyear), DMY2Date(31, workmonth, workyear));
                        PAGE.Run(PAGE::"Sales Invoice List", InvoiceRec);
                    end;
                }
            }
        }
    }
    var
        ActiveSubscriptions: Integer;
        RevenueGenerated: Decimal;
        TotalAmount: Decimal;

    trigger OnAfterGetRecord()
    var
        SubscriptionRec: Record "Subscription Table";
        InvoiceRec: Record "Sales Header";
        workmonth: Integer;
        workyear: Integer;
    begin
        // Count active subscriptions dynamically
        SubscriptionRec.SetRange(Status, SubscriptionRec.Status::Active);
        ActiveSubscriptions := SubscriptionRec.Count;

        // Reset revenue
        TotalAmount := 0;

        workmonth := Date2DMY(WorkDate(), 2);
        workyear := Date2DMY(WORKDATE(), 3);


        // Sum revenue for subscription invoices for current month
        InvoiceRec.reset();
        InvoiceRec.SetRange(Subscription, true);
        InvoiceRec.SetRange("Document Date", DMY2Date(1, workmonth, workyear), DMY2Date(31, workmonth, workyear));

        if InvoiceRec.FindSet() then begin

            repeat
                InvoiceRec.CalcFields(Amount);
                TotalAmount += InvoiceRec.Amount;
            until InvoiceRec.Next() = 0;
        end;

    end;
}