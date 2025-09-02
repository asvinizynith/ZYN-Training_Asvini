table 50104 "Employee Table"
{
    Caption = 'Employee Table';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Employee ID"; Code[30])
        {
            Caption = 'Employee ID';

            DataClassification = ToBeClassified;
        }
        field(2; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
        }
        field(3; "Employee Role"; Enum "Emplyee Role Type")
        {
            Caption = 'Employee Role';
        }
        field(4; "Department"; Enum "Department Type")
        {
            Caption = 'Department';
        }


    }

    keys
    {
        key(PK; "Employee ID")
        {
            Clustered = true;
        }

    }
    trigger OnInsert()
    var
        PopulateLeaveCU: Codeunit "Populate Employee Leave Table";
    begin
        PopulateLeaveCU.Run();
    end;

}
