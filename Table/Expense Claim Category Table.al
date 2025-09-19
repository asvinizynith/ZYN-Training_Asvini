table 50117 "Expense Claim Category Table"
{
    Caption = 'Expense Claim Category Table';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Category Code"; Code[50])
        {
            Caption = 'Category Code';
        }
        field(2; "Category Name"; Text[50])
        {
            Caption = 'Category Name';
        }
        field(3; Subtype; Text[50])
        {
            Caption = 'Subtype';
        }
        field(4; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(5; "Amount Limit"; Decimal)
        {
            Caption = 'Amount Limit';
        }
    }
    keys
    {
        key(PK; "Category Code", "Category Name", Subtype)
        {
            Clustered = true;
        }
    }
}
