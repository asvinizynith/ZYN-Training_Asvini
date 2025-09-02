pageextension 50149 extendedline extends "Extended Text Lines"
{
    layout
    {
        addafter(Text)
        {
            field(Bold; Rec.Bold)
            {
                Caption = 'Bold';
                ApplicationArea = All;
            }
            field(Italic; Rec.Italic)
            {
                Caption = 'Italic';
                ApplicationArea = All;
            }
            field(Underline; Rec.Underline)
            {
                Caption = 'Underline';
                ApplicationArea = All;
            }
        
        }
    
    }
    
}
