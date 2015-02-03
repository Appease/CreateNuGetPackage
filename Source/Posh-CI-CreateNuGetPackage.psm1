# halt immediately on any errors which occur in this module
$ErrorActionPreference = "Stop"

function EnsureNuGetCommandLineInstalled(){
    # install nuget-commandline
    try{
        Get-Command nuget -ErrorAction Stop | Out-Null
    }
    catch{             
        cinst 'nuget.commandline'
    }    
}

function Invoke-CIStep(
[string][Parameter(Mandatory=$true)]$CsprojAndOrNuspecFilePaths,
[string]$OutputDirectoryPath){
    EnsureNuGetCommandLineInstalled
    
    foreach($CsprojAndOrNuspecFilePaths in $CsprojAndOrNuspecFilePaths)
    {        
        # invoke nuget pack
        nuget pack (resolve-path $CsprojAndOrNuspecFilePath) `
        -Symbols `
        -OutputDirectory $OutputDirectoryPath

        # handle errors
        if ($LastExitCode -ne 0) {
            throw $Error
        }
    }

}

Export-ModuleMember -Function Invoke-CIStep
