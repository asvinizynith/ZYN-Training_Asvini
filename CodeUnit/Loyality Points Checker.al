codeunit 50126 "ZYN_Loyality Points Checker"
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