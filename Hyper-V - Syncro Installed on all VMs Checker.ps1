# Include your syncroinstaller as a required file for this script and store it in C:\syncroinstaller.exe

Import-Module $env:SyncroModule

$Whitelist = @(
    'computername1',
    )


$Username = "ENTER USERNAME"
$Password = "ENTER PASSWORD" | ConvertTo-SecureString -asPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($username,$password)
$VMList = @()

# Check if Syncro is installed on all VMs
get-vm | where {$_.State -ne 'Stopped' -and $_.State -ne 'Off' -and $_.Name -notin $Whitelist} | %{

    
    $SyncroInstalled = Invoke-Command -VMName $_.Name -Credential $credential -ScriptBlock {
        $SyncroInstalled = Test-Path 'C:\Program Files\repairtech' 
        Return $SyncroInstalled
    }
    
    $VMList+=(
        [pscustomobject]@{
            VMName=$_.VMName
            SyncroInstalled=$SyncroInstalled
            }
    )

}

# Install Syncro on device that returned false to the previous check
$SyncroNotInstalledList = @()
$VMList | %{

    If ($_.SyncroInstalled -ne 'True'){
        Copy-VMFile -VMName $_.VMName -SourcePath "C:\syncroinstaller.exe" -DestinationPath "C:\Temp\syncroinstaller.exe" -CreateFullPath -FileSource Host -ErrorAction SilentlyContinue
        Invoke-Command -VMName $_.VMName -ScriptBlock {start c:\Temp\syncroinstaller.exe} -Credential $credential
        $SyncroNotInstalledList += $_.VMName
        }
}


# Alert on Syncro
$Body = "
Syncro was not be installed on the following workstations:

$SyncroNotInstalledList

Attempting to automatically install syncro on these devices. No action is required unless this alert appears 2 days in a row.
"

If($SyncroNotInstalledList){Rmm-Alert -Category 'Syncro Deployment' -Body $Body}