table 50103 "Expense & Budget Category"
{
    Caption = 'Expense & Budget Category';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Category ID"; Code[50])
        {
            Caption = 'Category Name';
        }
        field(2; "Category Name"; Code[50])
        {
            Caption = 'Category Name';
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; "Category Name")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Category Name")
        {
            Caption = 'Category Name';

        }
    }
}
