page 50137 "Buffer Table List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Buffer Table";

    layout
    {
        area(Content)
        {
            repeater(general)
            {
                field("Field ID"; Rec."Field ID")
                {
                    ApplicationArea = All;
                }
                field("Field Name"; Rec."Field Name")

                {
                    ApplicationArea = All;

                }
                field("Field Value"; Rec."Record Selection")
                {
                    ApplicationArea = All;
                }


            }
        }
    }
}
