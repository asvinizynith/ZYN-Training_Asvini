pageextension 50125 "Purchase Order Extension" extends "Purchase Order"
{
    layout
    {
        addlast(General)
        {
            field("Purchase Approval Status"; Rec."Purchase Approval Status")
            {
                ApplicationArea = All;
                Caption = 'Purchase Approval Status';
            }
        }
    }
}