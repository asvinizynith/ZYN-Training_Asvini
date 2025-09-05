page 50125 Myrolecenter 

{
    PageType = RoleCenter;
    Caption = 'My Role Center Asvini';
    ApplicationArea = All;
layout
{
    area(RoleCenter)
    {
        part(myCue; 50128)
        {
            ApplicationArea = All;
            Caption = 'My Cue';
           
            
        }
        part("Subscription Cues"; 50130)
        {
            ApplicationArea = All;
            Caption = 'Subscription Cues';
            
        }
    }
}
    actions
    {
        area(Sections)
        {
         group(AssetManagement)
            {
                caption = 'Asset Management';
                action(EmployeeAssetList)
                {
                    Caption = 'Employee Asset List';
                    RunObject = page "Employee Asset List";
                    ApplicationArea = All;

                }
                action(AssetList)
                {
                    Caption = 'Asset List';
                    RunObject = page "Asset List";
                    ApplicationArea = All;
                }
                action(AssetType)
                {
                    Caption = 'Asset Type';
                    RunObject = page "Asset type List";
                    ApplicationArea = All;
                
                }
            }
            group(ExpenseVSBudgetManagement)
            {
                caption = 'Expense VS Budget Management';
                action(ExpenseCategory)
                {
                    Caption = 'Expense Category List';
                    RunObject = page "Expense Category List ";
                    ApplicationArea = All;

                }
                action(ExpenseList)
                {
                    Caption = 'Expense List';
                    RunObject = page "Expense List";
                    ApplicationArea = All;
                }
                action(RecurringExpense)
                {
                    Caption = 'Recurring Expense list';
                    RunObject = page "Recurring Expense List";
                    ApplicationArea = All;
                }
                action(Budget)
                {
                    Caption = 'Budget list';
                    RunObject = page "Budget List";
                    ApplicationArea = All;
                }
                 action(IncomeCategory)
                {
                    Caption = 'Income Category list';
                    RunObject = page "Income Category List ";
                    ApplicationArea = All;
                }
                action(Income)
                {
                    Caption = 'Income list';
                    RunObject = page "Income List";
                    ApplicationArea = All;
                }
            }
            group(LeaveManagement)
            {
                caption = 'Leave Management';
                action(Employee)
                {
                    Caption = 'Employee List';
                    RunObject = page "Employee Entry List";
                    ApplicationArea = All;

                }
                action(LeaveCategory)
                {
                    Caption = 'Leave Category List';
                    RunObject = page "Leave Category List";
                    ApplicationArea = All;
                }
                action(LeaveRequest)
                {
                    Caption = 'Leave Request list';
                    RunObject = page "Leave Request List";
                    ApplicationArea = All;
                }
                
                }
        }
        area(Embedding)
        {
            action(Customers)
            {
                Caption = 'Customers';
                RunObject = page "Customer List";
           ApplicationArea = All;
            
        }
    }
}
}

profile Zynith
{
    ProfileDescription = 'Zynith';
    RoleCenter = Myrolecenter;
    Caption = 'Zynith';
}
   
    
    