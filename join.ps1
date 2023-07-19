# Define parameters
param(
    [Parameter(Mandatory=$true)]
    [string]$DomainName,
    [Parameter(Mandatory=$true)]
    [string]$AdminUsername,
    [Parameter(Mandatory=$true)]
    [SecureString]$AdminPassword
)

# Convert secure string password to plain text
$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($AdminPassword)
$PlainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

# Create a credential object
$Credential = New-Object System.Management.Automation.PSCredential ($AdminUsername, $AdminPassword)

# Join the domain
Add-Computer -DomainName $DomainName -Credential $Credential -Restart -Force
