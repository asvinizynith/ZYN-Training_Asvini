page 50200 "Budget FactBox"
{
    PageType = CardPart;
    SourceTable = "Budget Table";
    Caption = 'Budget Info';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'Budget for Current Month';
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = All;
                }

                field("Category"; Rec."Category")
                {
                    ApplicationArea = All;
                }
                field("Amount"; Rec."Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Budget Amount';
                }

            }
        }
    }
    trigger OnOpenPage()
    var
        StartDate: Date;
        EndDate: Date;
    begin
        // Current month date range
        StartDate := CalcDate('<-CM>', WorkDate());
        EndDate := CalcDate('<CM>', WorkDate());

        // Apply filter only to current month
        Rec.SetRange("From Date", StartDate, EndDate);
        Rec.SetRange("To Date", EndDate);
    end;
}
