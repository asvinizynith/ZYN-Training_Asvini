table 50134 "Problem List"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Entry No';
            AutoIncrement = true;

        }
        field(2; "Customer ID"; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer ID';

        }
        field(3; "Customer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Name';

        }
        field(50135; "Issue List"; Enum "Issue List")
        {
            DataClassification = ToBeClassified;
            Caption = 'Issue List';
        }
        field(50131; Department; Enum "Technician Department")
        {
            Caption = 'Department';
            DataClassification = ToBeClassified;

        }
        field(4; "Technician Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Technician Name';
            TableRelation = "Technician Table".Name where(Department = field(Department));

        }
        field(5; Date; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date';
        }
        field(6; Description; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';

        }
    }

    keys
    {
        key(Pk; "Entry No", "Customer ID")
        {
            Clustered = true;
        }
    }



}
