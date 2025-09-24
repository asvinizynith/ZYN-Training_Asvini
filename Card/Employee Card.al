page 50105 "ZYN_Employee Entry Card"
{
    ApplicationArea = All;
    Caption = 'ZYN_Employee Entry Card';
    PageType = Card;
    SourceTable = "ZYN_Employee Table";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
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
    }
}