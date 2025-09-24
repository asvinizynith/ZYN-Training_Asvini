table 50107 "ZYN_Employee Leave Table"
{
    Caption = 'Employee Leave Table';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Employee ID"; Code[30])
        {
            Caption = 'Employee ID';
            TableRelation = "ZYN_Employee Table"."Employee ID";
        }
        field(2; "Leave Category"; Text[100])
        {
            Caption = 'Leave Category';
            TableRelation = "ZYN_Leave Category Table"."Leave Category";
        }
        field(3; "Remaining leave"; Integer)
        {
            Caption = 'Remaining leave';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Employee ID", "Leave Category") { Clustered = true; }
    }
}

