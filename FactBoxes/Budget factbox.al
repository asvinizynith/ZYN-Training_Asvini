page 50200 "ZYN_Budget FactBox"
{
    PageType = CardPart;
    SourceTable = "ZYN_Budget Table";
    Caption = 'ZYN_Budget Info';
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
                }
                field("To Date"; Rec."To Date")
                {
                }
                field("Category"; Rec."Category")
                {
                }
                field("Amount"; Rec."Amount")
                {
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
