####What is it?

A [Posh-CI](https://github.com/Posh-CI/Posh-CI) step that creates one or more [NuGet](http://www.nuget.org/) packages

####How do I install it?

```PowerShell
Add-CIStep -Name "YOUR-CISTEP-NAME" -ModulePackageId "Posh-CI-CreateNuGetPackage"
```

####What parameters are available?

#####CsprojAndOrNuspecFilePaths
explicit paths to .nuspec and or .csproj files you want to pass to `nuget.exe pack`; defaults is all .nuspec files within your project root dir @ any depth unless .csproj files found by same name in which case .csproj will be used
```PowerShell
[string[]][Parameter(ValueFromPipelineByPropertyName = $true)]$CsprojAndOrNuspecFilePaths
```
#####OutputDirectoryPath
the output directory to pass to `nuget.exe pack`
```PowerShell
[string][Parameter(ValueFromPipelineByPropertyName=$true)]$OutputDirectoryPath='.'
```
#####Version
version to pass to `nuget.exe pack`
```PowerShell
[string][Parameter(ValueFromPipelineByPropertyName=$true)]$Version='0.0.1'
```

####What's the build status?
![](https://ci.appveyor.com/api/projects/status/78dvewyub2c3ih9c?svg=true)

