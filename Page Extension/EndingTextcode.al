pageextension 50122 endingtextcodeext extends "Sales Invoice"
{
    layout
    {
        addlast(content)
        {
            field("Ending Text Code"; Rec."Ending Text Code")
            {
                Caption = 'Ending Text Code';
                ApplicationArea = All;
                TableRelation = "Standard Text";

                
            }
            part(EndingLine; "Ending Text Code")
            {
                ApplicationArea = All;
                SubPageLink = "Customer No" = field("Sell-to Customer No."), Selection = const(EndingText);
            }

        }
    }
}