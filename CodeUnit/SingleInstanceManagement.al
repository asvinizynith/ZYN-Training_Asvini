codeunit 50104 "ZYN_Single Instance Management"
{
    SingleInstance = true;

    internal procedure SetFromCreateAs()
    begin
        FromCreateAs := true;
    end;

    internal procedure GetFromCreateAs(): Boolean
    begin
        exit(FromCreateAs);
    end;


    internal procedure ClearCreateAs()
    begin
        Clear(FromCreateAs);
    end;
      // NEW - Syncing flag management
    internal procedure SetIsSyncing(NewValue: Boolean)
    begin
        IsSyncing := NewValue;
    end;
 
    internal procedure GetIsSyncing(): Boolean
    begin
        exit(IsSyncing);
    end;
 
    internal procedure ClearIsSyncing()
    begin
        IsSyncing := false;
    end;

    var
        FromCreateAs: Boolean;
        IsSyncing:Boolean;

}
