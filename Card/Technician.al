page 50131 "ZYN_Technician Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "ZYN_Technician Table";
    Caption = 'ZYN_Technician Card';

    layout
    {
        area(Content)
        {
            group(general)
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
        }
    }
}