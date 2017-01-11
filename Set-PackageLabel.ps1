$Env:PackageType = 'development'; # default value
if($Env:APPVEYOR_REPO_TAG -eq 'true') { # if there is a repo tag pushed
  if($Env:APPVEYOR_REPO_TAG_NAME -match 'v(\d+(\.)?){1,4}') { #if it matches v{Maj}.{Min}.{Rev}.{Build}
    $Env:PackageType = 'release'; # this is a release package	
  }
}
else{
	# set the package label
	$Env:LABEL = "$Env:PackageType-" + $Env:APPVEYOR_BUILD_NUMBER.PadLeft(5, "0")
	$Env:VERSIONLABEL = "1.0.0-$Env:LABEL" ;
	Update-AppVeyorBuild -Version $Env:VERSIONLABEL ;
	Write-Output "Packages will be suffixed with $Env:LABEL";
}
