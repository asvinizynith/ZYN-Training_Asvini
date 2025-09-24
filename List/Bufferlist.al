page 50137 "ZYN_Buffer Table List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "ZYN_Buffer Table";
    Caption = 'ZYN_Buffer Table List';

    layout
    {
        area(Content)
        {
            repeater(general)
            {
                field("Field ID"; Rec."Field ID")
                {
                }
                field("Field Name"; Rec."Field Name")
                {
                }
                field("Field Value"; Rec."Record Selection")
                {
                }
            }
        }
    }
}
