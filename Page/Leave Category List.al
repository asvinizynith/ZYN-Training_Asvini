page 50109 "ZYN_Leave Category List"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'ZYN_Leave Category List';
    SourceTable = "ZYN_Leave Category Table";
    UsageCategory=Administration;
    CardPageId="ZYN_Leave Category Card";
   
    layout
    {
        area(Content)
        {
            repeater(LeaveCategory)
            {
                 Editable=false;
             field("Leave Category";Rec."Leave Category")
                {
                }
                field(Description;Rec.Description)
                {
                }
                field("No. Of Days Allowed";Rec."No. Of Days Allowed")
                {
                }   
            }  
        }
        }
    }

    
