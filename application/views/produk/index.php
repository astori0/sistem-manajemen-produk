<!-- Flash Message Notification -->
<?php if ($this->session->flashdata('pesan_sukses')): ?>
    <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm mb-4" role="alert">
        <i class="bi bi-check-circle-fill me-2"></i> <?= $this->session->flashdata('pesan_sukses'); ?>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
<?php endif; ?>

<?php if ($this->session->flashdata('pesan_error')): ?>
    <div class="alert alert-danger alert-dismissible fade show border-0 shadow-sm mb-4" role="alert">
        <i class="bi bi-exclamation-triangle-fill me-2"></i> <?= $this->session->flashdata('pesan_error'); ?>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
<?php endif; ?>

<!-- Form Pencarian & Filter Produk -->
<div class="card card-custom p-3 bg-white mb-4">
    <form action="<?= base_url('produk'); ?>" method="GET">
        <div class="row g-2 align-items-center">
            <div class="col-md-3">
                <label class="form-label fw-semibold small text-muted mb-1">Cari Kode / Nama</label>
                <div class="input-group input-group-sm">
                    <span class="input-group-text bg-light"><i class="bi bi-search"></i></span>
                    <input type="text" name="keyword" class="form-control" placeholder="Contoh: GMS-0001 / Abaya..." value="<?= html_escape($filters['keyword']); ?>">
                </div>
            </div>

            <div class="col-md-2">
                <label class="form-label fw-semibold small text-muted mb-1">Kategori</label>
                <select name="kategori" class="form-select form-select-sm">
                    <option value="">-- Semua --</option>
                    <?php 
                    $opsi_kategori = ['Gamis', 'Baju Koko', 'Hijab', 'Mukena', 'Tunik'];
                    foreach ($opsi_kategori as $kat):
                    ?>
                        <option value="<?= $kat; ?>" <?= ($filters['kategori'] == $kat) ? 'selected' : ''; ?>><?= $kat; ?></option>
                    <?php endforeach; ?>
                </select>
            </div>

            <div class="col-md-2">
                <label class="form-label fw-semibold small text-muted mb-1">Warna</label>
                <input type="text" name="warna" class="form-control form-control-sm" placeholder="Misal: Hitam" value="<?= html_escape($filters['warna']); ?>">
            </div>

            <div class="col-md-2">
                <label class="form-label fw-semibold small text-muted mb-1">Ukuran</label>
                <input type="text" name="ukuran" class="form-control form-control-sm" placeholder="Misal: XL" value="<?= html_escape($filters['ukuran']); ?>">
            </div>

            <div class="col-md-2">
                <label class="form-label fw-semibold small text-muted mb-1">Status</label>
                <select name="status" class="form-select form-select-sm">
                    <option value="">-- Semua --</option>
                    <option value="Aktif" <?= ($filters['status'] == 'Aktif') ? 'selected' : ''; ?>>Aktif</option>
                    <option value="Tidak Aktif" <?= ($filters['status'] == 'Tidak Aktif') ? 'selected' : ''; ?>>Tidak Aktif</option>
                </select>
            </div>

            <div class="col-md-1 d-flex gap-1 mt-auto pt-3 pt-md-0">
                <button type="submit" class="btn btn-utama btn-sm w-100" title="Terapkan Filter"><i class="bi bi-filter"></i></button>
                <a href="<?= base_url('produk'); ?>" class="btn btn-light border btn-sm" title="Reset Filter"><i class="bi bi-arrow-counterclockwise"></i></a>
            </div>
        </div>
    </form>
</div>

