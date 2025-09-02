page 50107 "Employee Entry List"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'Employee Entry List';
    SourceTable = "Employee Table";
    UsageCategory=Administration;
    CardPageId="Employee Entry Card";
    Editable=false;
    layout
    {
        area(Content)
        {
            repeater(EmployeeDetails)
            {
             field("Employee ID";Rec."Employee ID")
                {
                    ApplicationArea = All;
                }
                field("Employee Name";Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Employee Role";Rec."Employee Role")
                {}
                field(Department;Rec.Department)
                {}
               
            }
           
        }
        
        }
    }

    
