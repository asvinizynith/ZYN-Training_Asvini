table 50112 "ZYN_Asset Table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Asset No"; Integer)
        {
            AutoIncrement = true;
            Caption = 'No';
        }
        field(2; "Asset Name"; Text[50])
        {
            Caption = 'Asset Name';
            TableRelation = "ZYN_Asset Type Table"."Asset Name";
        }
        field(3; "Serial No"; Code[30])
        {
            Caption = 'Serial No';
        }
        field(4; "Procured Date"; Date)
        {
            Caption = 'Procured Date';
        }
        field(5; "Vendor Name"; Text[30])
        {
            Caption = 'Vendor Name';
        }
        field(6; Available; Boolean)
        {
            Caption = 'Available';
        }
    }

    keys
    {
        key(Pk; "Asset No", "Asset Name", "Serial No")
        {
            Clustered = true;
        }
    }
    trigger OnModify()
    begin
        UpdateAvailable();
    end;

    trigger OnInsert()
    begin
        UpdateAvailable();
    end;

    procedure UpdateAvailable()
    var
        EmployeeAsset: Record "ZYN_Employee Asset Table";
        ExpiryDate: Date;
    begin
        if "Procured Date" <> 0D then
            ExpiryDate := CalcDate('<+5Y>', "Procured Date");

        // Default to false
        "Available" := false;

        // Find the latest Employee Asset entry for this Asset
        EmployeeAsset.Reset();
        EmployeeAsset.SetRange("Serial No", "Serial No");
        if EmployeeAsset.FindLast() then begin
            case EmployeeAsset.Status of
                EmployeeAsset.Status::Returned:
                    if (WorkDate() <= ExpiryDate) then
                        "Available" := true
                    else
                        "Available" := false;

                EmployeeAsset.Status::Lost:
                    "Available" := false;

                EmployeeAsset.Status::Assigned:
                    if (WorkDate() <= ExpiryDate) then
                        "Available" := true;
                else
                    Available := false;
            end;
        end else begin
            // No employee record → asset is free if not expired
            if (Today <= ExpiryDate) then
                "Available" := true
            else
                "Available" := false;
        end;
    end;
}