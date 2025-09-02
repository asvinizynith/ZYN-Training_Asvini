codeunit 50189 "Remaining Budget"
{
    procedure GetRemainingBudget(Category: Code[50]): Decimal
    var
        BudgetRec: Record "Budget Table";
        ExpenseRec: Record "Expense Table";
        StartDate: Date;
        EndDate: Date;
        ExpenseAmount: Decimal;
        RemainingBudget: Decimal;
    begin
        // Get current month range
        StartDate := CalcDate('<-CM>', WorkDate()); // first day of current month
        EndDate := CalcDate('<CM>', WorkDate());    // last day of current month

        // Find budget for this category in this month
        BudgetRec.Reset();
        BudgetRec.SetRange("Category", Category);
        BudgetRec.SetRange("From Date", StartDate);
        BudgetRec.SetRange("To Date", EndDate);

        if BudgetRec.FindFirst() then begin
            // Calculate all expenses for this category in this month
            ExpenseRec.Reset();
            ExpenseRec.SetRange("Category", Category);
            ExpenseRec.SetRange("Date", StartDate, EndDate);
            ExpenseRec.CalcSums(Amount);

            ExpenseAmount := ExpenseRec.Amount;
            RemainingBudget := BudgetRec.Amount - ExpenseAmount;
        end else begin
            ExpenseAmount := 0;
            RemainingBudget := 0;
        end;

        exit(RemainingBudget);
    end;
}
