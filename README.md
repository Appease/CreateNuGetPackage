###What is it?
A [Posh-CI](https://github.com/Posh-CI/Posh-CI) step that creates one or more [NuGet](http://www.nuget.org/) packages

###How do I install it?
add an entry in your ci plans `Packages.config` file
```XML
<packages>
  <package id="posh-ci-createnugetpackage" />
  <!-- other dependencies snipped -->
</packages>
```

###What parameters are supported?

#####CsprojAndOrNuspecFilePaths Parameter
explicit paths to .nuspec and or .csproj files you want to pass to `nuget.exe pack`; defaults is all .nuspec files within your project root dir @ any depth unless .csproj files found by same name in which case .csproj will be used
```PowerShell
[string[]][Parameter(ValueFromPipelineByPropertyName = $true)]$CsprojAndOrNuspecFilePaths
```
#####OutputDirectoryPath Parameter
the output directory to pass to `nuget.exe pack`
```PowerShell
[string][Parameter(ValueFromPipelineByPropertyName=$true)]$OutputDirectoryPath='.'
```
#####Version Parameter
version to pass to `nuget.exe pack`
```PowerShell
[string][Parameter(ValueFromPipelineByPropertyName=$true)]$Version='0.0.1'
```

###What's the build Status?
![](https://ci.appveyor.com/api/projects/status/78dvewyub2c3ih9c?svg=true)

