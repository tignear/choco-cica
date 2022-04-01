$ErrorActionPreference = 'Stop';
$url='https://github.com/miiton/Cica/releases/download/v5.0.3/Cica_v5.0.3.zip'
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
  checksum      = 'cbd1bcf1f3fd1ddbffe444369c76e42529add8538b25aeb75ab682d398b0506f'
  checksumType  = 'sha256'
}

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
Start-ChocolateyProcessAsAdmin $toExecute
