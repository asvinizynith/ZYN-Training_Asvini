page 50116 "ZYN_Asset type List"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'ZYN_Asset type List';
    SourceTable = "ZYN_Asset Type Table";
    UsageCategory=Administration;
    CardPageId="ZYN_Asset Type Card";
   
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

    
