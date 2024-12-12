function Invoke-CheckScubaGearVersionPSGallery {
    # Define the path to the file where we store the last version check time
    $VersionCheckFile = [System.IO.Path]::Combine($env:TEMP, "ScubaVersionCheck.txt")

    # Check if the version check file exists
    if (Test-Path $VersionCheckFile) {
        # Read the last check time
        $LastCheckTime = Get-Content $VersionCheckFile | Out-String
        $LastCheckTime = [datetime]::Parse($LastCheckTime)

        # If the last check was within 24 hours, skip the version check
        if ((Get-Date) -lt $LastCheckTime.AddHours(24)) {
            # Exit function without checking for a new version
            return
        }
    }

    # Retrieve the installed version of ScubaGear from the system
    $InstalledModule = Get-Module -Name ScubaGear -ListAvailable
    if ($InstalledModule) {
        $CurrentVersion = [System.Version]$InstalledModule.Version
    } else {
        # If we are here, ScubaGear is not installed from PSGallery.
        # Or it may have been installed a different way in a nonstandard folder,
        # or is running in an extracted release folder. Check github instead.
        return Invoke-CheckScubaGearVersionGithub
    }

    # Retrieve the latest version from PowerShell Gallery
    $ModuleInfo = Find-Module -Name ScubaGear
    $LatestVersion = [System.Version]$ModuleInfo.Version

    if ($CurrentVersion -lt $LatestVersion) {
        Write-Warning "A new version of ScubaGear ($LatestVersion) is available on PowerShell Gallery."
    }

    # Store the current time in the file to mark the last check time
    (Get-Date).ToString() | Set-Content $VersionCheckFile
}


function Invoke-CheckScubaGearVersionGithub {
    $ScubaManifest = Import-PowerShellDataFile (Join-Path -Path $PSScriptRoot -ChildPath 'ScubaGear.psd1' -Resolve) -ErrorAction 'Stop'
    $CurrentVersion = $ScubaManifest.ModuleVersion
    $LatestVersion = $(Invoke-RestMethod -Uri "https://api.github.com/repos/cisagov/ScubaGear/releases/latest").tag_name.TrimStart("v")
    if ($CurrentVersion -ne $LatestVersion) {
            Write-Warning "A new version of ScubaGear ($latestVersion) is available. Please consider updating at: https://github.com/cisagov/ScubaGear/releases"
    }
}

# Do the version check if the skip envvar is not defined.
if ([string]::IsNullOrWhiteSpace($env:SCUBAGEAR_SKIP_VERSION_CHECK)) {
    Invoke-CheckScubaGearVersionPSGallery
}
