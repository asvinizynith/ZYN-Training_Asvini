page 50108 "ZYN_Leave Category Card"
{
    ApplicationArea = All;
    Caption = 'ZYN_Leave Category Card';
    PageType = Card;
    SourceTable = "ZYN_Leave Category Table";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(Description; Rec.Description)
                {
                }
                field("Leave Category"; Rec."Leave Category")
                {
                }
                field("No. Of Days Allowed"; Rec."No. Of Days Allowed")
                {
                }
            }
        }
    }
}