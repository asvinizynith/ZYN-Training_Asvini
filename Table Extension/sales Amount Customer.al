tableextension 50126 "Customersales Extension" extends "Customer"
{
    fields
    {

        field(50103; "sales Year Fliter"; Date)
        {
            Caption = 'sales Year Fliter';
            FieldClass = FlowFilter;
        }

        /* field(50105; "Sales Amount"; Decimal)
         {
             Caption = 'Sales Amount';

             FieldClass = FlowField;
             CalcFormula = Sum("Cust. Ledger Entry"."Amount" where("Customer No." = field("No."),
              "Posting Date" = field("Sales Year Fliter")));
         }*/
    }
}