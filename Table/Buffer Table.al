table 50113 "Buffer Table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Field ID"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Field Name"; Text[100])
        {

        }
        field(3; "Record Selection"; Text[100])
        {

        }
        field(4; "Line No"; Integer)
        {

        }
      field(5; "Record ID"; RecordId)
        {

        }
    }

    keys
    {
        key(PK; "Field ID", "Field Name", "Record Selection")
        {
            Clustered = true;
        }
    }
}