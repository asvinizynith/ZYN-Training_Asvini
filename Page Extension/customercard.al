pageextension 50124 "Customer Card Extension" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("Credit Allowed"; Rec."Credit Allowed")
            {
                ApplicationArea = All;
                Caption = 'Credit Allowed';
            }
            field("Credit Used"; Rec."Credit Used")
            {
                ApplicationArea = All;
                Caption = 'Credit Used';
            }
            field("Sales Year Filter"; Rec."sales Year Fliter")
            {
                ApplicationArea = All;
                Caption = 'sales Year Fliter';
            }

            /*   field("Sales Amount"; Rec."Sales Amount")
               {
                   ApplicationArea = All;
                   Caption = 'Sales Amount';
               }*/
        }
    }



}
