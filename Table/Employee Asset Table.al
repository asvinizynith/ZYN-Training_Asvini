table 50114 "ZYN_Employee Asset Table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No';
        }
        field(2; "Employee ID"; Code[30])
        {
            Caption = 'Employee ID';
            TableRelation = "ZYN_Employee Table"."Employee ID";
        }
        field(3; "Serial No"; Code[30])
        {
            Caption = 'Serial No';
            TableRelation = "ZYN_Asset Table"."Serial No" WHERE(Available = CONST(true));
        }
        field(4; "Asset Name"; Text[50])
        {
            Caption = 'Asset Name';
            FieldClass = FlowField;
            CalcFormula = lookup("ZYN_Asset Table"."Asset Name" where("Serial No" = field("Serial No")));
        }

        field(5; Status; Enum "ZYN_Asset Status")
        {
            Caption = 'Status';
            trigger OnValidate()
            var
                EmployeeAsset: Record "ZYN_Employee Asset Table";
            begin
                // If asset is being Returned or Lost
                if (Status = Status::Returned) or (Status = Status::Lost) then begin
                    // Find the original assigned record for the same asset
                    EmployeeAsset.Reset();
                    EmployeeAsset.SetRange("Serial No", Rec."Serial No");
                    EmployeeAsset.SetRange(Status, EmployeeAsset.Status::Assigned);

                    if EmployeeAsset.FindFirst() then begin
                        Rec."Assigned Date" := EmployeeAsset."Assigned Date";
                    end;
                end;
            end;
        }
        field(6; "Assigned Date"; Date)
        {
            Caption = 'Assigned Date';
        }
        field(7; "Returned Date"; Date)
        {
            Caption = 'Returned Date';
        }
        field(8; "Lost Date"; Date)
        {
            Caption = 'Lost Date';
        }
    }

    keys
    {
        key(Pk; "Entry No", "Employee ID", "Serial No")
        {
            Clustered = true;
        }
    }
}