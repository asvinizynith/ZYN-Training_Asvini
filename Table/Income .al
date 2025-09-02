table 50178 "Income Table"
{
    Caption = 'Income Table';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Income ID"; Integer)
        {
            Caption = 'Income ID';
            AutoIncrement = true;
        }
        field(2; "Income Description"; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Income Amount"; Decimal)
        {
            Caption = 'Income Amount';
        }
        field(4; "Income Date"; Date)
        {
            Caption = 'Income Date';
        }
        field(5; "Income Category"; code[50])
        {

            TableRelation = "Income Category"."Income Category Name";
            Caption = 'Income Category';

        }

    }
    keys
    {
        key(PK; "Income ID")
        {
            Clustered = true;
        }
        key(categorykey; "Income Category")
        { }
    }

}