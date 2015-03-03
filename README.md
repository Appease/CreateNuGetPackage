####What is it?

A [PoshCI](https://github.com/PoshCI/PoshCI) step that creates one or more [NuGet](http://www.nuget.org/) packages

####How do I install it?

```PowerShell
Add-CIStep -Name "YOUR-CISTEP-NAME" -PackageId "CreateNuGetPackage"
```

####What parameters are available?

#####CsprojAndOrNuspecFilePaths
A String[] representing explicit paths to .nuspec and or .csproj files you want to pass to `nuget.exe pack`; defaults is all .nuspec files within your project root dir @ any depth unless .csproj files found by same name in which case .csproj will be used
```PowerShell
[String[]]
[Parameter(
    ValueFromPipelineByPropertyName = $true)]
$CsprojAndOrNuspecFilePaths
```
#####OutputDirectoryPath
A String representing the output directory to pass to `nuget.exe pack`
```PowerShell
[String]
[Parameter(
    ValueFromPipelineByPropertyName = $true)]
$OutputDirectoryPath='.'
```
#####Version
version to pass to `nuget.exe pack`
```PowerShell
[String]
[Parameter(
    ValueFromPipelineByPropertyName = $true)]
$Version='0.0.1'
```

####What's the build status?
![](https://ci.appveyor.com/api/projects/status/78dvewyub2c3ih9c?svg=true)

