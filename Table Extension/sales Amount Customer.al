tableextension 50126 "Customersales Extension" extends "Customer"
{
    fields
    {
        field(50103; "sales Year Fliter"; Date)
        {
            Caption = 'sales Year Fliter';
            FieldClass = FlowFilter;
        } 
    }
}