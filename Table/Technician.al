table 50130 "ZYN_Technician Table"
{
    DataClassification = ToBeClassified;
    Caption = 'Technician Table';
    fields
    {
        field(1; ID; Code[20])
        {
            Caption = 'ID';
        }
        field(2; Name; Text[30])
        {
            Caption = 'Name';
        }
        field(3; "Ph.No"; Integer)
        {
            Caption = 'Ph.No';
        }
        field(50131; Department; Enum "ZYN_Technician Department")
        {
            Caption = 'Department';        
        }
        field(4; "No Of Problems"; Integer)
        {
            Caption = 'No Of Problems';
            FieldClass = FlowField;
            CalcFormula = count("ZYN_Problem List" where("Technician Name" = field(Name)));
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