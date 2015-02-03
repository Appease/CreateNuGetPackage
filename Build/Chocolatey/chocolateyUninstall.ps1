try {

    . "$PSScriptRoot\Posh-CI-CreateNuGetPackage\Uninstall.ps1"

    Write-ChocolateySuccess 'Posh-CI-CreateNuGetPackage'

} catch {

    Write-ChocolateyFailure 'Posh-CI-CreateNuGetPackage' $_.Exception.Message

    throw 
}
