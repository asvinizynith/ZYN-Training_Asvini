page 50117 "Asset Card"
{
    ApplicationArea = All;
    Caption = 'Assets Card';
    PageType = Card;
    SourceTable = "Asset Table";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(No; Rec."Asset No")
                {

                }
                field("Asset Name"; Rec."Asset Name")
                {

                }
                field("Serial No"; Rec."Serial No")
                {

                }
                field("Procured Date"; Rec."Procured Date")
                {

                }
                field("Vendor Name"; Rec."Vendor Name")
                {

                }
                field(Available; Rec.Available)
                {

                }

            }
        }


    }


}