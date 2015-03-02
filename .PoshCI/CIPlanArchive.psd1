[PSCustomObject]@{
	Steps = [Ordered]@{
		SetCleanTempDir = [PSCustomObject]@{
			Name = [String]"SetCleanTempDir"; 
			PackageId = [String]"PoshCI.SetCleanDir"; 
			PackageVersion = [String]"0.0.1"; 
			Parameters = [Hashtable]@{
				Path = [String]".\.PoshCI\Temp"; 
				Recurse = [Boolean]$True; 
				Force = [Boolean]$True
			}
		}; 
		CopySrcToTempDir = [PSCustomObject]@{
			Name = [String]"CopySrcToTempDir"; 
			PackageId = [String]"PoshCI.InvokeCmdlet"; 
			PackageVersion = [String]"0.0.1"; 
			Parameters = [Hashtable]@{
				CmdletName = [String]"Copy-Item"; 
				CmdletParameters = [Hashtable]@{
					Destination = [String]".\.PoshCI\Temp"; 
					Path = [String]".\Src\*"
				}
			}
		}
	}
}