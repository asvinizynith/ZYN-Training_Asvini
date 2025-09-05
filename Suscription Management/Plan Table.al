table 50115 "Plan Table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Plan ID"; Integer)
        {

            AutoIncrement = true;
            Caption = 'Plan ID';
        }
        field(2; "Plan Name"; Text[50])
        {

            Caption = 'Plan Name';

        }
        field(3; "Monthly Fee"; Decimal)
        {
            Caption = 'Monthly Fee';
        }
        field(4; "Status"; Enum "Plan Status")
        {
            Caption = 'Status';
        }
        field(5; "Description"; Text[30])
        {
            Caption = 'Description';
        }

    }

    keys
    {
        key(Pk; "Plan ID")
        {
            Clustered = true;
        }
    }
}