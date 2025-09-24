table 50140 "ZYN_Text Code Table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
            Caption='Line No';
        }
        field(2; No; Code[20])
        {
            Caption='No';
        }
        field(3; "Customer No"; Text[100])
        {
            Caption='Customer No';
        }
        field(4; "Document Type"; Enum "Sales Document Type")
        {
            Caption='Document Type';
        }
        field(5; Text; Text[100])
        {
            Caption='Text';
        }
        field(8; Selection; Enum "ZYN_TextCode Selection")
        {
            Caption='Selection';
        }
        field(6; "Language Code"; Code[30])
        {
            Caption='Language Code';
        }
    }

    keys
    {
        key(PK; "Line No", "No", "Document Type", "Language Code", Selection)
        {
            Clustered = true;
        }
    }
}

