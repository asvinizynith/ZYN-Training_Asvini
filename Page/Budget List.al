page 50189 "ZYN_Budget List"
{
    ApplicationArea = All;
    Caption = 'ZYN_Budget List';
    PageType = List;
    SourceTable = "ZYN_Budget Table";
    UsageCategory = Administration;
    CardPageId = "ZYN_Budget Card"; // Ensures standard 'New' works too
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
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