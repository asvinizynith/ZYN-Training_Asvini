codeunit 50102 "Loyalty Points Handler"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', true, true)]
    local procedure OnAfterPostSalesDoc(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
     SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean;
     InvtPickPutaway: Boolean; var CustLedgerEntry: Record "Cust. Ledger Entry"; WhseShip: Boolean; WhseReceiv: Boolean; PreviewMode: Boolean)
    var
        Customer: Record Customer;

    begin
        if (SalesHeader."Document Type" <> SalesHeader."Document Type"::Invoice) or
        (SalesHeader."Document Type" <> SalesHeader."Document Type"::Order) then begin


            if Customer.Get(SalesHeader."Sell-to Customer No.") then begin
                Customer."Loyality Points" := Customer."Loyality Points" + 10;
                Customer.Modify();


            end;
        end;
    end;

}
codeunit 50126 "Loyality Points Checker"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', true, true)]
    local procedure OnBeforePostSalesDoc(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean;
     var HideProgressWindow: Boolean; var IsHandled: Boolean; var CalledBy: Integer)
    var
        Customer: Record Customer;

    begin
        if (SalesHeader."Document Type" <> SalesHeader."Document Type"::Invoice) or
        (SalesHeader."Document Type" <> SalesHeader."Document Type"::Order) then begin



            if Customer.Get(SalesHeader."Sell-to Customer No.") then begin
                if Customer."Loyality Points" >= 100000 then
                    Error('Cannot post invoice. Loyalty points (%1) reached for this customer.', Customer."Loyality Points");
            end;
        end;
    end;


}