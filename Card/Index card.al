page 50169 "Index Card"
{
    ApplicationArea = All;
    Caption = 'Index Card';
    PageType = Card;
    SourceTable = "Index Table";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Code"; Rec."Code")
                {
                    
                }
                field(Description; Rec.Description)
                {
                   
                }
                field("Percentage Increase"; Rec."Percentage Increase")
                {
                    
                }
                field("Start Year"; Rec."Start Year")
                {
                  
                }
                field("End Year"; Rec."End Year")
                {
                    
                }
            }
            part(IndexLines; "Index Lines list Part")
            {
                ApplicationArea = All;
                Caption = 'Index Lines';
                SubPageLink = "Code" = field("Code");

            }

        }
    }
}