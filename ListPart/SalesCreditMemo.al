page 50146 "ZYN_Sales Credit Memo"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sales Header";
    SourceTableView = where("Document Type" = const("Credit Memo"));

    layout
    {
        area(Content)
        {
            repeater(control)
            {
                field("No."; Rec."No.")
                {
                    trigger OnDrillDown()
                    var
                        sales: Page "Sales Credit Memo";
                    begin
                        sales.SetRecord(Rec);
                        sales.Run();
                    end;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Due Date"; Rec."Due Date")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
            }
        }
    }
}