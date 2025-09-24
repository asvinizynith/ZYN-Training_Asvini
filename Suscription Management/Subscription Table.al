table 50116 "ZYN_Subscription Table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Subscription ID"; Integer)
        {
            AutoIncrement = true;
            Caption = 'Subscription ID';
        }
        field(2; "Customer ID"; Code[50])
        {
            Caption = 'Customer ID';
            TableRelation = Customer."No.";
        }
        field(3; "Plan ID"; Integer)
        {
            Caption = 'Plan ID';
            TableRelation = "ZYN_Plan Table"."Plan ID";
        }
        field(4; "Start Date"; Date)
        {
            Caption = 'Start Date';
            trigger OnValidate()
            begin
                CalcEndDate();
                CalcNextBillingDate();
            end;
        }
        field(5; Duration; Integer)
        {
            Caption = 'Duration';
            trigger OnValidate()
            begin
                CalcEndDate();
            end;
        }
        field(6; "End Date"; Date)
        {
            Caption = 'End Date';
            Editable = false;     
        }
        field(7; "Next Billing Date"; Date)
        {
            Caption = 'Next Billing Date';
        }
        field(8; status; Enum "ZYN_Subscription Status")
        {
            Caption = 'Status';
        }
        field(9; "Next Renewal Date"; Date)
        {
            Caption = 'Next Renewal Date';
            Editable = false;
            trigger OnValidate()
            begin
                if "Next Renewal Date" < "End Date" then
                    Error('Next Renewal Date must be after End Date');
            end;
        }
        field(10; "Remainder Sent"; Boolean)
        {
            Caption = 'Remainder Sent';
            Editable = false;
        }
    }

    keys
    {
        key(Pk; "Plan ID", "Subscription ID")
        {
            Clustered = true;
        }
    }

    local procedure CalcEndDate()
    begin
        if ("Start Date" <> 0D) and (Duration > 0) then
            "End Date" := CalcDate(StrSubstNo('<%1M>', Duration), "Start Date");
    end;

    procedure CalcNextBillingDate()
    begin
        if "Start Date" <> 0D then begin
            if "Next Billing Date" = 0D then
                // First time: Start Date Month
                "Next Billing Date" := "Start Date"
            else
                // Subsequent billings: Add 1 Month to existing Next Billing Date
                "Next Billing Date" := CalcDate('<1M>', "Next Billing Date");
        end;
    end;
}