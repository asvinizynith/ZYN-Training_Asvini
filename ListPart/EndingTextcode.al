page 50144 "Ending Text Code"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "Text Code Table";

    layout
    {
        area(Content)
        {
            repeater(BeginningLine)
            {
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = ALl;
                }
                field(EndingText; Rec.Text)
                {
                    ApplicationArea = All;
                }


            }

        }
    }
}