# Load posh-git module from current directory
Import-Module posh-git;
Import-Module C:\Projects\Scripts\OneStoreScripts.ps1;

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

$computerName = $env:COMPUTERNAME.Substring(0,1).ToUpper() + 
                $env:COMPUTERNAME.Substring(1).ToLower();

$host.ui.RawUI.WindowTitle = "Terminal"

# Set up a simple prompt, adding the git prompt parts inside git repos
function global:prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    Write-Host($env:USERNAME) -NoNewline -ForegroundColor Cyan
    Write-Host("@") -NoNewline -ForegroundColor White
    Write-Host($computerName)-NoNewline -ForegroundColor Cyan

    Write-VcsStatus

    $global:LASTEXITCODE = $realLASTEXITCODE
    Write-Host " $" -ForegroundColor yellow -NoNewline
    return " ";
}

# Aliases
function lsdir { ls.exe --color=auto $args }
Set-Alias -name ls -value lsdir -Option allscope;
Set-Alias -name echo -value "echo.exe" -Option allscope;
Set-Alias -name open -value "ii";

function which 
{
    param([string] $executable)
    return (Get-command $executable).Source
}

function track { & git push --set-upstream $args }
New-Alias -Name s -Value track -Force -Option AllScope;

function projects { & Set-Location C:\Projects; Get-Location; }
New-Alias -Name proj -Value projects -Force -Option AllScope;

function Restart-Explorer { Stop-Process -ProcessName explorer }
Set-alias -name restart -value Restart-Explorer;

function whois {
  param ([Parameter(Mandatory=$True,
          HelpMessage='Please enter domain name (e.g. microsoft.com)')]
          [string]$domain)
  Write-Host "Connecting to Web Services URL..." -ForegroundColor Green
  try {
    #Retrieve the data from web service WSDL
    If ($whois = New-WebServiceProxy -uri "http://www.webservicex.net/whois.asmx?WSDL") {
      Write-Host "Ok" -ForegroundColor Green
    }
    else {
      Write-Host "Error" -ForegroundColor Red
    }

    Write-Host "Gathering $domain data..." -ForegroundColor Green
    #Return the data
    (($whois.getwhois("=$domain")).Split("<<<")[0])
  } 
  catch {
    Write-Host "Please enter valid domain name (e.g. microsoft.com)." -ForegroundColor Red}
} 

Clear-Host;
