page 50172 "Expense Card"
{
    ApplicationArea = All;
    Caption = 'Expense Card';
    PageType = Card;
    SourceTable = "Expense Table";

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
                    ApplicationArea = All;
                    Editable = false;
                }


            }
        }
    }
   
}