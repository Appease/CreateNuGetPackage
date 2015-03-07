# halt immediately on any errors which occur in this module
$ErrorActionPreference = 'Stop'

function Find-PrimaryNupkgSpec(
[String]
[ValidateNotNullOrEmpty()]
[ValidateScript({$_ -match '\.(nuspec|csproj)$'})]
$NuspecOrCsprojPath){

    <#
        .SUMMARY
            If .csproj found @ same path as $NuspecOrCsprojPath it will be returned; otherwise original argument returned
    #>

    $CsprojTestPath = $NuspecOrCsprojPath -ireplace '.nuspec','.csproj'

    if(Test-Path $CsprojTestPath){
        Write-Output $CsprojTestPath
    }
    else{
        Write-Output $NuspecOrCsprojPath
    }
}

function Invoke-CIStep(
[String]
[ValidateNotNullOrEmpty()]
[Parameter(
    Mandatory=$true,
    ValueFromPipelineByPropertyName=$true)]
$PoshCIProjectRootDirPath,

[String[]]
[ValidateCount(1,[Int]::MaxValue)]
[Parameter(
    ValueFromPipelineByPropertyName = $true)]
$IncludeCsprojAndOrNuspecPath = @(gci -Path $PoshCIProjectRootDirPath -File -Filter '*.nuspec' -Recurse | %{$_.FullName}),

[String[]]
[Parameter(
    ValueFromPipelineByPropertyName = $true)]
$ExcludeCsprojAndOrNuspecNameLike,

[Switch]
[Parameter(
    ValueFromPipelineByPropertyName=$true)]
$Recurse,

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
    ValueFromPipelineByPropertyName = $true)]
$IncludeSymbols){
    
    $CsprojAndOrNuspecPaths = @(gci -Path $IncludeCsprojAndOrNuspecPath -File -Exclude $ExcludeCsprojAndOrNuspecNameLike -Recurse:$Recurse | %{$_.FullName})
    
    $nugetExecutable = 'nuget'

    foreach($csprojOrNuspecPath in $CsprojAndOrNuspecPaths)
    {        
        $nugetParameters = @('pack', (Find-PrimaryNupkgSpec $csprojOrNuspecPath),'-Version',$Version)
        
        if($OutputDirectoryPath){
            $nugetParameters += @('-OutputDirectory',$OutputDirectoryPath)
        }
        if($IncludeSymbols.IsPresent){
            $nugetParameters += @('-Symbols')
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
