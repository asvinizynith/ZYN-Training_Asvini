
tableextension 50119 SalesLineExt extends "Sales Line"
{
    trigger OnInsert()
    begin
        CheckCustomerCreditLimit();
    end;

    trigger OnModify()
    begin
        CheckCustomerCreditLimit();
    end;

    local procedure CheckCustomerCreditLimit()
    var
        CustomerRec: Record Customer;
    begin
        if "Sell-to Customer No." = '' then
            exit;

        if CustomerRec.Get("Sell-to Customer No.") then begin
            CustomerRec.CalcFields("credit Used");
        end;
    end;
}