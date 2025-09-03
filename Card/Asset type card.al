page 50115 "Asset Type Card"
{
    ApplicationArea = All;
    Caption = 'Asset Type Card';
    PageType = Card;
    SourceTable = "Asset Type";

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