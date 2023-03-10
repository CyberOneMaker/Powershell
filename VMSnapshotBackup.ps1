#PS script to create snapshots of VMs

# Check if PowerShell 7 is installed
if (Get-Command pwsh -ErrorAction SilentlyContinue) 
{
    Write-Output "PowerShell 7 is installed. Using PowerShell 7 for the rest of the script."
    & pwsh -c $([ScriptBlock]::Create($ExecutionContext.SessionState.InvokeCommand.NewScriptBlock("Set-Item -Path variable:PSVersionTable.PSVersion -Value ([version]'7.0')")))
}

# Get all virtual machines on the local Hyper-V server
$vms = Get-VM

# Iterate through each virtual machine
foreach ($vm in $vms) {

    # Get the current date and time
    $currentDate = Get-Date

    # Create a snapshot of the virtual machine
    $snapshotName = "$($vm.Name)_$($currentDate.ToString('MMddyyyy_HHmmss'))"
    Checkpoint-VM -Name $vm.Name -SnapshotName $snapshotName

    # Get all snapshots for the virtual machine
    $snapshots = Get-VMSnapshot -VMName $vm.Name

    # Iterate through each snapshot
    foreach ($snapshot in $snapshots) {

        # Calculate the age of the snapshot
        $age = $currentDate - $snapshot.CreationTime

        # Delete the snapshot if it is more than 90 days old
        if ($age.TotalDays -gt 90) {
            Remove-VMSnapshot -VMName $vm.Name -Name $snapshot.Name -Confirm:$false
        }
    }
}
