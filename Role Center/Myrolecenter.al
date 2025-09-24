page 50125 ZYN_MyRoleCenter 
{
    PageType = RoleCenter;
    Caption = 'My Role Center Asvini';
    ApplicationArea = All;
layout
{
    area(RoleCenter)
    {
        part(myCue; ZYN_MyCue)
        {
            Caption = 'My Cue'; 
        }
        part("Subscription Cues"; "ZYN_Subscription Cues")
        {
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
                    RunObject = page "ZYN_Employee Asset List";
                }
                action(AssetList)
                {
                    Caption = 'Asset List';
                    RunObject = page "ZYN_Asset List";
                }
                action(AssetType)
                {
                    Caption = 'Asset Type';
                    RunObject = page "ZYN_Asset type List";
                }
            }
            group(ExpenseVSBudgetManagement)
            {
                caption = 'Expense VS Budget Management';
                action(ExpenseCategory)
                {
                    Caption = 'Expense Category List';
                    RunObject = page "ZYN_Expense Category List";
                }
                action(ExpenseList)
                {
                    Caption = 'Expense List';
                    RunObject = page "ZYN_Expense List";
                }
                action(RecurringExpense)
                {
                    Caption = 'Recurring Expense list';
                    RunObject = page "ZYN_Recurring Expense List";
                }
                action(Budget)
                {
                    Caption = 'Budget list';
                    RunObject = page "ZYN_Budget List";
                }
                 action(IncomeCategory)
                {
                    Caption = 'Income Category list';
                    RunObject = page "ZYN_Income Category List";
                }
                action(Income)
                {
                    Caption = 'Income list';
                    RunObject = page "ZYN_Income List";
                }
            }
            group(LeaveManagement)
            {
                caption = 'Leave Management';
                action(Employee)
                {
                    Caption = 'Employee List';
                    RunObject = page "ZYN_Employee Entry List";
                }
                action(LeaveCategory)
                {
                    Caption = 'Leave Category List';
                    RunObject = page "ZYN_Leave Category List";
                }
                action(LeaveRequest)
                {
                    Caption = 'Leave Request list';
                    RunObject = page "ZYN_Leave Request List";
                } 
                }
        }
        area(Embedding)
        {
            action(Customers)
            {
                Caption = 'Customers';
                RunObject = page "Customer List";   
        }
    }
}
}

profile Zynith
{
    ProfileDescription = 'Zynith';
    RoleCenter = ZYN_MyRoleCenter;
    Caption = 'Zynith';
}
   
    
    