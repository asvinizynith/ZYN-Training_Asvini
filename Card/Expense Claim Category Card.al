page 50133 "Expense Claim Category Card"
{
    ApplicationArea = All;
    Caption = 'Expense Claim Category Card';
    PageType = Card;
    SourceTable = "expense claim category table";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Category Code"; Rec."Category Code")
                {

                }
                field("Category Name"; Rec."Category Name")
                {

                }
                field(Subtype; Rec.Subtype)
                {

                }
                field(Description; Rec.Description)
                {

                }
                field("Amount Limit"; Rec."Amount Limit")
                {

                }
            }
        }
    }
}