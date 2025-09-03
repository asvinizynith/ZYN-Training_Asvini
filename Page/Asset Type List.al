page 50116 "Asset type List"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'Asset type List';
    SourceTable = "Asset Type";
    UsageCategory=Administration;
    CardPageId="Asset Type Card";
   
    layout
    {
        area(Content)
        {
            repeater(AssetDetails)
            {
                 Editable=false;
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

    
