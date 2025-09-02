page 50108 "Leave Category Card"
{
    ApplicationArea = All;
    Caption = 'Leave Category Card';
    PageType = Card;
    SourceTable = "Leave Category Table";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(Description; Rec.Description)
                {

                }
                field("Leave Category"; Rec."Leave Category")
                {

                }
                field("No. Of Days Allowed"; Rec."No. Of Days Allowed")
                {

                }

            }
        }


    }



}