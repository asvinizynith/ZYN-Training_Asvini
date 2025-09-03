table 50114 "Employee Asset Table"
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
            TableRelation = "Employee Table"."Employee ID";
        }
        field(3; "Serial No"; Code[30])
        {
            Caption = 'Serial No';

            trigger OnLookup()
            var
                Asset: Record "Asset Table";
            begin
                Asset.Reset();
                Asset.SetRange("Serial No", Rec."Serial No");
                Asset.SetRange(Available, true); // only available assets
                if Page.RunModal(Page::"Asset List", Asset) = Action::LookupOK then begin
                    "Serial No" := Asset."Serial No";
                end;
            end;


            trigger OnValidate()
            var
                Asset: Record "Asset Table";
            begin
                if Asset.Get("Serial No") then begin
                    if not Asset.Available then
                        Error('The selected asset (%1) is not available.', "Serial No");
                end;
            end;

        }
        field(4; "Asset Name"; Text[50])
        {
            Caption = 'Asset Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Asset Table"."Asset Name" where("Serial No" = field("Serial No")));
        }

        field(5; Status; Enum "Asset Status")
        {
            Caption = 'Status';
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