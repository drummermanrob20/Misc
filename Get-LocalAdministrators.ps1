# prompt user for CSV file to store output; break if a valid CSV file path/name with extension is not specified
$Path = Read-Host "Enter the full path to a CSV file where data will be stored"
if ($Path -notmatch '.\.csv$') { break }

# get all computers in the current domain
$Computer = (Get-ADComputer -Filter *).Name

# connect to each machine and return a custom PS Object containing computer names and local admin group members; output stored in CSV
Invoke-Command -ComputerName $Computer -ScriptBlock {
    $objCol = @()
    $Member = Get-LocalGroupMember -Group Administrators
    foreach ($m in $Member) {
        $obj = [PSCustomObject]@{
            ComputerName = $env:COMPUTERNAME
            Member = $m.Name
        }
        $objCol += $obj
    }
    Write-Output $objCol
} -ErrorAction SilentlyContinue | Select-Object ComputerName, Member | Export-Csv -Path $Path -NoTypeInformation -Force