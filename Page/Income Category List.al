page 50183 "Income Category List "
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'Income Category List ';
    SourceTable = "Income Category";

    layout
    {
        area(Content)
        {
            repeater(CategoryDetails)
            {
             field("Income Category Name";Rec."Income Category Name")
                {
                    ApplicationArea = All;
                }
                field("Category Description";Rec."Category Description")
                {
                    ApplicationArea = All;
                }
            }
           
        }
        area(FactBoxes)
        {
            part(CategoryIncomeFB; "Category Income FactBox")
            {
                ApplicationArea = All;
                Caption = 'Category Expense FactBox';
                SubPageLink = "Income Category Name" = field("Income Category Name");
            }
        }
    }
}
    
