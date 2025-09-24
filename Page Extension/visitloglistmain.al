pageextension 50111 CustomerCardExt extends "Customer Card"
{
    actions
    {
        addlast(Processing)
        {
            action(VisitLog)
            {
                ApplicationArea = All;
                Caption = 'Visit Log';
                Image = View; // Optional - you can choose an icon
                trigger OnAction()
                begin
                    PAGE.Run(PAGE::"ZYN_Customer Visit Log List");
                end;
            }
        }
    }
}