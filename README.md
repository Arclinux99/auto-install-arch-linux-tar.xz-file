# Script Otomatisasi Instalasi Aplikasi tar.xz untuk Arch Linux

Script bash untuk mempermudah instalasi aplikasi dari file `.tar.xz` di Arch Linux dengan otomatisasi penuh.

## Fitur

✅ **Otomatisasi lengkap** - Ekstrak, set permissions, buat desktop entry, dan symbolic link  
✅ **Deteksi otomatis** - Mencari executable dan icon secara otomatis  
✅ **Interactive** - Menu pilihan file dan konfigurasi aplikasi  
✅ **Validasi input** - Cek file dan directory sebelum instalasi  
✅ **Error handling** - Penanganan error yang komprehensif  
✅ **Colorful output** - Output berwarna untuk kemudahan membaca  

## Instalasi

1. Clone atau download script:
```bash
curl -O https://raw.githubusercontent.com/[your-repo]/install-tarxz-app.sh
# atau
wget https://raw.githubusercontent.com/[your-repo]/install-tarxz-app.sh
```

2. Buat executable:
```bash
chmod +x install-tarxz-app.sh
```

## Cara Penggunaan

### Penggunaan Dasar
```bash
./install-tarxz-app.sh
```

### Langkah-langkah:
1. **Input directory** - Masukkan path directory tempat file .tar.xz berada (default: directory saat ini)
2. **Pilih file** - Script akan menampilkan semua file .tar.xz yang ditemukan
3. **Konfigurasi aplikasi** - Masukkan nama tampilan dan deskripsi aplikasi
4. **Konfirmasi** - Script akan meminta konfirmasi sebelum instalasi
5. **Selesai** - Aplikasi akan terinstall dan siap digunakan

### Contoh Output
```
╔══════════════════════════════════════════╗
║     Instalasi Otomatis Aplikasi tar.xz  ║
║           untuk Arch Linux              ║
╚══════════════════════════════════════════╝

[INFO] Directory saat ini: /home/user/Downloads

[INFO] File tar.xz yang ditemukan:
  1. ./zen.linux-x86_64.tar.xz
  2. ./another-app.tar.xz

Pilih file (1-2) atau masukkan nama file: 1
[SUCCESS] File './zen.linux-x86_64.tar.xz' valid
[INFO] File yang akan diinstall: /home/user/Downloads/zen.linux-x86_64.tar.xz

Lanjutkan instalasi? [Y/n]: y
[INFO] Memulai instalasi aplikasi...
[INFO] Nama aplikasi: zen
[INFO] Lokasi instalasi: /opt/zen
...
[SUCCESS] === INSTALASI SELESAI ===
[INFO] Aplikasi: Zen Browser
[INFO] Lokasi: /opt/zen
[INFO] Command: zen
[INFO] Desktop entry: Cek di menu aplikasi
```

## Yang Dilakukan Script

1. **Ekstraksi** - Ekstrak file tar.xz ke `/opt/[nama-aplikasi]/`
2. **Permissions** - Set owner ke root:root dan permissions 755
3. **Executable Detection** - Mencari file executable utama secara otomatis
4. **Desktop Entry** - Membuat file `.desktop` di `/usr/share/applications/`
5. **Symbolic Link** - Buat symlink di `/usr/local/bin/` untuk akses CLI
6. **Icon Detection** - Mencari dan menggunakan icon aplikasi jika tersedia

## Struktur Instalasi

```
/opt/[nama-aplikasi]/           # Aplikasi utama
/usr/share/applications/        # Desktop entry (.desktop)
/usr/local/bin/[nama-app]       # Symbolic link untuk CLI
```

## Requirements

- Arch Linux atau turunannya (EndeavourOS, Manjaro, dll)
- Akses sudo
- File aplikasi dalam format `.tar.xz`

## Troubleshooting

### Executable tidak ditemukan otomatis
Script akan meminta input manual untuk path executable relatif dari directory instalasi.

### Permission denied
Pastikan menjalankan script sebagai user biasa (bukan root), script akan meminta sudo saat diperlukan.

### File tidak valid
Pastikan file berformat `.tar.xz` dan tidak corrupt.

## Contoh Aplikasi yang Bisa Diinstall

- Zen Browser
- VSCode (tar.xz version)
- Discord (tar.xz version)
- Telegram Desktop
- Dan aplikasi lainnya dalam format tar.xz

## Customization

Script dapat dimodifikasi untuk:
- Mengubah directory instalasi default (saat ini `/opt`)
- Menambah lokasi pencarian executable
- Menambah template desktop entry khusus
- Menambah kategori aplikasi yang berbeda

## Keamanan

- Script melakukan validasi input
- Tidak menjalankan command berbahaya tanpa konfirmasi
- Menggunakan sudo hanya untuk operasi yang memerlukan
- Set permissions yang aman (755)

## Lisensi

MIT License - Bebas digunakan dan dimodifikasi

---

**Dibuat untuk mempermudah instalasi aplikasi di Arch Linux** 🐧
