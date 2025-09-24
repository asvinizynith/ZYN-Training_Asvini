page 50171 "ZYN_Index Lines List Part"
{
    PageType = listpart;
    ApplicationArea = All;
    Caption = 'ZYN_Index Lines';
    SourceTable = "ZYN_Index Lines";
    Editable= false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                 field(Year; Rec.Year)
                {
                }
                field("Value"; Rec."Value")
                {
                }
            }
        }
    }
}
    
                