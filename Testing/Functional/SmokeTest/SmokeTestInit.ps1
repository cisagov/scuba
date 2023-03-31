function New-ServicePrincipalCertificate{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [Object[]]$EncodedCertificate,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [SecureString]$CertificatePassword
    )

    Set-Content -Path .\ScubaExecutionCert.txt -Value $EncodedCertificate
    certutil -decode .\ScubaExecutionCert.txt .\ScubaExecutionCert.pfx
    $Certificate = Import-PfxCertificate -FilePath .\ScubaExecutionCert.pfx -CertStoreLocation Cert:\CurrentUser\My -Password $CertificatePassword
    [String](([System.Security.Cryptography.X509Certificates.X509Certificate2]$Certificate).Thumbprint)
}