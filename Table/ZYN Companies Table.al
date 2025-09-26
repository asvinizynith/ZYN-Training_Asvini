table 50119 "ZYN_Companies Table"
{
    Caption = 'Company';
    DataPerCompany = false;
    Scope = Cloud;
    ReplicateData = false;
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Name; Text[30])
        {
            Caption = 'Name';
            ToolTip = '';
            trigger OnValidate()
            begin
                // Only validate if it's not a new record
                if '' <> xRec.Name then
                    Error(RenameNotAllowedErr, Rec.Name);
            end;
        }
        field(2; "Evaluation Company"; Boolean)
        {
            Caption = 'Evaluation Company';
        }
        field(3; "Display Name"; Text[250])
        {
            Caption = 'Display Name';
        }
        field(4; IsMaster; Boolean)
        {
            Caption = 'IsMaster';
            trigger OnValidate()
            var
                MyCompany: Record "ZYN_Companies Table";
            begin
                if IsMaster then begin
                    MyCompany.Reset();
                    MyCompany.SetRange(IsMaster, true);
                    // Exclude current record from the search
                    if MyCompany.FindFirst() and (MyCompany."Name" <> Rec."Name") then
                        Error(MasterNotAllowedErr, MyCompany."Name");
                end;
            end;
        }
        field(5; "Master Company Name"; Text[50])
        {
            Caption = 'Master Company Name';
            trigger OnValidate()
            var
                MasterCompany: Record "ZYN_Companies Table";
            begin
                if "Master Company Name" <> '' then begin
                    // Find the master company
                    MasterCompany.Reset();
                    MasterCompany.SetRange(IsMaster, true);
                    if not MasterCompany.FindFirst() then
                        Error(NoMasterCompanyNameErr);

                    // Validate that only the master company can be assigned
                    if "Master Company Name" <> MasterCompany.Name then
                        Error(MasterCompanyNameErr, MasterCompany.Name);
                end;
            end;
        }
        field(6; "Master Company ID"; Guid)
        {
            Caption = 'Master Company ID';
        }
        field(8000; Id; Guid)
        {
            Caption = 'Id';
        }
        field(8005; "Business Profile Id"; Text[250])
        {
            Caption = 'Business Profile Id';
        }
    }

    keys
    {
        key(Key1; Name)
        {
            Clustered = true;
        }
    }

    var
        RenameNotAllowedErr: Label 'You cannot rename this company due to the impact on performance.';
        MasterNotAllowedErr: Label 'Only one company can be set as Master. "%1" is already set as Master.', Comment = '%1=Name';
        MasterCompanyNameErr: Label 'Only the Master Company ("%1") can be selected here.';
        NoMasterCompanyNameErr: Label 'No company is set as Master. Please mark one company as Master first.';
}
