tableextension 50113 "Last Sold Item in SalesOrder" extends "Sales Header"
{

    fields
    {
        field(50118; "Last posting date"; Date)
        {


            FieldClass = FlowField;
            CaptionClass = 'Last posting date';
            CalcFormula = max("Last Sold Price Finder"."Posting Date" where("Customer No" = field("Sell-to Customer No.")));

        }

        field(50111; "Last Sold Price"; Decimal)
        {


            FieldClass = FlowField;
            CaptionClass = 'Last Sold Price';
            CalcFormula = max("Last Sold Price Finder"."LastItem Sold Price" where("Customer No" = field("Sell-to Customer No."), "Posting Date" = field("Last Posting Date")));

        }
    }
}
