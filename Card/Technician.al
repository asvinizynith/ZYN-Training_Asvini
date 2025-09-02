page 50131 "Technician Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "Technician Table";

    layout
    {
        area(Content)
        {
            group(general)
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
        }
    }
}