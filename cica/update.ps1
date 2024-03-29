import-module au

$releases = 'https://github.com/miiton/Cica/releases'
function global:au_BeforeUpdate {
    $Latest.Checksum = Get-RemoteChecksum $Latest.URL
}
function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^[$]url\s*=\s*)('.*')"        = "`$1'$($Latest.URL)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

    $url   = $download_page.links | ? href -match 'Cica_v\d+\.\d+\.\d+\.zip$' | % href | select -First 1
    $version = ((Split-Path ( Split-Path $url ) -Leaf)).Remove(0,1)
    @{
        URL   = 'https://github.com' + $url
        Version = $version
    }
}

update -ChecksumFor None