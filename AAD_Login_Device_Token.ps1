$ClientID = '1b730954-1685-4b74-9bfd-dac224a7b894'
$TenantID = 'common'
$Resource = 'https://graph.windows.net/' #Service Endpoint for Azure AD Graph

$DeviceCodeParameters = @{
    Method = 'POST'
    Uri    = "https://login.microsoftonline.com/$TenantID/oauth2/devicecode"
    Body   = @{
        client_id = $ClientId
        resource  = $Resource
    }
}

$DeviceCodeRequest = Invoke-RestMethod @DeviceCodeParameters
Write-Host $DeviceCodeRequest.message -ForegroundColor Green
Read-Host -Prompt "Once you have authenticated, hit Enter to continue"
$TokenParameters = @{
        Method = 'POST'
    Uri    = "https://login.microsoftonline.com/$TenantId/oauth2/token"
    Body   = @{
        grant_type = "urn:ietf:params:oauth:grant-type:device_code"
        code       = $DeviceCodeRequest.device_code
        client_id  = $ClientId
    }
}
$TokenRequest = Invoke-RestMethod @TokenParameters
$Token = $TokenRequest.access_token

# then just authenticate using the token option
Connect-AzureAD -AadAccessToken $Token -AccountId username@yourtenant.onmicrosoft.com -TenantId ########-####-####-####-############