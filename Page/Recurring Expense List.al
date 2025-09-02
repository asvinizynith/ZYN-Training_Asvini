page 50104 "Recurring Expense List"
{
    ApplicationArea = All;
    Caption = 'Recurring Expense List';
    PageType = List;
    SourceTable = "Recurring Expense Table";
    UsageCategory = Administration;
    CardPageId = "Recurring Expense Card"; // Ensures standard 'New' works too
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Category; Rec.Category) { }
                field(Amount; Rec.Amount) { }
                field(Cycle; Rec."Cycle Type") { }
                field("Start Date"; Rec."Start Date")
                {

                }
                field("Next Cycle Date"; Rec."Next Cycle Date")
                {

                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                }
            }
        }
    }

}