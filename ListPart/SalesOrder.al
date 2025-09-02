page 50148 SalesOrder
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
                    ApplicationArea = All;
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
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
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
