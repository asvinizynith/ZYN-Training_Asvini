pageextension 50148 Saleinvoiceext extends "Sales Invoice"
{
    layout
    {
        addafter(General)
        {
            field("Beginning Text Code"; Rec."Beginning Text Code")
            {
                ApplicationArea = All;
                Caption = 'Beginning text Code';
                TableRelation = "Standard Text".Code;
            }
            part(BeginningLine; "ZYN_Beginning Text Code")
            {
                ApplicationArea = All;
                Caption = 'Beginning text';
                SubPageLink = "Customer No" = field("Sell-to Customer No."), Selection = const(BeginningText);
            }
        }
    }
}


