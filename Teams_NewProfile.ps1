# Launch a second instance of the Teams desktop app to allow simultaneious sign-in across multiple accounts / tenants

# Uses the file name as the profile name
$MSTEAMS_PROFILE = 'NewProfile'

Write-Host "- Using profile '$MSTEAMS_PROFILE'"

# Set the custom profile path
$USERPROFILE = Join-Path $env:LOCALAPPDATA "Microsoft\Teams\CustomProfiles\$MSTEAMS_PROFILE"

# Set the old user profile
$OLD_USERPROFILE = $env:USERPROFILE

# Launch MS Teams with the custom profile
Write-Host "- Launching MS Teams with profile '$MSTEAMS_PROFILE'"
Set-Location "$OLD_USERPROFILE\AppData\Local\Microsoft\Teams"

$teamsProcessStartInfo = New-Object System.Diagnostics.ProcessStartInfo
$teamsProcessStartInfo.FileName = "$OLD_USERPROFILE\AppData\Local\Microsoft\Teams\Update.exe"
$teamsProcessStartInfo.Arguments = "--processStart ""Teams.exe"""
$teamsProcessStartInfo.WorkingDirectory = "$OLD_USERPROFILE\AppData\Local\Microsoft\Teams"
$teamsProcessStartInfo.EnvironmentVariables["USERPROFILE"] = $USERPROFILE
$teamsProcessStartInfo.UseShellExecute = $false

[System.Diagnostics.Process]::Start($teamsProcessStartInfo) | Out-Null

# Set the user profile back to the old user profile
$env:USERPROFILE = $OLD_USERPROFILE
