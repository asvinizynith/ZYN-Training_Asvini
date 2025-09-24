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
                    Customer: Record customer;
                    problem: Record "ZYN_Problem List";
                begin
                    Customer.get(Rec."No.");
                    problem.Init();
                    problem."Customer ID" := Customer."No.";
                    problem."Customer Name" := Customer.Name;
                    problem.Insert(true);
                    PAGE.Run(Page::"ZYN_Probelm List Card", problem)
                end;
            }
        }
    }
}
