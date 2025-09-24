page 50136 "ZYN_Problem List Part"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "ZYN_Problem List";
    CardPageId = "ZYN_Probelm List Card";
    layout
    {
        area(Content)
        {
            repeater(control)
            {
                field("Customer ID"; Rec."Customer ID")
                {
                }
                field("Customer Name"; Rec."Customer Name")
                {
                }
                field("Issue List"; Rec."Issue List")
                {
                }
                field(Department; Rec.Department)
                {
                }
                field("Technician Name"; Rec."Technician Name")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }
}
