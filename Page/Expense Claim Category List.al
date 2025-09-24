page 50134 "ZYN_ExpenseClaim Category List"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'ZYN_ExpenseClaim Category List';
    SourceTable = "ZYN_Expense Claim Category";
    UsageCategory=Administration;
    CardPageId="ZYN_ExpenseClaim Category Card";
   
    layout
    {
        area(Content)
        {
            repeater(ExpenseClaimDetails)
            {
                 Editable=false;
               field("Category Code"; Rec."Category Code")
                {
                }
                field("Category Name"; Rec."Category Name")
                {
                }
                field(Subtype; Rec.Subtype)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Amount Limit"; Rec."Amount Limit")
                {
                }
            }
        }
    }
}

    
