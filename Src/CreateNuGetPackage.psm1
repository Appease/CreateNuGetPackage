# halt immediately on any errors which occur in this module
$ErrorActionPreference = 'Stop'

function Get-NupkgSpecFileExtensionPreferences(
[Switch]
$PreferNuspec){

    <#
        .SUMMARY
            Gets an array of file extensions in order of descending preference;default prefers *proj extensions but can be overriden via the $PreferNuspec switch
    #>

    $nuspecFileExtension = @('.nuspec')
    $projFileExtensions = @('.csproj','.vbproj','.fsproj')
    
    # build array of extensions in order of descending preference
    if($PreferNuspec.IsPresent){
        return $nupkgSpecFileExtensionPreference = $nuspecFileExtension += $projFileExtensions
    }
    else{
        return $nupkgSpecFileExtensionPreference = $projFileExtensions +=$nuspecFileExtension
    }    
}

function Get-PreferredNupkgSpecPath(
[String]
[ValidateNotNullOrEmpty()]
[Parameter(
    Mandatory=$true)]
$NupkgSpecFilePath,
[String[]]
[ValidateCount(1,[Int]::MaxValue)]
$FileExtensionPreferences){

    <#
        .SUMMARY
            Gets the full name of the preferred nupkg specification file based on $NupkgSpecFilePath and $FileExtensionPreferences
    #>


    $nupkgSpecFile = (gi $NupkgSpecFilePath)
    $nupkgSpecFileFullBaseName = "$($nupkgSpecFile.DirectoryName)\$($nupkgSpecFile.BaseName)"
    

    foreach($fileExtensionPreference in $FileExtensionPreferences){
        $nupkgSpecFileFullName = "$nupkgSpecFileFullBaseName$fileExtensionPreference"
Write-Debug `
@"
checking for file at:
$nupkgSpecFileFullName
"@
        if(Test-Path $nupkgSpecFileFullName){
            return $nupkgSpecFileFullName
        }
    }

    throw `
@"
No file exist with base name: $nupkgSpecFileFullBaseName 
and a file extension in: $($FileExtensionPreferences|Out-String)
"@
}

function Invoke-PoshDevOpsTask(
[String]
[ValidateNotNullOrEmpty()]
[Parameter(
    Mandatory=$true,
    ValueFromPipelineByPropertyName=$true)]
$PoshDevOpsProjectRootDirPath,

[String[]]
[ValidateCount(1,[Int]::MaxValue)]
[Parameter(
    ValueFromPipelineByPropertyName = $true)]
$IncludeCsprojAndOrNuspecPath = @(gci -Path $PoshDevOpsProjectRootDirPath -File -Filter '*.nuspec' -Recurse | %{$_.FullName}),

[String[]]
[Parameter(
    ValueFromPipelineByPropertyName = $true)]
$ExcludeCsprojAndOrNuspecNameLike,

[Switch]
[Parameter(
    ValueFromPipelineByPropertyName=$true)]
$Recurse,

[Switch]
[Parameter(
    ValueFromPipelineByPropertyName=$true)]
$PreferNuspec,

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

    $nupkgSpecfileExtensionPreferences = Get-NupkgSpecFileExtensionPreferences -PreferNuspec:$PreferNuspec
    Write-Debug `
@"
Nupkg spec file extension preferences are: 
$($nupkgSpecfileExtensionPreferences|Out-String)
"@

    foreach($csprojOrNuspecPath in $CsprojAndOrNuspecPaths)
    {        
        $preferredNupkgSpecPath = Get-PreferredNupkgSpecPath $csprojOrNuspecPath -FileExtensionPreferences $nupkgSpecfileExtensionPreferences
        $nugetParameters = @('pack', $preferredNupkgSpecPath,'-Version',$Version)
        
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

Export-ModuleMember -Function Invoke-PoshDevOpsTask
