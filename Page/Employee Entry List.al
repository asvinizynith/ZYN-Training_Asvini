page 50107 "ZYN_Employee Entry List"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'ZYN_Employee Entry List';
    SourceTable = "ZYN_Employee Table";
    UsageCategory = Administration;
    CardPageId = "ZYN_Employee Entry Card";
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(EmployeeDetails)
            {
                field("Employee ID"; Rec."Employee ID")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Employee Role"; Rec."Employee Role")
                {               
                }
                field(Department; Rec.Department)
                {
                }
            }
        }
        area(FactBoxes)
        {
            part("Asset History"; "ZYN_Assets History FactBox")
            {
                Caption = 'Assets History FactBox';
                SubPageLink = "Employee ID" = field("Employee ID");
            }
        }
    }
}
