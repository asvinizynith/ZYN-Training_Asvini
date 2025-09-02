pageextension 50121 Modifylogext extends "Customer Card"
{
    actions
    {
        addlast(Processing)
        {
            action("Modify Log")
            {
                ApplicationArea = All;
                Caption = 'Modify Log';
                Image = View; // Optional - you can choose an icon
                trigger OnAction()
                begin
                    PAGE.Run(PAGE::"Modify Log List");
                end;

            }
        }
    }
}