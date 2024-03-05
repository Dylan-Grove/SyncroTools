Import-Module $env:SyncroModule


if(Get-NetFirewallProfile -Profile Domain,Public,Private | Where Enabled -eq True){
    $Hostname = hostname
    Rmm-Alert -Category 'Firewall' -Body 'The Domain, Public, or Private Firewall profile is enabled.  Deploying Automated Remediation...'
}