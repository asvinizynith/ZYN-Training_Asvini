table 50130 "Technician Table"
{
    DataClassification = ToBeClassified;
    Caption = 'Technician Table';
    fields
    {
        field(1; ID; Code[20])
        {
            Caption = 'ID';
            DataClassification = ToBeClassified;

        }
        field(2; Name; Text[30])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(3; "Ph.No"; Integer)
        {
            Caption = 'Ph.No';
            DataClassification = ToBeClassified;
        }
        field(50131; Department; Enum "Technician Department")
        {
            Caption = 'Department';
            DataClassification = ToBeClassified;
        }
        field(4; "No Of Problems"; Integer)
        {
            Caption = 'No Of Problems';
            FieldClass = FlowField;
            CalcFormula = count("Problem List" where("Technician Name" = field(Name)));
        }
    }

    keys
    {
        key(Key1; ID, Name)
        {
            Clustered = true;
        }
    }

}