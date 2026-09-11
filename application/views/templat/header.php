<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= isset($judul_halaman) ? $judul_halaman : 'Sistem Manajemen Produk'; ?></title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">
    <!-- CSS Custom -->
    <link href="<?= base_url('assets/css/style.css'); ?>" rel="stylesheet">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark navbar-custom mb-4 shadow-sm">
    <div class="container">
        <!-- Logo & Nama Sistem (Langsung Menuju Halaman Utama) -->
        <a class="navbar-brand d-flex align-items-center gap-2" href="<?= base_url('produk'); ?>">
            <i class="bi bi-box-seam fs-4 text-warning"></i>
            <span>SISTEM MANAJEMEN <span class="brand-accent">PRODUK</span></span>
        </a>
        <!--<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button> -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <!-- Tunggal: Tombol Tambah Produk 
                <li class="nav-item">
                    <a class="nav-link btn btn-aksen text-white px-3 mt-2 mt-lg-0 rounded-pill" href="<?= base_url('produk/tambah'); ?>">
                        <i class="bi bi-plus-circle me-1"></i> Tambah Produk
                    </a>
                </li> -->
            </ul>
        </div>
    </div>
</nav>

<div class="container pb-5">