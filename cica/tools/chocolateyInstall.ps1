$ErrorActionPreference = 'Stop';
$url='https://github.com/miiton/Cica/releases/download/v5.0.1/Cica_v5.0.1_with_emoji.zip'
$packageName= 'cica'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$destination = Join-Path $toolsDir "fonts"
$fontHelpers=Join-Path $toolsDir FontHelpers.ps1;
. $fontHelpers

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $destination
  url           = $url
  softwareName  = 'cica*'
  checksum      = 'b61ae55fb1a4a98dd78e90fe68649bcfaabb20a5eaaffa57c246356890c6b0df'
  checksumType  = 'sha256'
}
Write-Host $fontsFolderPath

# un zip
Install-ChocolateyZipPackage @packageArgs


# Install fonts
$fontFiles = Get-ChildItem $destination -Recurse -Filter *.ttf
[string[]]$commands = $fontFiles |
ForEach-Object { Join-Path $fontsFolderPath $_.Name } |
Where-Object { Test-Path $_ } |
ForEach-Object { "Remove-SingleFont '$([System.IO.Path]::GetFileName($_))' -Force" }
 
# http://blogs.technet.com/b/deploymentguys/archive/2010/12/04/adding-and-removing-fonts-with-windows-powershell.aspx
$fontFiles |
ForEach-Object { $commands += "Add-SingleFont '$($_.FullName)'" }
 
$toExecute = ". '$fontHelpers';" + ($commands -join ';')
Write-Host $toExecute
Start-ChocolateyProcessAsAdmin $toExecute


 
