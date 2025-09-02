page 50142 "Text Code"
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

                field(BeginningText; Rec.Text)
                {
                    ApplicationArea = All;
                }


            }

        }
    }
}