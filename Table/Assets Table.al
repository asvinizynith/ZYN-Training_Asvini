table 50112 "Asset Table"
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
            TableRelation = "Asset Type"."Asset Name";
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
        EmpAsset: Record "Employee Asset Table";
        ExpiryDate: Date;
    begin
        if "Procured Date" <> 0D then
            ExpiryDate := CalcDate('<+5Y>', "Procured Date");

        // Default to false
        "Available" := false;

        // Find the latest Employee Asset entry for this Asset
        EmpAsset.Reset();
        EmpAsset.SetRange("Serial No", "Serial No");
        if EmpAsset.FindLast() then begin
            case EmpAsset.Status of
                EmpAsset.Status::Returned:
                    if (WorkDate() <= ExpiryDate) then
                        "Available" := true
                    else
                        "Available" := false;

                EmpAsset.Status::Lost:
                    "Available" := false;

                EmpAsset.Status::Assigned:
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