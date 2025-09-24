page 50124 "ZYN_Plan Card"
{
    ApplicationArea = All;
    Caption = 'ZYN_Plan Card';
    PageType = Card;
    SourceTable = "ZYN_Plan Table";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Plan ID"; Rec."Plan ID")
                {
                }
                field("Plan Name"; Rec."Plan Name")
                {
                }
                field("Monthly Fee"; Rec."Monthly Fee")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }
}