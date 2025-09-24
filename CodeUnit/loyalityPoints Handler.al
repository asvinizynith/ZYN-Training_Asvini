codeunit 50102 "ZYN_Loyalty Points Handler"
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
