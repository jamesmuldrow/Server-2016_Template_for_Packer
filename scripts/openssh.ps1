cd C:\Users\Administrator\Desktop
#cp A:\OpenSSH-Win64.zip C:\Users\Administrator\Desktop\
#[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
#Invoke-WebRequest -Uri "https://github.com/PowerShell/Win32-OpenSSH/releases/download/v7.7.2.0p1-Beta/OpenSSH-Win64.zip" -OutFile "powershell.zip"
Add-Type -assembly "system.io.compression.filesystem"
[io.compression.zipfile]::ExtractToDirectory( 'C:\Users\Administrator\Desktop\OpenSSH-Win64.zip','C:\Users\Administrator\Desktop' )
$Acl = Get-Acl ".\OpenSSH-Win64"
$Ar = New-Object  system.security.accesscontrol.filesystemaccessrule("users","FullControl","Allow")
$Acl.SetAccessRule($Ar)
Set-Acl ".\OpenSSH-Win64\*" $Acl
cd .\OpenSSH-Win64
.\install-sshd.ps1
get-service | findstr ssh
Start-Service sshd
netsh advfirewall firewall add rule name=SSHPort dir=in action=allow protocol=TCP localport=22
Set-Service -Name sshd -StartupType "Automatic"
