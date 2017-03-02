set-alias -name ls -value "ls.exe" -Option allscope;
set-alias -name echo -value "echo.exe" -Option allscope;
set-alias -name open -value "ii";

function track { & git push --set-upstream $args }
New-Alias -Name s -Value track -Force -Option AllScope;

function projects { & Set-Location C:\Projects; Get-Location; }
New-Alias -Name proj -Value projects -Force -Option AllScope;

function Restart-Explorer { Stop-Process -ProcessName explorer }
Set-alias -name restart -value Restart-Explorer;