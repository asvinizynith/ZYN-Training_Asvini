page 50173 "Expense List"
{
    ApplicationArea = All;
    Caption = 'Expenses Tracker';
    PageType = List;
    SourceTable = "Expense Table";
    UsageCategory = Administration;
    CardPageId = "Expense Card"; // Ensures standard 'New' works too
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Description; Rec.Description) { }
                field(Amount; Rec.Amount) { }
                field("Date"; Rec."Date") { }
                field("Category"; Rec."Category")
                {
                    ApplicationArea = All;

                }
            }
        }
          area(FactBoxes)
        {
                part(BudgetFactbox; "Budget FactBox")
                {
                    ApplicationArea = All;
                } 
           
    }
    }
    
    actions
    {
        area(Processing)
        {
            action(Action)
            {
                ApplicationArea = All;
                Caption = 'Category List';
                Image = List;
                RunObject = page "Expense Category List ";

            }
            action(ExpenseTracker)
            {
                ApplicationArea = All;
                Caption = 'Expense Tracker Report';
                Image = Report;
                RunObject = report "Expense Tracker Report";
            }
            action(BudgetVsExpense )
            {
                ApplicationArea = All;
                Caption = 'Budget Vs Expense Report';
                Image = Report;
                RunObject = report "Budget Vs Expense Report";
            }
        }
         
    }
     
        }
    

