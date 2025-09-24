table 50105 "ZYN_Leave Category Table"
{
    Caption = 'Leave Category Table';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Description"; Text[30])
        {
            Caption = 'Description';
        }
        field(2; "Leave Category"; Code[50])
        {
            Caption = 'Leave Category';
        }
        field(3; "No. Of Days Allowed"; Integer)
        {
            Caption = 'No. Of Days Allowed';
        }
    }

    keys
    {
        key(PK; "Leave Category")
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
