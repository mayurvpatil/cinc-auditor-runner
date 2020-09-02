<powershell>
write-output "Running User Data Script"

# Set TZ
write-output "Setting TZ"
cmd.exe /c tzutil /s "Eastern Standard Time"

#setting execution policy
Set-ExecutionPolicy Unrestricted -Force

# Initial WinRM configuration
&winrm quickconfig `-q
&winrm set winrm/config '@{MaxTimeoutms="1800000"}'
&winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="4096"}'
&winrm set winrm/config/client/auth '@{Basic="true"}'
&winrm set winrm/config/service/auth '@{Basic="true"}'
&winrm set winrm/config/client '@{AllowUnencrypted="false"}'
&winrm set winrm/config/service '@{AllowUnencrypted="false"}'

# Firewall setup for HTTPS WinRM
cmd.exe /c netsh advfirewall firewall set rule group="remote administration" new enable=yes
cmd.exe /c netsh firewall delete portopening TCP 5985 CURRENT
cmd.exe /c netsh firewall delete portopening TCP 5985 ALL
cmd.exe /c netsh firewall add portopening TCP 5986 "Port 5986"

# Self-signed cert for WinRM (copied from RDP cert)
$SourceStoreScope = 'LocalMachine'
$SourceStorename = 'Remote Desktop'
$SourceStore = New-Object  -TypeName System.Security.Cryptography.X509Certificates.X509Store  -ArgumentList $SourceStorename, $SourceStoreScope
$SourceStore.Open([System.Security.Cryptography.X509Certificates.OpenFlags]::ReadOnly)
$cert = $SourceStore.Certificates | Where-Object  -FilterScript {
    $_.subject -like '*'
}
$DestStoreScope = 'LocalMachine'
$DestStoreName = 'My'
$DestStore = New-Object  -TypeName System.Security.Cryptography.X509Certificates.X509Store  -ArgumentList $DestStoreName, $DestStoreScope
$DestStore.Open([System.Security.Cryptography.X509Certificates.OpenFlags]::ReadWrite)
$DestStore.Add($cert)
$SourceStore.Close()
$DestStore.Close()

# HTTPS WinRM configuration
&winrm delete winrm/config/Listener?Address=*+Transport=HTTPS
&winrm create winrm/config/listener?Address=*+Transport=HTTPS `@`{Hostname=`"($env:COMPUTERNAME)`"`;CertificateThumbprint=`"($cert.Thumbprint)`"`}
&winrm delete winrm/config/Listener?Address=*+Transport=HTTP
</powershell>