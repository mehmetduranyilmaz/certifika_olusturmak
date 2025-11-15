# 🔐 Windows Sunucuda SSL Sertifikası Oluşturma

Windows sunucuda yerel geliştirme ortamı için SSL sertifikası oluşturma ve IIS'e kurulum adımları.

---

## 📋 Gereksinimler

- Windows Server veya Windows 10/11
- PowerShell (Yönetici yetkisi)
- IIS (Internet Information Services)

---

## 🚀 Kurulum Adımları

### 1️⃣ Script Dosyasını İndirin

`localhost-ssl-kurulum.ps1` dosyasını bilgisayarınıza indirin.

### 2️⃣ Sertifikayı Oluşturun

1. **PowerShell'i yönetici olarak çalıştırın**
   - Windows tuşuna basın
   - "PowerShell" yazın
   - Sağ tıklayıp **"Yönetici olarak çalıştır"** seçin

2. **Script klasörüne gidin**
   ```powershell
   cd C:\indirilen\klasor\yolu
   ```

3. **Script'i çalıştırın**
   ```powershell
   .\localhost-ssl-kurulum.ps1
   ```

### 3️⃣ Sertifikayı Doğrulayın

1. **Windows + R** tuşlarına basın
2. `certlm.msc` yazıp Enter'a basın
3. Sertifikanın aşağıdaki konumlarda göründğünü kontrol edin:
   - ✅ **Personal** → Certificates
   - ✅ **Trusted Root Certification Authorities** → Certificates

### 4️⃣ IIS'e Bağlayın

1. **IIS Manager'ı açın**
2. Sitenizi seçin
3. Sağ taraftan **"Bindings"** (Site Bağlamaları) tıklayın
4. **"Add"** veya mevcut HTTPS'i düzenleyin
5. Ayarları yapın:
   - **Type:** HTTPS
   - **Port:** `launchSettings.json` dosyasındaki HTTPS portunu girin (örn: 443, 5001)
   - **SSL certificate:** Yeni oluşturduğunuz `localhost` sertifikasını seçin
6. **OK** ile kaydedin

---

## ✅ Tamamlandı!

Artık siteniz yerel geliştirme ortamında HTTPS ile çalışmaya hazır.

---

## 💡 İpuçları

- Sertifika genellikle **1 yıl** geçerlidir ancak scriptte **10 yıl** geçerli olacak şekilde ayarladık.
- Tarayıcınızda sertifika uyarısı alırsanız, tarayıcı ayarlarından sertifikayı güvenilir listeye ekleyin
- Üretim ortamı için Let's Encrypt veya ticari SSL sertifikası kullanın

---

## 📞 Destek

Sorun yaşarsanız, issue açabilirsiniz.

**Kolay gelsin! 🎉**
