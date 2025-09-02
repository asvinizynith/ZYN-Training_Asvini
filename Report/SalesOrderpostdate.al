report 50100 "Orders By Post Date"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Salesorder; "Sales Header")
        {
            trigger OnAfterGetRecord()
            begin
                Salesorder.SetRange("Document Type", "Document Type"::Order);
                Salesorder.SetRange(Status, Status::Open);
                Salesorder."Posting Date" := "Selected Date";
                Salesorder.Modify();
                "Order Count" := "Order Count" + 1;

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                group(EnterDate)
                {
                    field("Selected Date"; "Selected Date")
                    {
                        ApplicationArea = All;
                        Caption = 'New Posting Date';
                    }
                }
            }
        }

        
    }

    var
        "Selected Date": Date;
        "Order Count": Integer;

    trigger OnPostReport()
    begin
        Message('There are %1 open sales order on %2', "Order Count", Format("Selected Date"));
    end;
}