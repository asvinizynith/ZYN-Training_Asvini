page 50171 "Index Lines List Part"

{
    PageType = listpart;
    ApplicationArea = All;
    Caption = 'Index Lines';
    SourceTable = "Index Lines";
    Editable= false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                 field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field("Value"; Rec."Value")
                {
                    ApplicationArea = All;
                }
            }
        }

    }
}
    
                