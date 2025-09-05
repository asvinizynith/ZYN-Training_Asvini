tableextension 50100 recurringSalesHeaderExt extends "Sales Header"
{
    fields
    {
        field(50100; Subscription; Boolean)
        {
            Caption = 'Subscription';
            DataClassification = ToBeClassified;
        }
        field(50101; "Subscription Amount"; Decimal)
        {
            Caption = 'Subscription Amount';
            DataClassification = ToBeClassified;
        }
    }
}