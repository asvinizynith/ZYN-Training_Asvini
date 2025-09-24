page 50188 "ZYN_Budget Card"
{
    ApplicationArea = All;
    Caption = 'ZYN_Budget Card';
    PageType = Card;
    SourceTable = "ZYN_Budget Table";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("From Date"; Rec."From Date")
                {
                }
                field("To Date"; Rec."To Date")
                {
                }
                field(Category; Rec.Category)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
            }
        }
    }
}