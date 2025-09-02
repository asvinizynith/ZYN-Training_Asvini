tableextension 50123 "Customer Card Extension" extends "Customer"
{
    fields
    {
        field(50100; "Credit Allowed"; Decimal)
        {
            Caption = 'Credit Allowed';
            DataClassification = CustomerContent;
        }
        field(50101; "Credit Used"; Decimal)
        {
            Caption = 'Credit Used';
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line"."Amount" where("Sell-to Customer No." = field("No.")));
            Editable = false;

        }
    }
}