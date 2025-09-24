page 50115 "ZYN_Asset Type Card"
{
    ApplicationArea = All;
    Caption = 'ZYN_Asset Type Card';
    PageType = Card;
    SourceTable = "ZYN_Asset Type Table";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(No; Rec.No)
                {
                }
                field("Asset Category"; Rec."Asset Category")
                {
                }
                field("Asset Name"; Rec."Asset Name")
                {
                }
            }
        }
    }
}