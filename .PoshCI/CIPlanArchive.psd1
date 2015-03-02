[PSCustomObject]@{
	Steps = [Ordered]@{
		CreateNuGetPackage = [PSCustomObject]@{
			Name = [String]"CreateNuGetPackage"; 
			PackageId = [String]"PoshCI.CreateNuGetPackage"; 
			PackageVersion = [String]"0.0.3"; 
			Parameters = [Hashtable]@{
				Version = [String]"0.0.4"
			}
		}
	}
}
