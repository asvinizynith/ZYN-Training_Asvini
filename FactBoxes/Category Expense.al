page 50175 "Category Expense FactBox"
{
    PageType = CardPart;
    SourceTable = "Expense & Budget Category";
    ApplicationArea = All;
    Caption = 'Category Expense Info';

    layout
    {
        area(content)
        {
            cuegroup("Category Expense Info")
            {
                field("Current Year"; CurrentYear)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Current Year';
                    trigger OnDrillDown()
                    var
                        Expense: Record "Expense Table";
                    begin
                        Expense.SetRange("Category", Rec."Category Name");
                        StartDate := CALCDATE('<-CY>', WORKDATE);
                        EndDate := CALCDATE('<CY>', WORKDATE);
                        Expense.SetRange("Date", StartDate, EndDate);

                        PAGE.Run(PAGE::"Expense List", Expense);
                    end;
                }
                field("Current Month"; CurrentMonth)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Current Month';
                    trigger OnDrillDown()
                    var
                        Expense: Record "Expense Table";
                    begin
                        Expense.SetRange("Category", Rec."Category Name");
                        StartDate := CALCDATE('<-CM>', WORKDATE);
                        EndDate := CALCDATE('<CM>', WORKDATE);
                        Expense.SetRange("Date", StartDate, EndDate);          // Till today
                        PAGE.Run(PAGE::"Expense List", Expense);
                    end;
                }
                field("Current Half Year"; CurrentHalfYear)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Current Half Year';
                    trigger OnDrillDown()
                    var
                        Expense: Record "Expense Table";
                    begin
                        Expense.SetRange("Category", Rec."Category Name");
                        if Date2DMY(WORKDATE, 2) <= 6 then begin
                            StartDate := CALCDATE('<-CY>', WORKDATE);        // Jan 1 of current year
                            EndDate := CALCDATE('<-CY>+6M-1D', WORKDATE);    // Jun 30 of current year
                        end else begin
                            StartDate := CALCDATE('<-CY>+6M', WORKDATE);     // Jul 1 of current year
                            EndDate := CALCDATE('<CY>', WORKDATE);   // Dec 31 of current year
                        end;
                        Expense.SetRange("Date", StartDate, EndDate);
                        PAGE.Run(PAGE::"Expense List", Expense);

                    end;
                }
                field("Current Quarter"; CurrentQuarter)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Current Quarter';
                    trigger OnDrillDown()
                    var
                        Expense: Record "Expense Table";
                    begin
                        Expense.SetRange("Category", Rec."Category Name");
                        StartDate := CALCDATE('<-CQ>', WORKDATE);
                        EndDate := CALCDATE('<CQ>', WORKDATE);
                        Expense.SetRange("Date", StartDate, EndDate); // If you want "till WorkDate"
                        PAGE.Run(PAGE::"Expense List", Expense);
                    end;
                }
            }
            field(RemainingBudget; "RemainingBudget")
            {
                ApplicationArea = All;
                Caption = 'Remaining Budget';
                Editable = false;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        Expense: Record "Expense Table";
    begin
        Month := DATE2DMY(WorkDate(), 2);
        Year := DATE2DMY(WorkDate(), 3);

        // -------------------
        // Current Year
        // -------------------
        Expense.Reset();
        Expense.SetRange("Category", Rec."Category Name");
        StartDate := CALCDATE('<-CY>', WORKDATE);
        EndDate := CALCDATE('<CY>', WORKDATE);
        Expense.SetRange("Date", StartDate, EndDate);
        Expense.CalcSums(Amount);
        CurrentYear := Expense.Amount;

        // -------------------
        // Current Month
        // -------------------
        Expense.Reset();
        Expense.SetRange("Category", Rec."Category Name");
        StartDate := CALCDATE('<-CM>', WORKDATE);
        EndDate := CALCDATE('<CM>', WORKDATE);                  // Till today
        Expense.SetRange("Date", StartDate, EndDate);
        Expense.CalcSums(Amount);
        CurrentMonth := Expense.Amount;

        // -------------------
        // Current Half-Year
        // -------------------
        Expense.Reset();
        Expense.SetRange("Category", Rec."Category Name");

        if Date2DMY(WORKDATE, 2) <= 6 then begin
            StartDate := CALCDATE('<-CY>', WORKDATE);        // Jan 1 of current year
            EndDate := CALCDATE('<-CY>+6M-1D', WORKDATE);    // Jun 30 of current year
        end else begin
            StartDate := CALCDATE('<-CY>+6M', WORKDATE);     // Jul 1 of current year
            EndDate := CALCDATE('<CY>', WORKDATE);   // Dec 31 of current year
        end;

        Expense.SetRange("Date", StartDate, EndDate);
        Expense.CalcSums(Amount);
        CurrentHalfYear := Expense.Amount;

        // -------------------
        // Current Quarter
        // -------------------
        Expense.Reset();
        Expense.SetRange("Category", Rec."Category Name");

        StartDate := CALCDATE('<-CQ>', WORKDATE);
        EndDate := CALCDATE('<CQ>', WORKDATE);

        Expense.SetRange("Date", StartDate, EndDate);
        Expense.CalcSums(Amount);
        CurrentQuarter := Expense.Amount;

        // --- Your existing calculations for CurrentYear, CurrentMonth, etc. ---

        // Get Remaining Budget for this category
        RemainingBudget := RemainingBudgetMgt.GetRemainingBudget(Rec."Category Name");
    end;





    var
        CurrentYear: Decimal;
        CurrentMonth: Decimal;
        CurrentHalfYear: Decimal;
        CurrentQuarter: Decimal;
        StartDate: Date;
        EndDate: Date;
        Month: Integer;
        Year: Integer;
        RemainingBudgetMgt: Codeunit "Remaining Budget";
        RemainingBudget: Decimal;
}
