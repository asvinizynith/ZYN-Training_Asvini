page 50142 "ZYN_Beginning Text Code"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "ZYN_Text Code Table";
    Caption = 'ZYN_Beginning Text Code';

    layout
    {
        area(Content)
        {
            repeater(BeginningLine)
            {
                field("Line No"; Rec."Line No")
                {
                }
                field(BeginningText; Rec.Text)
                {
                }
            }
        }
    }
}