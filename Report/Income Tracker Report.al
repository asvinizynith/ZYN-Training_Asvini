report 50184 "Income Tracker Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Income_Tracker; "Income Table")
        {
            DataItemTableView = sorting("Income Category");

            trigger OnAfterGetRecord()
            begin
                if (Income_Tracker."Income Date" >= StartDate) and (Income_Tracker."Income Date" <= EndDate) then begin
                    if (IncomeCategoryFilter = '') or (Income_Tracker."Income Category" = IncomeCategoryFilter) then begin
                        // Add each line into ExcelBuffer
                        ExcelBuffer.AddColumn(Income_Tracker."Income Category", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(Income_Tracker."Income Date", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
                        ExcelBuffer.AddColumn(Income_Tracker."Income Amount", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.NewRow();

                        // Track total for selected category
                        TotalAmount += Income_Tracker."Income Amount";
                        RecordsFound := true;
                    end;
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Filter_Group)
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }
                    field(IncomeCategoryFilter; IncomeCategoryFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Income Category';
                        TableRelation = "Income Category"."Income Category Name";
                    }
                }
            }
        }
    }

    var
        StartDate: Date;
        EndDate: Date;
        ExcelBuffer: Record "Excel Buffer" temporary;
        IncomeCategoryFilter: Code[50];
        TotalAmount: Decimal;
        RecordsFound: Boolean;

    trigger OnPreReport()
    begin
        ExcelBuffer.DeleteAll();
        TotalAmount := 0;
        RecordsFound := false;

        // Header row
        ExcelBuffer.AddColumn('Income Category', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Income Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn('Income Amount', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.NewRow();
    end;

    trigger OnPostReport()
    var
        FileName: Text;
    begin
        if not RecordsFound then begin
            ExcelBuffer.AddColumn('No data found for the selected filters.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.NewRow();
        end else begin
            ExcelBuffer.NewRow();
            ExcelBuffer.AddColumn('TOTAL', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(TotalAmount, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
            ExcelBuffer.NewRow();
        end;

        FileName := 'Expense_Report_' +
                    (IncomeCategoryFilter <> '' ? IncomeCategoryFilter : 'All') + '_' +
                    Format(Today, 0, '<Year4><Month,2><Day,2>') + '.xlsx';

        ExcelBuffer.CreateNewBook('Income Tracker Report');
        ExcelBuffer.WriteSheet('Incomes', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename(FileName);
        ExcelBuffer.OpenExcel();
    end;
}
