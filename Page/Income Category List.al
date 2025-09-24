page 50183 "ZYN_Income Category List"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'ZYN_Income Category List';
    SourceTable = "ZYN_Income Category";

    layout
    {
        area(Content)
        {
            repeater(CategoryDetails)
            {
             field("Income Category Name";Rec."Income Category Name")
                {
                }
                field("Category Description";Rec."Category Description")
                {
                }
            }  
        }
        area(FactBoxes)
        {
            part(CategoryIncomeFB; "ZYN_Category Income FactBox")
            {
                Caption = 'Category Expense FactBox';
                SubPageLink = "Income Category Name" = field("Income Category Name");
            }
        }
    }
}
    
