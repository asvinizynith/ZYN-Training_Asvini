page 50174 "Expense Category List "
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'Expense Category List';
    SourceTable = "Expense & Budget Category";

    layout
    {
        area(Content)
        {
            repeater(CategoryDetails)
            {
             field("Category Name"; Rec."Category Name")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
           
        }
        area(FactBoxes)
        {
            part(CategoryExpenseFB; "Category Expense FactBox")
            {
                ApplicationArea = All;
                Caption = 'Category Expense FactBox';
                SubPageLink = "Category Name" = field("Category Name");
            }
            part(BudgetCueFB; "Budget Cue FactBox")
            {
                ApplicationArea = All;
                Caption = 'Budget Cue FactBox';
                SubPageLink = "Category Name" = field("Category Name");
            }
        }
    }
}
    
