param (
	[string]$Build = "Release",
	[string]$NugetToken = "missing"
	#[Parameter(Mandatory=$true)][string]$username,
	#[string]$password = $( Read-Host "Input password, please" )
)

$ep = Get-ExecutionPolicy -Scope CurrentUser
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# Install yaml library
if(!(Get-Module -ListAvailable -Name powershell-yaml)) {
  Install-Module powershell-yaml -Scope CurrentUser -Force  
}

Import-Module powershell-yaml

Set-ExecutionPolicy "$ep" -Scope CurrentUser


$BUILD_CONFIGURATION = $Build
$BUILD_DIR = "$BUILD_CONFIGURATION\ucp-package\"
$GITHUB_ENV = "GITHUB_ENV"
$GITHUB_SHA = git rev-parse HEAD


# Set up the right nuget packages
nuget sources add -Name "gynt-packages" -Source "https://nuget.pkg.github.com/gynt/index.json" -StorePasswordInClearText -Username git -Password "$NugetToken"
nuget restore


# Prepare the directories
# Get-ChildItem -Directory -Path "build" | Where({$_.Name -eq "$buildConfiguration"}) | Remove-Item -Recurse -Force

if(!(Test-Path -Path "$BUILD_CONFIGURATION\ucp-package")) {
  mkdir "$BUILD_CONFIGURATION"  
}

if(Test-Path -Path "$BUILD_CONFIGURATION\ucp-package") {
  Remove-Item -Recurse -Force -Path "$BUILD_CONFIGURATION\ucp-package"
}
mkdir "$BUILD_CONFIGURATION\ucp-package"
mkdir "$BUILD_CONFIGURATION\ucp-package\ucp"    


# Copy all content/ucp files ucp-package/ucp, except the modules folder
$mainfiles = Get-ChildItem content\ucp | Where({$_.Name -ne "modules"})  | foreach{$_.FullName}
Copy-Item $mainfiles -Destination "$BUILD_CONFIGURATION\ucp-package\ucp" -Recurse

