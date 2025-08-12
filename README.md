## Dokumentasi Frontend

Aplikasi ini merupakan frontend Flutter yang sepenuhnya berjalan offline (tanpa backend). Seluruh data produk (PC) dan daftar booking contoh bersumber dari data lokal di dalam kode dan aset gambar pada folder `assets/images`.

### Ringkasan
- Tidak ada koneksi ke backend/API.
- Data PC diambil dari `lib/modal/dataPC.dart` melalui method statis `VIPlist()` dan `regularList()`.
- Gambar di-load dari aset lokal (bukan URL).
- Alur utama: Splash → Home → Detail → Booking → Payment → Success.
- Halaman akun (Login/Sign Up/Forgot Password/Verification/New Password) bersifat UI-only, tetap menavigasi halaman terkait tanpa logika backend.

### Prasyarat
- Flutter SDK terpasang (sesuai `environment: sdk` pada `pubspec.yaml`).
- Android Studio/Xcode/VS Code beserta emulator atau perangkat fisik.

### Menjalankan Aplikasi
1. Install dependencies:
   - `flutter pub get`
2. Jalankan di emulator/perangkat:
   - `flutter run`

### Struktur Penting
- `lib/main.dart`: Entry point aplikasi (menampilkan `SplashScreen`).
- `lib/mainPage/`
  - `homeScreen.dart`: Beranda, menampilkan list VIP & Regular (data lokal).
  - `hotelPackage.dart`: Kartu daftar Regular (list vertikal) dengan gambar aset.
  - `dipesan.dart`: Riwayat booking contoh (data lokal `DataBooking`).
  - `profil.dart`: Tampilan profil (UI-only, avatar dari aset lokal).
  - `splashScreen.dart`: Splash dan transisi otomatis ke `HomePage`.
- `lib/modal/`
  - `dataPC.dart`: Model lokal `DataPC`, data statis `VIPlist()` dan `regularList()`, serta `DataBooking` untuk contoh riwayat.
  - `PCdetails.dart`: Halaman detail PC (gambar dari aset, tombol Book Now).
  - `api_service.dart`: Stub kosong (tidak melakukan panggilan jaringan).
- `lib/booking/`
  - `booking.dart`: Pilih tanggal & jam (tanpa cek backend), lanjut ke Payment.
  - `payment.dart`: Simulasi pembayaran sukses, lanjut ke `success.dart`.
  - `success.dart`: Layar sukses.
- `lib/AccountManajement/` (UI-only)
  - `login.dart`: Navigasi ke `HomePage` jika form terisi.
  - `createAccount.dart`: Navigasi ke `HomePage` setelah tekan Sign Up.
  - `forgetPW.dart` → `verificationCode.dart` → `newPW.dart`: Alur tampilan reset password (simulasi/navigasi saja).

### Sumber Data Lokal
- Ubah/kelola data PC di `lib/modal/dataPC.dart`:
  - `static List<DataPC> VIPlist()` untuk data kelas VIP
  - `static List<DataPC> regularList()` untuk data kelas Regular
- Setiap item `DataPC` berbentuk:
  - `DataPC('assets/images/<nama-file>.jpg', 'Title', 'Description', 'Status', price)`
- Status yang digunakan di UI: `Tersedia`, `Sedang Dipakai`, `Maintenance`.
  - Pada `PCdetails`, tombol Book Now dinonaktifkan bila status `Maintenance`.

### Aset Gambar
- Simpan gambar pada `assets/images/`.
- `pubspec.yaml` telah meng-include direktori tersebut:
  - `flutter -> assets: - assets/images/`
- Pastikan nama file yang digunakan di data sesuai dengan yang ada di `assets/images`.

### Navigasi Yang Tetap Aktif
- Home → Detail → Booking → Payment → Success
- Tab bawah: Home, Booking (Dipesan), Profil
- Login → Home, Create Account → Home
- Forgot Password → Verification → New Password → Login

### Catatan Teknis
- Seluruh pemanggilan `Image.network`/`NetworkImage` telah diganti ke `Image.asset`/`AssetImage`.
- File `lib/modal/api_service.dart` dan `lib/AccountManajement/auth_service.dart` adalah stub agar impor tidak rusak; tidak ada kode jaringan yang berjalan.
- Jika ingin benar‑benar membersihkan dependency yang tidak digunakan (misal `http`, `flutter_secure_storage`, `shared_preferences`, dll.), Anda bisa menghapusnya dari `pubspec.yaml` lalu menjalankan `flutter pub get`. Saat ini keberadaannya tidak mengganggu karena kode tidak memanggilnya.

### Pengembangan Lanjutan (Opsional)
- Mengganti data lokal menjadi API dapat dilakukan dengan mengembalikan implementasi pada `api_service.dart`, menyesuaikan model `DataPC`, dan mengembalikan `Image.network` di tempat yang diperlukan.

Selamat mengembangkan!
