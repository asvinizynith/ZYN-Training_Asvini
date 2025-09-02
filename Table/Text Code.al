table 50140 "Text Code Table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; No; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Customer No"; Text[100])
        {
            DataClassification = ToBeClassified;

        }

        field(4; "Document Type"; Enum "Sales Document Type")
        {
            DataClassification = ToBeClassified;

        }
        field(5; Text; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(8; Selection; Enum "Textcode Selection")
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Language Code"; Code[30])
        {
            DataClassification = ToBeClassified;

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

