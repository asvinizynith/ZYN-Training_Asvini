page 50148 "ZYN_Sales Order"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sales Header";
    SourceTableView = where("Document Type" = const(Order));

    layout
    {
        area(Content)
        {
            repeater(control)
            {
                field("No."; Rec."No.")
                {
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        sales: Page "Sales Order";
                    begin
                        sales.SetRecord(Rec);
                        sales.Run();
                    end;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
            }
        }
    }
}
