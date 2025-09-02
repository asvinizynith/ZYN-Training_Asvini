pageextension 50156 salesodertextcodeext extends "Sales Order"
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
            part(BeginningLine; "Text Code")
            {
                ApplicationArea = All;
                SubPageLink = "Customer No" = field("Sell-to Customer No."), Selection = const(BeginningText),"Document Type"=const(Order);
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
            part(EndingLine; "Ending Text Code")
            {
                ApplicationArea = All;
                SubPageLink = "Customer No" = field("Sell-to Customer No."), Selection = const(EndingText),"Document Type"=const(Order);
            }
        }
        addafter(General)
        {
            field("Invoice Beginning Text Code";Rec."Invoice Beginning Text Code")
            {
                ApplicationArea = All;
                TableRelation="Standard Text".Code;
            }
            field("Invoice Ending Text Code";Rec."Invoice Ending Text Code")
            {
                ApplicationArea = All;
                TableRelation = "Standard Text".Code;
            }
        }
    }
}


    
   
