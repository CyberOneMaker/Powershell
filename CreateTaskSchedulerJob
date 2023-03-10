#PS script to create a Task Scheduler Job to alert email group after reboot

#Check if Powershell 7 is installed
if (Get-Command pwsh -ErrorAction SilentlyContinue) 
{
    Write-Output "Powershell 7 is installed. Using Powershell 7 for the rest of the script."
    & pwsh -c $([ScriptBlock]::Create($ExecutionContext.SessionState.InvokeCommand.NewScriptBlock("Set-Item -Path variable:PSVersionTable.PSVersion -Value ([version]'7.0')")))
}

# Variables
$taskName = "$env:COMPUTERNAME Reboot"
$emailTo = "ARS-PA3062-ITSpecialists-FirstLineSupervisor@usda.gov"
$action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument "-Command `"Send-MailMessage -To '$emailTo' -From '$env:COMPUTERNAME@localhost' -Subject 'Server Rebooted' -Body 'The server $env:COMPUTERNAME has been rebooted.' -SmtpServer 10.133.169.13`""

# Check if task exists
if (Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue -TaskPath "\ARS") {
    Write-Output "The task '$taskName' already exists in the 'Task Scheduler Library\ARS' folder. Skipping task creation."
} else {
    # Create task
    $triggerParams = @{
        AtStartup = $true
    }

    $settingsParams = @{
        ExecutionTimeLimit = New-TimeSpan -Minutes 5
        StartWhenAvailable = $true
    }

    Register-ScheduledTask -TaskName $taskName -Trigger (New-ScheduledTaskTrigger @triggerParams) -User "SYSTEM" -Action $action -Settings (New-ScheduledTaskSettingsSet @settingsParams) -TaskPath "\ARS" | Out-Null
    Write-Output "The task '$taskName' has been created in the 'Task Scheduler Library\ARS' folder."
}
