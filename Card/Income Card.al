page 50181 "ZYN_Income Card"
{
    ApplicationArea = All;
    Caption = 'ZYN_Income Card';
    PageType = Card;
    SourceTable = "ZYN_Income Table";

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