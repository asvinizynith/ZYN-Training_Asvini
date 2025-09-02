table 50185 "Income Category"
{
    Caption = 'Income Category';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; " Income Category ID"; Code[50])
        {
            Caption = 'Income Category ID';
        }
        field(2; "Income Category Name"; Code[50])
        {
            Caption = 'Income Category Name';
        }
        field(3; "Category Description"; Text[100])
        {
            Caption = 'Category Description';
        }
    }
    keys
    {
        key(PK; "Income Category Name")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Income Category Name")
        {
            Caption = 'Income Category Name';

        }
    }
}
