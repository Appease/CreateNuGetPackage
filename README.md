![](https://ci.appveyor.com/api/projects/status/rayv6xsibmqf48e8?svg=true)

####What is it?

An [Appease](http://appease.io) task template that creates one or more [NuGet](http://www.nuget.org/) packages

####How do I install it?

```PowerShell
Add-AppeaseTask `
    -DevOpName YOUR-DEVOP-NAME `
    -Name YOUR-TASK-NAME `
    -TemplateId CreateNuGetPackage
```

####What parameters are required?
none

####What parameters are optional?

#####IncludeCsprojAndOrNuspecPath
description: a `string[]` representing included .nuspec and/or .csproj file paths. Either literal or wildcard paths are allowed.  
default: all .nuspec files within your project root dir @ any depth unless .csproj files found by same name in which case .csproj will be used.

#####ExcludeCsprojAndOrNuspecPath
description: a `string[]` representing .csproj and/or .nuspec file names to exclude. Either literal or wildcard names are supported.

#####Recurse
description: a `switch` representing whether to recursively search directories below $IncludeCsprojAndOrNuspecPath.

#####PreferNuspec
description: a `switch` representing whether to prefer .nuspec files over project files(.csproj,.vbproj..etc.).  
default: Prefers project files with the same base name as .nuspec files (when they exist).

#####OutputDirectoryPath
description: a `string` representing the output directory to pass to `nuget.exe pack`.

#####Version
description: a `string` representing the version of the package.

#####IncludeSymbols
description: a `switch` representing whether debug symbols should included in the package.