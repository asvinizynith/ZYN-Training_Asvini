pageextension 50114 customerloyalityexten extends "Customer Card"
{
     layout
    {
        addlast(General)
        {
            field("Loyality Points"; Rec."Loyality Points")
            {
                ApplicationArea = All;
                Caption = 'Loyality Points';
            }
}
    }
}