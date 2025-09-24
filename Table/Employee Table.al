table 50104 "ZYN_Employee Table"
{
    Caption = 'Employee Table';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Employee ID"; Code[30])
        {
            Caption = 'Employee ID';
        }
        field(2; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
        }
        field(3; "Employee Role"; Enum "ZYN_Emplyee Role Type")
        {
            Caption = 'Employee Role';
        }
        field(4; "Department"; Enum "ZYN_Department Type")
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
        EmployeeLeaveCU: Codeunit "ZYN_Employee Leave Management";
    begin
        EmployeeLeaveCU.Run();
    end;
}
