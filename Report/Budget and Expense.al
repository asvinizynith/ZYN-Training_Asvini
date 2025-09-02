report 50101 "Budget Vs Expense Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        // Only a dummy dataitem to trigger report
        dataitem(Dummy; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = const(1));

            trigger OnAfterGetRecord()
            var
                Category: Record "Expense & Budget Category";
                Expense: Record "Expense Table";
                Budget: Record "Budget Table";
                Income: Record "Income Table";
                StartDate: Date;
                EndDate: Date;
                ExpensecatAmt: Decimal;
                BudgetAmt: Decimal;
                MonthNo: Integer;
                MonthName: Text[30];
                Monthprinted: Boolean;
                IncomeAmt: Decimal;
                TotalExpense: Decimal;
                Savings: Decimal;
            begin
                for MonthNo := 1 to 12 do begin
                    StartDate := DMY2DATE(1, MonthNo, Year);
                    EndDate := CALCDATE('<CM>', StartDate); // last day of month
                    MonthName := Format(StartDate, 0, '<Month Text>');
                    Monthprinted := false;
                    TotalExpense := 0;
                    // ---- Income Caculation ----
                    IncomeAmt := 0;
                    Income.Reset();
                    Income.SetRange("Income Date", StartDate, EndDate);
                    Income.CalcSums("Income Amount");
                    IncomeAmt := Income."Income Amount";

                    Category.Reset();
                    if Category.FindSet() then
                        repeat
                            ExpensecatAmt := 0;
                            BudgetAmt := 0;

                            // ---- Expense Calculation ----
                            Expense.Reset();
                            Expense.SetRange("Category", Category."Category Name");
                            Expense.SetRange(Date, StartDate, EndDate);
                            Expense.CalcSums(Amount);
                            ExpensecatAmt := Expense.Amount;


                            // ---- Budget Calculation ----
                            Budget.Reset();
                            Budget.SetRange("Category", Category."Category Name");
                            Budget.SetFilter("From Date", '..%1', EndDate);
                            Budget.SetFilter("To Date", '%1..', StartDate);
                            Budget.CalcSums(Amount);
                            BudgetAmt := Budget.Amount;

                            ExcelBuffer.NewRow();
                            if not Monthprinted then begin
                                ExcelBuffer.AddColumn(MonthName, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                                Monthprinted := true;
                            end else
                                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                            ExcelBuffer.AddColumn(Category."Category Name", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                            ExcelBuffer.AddColumn(BudgetAmt, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                            ExcelBuffer.AddColumn(ExpensecatAmt, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);

                            //------ Total Expense Calculation --------//
                            Expense.SetRange(Date, StartDate, EndDate);
                            Expense.CalcSums(Amount);
                            ExpensecatAmt := Expense.Amount;
                            TotalExpense += ExpensecatAmt;

                        until Category.Next() = 0;
                    Savings := IncomeAmt - TotalExpense;

                    ExcelBuffer.NewRow();
                    ExcelBuffer.AddColumn('TotalIncome', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(IncomeAmt, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.NewRow();
                    ExcelBuffer.AddColumn('TotalExpense', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(TotalExpense, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.NewRow();
                    ExcelBuffer.AddColumn('Savings', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(Savings, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.NewRow();

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
                    field(Year; Year)
                    {
                        ApplicationArea = All;
                        Caption = 'Year';
                    }
                }
            }
        }
    }

    var
        Year: Integer;
        ExcelBuffer: Record "Excel Buffer" temporary;
        RecordsFound: Boolean;

    trigger OnPreReport()
    begin
        ExcelBuffer.DeleteAll();
        RecordsFound := false;

        // Header
        ExcelBuffer.AddColumn('Month', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Category', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Budget Amount', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Expense Amount', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.NewRow();
    end;

    trigger OnPostReport()
    var
        FileName: Text;
    begin
        if not RecordsFound then begin
            ExcelBuffer.AddColumn('No data found for the selected filters.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.NewRow();
        end;

        FileName := 'BudgetVsExpense_' + Format(Year) + '.xlsx';
        ExcelBuffer.CreateNewBook('Budget Vs Expense Report');
        ExcelBuffer.WriteSheet('BudgetVsExpense', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename(FileName);
        ExcelBuffer.OpenExcel();
    end;
}
