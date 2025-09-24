page 50174 "ZYN_Expense Category List"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'ZYN_Expense Category List';
    SourceTable = "ZYN_Expense & Budget Category";

    layout
    {
        area(Content)
        {
            repeater(CategoryDetails)
            {
             field("Category Name"; Rec."Category Name")
                {                  
                }
                field(Description; Rec.Description)
                {
                }
            }    
        }
        area(FactBoxes)
        {
            part(CategoryExpenseFB; "ZYN_Category Expense FactBox")
            {
                Caption = 'Category Expense FactBox';
                SubPageLink = "Category Name" = field("Category Name");
            }
            part(BudgetCueFB; "ZYN_Budget Cue FactBox")
            {
                Caption = 'Budget Cue FactBox';
                SubPageLink = "Category Name" = field("Category Name");
            }
        }
    }
}
    
