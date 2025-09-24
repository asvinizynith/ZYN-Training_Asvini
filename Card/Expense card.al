page 50172 "ZYN_Expense Card"
{
    ApplicationArea = All;
    Caption = 'ZYN_Expense Card';
    PageType = Card;
    SourceTable = "ZYN_Expense Table";

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
                field(Amount; Rec.Amount)
                {
                }
                field("Date"; Rec."Date")
                {
                }
                field("Category"; Rec."Category")
                {
                }
                field("Remaining Budget"; Rec."Remaining Budget")
                {
                    Editable = false;
                }
            }
        }
    }
}