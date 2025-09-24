table 50134 "ZYN_Problem List"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            AutoIncrement = true;
        }
        field(2; "Customer ID"; code[20])
        {
            Caption = 'Customer ID';
        }
        field(3; "Customer Name"; Text[50])
        {
            Caption = 'Customer Name';
        }
        field(50135; "Issue List"; Enum "ZYN_Issue List")
        {
            Caption = 'Issue List';
        }
        field(50131; Department; Enum "ZYN_Technician Department")
        {
            Caption = 'Department';
        }
        field(4; "Technician Name"; Text[50])
        {
            Caption = 'Technician Name';
            TableRelation = "ZYN_Technician Table".Name where(Department = field(Department));
        }
        field(5; Date; Date)
        {   
            Caption = 'Date';
        }
        field(6; Description; Text[50])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Pk; "Entry No", "Customer ID")
        {
            Clustered = true;
        }
    }
}
