$ErrorActionPreference = 'Stop';
$url='https://github.com/miiton/Cica/releases/download/v5.0.1/Cica_v5.0.1_with_emoji.zip'
$packageName= 'cica'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$dist = Join-Path $toolsDir "fonts"
$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $dist
  url           = $url
  softwareName  = 'cica*'
  checksum      = ''
  checksumType  = 'sha256'
}
 
# un zip
Install-ChocolateyZipPackage @packageArgs
 
# un tar
# 
#$zip = Join-Path $toolsDir ("$([System.IO.Path]::GetFileNameWithoutExtension($url)).zip")
#Get-ChocolateyUnzip -FileFullPath $zip -Destination $dist
 
# Install fonts
powershell -f """$(Split-Path -parent $MyInvocation.MyCommand.Definition)\Add-Font.ps1"""  $dist

 
