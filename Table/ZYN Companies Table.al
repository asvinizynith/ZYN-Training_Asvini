table 50119 "ZYN_Companies Table"
{
    Caption = 'Company';
    DataPerCompany = false;
    Scope = Cloud;
    ReplicateData = false;
DataClassification=ToBeClassified;

    fields
    {
        field(1; Name; Text[30])
        {
            Caption = 'Name';
            trigger OnValidate()
            begin
                if Name <> xRec.Name then
                    Error(RenameNotAllowedErr, Rec.FieldCaption("Display Name"));
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
        RenameNotAllowedErr: Label 'You cannot rename this company due to the impact on performance. Instead, change the %1.', Comment = '%1 = Display Name';
}