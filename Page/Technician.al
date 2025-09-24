page 50132 "ZYN_Technician List"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "ZYN_Technician Table";
    CardPageId = "ZYN_Technician Card";
    Caption = 'ZYN_Technician List';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(ID; Rec.ID)
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Ph.No"; Rec."Ph.No")
                {
                }
                field(Department; Rec.Department)
                {
                }
                field("No Of Problems"; Rec."No Of Problems")
                {
                }
            }
            part("Problem List"; "ZYN_Problem List Part")
            {
                Caption = 'ZYN_Problem List Part';
                SubPageLink = "Technician Name" = field(Name);
            }
        }
    }
}
