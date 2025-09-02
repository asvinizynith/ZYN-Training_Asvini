codeunit 50100 "Recurring Expense"
{
    Subtype = Normal;   // This makes it available for Job Queue

    trigger OnRun()
    var
        RecurringExpense: Record "Recurring Expense Table";
        ExpenseList: Record "Expense table";
    begin

        // Loop through Recurring Expense table
        RecurringExpense.Reset();
        RecurringExpense.SetRange("Next Cycle Date", WorkDate());

        // Filter for today's date or next cycle date
        if RecurringExpense.FindSet() then
            repeat
                // Insert into Expense List 
                ExpenseList."Expense ID" := 0;
                ExpenseList.Init();
                ExpenseList."Date" := WorkDate(); // Or use WorkDate if required
                ExpenseList."Category" := RecurringExpense."Category";
                ExpenseList."Description" := RecurringExpense."Description";
                ExpenseList."Amount" := RecurringExpense."Amount";


                ExpenseList.Insert();
                UpdateNextDate(RecurringExpense);
            until RecurringExpense.Next() = 0;
    end;

    local procedure UpdateNextDate(var RecurringExpense: Record "Recurring Expense Table")
    begin
        case RecurringExpense."Cycle Type" of
            RecurringExpense."Cycle Type"::Weekly:
                RecurringExpense."Next Cycle Date" := CalcDate('<+1W>', RecurringExpense."Next Cycle Date");
            RecurringExpense."Cycle Type"::Monthly:
                RecurringExpense."Next Cycle Date" := CalcDate('<+1M>', RecurringExpense."Next Cycle Date");
            RecurringExpense."Cycle Type"::Quaterly:
                RecurringExpense."Next Cycle Date" := CalcDate('<+3M>', RecurringExpense."Next Cycle Date");
            RecurringExpense."Cycle Type"::"Half Yearly":
                RecurringExpense."Next Cycle Date" := CalcDate('<+6M>', RecurringExpense."Next Cycle Date");
            RecurringExpense."Cycle Type"::Yearly:
                RecurringExpense."Next Cycle Date" := CalcDate('<+1Y>', RecurringExpense."Next Cycle Date");
        end;
        RecurringExpense.Modify(true);
    end;



}