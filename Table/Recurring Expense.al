table 50102 "ZYN_Recurring Expense Table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "ID"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; Category; Code[50])
        {
            Caption = 'Category';
            TableRelation = "ZYN_Expense & Budget Category"."Category Name";
        }
        field(3; "Amount"; Decimal)
        {
            Caption = 'Amount';
        }
        field(4; "Cycle Type"; Enum "ZYN_Expense Cycle")
        {
            Caption = 'Cycle';
        }
        field(5; "Start Date"; Date)
        {
            Caption = 'Start Date';
            trigger OnValidate()
            begin
                UpdateNextCycleDate();
            end;
        }
        field(6; "Next Cycle Date"; Date)
        {
            Caption = 'Next Cycle Date';
            trigger OnValidate()
            begin
                UpdateNextCycleDate();
            end;
        }
        field(7; "Description"; Text[100])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(PK; "ID")
        {
            Clustered = true;
        }
    }
    local procedure UpdateNextCycleDate()
    begin
        case "Cycle Type" of
            "Cycle Type"::Weekly:
                "Next Cycle Date" := CalcDate('<+1W>', "Start Date");
            "Cycle Type"::Monthly:
                "Next Cycle Date" := CalcDate('<+1M>', "Start Date");
            "Cycle Type"::Quaterly:
                "Next Cycle Date" := CalcDate('<+3M>', "Start Date");
            "Cycle Type"::"Half Yearly":
                "Next Cycle Date" := CalcDate('<+6M>', "Start Date");
            "Cycle Type"::Yearly:
                "Next Cycle Date" := CalcDate('<+1Y>', "Start Date");
        end;
    end;
}
