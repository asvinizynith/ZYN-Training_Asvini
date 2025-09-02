pageextension 50158 postedcreditmemotextcodeext extends "Posted Sales Credit Memo"
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
                    TableRelation = "Standard Text".Code;
                    Editable = false;
                }
            }
            part(BeginningLine; "Text Code")
            {
                ApplicationArea = All;
                SubPageLink = "No" = field("No."),"Document Type"=const("Posted Credit Memo"), Selection = const(BeginningText);
            }

        }
        addlast(content)
        {
            field("Ending Code"; Rec."Ending Code")
            {
                ApplicationArea = All;
                Caption = 'Ending Code';
                TableRelation = "Standard Text".Code;
                Editable = false;
            }
            part(EndingLine; "Text Code")
            {
                ApplicationArea = All;
                SubPageLink = "No" = field("No."),"Document Type"=const("Posted Credit Memo"), Selection = const(EndingText);
            }

        }

    }
}
