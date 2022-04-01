$ErrorActionPreference = 'continue';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$destination = Join-Path $toolsDir "fonts"
$fontHelpers=Join-Path $toolsDir FontHelpers.ps1;
. $fontHelpers

$fontFiles = Get-ChildItem $destination -Recurse -Filter *.ttf

[string[]]$commands = $fontFiles |
ForEach-Object { Join-Path $fontsFolderPath ([System.IO.Path]::GetFileName($_)) }|Where-Object { Test-Path $_ }|ForEach-Object { "Remove-SingleFont '$([System.IO.Path]::GetFileName($_))' -Force" }
$toExecute = ". $fontHelpers;" + ($commands -join ';')
Write-Host $toExecute
Start-ChocolateyProcessAsAdmin $toExecute
