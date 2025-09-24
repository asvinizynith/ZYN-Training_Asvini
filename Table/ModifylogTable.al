table 50141 "ZYN_Modify Log Table"
{
    DataClassification = ToBeClassified;
    Caption = 'Modify Log Table';

    fields
    {
        field(1; "Entry Number"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "No"; code[20])
        {
            Caption = 'Customer No';
        }
        field(3; "Field Name"; Text[100])
        {
            Caption = 'Field Name';
        }
        field(4; "Old Value"; Text[100])
        {
            Caption = 'Old Value';
        }
        field(5; "New Value"; Text[100])
        {
            Caption = 'New Value';
        }
        field(6; "User ID"; Code[50])
        {
            Caption = 'User ID';
        }
    }

    keys
    {
        key(PK; "Entry Number", "No")
        {
            Clustered = true;
        }
    }
}
