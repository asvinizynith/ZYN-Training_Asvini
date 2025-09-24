page 50186 "ZYN_Category Income FactBox"
{
    PageType = CardPart;
    SourceTable = "ZYN_Income Category";
    ApplicationArea = All;
    Caption = 'ZYN_Category Income Info';

    layout
    {
        area(content)
        {
            cuegroup("Category Income Info")
            {
                field("Current Year"; CurrentYear)
                {
                    DrillDown = true;
                    Caption = 'Current Year';
                    trigger OnDrillDown()
                    var
                        Income: Record "ZYN_Income Table";
                    begin
                        Income.SetRange("Income Category", Rec."Income Category Name");
                        StartDate := CALCDATE('<-CY>', WORKDATE);
                        EndDate := CALCDATE('<CY>', WORKDATE);
                        Income.SetRange("Income Date", StartDate, EndDate);
                        PAGE.Run(PAGE::"ZYN_Income List", Income);
                    end;
                }
                field("Current Month"; CurrentMonth)
                {
                    DrillDown = true;
                    Caption = 'Current Month';
                    trigger OnDrillDown()
                    var
                        Income: Record "ZYN_Income Table";
                    begin
                        Income.SetRange("Income Category", Rec."Income Category Name");
                        StartDate := CALCDATE('<-CM>', WORKDATE);
                        EndDate := CALCDATE('<CM>', WORKDATE);
                        Income.SetRange("Income Date", StartDate, EndDate);                    // Till today
                        PAGE.Run(PAGE::"ZYN_Income List", Income);
                    end;
                }
                field("Current Half Year"; CurrentHalfYear)
                {
                    DrillDown = true;
                    Caption = 'Current Half Year';
                    trigger OnDrillDown()
                    var
                        Income: Record "ZYN_Income Table";
                    begin
                        Income.SetRange("Income Category", Rec."Income Category Name");
                        if Date2DMY(WORKDATE, 2) <= 6 then begin
                            StartDate := CALCDATE('<-CY>', WORKDATE);        // Jan 1 of current year
                            EndDate := CALCDATE('<-CY>+6M-1D', WORKDATE);    // Jun 30 of current year
                        end else begin
                            StartDate := CALCDATE('<-CY>+6M', WORKDATE);     // Jul 1 of current year
                            EndDate := CALCDATE('<CY>', WORKDATE);   // Dec 31 of current year
                        end;
                        Income.SetRange("Income Date", StartDate, EndDate);
                        PAGE.Run(PAGE::"ZYN_Income List", Income);
                    end;
                }
                field("Current Quarter"; CurrentQuarter)
                {
                    DrillDown = true;
                    Caption = 'Current Quarter';
                    trigger OnDrillDown()
                    var
                        Income: Record "ZYN_Income Table";
                    begin
                        Income.SetRange("Income Category", Rec."Income Category Name");
                        StartDate := CALCDATE('<-CQ>', WORKDATE);
                        EndDate := CALCDATE('<CQ>', WORKDATE);
                        Income.SetRange("Income Date", StartDate, EndDate); // If you want "till WorkDate"
                        PAGE.Run(PAGE::"ZYN_Income List", Income);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        "Income Rec": Record "ZYN_Income Table";
    begin
        // Current Year
        "Income Rec".Reset();
        "Income Rec".SetRange("Income Category", Rec."Income Category Name");
        StartDate := CALCDATE('<-CY>', WORKDATE);
        EndDate := CALCDATE('<CY>', WORKDATE);
        "Income Rec".SetRange("Income Date", StartDate, EndDate);
        "Income Rec".CalcSums("Income Amount");
        CurrentYear := "Income Rec"."Income Amount";

        // Current Month
        "Income Rec".Reset();
        "Income Rec".SetRange("Income Category", Rec."Income Category Name");
        StartDate := CALCDATE('<-CM>', WORKDATE);
        EndDate := CALCDATE('<CM>', WORKDATE);
        "Income Rec".SetRange("Income Date", StartDate, EndDate);
        "Income Rec".CalcSums("Income Amount");
        CurrentMonth := "Income Rec"."Income Amount";

        // Current Half-Year
        "Income Rec".Reset();
        "Income Rec".SetRange("Income Category", Rec."Income Category Name");
        if Date2DMY(WORKDATE, 2) <= 6 then begin
            StartDate := CALCDATE('<-CY>', WORKDATE);        // Jan 1 of current year
            EndDate := CALCDATE('<-CY>+6M-1D', WORKDATE);    // Jun 30 of current year
        end else begin
            StartDate := CALCDATE('<-CY>+6M', WORKDATE);     // Jul 1 of current year
            EndDate := CALCDATE('<CY>', WORKDATE);   // Dec 31 of current year
        end;
        "Income Rec".SetRange("Income Date", StartDate, EndDate);
        "Income Rec".CalcSums("Income Amount");
        CurrentHalfYear := "Income Rec"."Income Amount";

        // Current Quarter
        "Income Rec".Reset();
        "Income Rec".SetRange("Income Category", Rec."Income Category Name");
        StartDate := CALCDATE('<-CQ>', WORKDATE);
        EndDate := CALCDATE('<CQ>', WORKDATE);
        "Income Rec".SetRange("Income Date", StartDate, EndDate);
        "Income Rec".CalcSums("Income Amount");
        CurrentQuarter := "Income Rec"."Income Amount";
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
