Import-Module $env:SyncroModule


if(Get-NetAdapterBinding | Where-Object ComponentID -EQ 'ms_tcpip6' | where Enabled -EQ 'True'){
    $Hostname = hostname
    Rmm-Alert -Category 'IPv6' -Body 'IPv6 is enabled on an ethernet adapter. Deploying Automated Remediation...'
}