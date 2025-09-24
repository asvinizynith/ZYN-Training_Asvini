page 50138 "ZYN_Probelm List Card"
{
    PageType = card;
    ApplicationArea = All;
    Caption = 'ZYN_Probelm List Card';
    UsageCategory = Lists;
    SourceTable = "ZYN_Problem List";

    layout
    {
        area(Content)
        {
            group(general)
            {
                field("Entry No"; Rec."Entry No")
                {
                }
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
