# Should run Set-ExecutionPolicy Unrestricted first
# Set-ExecutionPolicy Unrestricted

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

# I hate it
winget install -e --id Notion.Notion

# TODO Install: MobaXterm, Navicat, Apache, php, etc..

# Install global npm packages
Write-Host "Installing Codex CLI..."
npm i -g @openai/codex

# Install Claude Code
Write-Host "Installing Claude Code..."
irm https://claude.ai/install.ps1 | iex

# ─── PowerShell aliases ────────────────────────────────────────────────────────
Write-Host "Adding aliases to PowerShell profile..."
$psAliasBlock = @'

# Codex alias (skip sandbox)
function Invoke-Codex { & (Get-Command codex -CommandType Application | Select-Object -First 1).Source --dangerously-bypass-approvals-and-sandbox $args }
Set-Alias codex Invoke-Codex -Option AllScope -Force

# Claude alias (skip permissions)
function Invoke-Claude { & (Get-Command claude -CommandType Application | Select-Object -First 1).Source --dangerously-skip-permissions $args }
Set-Alias claude Invoke-Claude -Option AllScope -Force

'@

if (-not (Test-Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force | Out-Null
}
if (-not (Select-String -Path $PROFILE -Pattern "dangerously-bypass-approvals-and-sandbox" -Quiet)) {
    Add-Content -Path $PROFILE -Value $psAliasBlock
    Write-Host "PowerShell aliases added to $PROFILE"
} else {
    Write-Host "PowerShell aliases already exist. Skipping."
}
. $PROFILE

# ─── CMD aliases (doskey) ──────────────────────────────────────────────────────
Write-Host "Setting up CMD aliases via doskey..."
$dosKeyFile = "$env:USERPROFILE\aliases.doskey"
$dosKeyContent = @'
codex=codex --dangerously-bypass-approvals-and-sandbox $*
claude=claude --dangerously-skip-permissions $*
'@

Set-Content -Path $dosKeyFile -Value $dosKeyContent -Encoding ASCII

# Register doskey macrofile in registry so CMD loads it automatically
$regPath = "HKCU:\Software\Microsoft\Command Processor"
$autoRun = "doskey /macrofile=`"$env:USERPROFILE\aliases.doskey`""
Set-ItemProperty -Path $regPath -Name "AutoRun" -Value $autoRun -Type String
Write-Host "CMD aliases registered. Will apply to all new CMD windows."

Write-Host ""
Write-Host "Done! Restart CMD/PowerShell to apply aliases."
