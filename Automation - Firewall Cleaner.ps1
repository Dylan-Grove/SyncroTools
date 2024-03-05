Import-Module $env:SyncroModule

Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

Rmm-Alert -Category 'Firewall' -Body "Firewall has been disabled on all profiles."