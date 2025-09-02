table 50106 "Leave Request Table"
{
    Caption = 'Leave Request Table';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Request ID"; Integer)
        {
            Caption = 'Request ID';
            AutoIncrement = true;

            DataClassification = ToBeClassified;
        }
        field(2; "Employee ID"; Code[30])
        {
            Caption = 'Employee ID';
            TableRelation = "Employee Table"."Employee ID";

        }
        field(3; "Leave Category"; Code[50])
        {
            Caption = 'Leave Category';
            TableRelation = "Leave Category Table"."Leave Category";

        }
        field(4; "Reason"; Text[100])
        {
            Caption = 'Reason';
        }


        field(5; "Remaining leave"; Integer)
        {
            Caption = 'Remaining leave';
            Editable = false;

        }
        field(6; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(7; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(8; "No. of Leave days"; Integer)
        {
            Caption = 'No. of leave days';
            Editable = false;

        }
        field(9; Status; Enum "Status type")
        {
            Caption = 'Status';
        
        }
    }

    keys
    {
        key(PK; "Request ID")
        {
            Clustered = true;
        }

    }
    trigger OnDelete()
    begin
        if Status <> Status::Pending then
            Error(
                'Leave Request %1 for Employee %2 cannot be deleted because the status is %3. Allowed only if the status is Pending.',
                "Request ID", "Employee ID", Format(Status));
    end;




}



