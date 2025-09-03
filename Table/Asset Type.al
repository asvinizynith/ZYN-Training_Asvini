table 50111 "Asset Type"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Integer)
        {

            AutoIncrement = true;
            Caption = 'No';
        }
        field(2; "Asset Category"; Enum "Asset Category")
        {

            Caption = 'Asset Category';
        }
        field(3; "Asset Name"; Text[50])
        {
            Caption = 'Asset Name';
        }
    }

    keys
    {
        key(Pk; No, "Asset Name")
        {
            Clustered = true;
        }
    }



}