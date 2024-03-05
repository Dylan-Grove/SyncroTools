# Include your syncroinstaller as a required file for this script and store it in C:\syncroinstaller.exe

get-vm | Enable-VMIntegrationService -Name 'Guest Service Interface'

$Username = "ENTER USERNAME"
$Password = "ENTER PASSWORD" | ConvertTo-SecureString -asPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($username,$password)

$ScriptBlock = {
    
    start c:\Temp\syncroinstaller.exe

}


#Run against all VMs
Get-VM | %{Copy-VMFile -VMName $_.Name -SourcePath "C:\syncroinstaller.exe" -DestinationPath "C:\Temp\syncroinstaller.exe" -CreateFullPath -FileSource Host -verbose}
Get-vm | %{Invoke-Command -VMName $_.Name -ScriptBlock $ScriptBlock -Credential $credential}