### Build each module if required, and then package the module by copying the right files
# List of modules
$modules = Get-ChildItem -Directory content\ucp\modules
foreach($module in $modules) {
  
  # Create the module directory in the ucp-package\ucp\modules folder
  New-Item -Path "$BUILD_CONFIGURATION\ucp-package\ucp\modules\" -Name $module.Name -ItemType "directory"
  $moduleDir = "$BUILD_CONFIGURATION\ucp-package\ucp\modules\" + $module.Name + "\"
  
  # If the module uses C++ we have to build it first
  $hasSLN = Get-ChildItem -Recurse -Path ($module.FullName + "\*.sln")
  
  # If the module specifies a custom list of files to include, read that
  $hasFilesList = Test-Path -Path ($module.FullName + "\files.xml")
  
  # Modules that should be compiled do not inherit the Secure build configurations for now
  $simpleBuildConfiguration=$BUILD_CONFIGURATION
  if($BUILD_CONFIGURATION -eq "DebugSecure") {
    $simpleBuildConfiguration="Debug"
  }
  if($BUILD_CONFIGURATION -eq "ReleaseSecure") {
    $simpleBuildConfiguration="Release"
  }
  
  # Build the module
  if($hasSLN) {
    pushd $hasSLN.Directory.FullName
    nuget restore
    msbuild /m /p:Configuration=$simpleBuildConfiguration
    popd
  }
  
  # Copy the specified files, or *.lua and definition.yml if no module.files file was found.
  if($hasFilesList) {
    $defaultFilesNode = Select-Xml -XPath "/module/files[not(@build)]" -Path ($module.FullName + "\files.xml")
    $buildFilesNode = Select-Xml -XPath "/module/files[@build='$simpleBuildConfiguration']" -Path ($module.FullName + "\files.xml")
    
    $node = $null
    if($buildFilesNode) {
      $node = $buildFilesNode
    } elseif ($defaultFilesNode) {
      $node = $defaultFilesNode
    } else {
      Throw "Invalid files.xml in module: " + $moduleDir
    }
    
    $moduleFiles = $node.Node.file
    foreach($moduleFile in $moduleFiles) {
      # To allow specification of $(Configuration) in "src" in module.files, we substitute it with the right value here
      $srcFile = $moduleFile.src.Replace("`$(Configuration)", "$simpleBuildConfiguration")
      
      $t = $null
      if($moduleFile.target -eq $null) {
        $t = "."
      } else {
        $t = $moduleFile.target
      }
      
      # create dest if not exist
      $destinationFolder = $moduleDir + "\" + $t + "\"
      if (!(Test-Path -path $destinationFolder)) {
        New-Item $destinationFolder -Type Directory
      }
      
      # Copy the file, can include wildcards
      Copy-Item ($module.FullName + "\" + $srcFile) -Destination $destinationFolder -Recurse
    }
  } else {
    # TODO: avoid this wildcard. Include .lua .yml and ... only?
    Copy-Item ($module.FullName + "\*") -Destination $moduleDir -Recurse
  }
}


# Copy over fasm dll
Copy-Item "dll\vendor\fasm\source\dll\fasm.dll" -Destination "$BUILD_CONFIGURATION\ucp-package\ucp\code\vendor\fasm\fasm.dll"
Copy-Item "dll\vendor\fasm\LICENSE.txt" -Destination "$BUILD_CONFIGURATION\ucp-package\ucp\code\vendor\fasm\LICENSE.txt"

# Zip files in secure mode
if(($BUILD_CONFIGURATION -eq "DebugSecure") -or ($BUILD_CONFIGURATION -eq "ReleaseSecure")) {
  pushd "$BUILD_CONFIGURATION\ucp-package\"
  # Zip all files and remove the original to avoid packing twice
  7z a -tzip -m0=Copy ..\..\internaldata.zip ucp -x"!ucp/plugins" -sdel
  popd
} else {
}

# Build UCP3
msbuild /m /p:Configuration=$BUILD_CONFIGURATION .


# Copy the dll files, rename binkw32.dll to binkw32_ucp.dll
$dllfiles = Get-ChildItem $BUILD_CONFIGURATION\*.dll
Copy-Item $dllfiles -Destination "$BUILD_CONFIGURATION\ucp-package\" -Recurse

# binkw32.dll is in the Release or Debug folder.
if($BUILD_CONFIGURATION -eq "DebugSecure") {
  $binkw32dir = "Debug"
} elseif($BUILD_CONFIGURATION -eq "ReleaseSecure") {
  $binkw32dir = "Release"
} else {
  $binkw32dir = $BUILD_CONFIGURATION         
}        
Copy-Item "$binkw32dir\binkw32.dll" -Destination "$BUILD_CONFIGURATION\ucp-package\" -Recurse

Rename-Item -Path "$BUILD_CONFIGURATION\ucp-package\binkw32.dll" -NewName "binkw32_ucp.dll"

# Copy the bat file that renames binkw32_ucp.dll to binkw32.dll and backs up binkw32.dll to binkw32_real.dll (if necessary)
Copy-Item installer\rename-dlls.bat "$BUILD_CONFIGURATION\ucp-package\install.bat"

# Copy the legacy ucp.cfg
Copy-Item installer\ucp.cfg "$BUILD_CONFIGURATION\ucp-package\ucp.cfg"

mkdir "$BUILD_CONFIGURATION\ucp-package\gameseeds"


#Install-Module powershell-yaml -Scope CurrentUser -Force
#Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
#Import-Module powershell-yaml

# Set the defaults
# Function to convert a options.yml definition to a simplified ucp-config.yml style format
function Convert-ConfigFile 
{
  param (
    [hashtable]$Table
  )
  if($Table.ContainsKey("default")) 
  {
    # We reached a terminal node
    return $Table.default
  } else 
  {
    # We did not reach a terminal node, continue looking for terminals, collect them
    $nht = [ordered]@{}
    foreach($key in $Table.keys) {
        if($Table[$key] -is [System.Collections.IDictionary]) {
            # This might be a good terminal node candidate.
            $nht[$key] = Convert-ConfigFile -Table $Table[$key]
        } else 
        {
            $nht[$key] = $Table[$key]
        }
    }
    return $nht
  }
}

$defaults = [ordered]@{"modules"=[ordered]@{};"plugins"=[ordered]@{}}

$modules = Get-ChildItem -Directory content\ucp\modules

foreach($module in $modules) 
{
    $i = Get-Content -Path ($module.FullName + "\definition.yml") -Raw
    $iy = ConvertFrom-Yaml $i
    
    $name = $iy.name
    $version = $iy.version
    
    $defaults.modules[$name] = [ordered]@{}
    $defaults.modules[$name].active = $false
    $defaults.modules[$name].version = $version
    
    if(Test-Path -Path ($module.FullName + "\options.yml")) 
    {
        $defaults.modules[$name].options = [ordered]@{}
        
        $f = Get-Content -Path ($module.FullName + "\options.yml") -Raw
        $yus = ConvertFrom-Yaml $f
        
        if($yus -ne $null) 
        {
            # Create an ordered dictionary
            $yk = $yus.keys | Sort
            $y = [ordered]@{}
            foreach($k in $yk) 
            {
                $y[$k] = $yus[$k]
            }
            
            # Set the default values
            $defaults.modules[$name].options = Convert-ConfigFile -Table $y           
        } 
    }
}

$plugins = Get-ChildItem -Directory content\ucp\plugins

foreach($plugin in $plugins) 
{
    $i = Get-Content -Path ($plugin.FullName + "\definition.yml") -Raw
    $iy = ConvertFrom-Yaml $i
    
    $name = $iy.name
    $version = $iy.version
    $default_active = $iy.default
    if($default_active -eq $null) 
    {
      $default_active = $false
    }
    
    $defaults.plugins[$name] = [ordered]@{}
    $defaults.plugins[$name].active = $default_active
    $defaults.plugins[$name].version = $version
    
    if(Test-Path -Path ($plugin.FullName + "\options.yml")) 
    {
        $defaults.plugins[$name].options = [ordered]@{}
        
        $f = Get-Content -Path ($plugin.FullName + "\options.yml") -Raw
        $y = ConvertFrom-Yaml $f
        if($y -ne $null) 
        {
            $defaults.plugins[$name].options = Convert-ConfigFile -Table $y                
        }
    }
}

$o = ConvertTo-Yaml $defaults
Set-Content -Path "$BUILD_CONFIGURATION\ucp-package\ucp-config-defaults.yml" -Value $o


$f = Get-Content -Path "version.yml" -Raw
$vyml = ConvertFrom-Yaml $f

# Create the ucp-version.yml
#Import-Module powershell-yaml
$versionInfo = [ordered]@{
    major = $vyml.major;
    minor = $vyml.minor;
    patch = $vyml.patch;
    sha = "$GITHUB_SHA";
    build = "$BUILD_CONFIGURATION";
}
$y = ConvertTo-Yaml $versionInfo
Set-Content -Path "$BUILD_CONFIGURATION\ucp-package\ucp-version.yml" -Value $y


# Create a file name
$name = "$GITHUB_SHA".SubString(0, 10)
$type = "$BUILD_CONFIGURATION" #.SubString(0, 1)
if($BUILD_CONFIGURATION -eq "Debug") 
{
  $type = "DevDebug"
}
if($BUILD_CONFIGURATION -eq "DebugSecure") 
{
  $type = "Debug"
}
if($BUILD_CONFIGURATION -eq "Release") 
{
  $type = "DevRelease"
}
if($BUILD_CONFIGURATION -eq "ReleaseSecure") 
{
  $type = "Release"
}
$NAME = "UCP3-snapshot-$type-$name"


# Write a zip file in the main folder 
pushd "$BUILD_CONFIGURATION/ucp-package/"
7z a -tzip -m0=Copy "..\..\$($NAME).zip" *
popd

