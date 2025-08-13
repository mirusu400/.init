# Should run Set-ExecutionPolicy Unrestricted first

$progressPreference = 'silentlyContinue'

# Check if winget is already available
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "winget not found. Installing WinGet PowerShell module from PSGallery..."
    Install-PackageProvider -Name NuGet -Force | Out-Null
    Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery | Out-Null
    Write-Host "Using Repair-WinGetPackageManager cmdlet to bootstrap WinGet..."
    Repair-WinGetPackageManager -AllUsers
    Write-Host "WinGet installation complete."
} else {
    Write-Host "winget is already installed. Skipping installation."
}

# Now use winget to install packages
winget install --id=Git.Git -e
winget install --id=Microsoft.WindowsTerminal  -e
winget install --id=Discord.Discord  -e
winget install --id=SlackTechnologies.Slack  -e
winget install --id=Microsoft.VisualStudioCode  -e
winget install --id=Microsoft.VCRedist.2013.x64  -e
winget install --id=Microsoft.VCRedist.2013.x86  -e
winget install --id=Python.Python.3.12  -e
winget install --id=Anysphere.Cursor  -e
winget install --id=OpenJS.NodeJS  -e
winget install --id=Docker.DockerDesktop  -e

winget install --id=Oracle.JDK.21 -e
# I love it
winget install -e --id ShareX.ShareX

# TODO Install: MobaXterm, Navicat, Apache, php, etc..
