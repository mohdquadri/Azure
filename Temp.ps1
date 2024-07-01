Import-Module activedirectory
$user1 = import-csv "C:\Users\riquadri\temp\Book1.csv"
foreach($users in $user1){
    Get- -Identity $users.'disabled users'

}