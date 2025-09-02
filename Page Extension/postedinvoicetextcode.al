pageextension 50129 postedinvoiceext extends "Posted Sales Invoice"
{
    layout
    {
        addafter(General)
        {
            group(TextCode)
            {
                field("Beginning Code"; Rec."Beginning Code")
                {
                    Caption = 'Biginning Code';
                    ApplicationArea = All;
                    
                    Editable = false;
                }
                
            }
            part(BeginningLine; "Text Code")
            {
                ApplicationArea = All;
                SubPageLink = "No" = field("No."), "Document Type" = const("Posted Invoice"), Selection = const("BeginningText");
            }

        }
        addlast(content)
        {
            field("Ending Code"; Rec."Ending Code")
            {
                ApplicationArea = All;
                Caption = 'Ending Code';
               
                Editable = false;
            }
            part(EndingLine; "Text Code")
            {
                ApplicationArea = All;
                SubPageLink = "No" = field("No."), "Document Type" = const("Posted Invoice"), Selection = const("EndingText");
            }

        }

    }
}
