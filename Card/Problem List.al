page 50138 "Probelm List Card"
{
    PageType = card;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Problem List";

    layout
    {
        area(Content)
        {
            group(general)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = All;
                }
                field("Customer ID"; Rec."Customer ID")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Issue List"; Rec."Issue List")
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field("Technician Name"; Rec."Technician Name")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)

                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
