# halt immediately on any errors which occur in this module
$ErrorActionPreference = 'Stop'

function Invoke-CIStep(
[String]
[ValidateNotNullOrEmpty()]
[Parameter(
    Mandatory=$true,
    ValueFromPipelineByPropertyName=$true)]
$PoshCIProjectRootDirPath,

[String[]]
[Parameter(
    ValueFromPipelineByPropertyName = $true)]
$CsprojAndOrNuspecFilePaths,

[String]
[Parameter(
    ValueFromPipelineByPropertyName = $true)]
$OutputDirectoryPath,

[String]
[Parameter(
    ValueFromPipelineByPropertyName = $true)]
$Version='0.0.1',

[Switch]
[Parameter(
    ValueFromPipelineByPropertyName = $true)
$IncludeSymbols]){
    
    # default to recursively picking up any .nuspec files below the project root directory path.
    # if .csproj found with same name as any .nuspec that will be used instead
    if(!$CsprojAndOrNuspecFilePaths){

        $CsprojAndOrNuspecFilePaths = @()
    
        foreach($nuspecFileInfo in (Get-ChildItem -Path $PoshCIProjectRootDirPath -File -Name '*.nuspec' -Recurse)){
    
            $csprojFilePath = $nuspecFileInfo -ireplace '.nuspec','.csproj'

            if(Test-Path $csprojFilePath){
                $csprojAndOrNuspecFilePaths += $csprojFilePath
            }
            else{
                $csprojAndOrNuspecFilePaths += $nuspecFileInfo
            }

        }

    }
    
    $nugetExecutable = 'nuget'

    foreach($csprojOrNuspecFilePath in $CsprojAndOrNuspecFilePaths)
    {
        
        $nugetParameters = @('pack',(Resolve-Path $csprojOrNuspecFilePath),'-Version',$Version)
        
        if($OutputDirectoryPath){
            $nugetParameters = $nugetParameters + @('-OutputDirectory',$OutputDirectoryPath)
        }
        if($IncludeSymbols.IsPresent){
            $nugetParameters = $nugetParameters + @('-Symbols')
        }
    
Write-Debug `
@"
Invoking nuget:
& $nugetExecutable $($nugetParameters|Out-String)
"@
        & $nugetExecutable $nugetParameters

        # handle errors
        if ($LastExitCode -ne 0) {
            throw $Error
        }
    }

}

Export-ModuleMember -Function Invoke-CIStep
