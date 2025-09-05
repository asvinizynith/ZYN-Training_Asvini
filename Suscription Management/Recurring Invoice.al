codeunit 50122 "Subscription Billing Invoices"
{
    Subtype = Normal;

    trigger OnRun()
    begin
        ProcessRecurringInvoices();
    end;

    local procedure ProcessRecurringInvoices()
    var
        SubscriptionRec: Record "Subscription Table";
    begin
        SubscriptionRec.Reset();
        // SubscriptionRec.SetRange("Recurring Billing", true);
        SubscriptionRec.SetFilter("Next Billing Date", '<=%1', WorkDate()); // Due today

        if SubscriptionRec.FindSet() then
            repeat
                CreateSalesInvoice(SubscriptionRec);

                // Update next billing date
                SubscriptionRec.CalcNextBillingDate();
                SubscriptionRec.Modify(true);
            until SubscriptionRec.Next() = 0;
    end;

    local procedure CreateSalesInvoice(SubscriptionRec: Record "Subscription Table")
    var
        SalesHeader: Record "Sales Header";
        PlanRec: Record "Plan Table";
        Salesline: Record "Sales Line";
        InvoiceNo: Code[20];
    begin
        if SubscriptionRec."Customer ID" = '' then
            Error('Customer No. must be defined for Subscription %1', SubscriptionRec."Subscription ID");



        if not PlanRec.Get(SubscriptionRec."Plan ID") then
            Error('Plan %1 not found for Subscription %2', SubscriptionRec."Plan ID", SubscriptionRec."Subscription ID");
        InvoiceNo := 'SUB-' + Format(SubscriptionRec."Subscription ID") + '-' + Format(WorkDate(), 0, '<year4><month,2>');

        // --- Create Sales Header only ---
        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
        SalesHeader.Validate("Sell-to Customer No.", SubscriptionRec."Customer ID");
        SalesHeader.Validate(Subscription, true);
        SalesHeader."No." := InvoiceNo;

        // Add Sales Line for subscription amount
        SalesLine.Init();
        SalesLine."Document Type" := SalesLine."Document Type"::Invoice;
        SalesLine."Document No." := SalesHeader."No.";

        SalesLine.Validate(Amount, PlanRec."Monthly Fee");
        SalesLine.Insert();
        SalesLine.Modify();

        SalesHeader.Insert(true);

    end;
}
