pageextension 50135 customercardproblemlistext extends "Customer Card"

{

    actions
    {

        addlast(processing)
        {
            action(ProblemList)
            {
                caption = 'Problem List';
                ApplicationArea = All;
                trigger OnAction()
                var
                    cusRec: Record customer;
                    problemRec: Record "Problem List";

                begin
                    cusRec.get(Rec."No.");
                    problemRec.Init();
                    problemRec."Customer ID" := cusRec."No.";
                    problemRec."Customer Name" := cusRec.Name;
                    problemRec.Insert(true);

                    PAGE.Run(Page::"Probelm List Card", problemRec)
                end;

            }
        }
    }

}
