page 50188 "Budget Card"
{
    ApplicationArea = All;
    Caption = 'Budget Card';
    PageType = Card;
    SourceTable = "Budget Table";

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