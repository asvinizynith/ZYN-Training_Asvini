pageextension 50157 salesqoutetextcodeext extends "Sales Quote"
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
                 Caption= 'Beginning Line';
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
                 Caption= ' Ending Line';
                ApplicationArea = All;
                SubPageLink = "Customer No" = field("Sell-to Customer No."), Selection = const(EndingText);
            }
        }
    }
}
    
   

