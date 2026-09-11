## 📦 Sistem Manajemen Produk (CodeIgniter 3) ##

Sistem Manajemen Produk berbasis web yang dibangun menggunakan **CodeIgniter 3 (PHP 8)** dan **Bootstrap 5**. Aplikasi ini dilengkapi dengan fitur katalog produk, pembuatan kode otomatis berbasis kategori, penanganan variasi warna & ukuran, pencarian multi-filter, serta konfirmasi modal berbasis Bootstrap.

---

## 🛠️ Teknologi & Stack
* **Framework Backend:** CodeIgniter 3 
* **Database:** MySQL
* **Frontend UI:** Bootstrap 5, Bootstrap Icons, HTML5, CSS3, JavaScript (AJAX / Fetch API)
* **Local Server:** Laragon

---

## 📋 Fitur Utama
•	**List Produk**
•	**Tambah Produk**
•	**Detail Produk**
•	**Edit Produk**
•	**Hapus Produk**
•	**Tambah/Edit Warna & Ukuran**


---

## 🚀 Cara Menjalankan Aplikasi

### 1. Persiapan Database
1. Buka **phpMyAdmin**
2. Buat database baru dengan nama `db_sistem_produk`.
3. Import file `db_sistem_produk.sql` yang tersedia di folder projek ini.

### 2. Konfigurasi Aplikasi
* Pastikan file konfigurasi database di `application/config/database.php` sesuai dengan environment Anda:
  ```php
  'hostname' => 'localhost',
  'username' => 'root',
  'password' => '', // Sesuaikan jika ada password
  'database' => 'db_sistem_produk',
