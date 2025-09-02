tableextension 50128 salesinvoiceheadertextcodeext extends "Sales Invoice Header"
{
    fields
    {

        field(50146; "Beginning Code"; Text[30])
        {
            Caption = 'Beginning Code';
            DataClassification = CustomerContent;
            TableRelation = "Standard Text".Code;
        }
        field(50151; "Ending Code"; Text[30])
        {
            Caption = 'Ending Code';
            DataClassification = CustomerContent;
            TableRelation = "Standard Text".Code;

        }


    }
}

