page 50144 "ZYN_Ending Text Code"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "ZYN_Text Code Table";
    Caption = 'ZYN_Ending Text Code';

    layout
    {
        area(Content)
        {
            repeater(BeginningLine)
            {
                field("Line No"; Rec."Line No")
                {
                }
                field(EndingText; Rec.Text)
                {
                }
            }
        }
    }
}