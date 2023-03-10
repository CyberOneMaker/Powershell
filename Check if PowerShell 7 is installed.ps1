# Check if PowerShell 7 is installed
if (-not (Test-Path "C:\Program Files\PowerShell\7\pwsh.exe")) {
    Write-Output "PowerShell 7 not found. Installing..."

    # Download and Install PowerShell 7 zip archive

iex "& { $(irm https://aka.ms/install-powershell.ps1) } -UseMSI -Quiet"


} else {
    Write-Output "PowerShell 7 found."
}

# Set the path to the PowerShell 7 executable
$pwsh = "C:\Program Files\PowerShell\7\pwsh.exe"

# Check if the PSWindowsUpdate module is installed
if (& $pwsh -Command { -not (Get-Module -Name PSWindowsUpdate -ListAvailable) }) {

& $pwsh -Command { Install-Module -Name PSWindowsUpdate -Scope AllUsers -AllowPrerelease -Repository PSGallery -Force -ErrorAction SilentlyContinue }

} else {
    Write-Output "PSWindowsUpdate module found."
}

#Import PSWindowsUpdate Module
& $pwsh -Command Import-Module PSWindowsUpdate

# Set variables for the email notification
$to = "ARS-PA3062-ITSpecialists-FirstLineSupervisor@usda.gov"
$from = "ARS-PA3062-ITSpecialists-FirstLineSupervisor@usda.gov"
$subject = "Windows Update Complete"
$body = "Hostname $env:COMPUTERNAME has finished installing updates on $(Get-Date)."

# Perform Windows Updates using the PSWindowsUpdate module
Write-Output "Searching for updates..."
& $pwsh -Command { Get-WindowsUpdate -Install -AcceptAll -IgnoreReboot }

# Reboot the system if updates were installed
if ($updates.Count -gt 0) {
    Write-Output "Updates installed. Rebooting..."
 #   Restart-Computer -Force
}

# Wait for the system to come back up
while (-not (Test-Connection -ComputerName $env:COMPUTERNAME -Quiet -Count 1)) {
    Write-Output "Waiting for system to come back up..."
    Start-Sleep -Seconds 30
}

# Send an email notification that the update is complete
Write-Output "Sending email notification..."
Send-MailMessage -To $to -From $from -Subject $subject -Body $body -SmtpServer 10.133.169.13