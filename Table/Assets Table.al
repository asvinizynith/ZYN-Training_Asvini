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
    //     trigger OnInsert()
    // begin
    //     UpdateAvailable();
    // end;

    // trigger OnModify()
    // begin
    //     UpdateAvailable();
    // end;

    // procedure UpdateAvailable()
    // begin
    //     if ("Procured Date" <> 0D) and (CalcDate('<+5Y>', "Procured Date") >= WorkDate()) then
    //         Available := true
    //     else
    //         Available := false;
    // end;


}