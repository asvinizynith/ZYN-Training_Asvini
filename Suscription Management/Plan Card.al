page 50124 "Plan Card"
{
    ApplicationArea = All;
    Caption = 'Plan Card';
    PageType = Card;
    SourceTable = "Plan Table";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Plan ID"; Rec."Plan ID")
                {

                }
                field("Plan Name"; Rec."Plan Name")
                {

                }
                field("Monthly Fee"; Rec."Monthly Fee")
                {

                }
                field(Status; Rec.Status)
                {

                }
                field(Description; Rec.Description)
                {

                }


            }
        }


    }


}