<!-- Tabel Daftar Produk -->
<div class="card card-custom bg-white p-3">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <a href="<?= base_url('produk/tambah'); ?>" class="btn btn-utama px-3">
            <i class="bi bi-plus-circle me-1"></i> Tambah Produk Baru
        </a>
    </div>
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h5 class="fw-bold mb-0" style="color: var(--warna-utama);"><i class="bi bi-box-seam me-2"></i>Daftar Produk</h5>
        <span class="badge bg-light text-dark border">Total: <?= count($produk); ?> Produk</span>
    </div>

    <div class="table-responsive">
        <table class="table table-hover align-middle mb-0">
            <thead class="table-light">
                <tr>
                    <th width="5%">No</th>
                    <th width="12%">Kode</th>
                    <th width="23%">Nama Produk</th>
                    <th width="12%">Kategori</th>
                    <th width="15%">Harga</th>
                    <th width="15%">Variasi Warna</th>
                    <th width="10%">Status</th>
                    <th width="8%" class="text-center">Aksi</th>
                </tr>
            </thead>
            <tbody>
                <?php if (empty($produk)): ?>
                    <tr>
                        <td colspan="8" class="text-center py-4 text-muted">
                            <i class="bi bi-inbox fs-2 d-block mb-2"></i>
                            Data produk tidak ditemukan.
                        </td>
                    </tr>
                <?php else: ?>
                    <?php $no = 1; foreach ($produk as $item): ?>
                        <tr>
                            <td><?= $no++; ?></td>
                            <td><span class="badge bg-light text-dark border font-monospace"><?= html_escape($item['kode_produk']); ?></span></td>
                            <td class="fw-semibold"><?= html_escape($item['nama_produk']); ?></td>
                            <td><span class="badge bg-secondary opacity-75"><?= html_escape($item['kategori_produk']); ?></span></td>
                            <td class="fw-bold text-success">Rp <?= number_format($item['harga_produk'], 0, ',', '.'); ?></td>
                            <td>
                                <?php if (!empty($item['variasi'])): ?>
                                    <div class="d-flex flex-wrap gap-1">
                                        <?php foreach ($item['variasi'] as $v): ?>
                                            <span class="badge bg-white text-dark border" title="Jumlah Ukuran: <?= count($v['ukuran']); ?>">
                                                <?= html_escape($v['nama_warna']); ?>
                                            </span>
                                        <?php endforeach; ?>
                                    </div>
                                <?php else: ?>
                                    <span class="text-muted small">-</span>
                                <?php endif; ?>
                            </td>
                            <td>
                                <?php if ($item['status_produk'] == 'Aktif'): ?>
                                    <span class="badge bg-success-subtle text-success border border-success-subtle">Aktif</span>
                                <?php else: ?>
                                    <span class="badge bg-danger-subtle text-danger border border-danger-subtle">Tidak Aktif</span>
                                <?php endif; ?>
                            </td>
                            <td class="text-center">
                                <div class="btn-group btn-group-sm" role="group">
                                    <!-- Tombol Trigger Pop-up Detail -->
                                    <button type="button" class="btn btn-outline-info btn-detail-modal" data-id="<?= $item['id_produk']; ?>" title="Detail Produk">
                                        <i class="bi bi-eye"></i>
                                    </button>
                                    <a href="<?= base_url('produk/edit/' . $item['id_produk']); ?>" class="btn btn-outline-warning" title="Edit Produk">
                                        <i class="bi bi-pencil"></i>
                                    </a>
                                    <!-- Tombol Trigger Pop-up Hapus -->
                                    <button type="button" class="btn btn-outline-danger btn-hapus-modal" data-id="<?= $item['id_produk']; ?>" data-nama="<?= html_escape($item['nama_produk']); ?>" title="Hapus Produk">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                <?php endif; ?>
            </tbody>
        </table>
    </div>
</div>

<!-- ========================================== -->
<!-- POP-UP MODAL DETAIL PRODUK -->
<!-- ========================================== -->
<div class="modal fade" id="modalDetailProduk" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content border-0 shadow">
            <div class="modal-header text-white" style="background-color: var(--warna-utama);">
                <h5 class="modal-title fw-bold"><i class="bi bi-box-seam me-2"></i>Detail Informasi Produk</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                <div class="row g-3 mb-4">
                    <div class="col-md-6">
                        <label class="text-muted small">Kode Produk</label>
                        <h5 class="fw-bold text-dark font-monospace mb-0" id="detail_kode_produk">-</h5>
                    </div>
                    <div class="col-md-6">
                        <label class="text-muted small">Kategori</label>
                        <h5 class="fw-bold text-dark mb-0" id="detail_kategori_produk">-</h5>
                    </div>
                    <div class="col-md-6">
                        <label class="text-muted small">Nama Produk</label>
                        <h5 class="fw-bold text-dark mb-0" id="detail_nama_produk">-</h5>
                    </div>
                    <div class="col-md-6">
                        <label class="text-muted small">Harga Produk</label>
                        <h5 class="fw-bold text-success mb-0" id="detail_harga_produk">-</h5>
                    </div>
                    <div class="col-md-6">
                        <label class="text-muted small">Status Operational</label>
                        <div id="detail_status_produk">-</div>
                    </div>
                </div>

                <hr>

                <h6 class="fw-bold mb-3" style="color: var(--warna-utama);"><i class="bi bi-palette me-2"></i>Variasi Warna & Ukuran</h6>
                <div id="detail_wadah_variasi" class="row g-2">
                    <!-- Konten variasi dirender via JS -->
                </div>
            </div>
            <div class="modal-footer bg-light">
                <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal">Tutup</button>
            </div>
        </div>
    </div>
</div>

