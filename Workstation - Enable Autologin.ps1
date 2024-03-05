# Include $Username and $Password as required runtime variables.


Set-ItemProperty –Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' –Name AutoAdminLogon -Value "1"
New-ItemProperty –Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' –Name DefaultUserName -Value $Username
New-ItemProperty –Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' –Name DefaultPassword -Value $Password
Set-ItemProperty –Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' –Name DefaultUserName -Value $Username
Set-ItemProperty –Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' –Name DefaultPassword -Value $Password