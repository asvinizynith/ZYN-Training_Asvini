

pageextension 50136 upadteFieldext extends Companies
{
    actions
    {
        addlast(processing)
        {
            action(Updatefield)
            {
                ApplicationArea = All;
                Caption = 'Update Field';
                RunObject = page "UpdateField";
            }
        }
    }
}