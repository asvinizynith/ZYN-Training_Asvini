page 50173 "ZYN_Expense List"
{
    ApplicationArea = All;
    Caption = 'ZYN_Expenses Tracker';
    PageType = List;
    SourceTable = "ZYN_Expense Table";
    UsageCategory = Administration;
    CardPageId = "ZYN_Expense Card"; // Ensures standard 'New' works too
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
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
            }
        }
          area(FactBoxes)
        {
                part(BudgetFactbox; "ZYN_Budget FactBox")
                {
                    Caption='ZYN_Budget FactBox';
                }    
    }
    }   
    actions
    {
        area(Processing)
        {
            action(Action)
            {
                Caption = 'Category List';
                Image = List;
                RunObject = page "ZYN_Expense Category List";
            }
            action(ExpenseTracker)
            {
                Caption = 'Expense Tracker Report';
                Image = Report;
                RunObject = report "ZYN_Expense Tracker Report";
            }
            action(BudgetVsExpense )
            {
                Caption = 'Budget Vs Expense Report';
                Image = Report;
                RunObject = report "ZYN_Budget Vs Expense Report";
            }
        }    
        }
        }
    

