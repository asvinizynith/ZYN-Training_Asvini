page 50133 "ZYN_ExpenseClaim Category Card"
{
    ApplicationArea = All;
    Caption = 'ZYN_ExpenseClaim Category Card';
    PageType = Card;
    SourceTable = "ZYN_Expense Claim Category";

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