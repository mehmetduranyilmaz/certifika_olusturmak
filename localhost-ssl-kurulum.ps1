# ====================================================================
# Localhost SSL Sertifikasi Olusturma ve Kurulum Script
# ====================================================================
# Bu script localhost icin self-signed SSL sertifikasi olusturur,
# export eder ve Trusted Root'a ekler.
# ====================================================================

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "Localhost SSL Sertifikasi Kurulum Baslatiliyor..." -ForegroundColor Cyan
Write-Host "================================================`n" -ForegroundColor Cyan

# 1. Yeni sertifika olustur
Write-Host "[1/5] Sertifika olusturuluyor..." -ForegroundColor Yellow
$cert = New-SelfSignedCertificate -DnsName "localhost" `
    -CertStoreLocation "Cert:\LocalMachine\My" `
    -NotAfter (Get-Date).AddYears(10) `
    -FriendlyName "Localhost Development Certificate"

Write-Host "OK Sertifika basariyla olusturuldu!" -ForegroundColor Green
Write-Host "  Thumbprint: $($cert.Thumbprint)" -ForegroundColor Gray
Write-Host "  Gecerlilik: $(Get-Date) - $($cert.NotAfter)`n" -ForegroundColor Gray

# 2. Sifre hazirla
Write-Host "[2/5] Export sifresi hazirlaniyor..." -ForegroundColor Yellow
$password = ConvertTo-SecureString -String "586293" -Force -AsPlainText
Write-Host "OK Sifre hazir!`n" -ForegroundColor Green

# 3. PFX olarak export et
Write-Host "[3/5] PFX formatinda export ediliyor..." -ForegroundColor Yellow
Export-PfxCertificate -Cert $cert -FilePath "C:\localhost-cert.pfx" -Password $password | Out-Null
Write-Host "OK PFX dosyasi olusturuldu: C:\localhost-cert.pfx`n" -ForegroundColor Green

# 4. CER olarak export et
Write-Host "[4/5] CER formatinda export ediliyor..." -ForegroundColor Yellow
Export-Certificate -Cert $cert -FilePath "C:\localhost-cert.cer" | Out-Null
Write-Host "OK CER dosyasi olusturuldu: C:\localhost-cert.cer`n" -ForegroundColor Green

# 5. Trusted Root Certification Authorities'e ekle
Write-Host "[5/5] Trusted Root'a ekleniyor..." -ForegroundColor Yellow
$rootStore = New-Object System.Security.Cryptography.X509Certificates.X509Store("Root", "LocalMachine")
$rootStore.Open("ReadWrite")
$rootStore.Add($cert)
$rootStore.Close()
Write-Host "OK Sertifika Trusted Root'a eklendi!`n" -ForegroundColor Green

# Ozet bilgi
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "KURULUM TAMAMLANDI!" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "`nSertifika Bilgileri:" -ForegroundColor White
Write-Host "  Subject: $($cert.Subject)" -ForegroundColor Gray
Write-Host "  Thumbprint: $($cert.Thumbprint)" -ForegroundColor Gray
Write-Host "  Gecerlilik Suresi: 10 yil" -ForegroundColor Gray
Write-Host "  Friendly Name: Localhost Development Certificate" -ForegroundColor Gray
Write-Host "`nDosyalar:" -ForegroundColor White
Write-Host "  PFX: C:\localhost-cert.pfx (Sifre: YourPassword123)" -ForegroundColor Gray
Write-Host "  CER: C:\localhost-cert.cer" -ForegroundColor Gray
Write-Host "`nSertifika Konumlari:" -ForegroundColor White
Write-Host "  Personal: Cert:\LocalMachine\My" -ForegroundColor Gray
Write-Host "  Trusted Root: Cert:\LocalMachine\Root" -ForegroundColor Gray
Write-Host "`nKontrol:" -ForegroundColor White
Write-Host "  certlm.msc komutunu calistirarak kontrol edebilirsiniz" -ForegroundColor Gray
Write-Host "`n================================================`n" -ForegroundColor Cyan