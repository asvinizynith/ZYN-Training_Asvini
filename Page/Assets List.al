page 50118 "Asset List"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'Assets List';
    SourceTable = "Asset Table";
    UsageCategory=Administration;
    CardPageId="Asset Card";
   
    layout
    {
        area(Content)
        {
            repeater(Assets)
            {
                 Editable=false;
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
        
         area(FactBoxes)
        {
            part("Assigned Assets"; "Assigned Assets FactBox")
            {
                ApplicationArea = All;
                Caption = 'Assigned Assets FactBox';
               
            }
        
        }
        
    }
   trigger OnAfterGetRecord()
   
   begin
   rec.UpdateAvailable();
   Rec.Modify();
   end;
}
    