<!-- ========================================== -->
<!-- POP-UP MODAL KONFIRMASI HAPUS -->
<!-- ========================================== -->
<div class="modal fade" id="modalKonfirmasiHapus" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-sm">
        <div class="modal-content border-0 shadow">
            <div class="modal-body text-center p-4">
                <i class="bi bi-exclamation-circle text-danger display-3 d-block mb-3"></i>
                <h5 class="fw-bold mb-2">Hapus Produk?</h5>
                <p class="text-muted small mb-3">Apakah Anda yakin ingin menghapus <strong id="hapus_nama_produk"></strong>? Seluruh variasi warna dan ukuran terikat akan ikut terhapus secara permanen.</p>
                <div class="d-flex justify-content-center gap-2">
                    <button type="button" class="btn btn-light border px-3" data-bs-dismiss="modal">Batal</button>
                    <a id="btn_eksekusi_hapus" href="#" class="btn btn-danger px-3">Ya, Hapus</a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- ========================================== -->
<!-- JAVASCRIPT EVENT HANDLER -->
<!-- ========================================== -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    // 1. Pop-up Modal Detail
    const modalDetailElement = document.getElementById('modalDetailProduk');
    const modalDetail = new bootstrap.Modal(modalDetailElement);

    document.querySelectorAll('.btn-detail-modal').forEach(button => {
        button.addEventListener('click', function() {
            const idProduk = this.getAttribute('data-id');

            fetch('<?= base_url("produk/get_detail_ajax/"); ?>' + idProduk)
                .then(response => {
                    if (!response.ok) throw new Error('HTTP Error Status: ' + response.status);
                    return response.json();
                })
                .then(res => {
                    if (res.status) {
                        const p = res.data;
                        document.getElementById('detail_kode_produk').innerText = p.kode_produk;
                        document.getElementById('detail_kategori_produk').innerText = p.kategori_produk;
                        document.getElementById('detail_nama_produk').innerText = p.nama_produk;
                        document.getElementById('detail_harga_produk').innerText = 'Rp ' + parseInt(p.harga_produk).toLocaleString('id-ID');
                        
                        const statusBadge = (p.status_produk === 'Aktif')
                            ? '<span class="badge bg-success-subtle text-success border border-success-subtle">Aktif</span>'
                            : '<span class="badge bg-danger-subtle text-danger border border-danger-subtle">Tidak Aktif</span>';
                        document.getElementById('detail_status_produk').innerHTML = statusBadge;

                        const wadahVariasi = document.getElementById('detail_wadah_variasi');
                        wadahVariasi.innerHTML = '';

                        if (p.variasi && p.variasi.length > 0) {
                            p.variasi.forEach(v => {
                                let htmlUkuran = '';
                                if (v.ukuran && v.ukuran.length > 0) {
                                    v.ukuran.forEach(u => {
                                        htmlUkuran += `<span class="badge bg-white text-dark border me-1 mb-1">${u.nama_ukuran}</span>`;
                                    });
                                } else {
                                    htmlUkuran = '<span class="text-muted small">Tidak ada ukuran</span>';
                                }

                                const divCard = document.createElement('div');
                                divCard.className = 'col-md-6';
                                divCard.innerHTML = `
                                    <div class="card bg-light border p-3">
                                        <div class="fw-semibold text-dark mb-2"><i class="bi bi-tag-fill me-1 text-warning"></i> Warna: ${v.nama_warna}</div>
                                        <div>${htmlUkuran}</div>
                                    </div>
                                `;
                                wadahVariasi.appendChild(divCard);
                            });
                        } else {
                            wadahVariasi.innerHTML = '<div class="col-12 text-muted small">Tidak ada variasi warna atau ukuran.</div>';
                        }

                        modalDetail.show();
                    } else {
                        alert('Gagal memuat detail: ' + res.message);
                    }
                })
                .catch(err => {
                    console.error('Error fetching detail:', err);
                    alert('Terjadi kesalahan saat mengambil data detail produk.');
                });
        });
    });

    // 2. Pop-up Modal Konfirmasi Hapus
    const modalHapusElement = document.getElementById('modalKonfirmasiHapus');
    const modalHapus = new bootstrap.Modal(modalHapusElement);

    document.querySelectorAll('.btn-hapus-modal').forEach(button => {
        button.addEventListener('click', function() {
            const idProduk = this.getAttribute('data-id');
            const namaProduk = this.getAttribute('data-nama');

            document.getElementById('hapus_nama_produk').innerText = namaProduk;
            document.getElementById('btn_eksekusi_hapus').setAttribute('href', '<?= base_url("produk/hapus/"); ?>' + idProduk);

            modalHapus.show();
        });
    });
});
</script>