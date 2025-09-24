table 50101 "ZYN_Customer Visit Log"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Entry Number"; Integer)
        {
            Caption='Entry Number';
            AutoIncrement = true;
        }
        field(2; "Customer Number"; Code[30])
        {
           Caption='Customer Number';
            TableRelation = Customer."No.";
        }
        field(3; "Date"; Date)
        {
            Caption='Date';
        }
        field(4; "Purpose"; Text[50])
        {
           Caption='Purpose';
        }
        field(5; "Notes"; Text[50])
        {
           Caption='Notes';
        }
    }
    keys
    {
        key(PK; "Entry Number", "Customer Number")
        {
            Clustered = true;
        }
    }
}

