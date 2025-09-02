page 50132 "Technician List"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Technician Table";
    CardPageId = "Technician Card";
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(ID; Rec.ID)
                {

                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {

                    ApplicationArea = All;
                }
                field("Ph.No"; Rec."Ph.No")
                {

                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {

                    ApplicationArea = All;
                }
                field("No Of Problems"; Rec."No Of Problems")
                {
                    ApplicationArea = All;
                }

            }
            part("Problem List"; "Problem List Part")
            {
                ApplicationArea = All;
                SubPageLink = "Technician Name" = field(Name);
            }
        }

    }
}
