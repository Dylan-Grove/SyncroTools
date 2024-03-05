#Include the splashtop streamfile as a required file at c:\temp\streamer.exe

Import-Module $env:SyncroModule
$workingdir = "c:\temp"
$url = "https://my.splashtop.com/csrs/win"
$file = "$($workingdir)\streamer.exe"

# Test if the working directory exist
    If(!(test-path $workingdir))
        {
        New-Item -ItemType Directory -Force -Path $workingdir
        }
    
# Install
        start-process -wait -Filepath $file -ArgumentList "prevercheck /s /i hidewindow=1"
        Start-Sleep -s 3
        Write-Host "Deleting Installer"
        Remove-Item -path $file