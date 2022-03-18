# looks for a bitlocker recovery password on the C: drive of a computer

$BitLocker = Get-BitLockerVolume -MountPoint C -ErrorAction SilentlyContinue

if ($BitLocker) {
    $Password = $BitLocker.KeyProtector
    foreach ($p in $Password) {
        if ($p.RecoveryPassword) {
            $Key = $p.RecoveryPassword
            Write-Output $Key
        }
    }
}
else {break}