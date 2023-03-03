#Install Winget
$url = 'https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle'
$file = "$env:TEMP\Microsoft.DesktopAppInstaller.msixbundle"
Invoke-WebRequest -Uri $url -OutFile $file

Add-AppxPackage -Path $file -Verbose -confirm:$false


#A series of Winget commands I had to run to get it to work.  Some of these can obviously be removed.  I expect it to get better as Winget is so new.
WinGet source reset --force
winget source reset --force --verbose-logs
echo Y | winget upgrade -h --all --verbose-logs
echo Y | winget upgrade --all --verbose-logs
winget source reset winget
winget source update

#In time, the below commands will be cleaned up.  Leaving them here for reference now until I get it all in place.

#WinGet source remove --name msstore
#curl https://aka.ms/microsoft-store-terms-of-transaction

#echo Y | winget update
#echo Y | winget upgrade
#echo Y | winget upgrade --id GitHub.GitHubDesktop

#WinGet --version

winget -v

#echo Y | winget list


#echo Y | winget upgrade --id Microsoft.Office
#echo Y | winget upgrade --id "ProPlus2019Volume - en-us"

#echo Y | winget update -all

#echo Y | winget upgrade -h --all --verbose-logs

#echo Y | winget upgrade --id O365ProPlusRetail - en-us
#echo Y | winget upgrade --id Microsoft.Office
#winget list Microsoft.office
#echo Y | winget update
#echo Y | winget search Office

#echo Y | winget upgrade --id "9WZDNCRD29V9"
#echo Y | winget upgrade --id "Microsoft.Office"

#echo Y | winget list
