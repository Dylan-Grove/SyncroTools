Import-Module $env:SyncroModule


Get-NetAdapterBinding | Where-Object ComponentID -EQ 'ms_tcpip6' | Disable-NetAdapterBinding -ComponentID 'ms_tcpip6'

Rmm-Alert -Category 'IPv6' -Body "IPv6 has been disabled on all ethernet adapters."