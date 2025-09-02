page 50145 SalesInvoice
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sales Header";
    SourceTableView = where("Document Type" = const(Invoice));

    layout
    {
        area(Content)
        {
            repeater(control)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        sales: Page "Sales Invoice";
                    begin
                        sales.SetRecord(Rec);
                        sales.Run();
                    end;

                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }

            }
        }

    }
}