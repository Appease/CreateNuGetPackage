# remove source
$installRootDirPath = "C:\Program Files\Posh-CI\Modules\Posh-CI-CreateNuGetPackage"

# make idempotent
if(Test-Path "$installRootDirPath"){
    Remove-Item $installRootDirPath -Force -Recurse
}
