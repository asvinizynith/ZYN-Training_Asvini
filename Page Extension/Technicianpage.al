pageextension 50133 ExtendNavigationBar extends "Business Manager Role Center"
{
    actions
    {
        addlast(Embedding)
        {
            action("Technician List")
            {
                ApplicationArea = All;
                RunObject = page "ZYN_Technician List";
                Caption = 'Technician List';
            }
        }
    }
}
