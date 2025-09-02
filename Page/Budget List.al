page 50189 "Budget List"
{
    ApplicationArea = All;
    Caption = 'Budget List';
    PageType = List;
    SourceTable = "Budget Table";
    UsageCategory = Administration;
    CardPageId = "Budget Card"; // Ensures standard 'New' works too
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("From Date"; Rec."From Date") { }
                field("To Date"; Rec."To Date") { }
                field(Category; Rec.Category) { }
                field(Amount; Rec.Amount)
                {

                }
            }
        }
    }
   

}