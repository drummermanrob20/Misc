$servers = (Get-ADComputer -Filter * -SearchBase "").Name

Invoke-Command -ComputerName $servers -ScriptBlock {
    $hostname = hostname
    $member = (Get-LocalGroupMember -Group Administrators).Name
    $output = "[$hostname] $member"
    Write-Output $output
} -ErrorAction SilentlyContinue