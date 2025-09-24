page 50118 "ZYN_Asset List"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'ZYN_Asset List';
    SourceTable = "ZYN_Asset Table";
    UsageCategory=Administration;
    CardPageId="ZYN_Asset Card";
   
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
            part("Assigned Assets"; "ZYN_Assigned Assets FactBox")
            {
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
    
