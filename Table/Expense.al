table 50166 "Expense Table"
{
    Caption = 'Expense Table';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Expense ID"; Integer)
        {
            Caption = 'Expense ID';
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Description"; Text[100])
        {
            Caption = 'Description';
        }
        field(3; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(4; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(5; "Category"; Code[50])
        {
            TableRelation = "Expense & Budget Category"."Category Name";
            Caption = 'Category';
        }
        field(7; "Expense Amount"; Decimal)
        {
            Caption = 'Expense Amount';
            Editable = false;
        }
        field(9; "Remaining Budget"; Decimal)
        {
            Caption = 'Remaining Budget';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Expense ID")
        {
            Clustered = true;
        }
        key(categorydate; "Category", Date)
        {
            SumIndexFields = Amount;
        }
    }


}
