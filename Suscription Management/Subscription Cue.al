page 50130 "ZYN_Subscription Cues"
{
    PageType = CardPart;
    SourceTable = "ZYN_Subscription Table";
    ApplicationArea = All;
    Caption = 'ZYN_Subscription Cues';

    layout
    {
        area(content)
        {
            cuegroup(Subscriptions)
            {
                field("Active Subscriptions"; ActiveSubscriptions)
                {
                   caption='Active Subscriptions';
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        Subscription: Record "ZYN_Subscription Table";
                        SubscriptionList: Page "ZYN_Subscription List";
                    begin
                        Subscription.SetRange(Status, Subscription.Status::Active);
                        SubscriptionList.SetTableView(Subscription);
                        PAGE.Run(PAGE::"ZYN_Subscription List", Subscription);
                    end;
                }
                field("Revenue Generated"; TotalAmount)
                {
                    Caption='Revenue Generated';
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        SalesHeader: Record "Sales Header";
                        StartDate: Date;
                        EndDate: Date;

                    begin
                        // Calculate first and last day of the current month
                        StartDate := CALCDATE('<-CM>', WORKDATE);
                        EndDate := CALCDATE('<CM>', WORKDATE);
                        SalesHeader.SetRange(Subscription, true);
                        SalesHeader.SetFilter("No.", '*SUB*');
                        SalesHeader.SetRange("Document Date", StartDate, EndDate);
                        PAGE.Run(PAGE::"Sales Invoice List", SalesHeader);
                    end;
                }
            }
        }
    }
    var
        ActiveSubscriptions: Integer;
        RevenueGenerated: Decimal;
        TotalAmount: Decimal;
        StartDate: Date;
        EndDate: Date;

    trigger OnAfterGetRecord()
    var
        Subscription: Record "ZYN_Subscription Table";
        SalesHeader: Record "Sales Header";
        workmonth: Integer;
        workyear: Integer;

    begin
        // Count active subscriptions dynamically
        Subscription.SetRange(Status, Subscription.Status::Active);
        ActiveSubscriptions := Subscription.Count;

        // Reset revenue
        TotalAmount := 0;
        StartDate := CALCDATE('<-CM>', WORKDATE);
        EndDate := CALCDATE('<CM>', WORKDATE);
        // Sum revenue for subscription invoices for current month
        SalesHeader.reset();
        SalesHeader.SetRange(Subscription, true);
        SalesHeader.SetRange("Document Date", StartDate, EndDate);
        if SalesHeader.FindSet() then
            repeat
                SalesHeader.CalcFields("Amount");
                TotalAmount += SalesHeader."Amount";
            until SalesHeader.Next() = 0;
    end;

    var
        RenewalNotification: Codeunit "ZYN_Subscript Renew Notify Mgt";

    trigger OnOpenPage()
    begin
        RenewalNotification.SubscriptionRenewalNotification();
    end;
}