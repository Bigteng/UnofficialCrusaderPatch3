﻿
param (
    [Parameter(Mandatory=$true)][string]$Path,
	[Parameter(Mandatory=$true)][string]$BUILD_CONFIGURATION
)

$ErrorActionPreference = "Stop"

# Creates a System.IO.FileSystemInfo
$module = Get-Item -Path $Path

Write-Output "Compiling module: $($module.Name)"

$SIMPLE_CONFIG_MAPPING = @{
    "DebugSecure" = "Debug";
    "ReleaseSecure" = "Release";
    "Debug" = "Debug";
    "Release" = "Release";
}

# If the module uses C++ we have to build it first
$hasSLN = Get-ChildItem -Recurse -Path ($module.FullName + "\*.sln")
  
# Modules that should be compiled do not inherit the Secure build configurations for now
$simpleBuildConfiguration=$SIMPLE_CONFIG_MAPPING[$BUILD_CONFIGURATION]
  
# Build the module
if($hasSLN) {
    pushd $hasSLN.Directory.FullName
    msbuild /t:restore
    msbuild /m /p:Configuration=$simpleBuildConfiguration
    popd
}