page 50134 "Expense Claim Category List"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'Expense Claim Category List';
    SourceTable = "Expense Claim Category Table";
    UsageCategory=Administration;
    CardPageId="Expense Claim Category Card";
   
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

    
