# Pocketing — Backlog / Tugas Tertunda

Daftar ini untuk mencatat bug kecil dan tugas yang sengaja ditunda dulu,
supaya tidak hilang meski sesi kerja/chat terputus. Update file ini
setiap kali ada temuan baru atau ada yang sudah selesai dikerjakan.

## 🐛 Bug (belum mengganggu fungsi, tapi perlu dirapikan)

- [ ] **Sesi login tidak persist setelah force-close app.**
  Splash screen membaca `FirebaseAuth.instance.currentUser` secara instan
  setelah delay 2 detik. Kadang Firebase belum selesai memuat ulang sesi
  lama dari penyimpanan HP, jadi kelihatan seperti belum login padahal
  sebenarnya sudah. Fix: ganti ke `FirebaseAuth.instance.authStateChanges()`
  (tunggu status dikonfirmasi), bukan baca sekali langsung.
  File terkait: `lib/screens/splash_screen.dart`

- [ ] **Overflow "BOTTOM OVERFLOWED BY 103 PIXELS" di form Umur Anak.**
  Muncul saat keyboard angka aktif, karena konten form tidak bisa di-scroll.
  Fix: bungkus body form dengan `SingleChildScrollView`.
  File terkait: `lib/onboarding/child_step1_screen.dart` (dan cek juga
  `child_step2_screen.dart` untuk jaga-jaga masalah sama)

## 🧹 Cleanup sebelum rilis (Fase Polish)

- [ ] **Rapikan `login_screen.dart` dari mode debug.**
  Saat ini kalau Google Sign-In gagal, pesan error teknis mentah
  (`GoogleSignInException — code: ..., desc: ...`) ditampilkan langsung
  ke pengguna lewat SnackBar. Untuk versi live, ganti jadi pesan yang
  ramah pengguna (misal: "Login gagal, silakan coba lagi").
  File terkait: `lib/screens/login_screen.dart`git add .