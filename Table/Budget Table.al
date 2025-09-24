table 50187 "ZYN_Budget Table"
{
    DataClassification = ToBeClassified;
    Caption = 'Budget Table';

    fields
    {
        field(1; "Budget ID"; Integer)
        {
            Caption = 'Budget ID';
            AutoIncrement = true;
        }
        field(2; "From Date"; Date)
        {
            Caption = 'From Date';
        }
        field(3; "To Date"; Date)
        {
            Caption = 'To Date';
        }
        field(4; Category; Code[50])
        {
            Caption = 'Category';
            TableRelation = "ZYN_Expense & Budget Category"."Category Name";
        }
        field(5; "Amount"; Decimal)
        {
            Caption = 'Amount';
        }
    }

    keys
    {
        key(PK; Category, "From Date", "To Date")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if "From Date" = 0D then
            "From Date" := CalcDate('<-CM>', WorkDate());          // 1st day of current month

        if "To Date" = 0D then
            "To Date" := CalcDate('<CM>', WorkDate());      // last day of current month
    end;
}