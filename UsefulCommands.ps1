### Time stuff
## Usage: These commands can be used in-line or in an object.  E.g. $date = Get-Date -Uformat "%Y-%m-%d"

# Capture the date in YYYY-MM-DD format
Get-Date -UFormat "%Y-%m-%d"

# Capture the date in YYYY-MM-DD-HHmm format
Get-Date -UFormat "%Y-%m-%d-%H%M"

# Capture the date in YYYY.MM.DD.HHmm format (I use this format to version my scripts)
Get-Date -UFormat "%Y.%m.%d.%H%M"

# Capture the date in MM-DD-YY format
Get-Date -UFormat "%m-%d-%y"


### Certificate stuff
# Request a computer certificate from an internal PKI. Note that the certificate template has to be available and you must have the 'Enroll' permission for that template.
Get-Certificate -SubjectName "CN=www.example.com" -Template "YourTemplateName" -DnsName "www.example.com" -CertStoreLocation Cert:\LocalMachine\My


### Server Management
# Retrieve Local Administrators from all Member Servers and output to a CSV file
Invoke-Command (Get-ADComputer -Filter {OperatingSystem -like "*server*" -and Enabled -eq $true} | Select-Object -ExpandProperty -DnsName) -Credential (Get-Credential -Message "Provide an account with admin credentials to all member servers") -ScriptBlock {
    Get-LocalGroupMember -SID S-1-5-32-544 | Select-Object *
} | Export-Csv -Path .\LocalAdmins.csv -NoTypeInformation