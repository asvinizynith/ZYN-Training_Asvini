page 50136 "Problem List Part"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "Problem List";
    CardPageId = "Probelm List Card";
    layout
    {
        area(Content)
        {
            repeater(control)
            {
                /*  field("Entry No"; Rec."Entry No")
                  {
                      ApplicationArea = All;
                  }*/
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
