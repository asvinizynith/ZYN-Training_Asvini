codeunit 50189 "ZYN_Remaining Budget Manager"
{
    procedure GetRemainingBudget(Category: Code[50]): Decimal
    var
        Budget: Record "ZYN_Budget Table";
        Expense: Record "ZYN_Expense Table";
        StartDate: Date;
        EndDate: Date;
        ExpenseAmount: Decimal;
        RemainingBudget: Decimal;
    begin
        // Get current month range
        StartDate := CalcDate('<-CM>', WorkDate()); // first day of current month
        EndDate := CalcDate('<CM>', WorkDate());    // last day of current month
        // Find budget for this category in this month
        Budget.Reset();
        Budget.SetRange("Category", Category);
        Budget.SetRange("From Date", StartDate);
        Budget.SetRange("To Date", EndDate);

        if Budget.FindFirst() then begin
            // Calculate all expenses for this category in this month
            Expense.Reset();
            Expense.SetRange("Category", Category);
            Expense.SetRange("Date", StartDate, EndDate);
            Expense.CalcSums(Amount);
            ExpenseAmount := Expense.Amount;
            RemainingBudget := Budget.Amount - ExpenseAmount;
        end else begin
            ExpenseAmount := 0;
            RemainingBudget := 0;
        end;
        exit(RemainingBudget);
    end;
}
