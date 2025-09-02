table 50171 "Index Lines"
{
    Caption = 'Index Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            AutoIncrement = true;
        }
        field(2; "Code"; Code[30])
        {
            Caption = 'Code';
            TableRelation = "Index Table"."Code";
        }
        field(3; Year; Integer)
        {
            Caption = 'Year';
        }
        field(4; "Value"; Decimal)
        {
            Caption = 'Value';
        }
    }
    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
    }


}
