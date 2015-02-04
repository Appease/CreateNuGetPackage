**What is it?**
A [Posh-CI](https://github.com/Posh-CI/Posh-CI) step that creates one or more [NuGet](http://www.nuget.org/) packages

**How do I use it?**

add an entry in your ci plans `Packages.config` file
```XML
<packages>
  <package id="posh-ci-createnugetpackage" />
  <!-- other dependencies snipped -->
</packages>
```

then just pass variables to Invoke-CIPlan according to the following signature 
```POWERSHELL
function Invoke-CIStep(
[string][Parameter(Mandatory=$true)]$CsprojAndOrNuspecFilePaths,
[string]$OutputDirectoryPath){
  <# implementation snipped #>
}
```

**What's the build Status?**
![](https://ci.appveyor.com/api/projects/status/78dvewyub2c3ih9c?svg=true)

