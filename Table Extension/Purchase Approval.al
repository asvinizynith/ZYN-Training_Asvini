tableextension 50124 purchaseorderexts extends "Purchase Header"
{
    fields
    {
        field(50104; "Purchase Approval Status"; Enum "ZYN_purchase Approval Status")
        {
            Caption = 'Purchase Approval Status';
            DataClassification = ToBeClassified;
        }
    }
}
