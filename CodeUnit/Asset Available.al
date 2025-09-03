// codeunit 50119 "Update Asset Availability"
// {
//     trigger OnRun()
//     var
//         Asset: Record "Assets Table";
//     begin
//         if Asset.FindSet() then
//             repeat
//                 Asset.Updateavailable();
//                 Asset.Modify();
//             until Asset.Next() = 0;
//     end;
// }