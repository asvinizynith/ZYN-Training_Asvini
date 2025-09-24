pageextension 50153 Creditmemoexttextcode extends "Sales Credit Memo"
{
    layout
    {
        addafter(General)
        {
            field("Beginning Text Code";Rec."Beginning Text Code")
            {
                Caption= 'Beginning Text Code';
                ApplicationArea = All;
                TableRelation = "Standard Text";
            }
            part(BeginningLine; "ZYN_Beginning Text Code")
            {
                Caption= 'Beginning Text';
                ApplicationArea = All;
                SubPageLink = "Customer No" = field("Sell-to Customer No."), Selection = const(BeginningText);
            }
        }
        addlast(content)
        {
            field("Ending Text Code";Rec."Ending Text Code")
            {
                Caption= ' Ending Text Code';
                ApplicationArea= All;
                TableRelation = "Standard Text";
            }
            part(EndingLine; "ZYN_Ending Text Code")
            {
                ApplicationArea = All;
                Caption= ' Ending Text';
                SubPageLink = "Customer No" = field("Sell-to Customer No."), Selection = const(EndingText);
            }
        }
    }
}
    
   