table 50165 "ZYN_Last Sold Price Finder"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Customer No"; Code[20])
        {
            Caption = 'Customer No.';
        }
        field(2; "Item No"; Code[20])
        {
            Caption = 'Item No.';
        }
        field(3; "LastItem Sold Price"; Decimal)
        {
            Caption = 'LastItem Sold Price';
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Last Posting Date';
        }
    }

    keys
    {
        key(Pk; "Customer No", "Item No")
        {
            Clustered = true;
        }
    }
}