page 50149 "ZYN_Companies Card"
{
    ApplicationArea = All;
    Caption = 'ZYN_Companies Card';
    PageType = Card;
    SourceTable = "ZYN_Companies Table";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(Name; Rec.Name)
                {
                }
                field("Display Name"; Rec."Display Name")
                {
                }
                field(IsMaster; Rec.IsMaster)
                {
                }
                field("Master Company Name"; Rec."Master Company Name")
                {
                }
                field("Master Company ID"; Rec."Master Company ID")
                {
                }
                field("Company Id"; Rec.Id)
                {
                }
                field("Evaluation Company"; Rec."Evaluation Company")
                {
                }
            }
        }
    }
}