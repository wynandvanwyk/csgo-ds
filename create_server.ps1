Add-Type -AssemblyName System.IO.Compression.FileSystem

Write-Host "Loading variables..."
$variables = (Get-Content "$PSScriptRoot\config\variables.json") -join "`n" | ConvertFrom-Json

Write-Host "Creating install directory..."
$install_path = ($PSScriptRoot+"\"+$variables.install_path)
$steamcmd = ($PSScriptRoot+"\steamcmd.exe")
New-Item -ItemType Directory -Force -Path $install_path
Set-Location $install_path

Write-Host "Downloading and extracting steamcmd..."
if (-not (Test-Path "$install_path\steamcmd.zip")) { 
   (New-Object System.Net.WebClient).DownloadFile($variables.steamcmd_download_url, "$install_path\steamcmd.zip")
   Expand-Archive -Path "$install_path\steamcmd.zip" -DestinationPath $install_path -Force
}


Write-Host "Download and install the dedicated server..."
iex (".\steamcmd +login anonymous +force_install_dir " + $install_path + "\steamapps\csgo_ds +app_update 740 +quit")

if (-not (Test-Path "$install_path\steamapps\csgo_ds\csgo\addons\sourcemod")) { 
    Write-Host "Downloading and installing Sourcemod..."
    (New-Object System.Net.WebClient).DownloadFile($variables.sourcemod_url, "$PSScriptRoot\sourcemod.zip")
    Expand-Archive -Path "$PSScriptRoot\sourcemod.zip" -DestinationPath "$install_path\steamapps\csgo_ds\csgo" -Force
}

Write-Host "Downloading and Installing Metamod..."
(New-Object System.Net.WebClient).DownloadFile($variables.metamod_url, "$PSScriptRoot\metamod.zip")
Expand-Archive -Path "$PSScriptRoot\metamod.zip" -DestinationPath "$install_path\steamapps\csgo_ds\csgo" -Force

if (-not (Test-Path "$install_path\steamapps\csgo_ds\csgo\addons\sourcemod\plugins\warmod.smx")) { 
    Write-Host "Downloading and Installing Warmod..."
    (New-Object System.Net.WebClient).DownloadFile($variables.warmod_url, "$install_path\steamapps\csgo_ds\csgo\addons\sourcemod\plugins\warmod.smx")
}

Write-Host "Copying config files..."
Copy-Item -Path "$PSScriptRoot\config\csgo" -Recurse -Destination "$install_path\steamapps\csgo_ds" -Container -Force

Write-Host "Copying launch script..."
Copy-Item -Path "$PSScriptRoot\config\start_server.bat" -Destination "$install_path\steamapps\csgo_ds" -Force

Write-Host "Cleaning up downloaded files..."
If (Test-Path "$install_path\steamcmd.zip"){
	Remove-Item –path "$install_path\steamcmd.zip"
}
If (Test-Path "$PSScriptRoot\metamod.zip"){
	Remove-Item –path "$PSScriptRoot\metamod.zip"
}
If (Test-Path "$PSScriptRoot\sourcemod.zip"){
	Remove-Item –path "$PSScriptRoot\sourcemod.zip"
}


