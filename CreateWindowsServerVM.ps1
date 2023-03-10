# Define the path to the Windows Server ISO file
$isoPath = "C:\path\to\WindowsServer.iso"

# Define the name and location of the VM
$vmName = "testserver"
$vmLocation = "D:\VMs"

# Create the new VM with default settings
New-VM -Name $vmName -Path $vmLocation -MemoryStartupBytes 6GB -SwitchName "Internal Network"

# Configure the VM to boot from the ISO file
Set-VMDvdDrive -VMName $vmName -Path $isoPath

# Start the VM and wait for the installation process to complete
Start-VM -Name $vmName -WaitForGuest

# After the installation is complete, disconnect the ISO file
Set-VMDvdDrive -VMName $vmName -Path $null

