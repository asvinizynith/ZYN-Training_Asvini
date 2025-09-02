page 50109 "Leave Category List"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'Leave Category List';
    SourceTable = "Leave Category Table";
    UsageCategory=Administration;
    CardPageId="Leave Category Card";
   

    layout
    {
        area(Content)
        {
            repeater(LeaveCategory)
            {
                 Editable=false;
             field("Leave Category";Rec."Leave Category")
                {
                    ApplicationArea = All;
                }
                field(Description;Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("No. Of Days Allowed";Rec."No. Of Days Allowed")
                {

                }
                
            }
           
        }
        
        }
    }

    
