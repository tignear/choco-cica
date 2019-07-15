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
  checksum      = 'b61ae55fb1a4a98dd78e90fe68649bcfaabb20a5eaaffa57c246356890c6b0df'
  checksumType  = 'sha256'
}
 
# un zip
Install-ChocolateyZipPackage @packageArgs
 
# Install fonts
powershell -f """$(Split-Path -parent $MyInvocation.MyCommand.Definition)\Add-Font.ps1"""  $dist

 
