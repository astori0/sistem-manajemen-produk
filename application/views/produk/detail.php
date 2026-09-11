<div class="mb-3">
    <a href="<?= base_url('produk'); ?>" class="text-decoration-none text-muted small">
        <i class="bi bi-arrow-left me-1"></i> Kembali ke Daftar Produk
    </a>
</div>

<div class="card card-custom p-4 bg-white">
    <div class="d-flex justify-content-between align-items-start border-bottom pb-3 mb-4">
        <div>
            <span class="badge bg-warning text-dark mb-2"><?= html_escape($produk['kategori_produk']); ?></span>
            <h3 class="fw-bold mb-1" style="color: var(--warna-utama);"><?= html_escape($produk['nama_produk']); ?></h3>
            <p class="text-muted small mb-0">Kode Produk: <strong><?= html_escape($produk['kode_produk']); ?></strong></p>
        </div>
        <div class="text-end">
            <h4 class="fw-bold mb-1" style="color: var(--warna-aksen);">Rp <?= number_format($produk['harga_produk'], 0, ',', '.'); ?></h4>
            <?php if ($produk['status_produk'] === 'Aktif'): ?>
                <span class="badge badge-aktif px-3 py-1 rounded-pill">Status: Aktif</span>
            <?php else: ?>
                <span class="badge badge-nonaktif px-3 py-1 rounded-pill">Status: Tidak Aktif</span>
            <?php endif; ?>
        </div>
    </div>

    <h5 class="fw-bold mb-3" style="color: var(--warna-utama);"><i class="bi bi-layers me-2"></i>Variasi Warna & Ukuran</h5>

    <?php if (empty($produk['variasi_warna'])): ?>
        <p class="text-muted italic">Belum ada variasi warna dan ukuran pada produk ini.</p>
    <?php else: ?>
        <div class="row g-3">
            <?php foreach ($produk['variasi_warna'] as $item_warna): ?>
                <div class="col-md-6 col-lg-4">
                    <div class="card card-custom bg-light p-3 border">
                        <div class="fw-bold text-dark mb-2 d-flex align-items-center gap-2">
                            <i class="bi bi-palette text-success"></i>
                            Warna: <?= html_escape($item_warna['nama_warna']); ?>
                        </div>
                        <div class="d-flex flex-wrap gap-1 align-items-center">
                            <span class="small text-muted me-1">Ukuran:</span>
                            <?php if (empty($item_warna['daftar_ukuran'])): ?>
                                <span class="text-muted small">-</span>
                            <?php else: ?>
                                <?php foreach ($item_warna['daftar_ukuran'] as $item_ukuran): ?>
                                    <span class="badge bg-white text-dark border px-2 py-1 rounded"><?= html_escape($item_ukuran['nama_ukuran']); ?></span>
                                <?php endforeach; ?>
                            <?php endif; ?>
                        </div>
                    </div>
                </div>
            <?php endforeach; ?>
        </div>
    <?php endif; ?>

    <div class="mt-4 pt-3 border-top d-flex gap-2">
        <a href="<?= base_url('produk/edit/' . $produk['id_produk']); ?>" class="btn btn-warning px-4">
            <i class="bi bi-pencil me-1"></i> Edit Produk
        </a>
        <a href="<?= base_url('produk'); ?>" class="btn btn-light border px-4">Kembali</a>
    </div>
</div>