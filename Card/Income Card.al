page 50181 "income Card"
{
    ApplicationArea = All;
    Caption = 'Income Card';
    PageType = Card;
    SourceTable = "Income Table";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Income Description"; Rec."Income Description")
                {

                }
                field("Income Amount"; Rec."Income Amount")
                {

                }
                field("Income Date"; Rec."Income Date")
                {

                }

                field("Income Category"; Rec."Income Category")
                {

                }


            }
        }
    }
}