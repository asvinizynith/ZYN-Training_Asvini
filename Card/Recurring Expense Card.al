page 50101 "Recurring Expense Card"
{
    ApplicationArea = All;
    Caption = 'Recurring Expense Card';
    PageType = Card;
    SourceTable = "Recurring Expense Table";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(Category; Rec.Category)
                {

                }
                field(Amount; Rec.Amount)
                {

                }
                field(Cycle; Rec."Cycle Type")
                {

                }
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