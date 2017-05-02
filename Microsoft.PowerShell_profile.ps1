# Load posh-git module from current directory
Import-Module posh-git;

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

$computerName = $env:COMPUTERNAME.Substring(0,1).ToUpper() + 
                $env:COMPUTERNAME.Substring(1).ToLower();

# Set up a simple prompt, adding the git prompt parts inside git repos
function global:prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    Write-Host($env:USERNAME) -NoNewline -ForegroundColor Cyan
    Write-Host("@") -NoNewline -ForegroundColor Cyan
    Write-Host($computerName)-NoNewline -ForegroundColor Cyan

    Write-VcsStatus

    $global:LASTEXITCODE = $realLASTEXITCODE
    Write-Host " $" -ForegroundColor yellow -NoNewline
    return " ";
}

# Aliases
Set-Alias -name ls -value "ls.exe" -Option allscope;
Set-Alias -name echo -value "echo.exe" -Option allscope;
Set-Alias -name open -value "ii";
Set-Alias -name which -value "get-command";

function track { & git push --set-upstream $args }
New-Alias -Name s -Value track -Force -Option AllScope;

function projects { & Set-Location C:\Projects; Get-Location; }
New-Alias -Name proj -Value projects -Force -Option AllScope;

function Restart-Explorer { Stop-Process -ProcessName explorer }
Set-alias -name restart -value Restart-Explorer;

Clear-Host;
