pageextension 50161 salesinvoicebulkposting extends "Sales Invoice List"
{

    actions
    {
        addlast(processing)
        {
            action(BulkPosting)
            {
                ApplicationArea = All;
                Caption = 'BulkPosting';
                trigger OnAction()
                var
                    ReportSelection: Report "BulkPosting";
                begin
                    Report.Run(Report::BulkPosting);
                end;

            }
        }
    }


}