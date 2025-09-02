table 50141 "Modify Log Table"
{
    DataClassification = SystemMetadata;
    Caption = 'Modify Log Table';

    fields
    {
        field(1; "Entry Number"; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;


        }
        field(2; "No"; code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Customer No';


        }
        field(3; "Field Name"; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'Field Name';


        }

        field(4; "Old Value"; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'Old Value';


        }

        field(5; "New Value"; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'New Value';

        }

        field(6; "User ID"; Code[50])
        {
            DataClassification = SystemMetadata;
            Caption = 'User ID';
        }
    }

    keys
    {
        key(PK; "Entry Number","No")
        {
            Clustered = true;
        }
    }
}
