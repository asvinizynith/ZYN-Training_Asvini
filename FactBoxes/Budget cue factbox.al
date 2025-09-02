page 50190 "Budget Cue FactBox"
{
    PageType = CardPart;
    SourceTable = "Expense & Budget Category";
    ApplicationArea = All;
    Caption = 'Budget Allaction Info';

    layout
    {
        area(content)
        {
            cuegroup("Budget Allacation Info")
            {
                field("Current Year"; CurrentYear)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Current Year';
                    trigger OnDrillDown()
                    var
                        Budget: Record "Budget Table";
                    begin
                        Budget.SetRange(Category, Rec."Category Name");
                        StartDate := CALCDATE('<-CY>', WORKDATE);
                        EndDate := CALCDATE('<CY>', WORKDATE);
                        Budget.SetRange("From Date", StartDate, EndDate);

                        PAGE.Run(PAGE::"Budget List", Budget);
                    end;
                }
                field("Current Month"; CurrentMonth)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Current Month';
                    trigger OnDrillDown()
                    var
                        Budget: Record "Budget Table";
                    begin
                        Budget.SetRange("Category", Rec."Category Name");
                        StartDate := CALCDATE('<-CM>', WORKDATE);
                        EndDate := CALCDATE('<CM>', WORKDATE);
                        Budget.SetRange("From Date", StartDate, EndDate);          // Till today
                        PAGE.Run(PAGE::"Budget List", Budget);
                    end;
                }
                field("Current Half Year"; CurrentHalfYear)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Current Half Year';
                    trigger OnDrillDown()
                    var
                        Budget: Record "Budget Table";
                    begin
                        Budget.SetRange("Category", Rec."Category Name");
                        if Date2DMY(WORKDATE, 2) <= 6 then begin
                            StartDate := CALCDATE('<-CY>', WORKDATE);        // Jan 1 of current year
                            EndDate := CALCDATE('<-CY>+6M-1D', WORKDATE);    // Jun 30 of current year
                        end else begin
                            StartDate := CALCDATE('<-CY>+6M', WORKDATE);     // Jul 1 of current year
                            EndDate := CALCDATE('<CY>', WORKDATE);   // Dec 31 of current year
                        end;
                        Budget.SetRange("From Date", StartDate, EndDate);
                        PAGE.Run(PAGE::"Budget List", Budget);

                    end;
                }
                field("Current Quarter"; CurrentQuarter)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Current Quarter';
                    trigger OnDrillDown()
                    var
                        Budget: Record "Budget Table";
                    begin
                        Budget.SetRange("Category", Rec."Category Name");
                        StartDate := CALCDATE('<-CQ>', WORKDATE);
                        EndDate := CALCDATE('<CQ>', WORKDATE);
                        Budget.SetRange("From Date", StartDate, EndDate); // If you want "till WorkDate"
                        PAGE.Run(PAGE::"Budget List", Budget);
                    end;
                }
            }

        }
    }

    trigger OnAfterGetRecord()
    var
        Budget: Record "budget Table";
    begin
        Month := DATE2DMY(WorkDate(), 2);
        Year := DATE2DMY(WorkDate(), 3);

        // -------------------
        // Current Year
        // -------------------
        Budget.Reset();
        Budget.SetRange("Category", Rec."Category Name");
        StartDate := CALCDATE('<-CY>', WORKDATE);
        EndDate := CALCDATE('<CY>', WORKDATE);
        Budget.SetRange("From Date", StartDate, EndDate);
        Budget.CalcSums(Amount);
        CurrentYear := Budget.Amount;

        // -------------------
        // Current Month
        // -------------------
        Budget.Reset();
        Budget.SetRange("Category", Rec."Category Name");
        StartDate := CALCDATE('<-CM>', WORKDATE);
        EndDate := CALCDATE('<CM>', WORKDATE);                  // Till today
        Budget.SetRange("From Date", StartDate, EndDate);
        Budget.CalcSums(Amount);
        CurrentMonth := Budget.Amount;

        // -------------------
        // Current Half-Year
        // -------------------
        Budget.Reset();
        Budget.SetRange("Category", Rec."Category Name");

        if Date2DMY(WORKDATE, 2) <= 6 then begin
            StartDate := CALCDATE('<-CY>', WORKDATE);        // Jan 1 of current year
            EndDate := CALCDATE('<-CY>+6M-1D', WORKDATE);    // Jun 30 of current year
        end else begin
            StartDate := CALCDATE('<-CY>+6M', WORKDATE);     // Jul 1 of current year
            EndDate := CALCDATE('<CY>', WORKDATE);   // Dec 31 of current year
        end;

        Budget.SetRange("From Date", StartDate, EndDate);
        Budget.CalcSums(Amount);
        CurrentHalfYear := Budget.Amount;

        // -------------------
        // Current Quarter
        // -------------------
        Budget.Reset();
        Budget.SetRange("Category", Rec."Category Name");

        StartDate := CALCDATE('<-CQ>', WORKDATE);
        EndDate := CALCDATE('<CQ>', WORKDATE);

        Budget.SetRange("From Date", StartDate, EndDate);
        Budget.CalcSums(Amount);
        CurrentQuarter := Budget.Amount;

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

}
