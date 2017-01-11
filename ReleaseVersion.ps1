if($Env:APPVEYOR_REPO_TAG -eq 'true') { # if there is a repo tag pushed
  if($Env:APPVEYOR_REPO_TAG_NAME -match 'v(\d+(\.)?){1,4}') { #if it matches v{Maj}.{Min}.{Rev}.{Build}
    $Env:PackageType = 'release'; # this is a release package
	Update-AppVeyorBuild -Version $Env:APPVEYOR_REPO_TAG_NAME.TrimStart("v");	
	gci -Recurse "src\**\project.json" |
	Foreach-Object {
		$json = Get-Content -Raw -Path $_.FullName | ConvertFrom-Json
		$json.version = $Env:APPVEYOR_REPO_TAG_NAME.TrimStart("v")
		$json | ConvertTo-Json -depth 999 | Out-File $_.FullName
	}
  }
}