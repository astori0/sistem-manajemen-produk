<div class="mb-3">
    <a href="<?= base_url('produk'); ?>" class="text-decoration-none text-muted small">
        <i class="bi bi-arrow-left me-1"></i> Kembali ke Daftar Produk
    </a>
</div>

<div class="card card-custom p-4 bg-white">
    <h4 class="fw-bold mb-4" style="color: var(--warna-utama);"><i class="bi bi-pencil-square me-2"></i>Edit Data Produk</h4>

    <form action="<?= base_url('produk/edit/' . $produk['id_produk']); ?>" method="POST">
        <div class="row g-3 mb-4">
            <div class="col-md-4">
                <label for="kode_produk" class="form-label fw-semibold">Kode Produk <span class="text-danger">*</span></label>
                <input type="text" class="form-control" id="kode_produk" name="kode_produk" value="<?= set_value('kode_produk', $produk['kode_produk']); ?>" required>
                <?= form_error('kode_produk'); ?>
            </div>

            <div class="col-md-8">
                <label for="nama_produk" class="form-label fw-semibold">Nama Produk <span class="text-danger">*</span></label>
                <input type="text" class="form-control" id="nama_produk" name="nama_produk" value="<?= set_value('nama_produk', $produk['nama_produk']); ?>" required>
                <?= form_error('nama_produk'); ?>
            </div>

            <div class="col-md-4">
                <label for="kategori_produk" class="form-label fw-semibold">Kategori <span class="text-danger">*</span></label>
                <?php $kat = set_value('kategori_produk', $produk['kategori_produk']); ?>
                <select class="form-select" id="kategori_produk" name="kategori_produk" required>
                    <option value="Gamis" <?= ($kat === 'Gamis') ? 'selected' : ''; ?>>Gamis</option>
                    <option value="Baju Koko" <?= ($kat === 'Baju Koko') ? 'selected' : ''; ?>>Baju Koko</option>
                    <option value="Hijab" <?= ($kat === 'Hijab') ? 'selected' : ''; ?>>Hijab / Jilbab</option>
                    <option value="Mukena" <?= ($kat === 'Mukena') ? 'selected' : ''; ?>>Mukena</option>
                    <option value="Tunik" <?= ($kat === 'Tunik') ? 'selected' : ''; ?>>Tunik</option>
                </select>
                <?= form_error('kategori_produk'); ?>
            </div>

            <div class="col-md-4">
                <label for="harga_produk" class="form-label fw-semibold">Harga (Rp) <span class="text-danger">*</span></label>
                <input type="number" class="form-control" id="harga_produk" name="harga_produk" value="<?= set_value('harga_produk', (int)$produk['harga_produk']); ?>" required>
                <?= form_error('harga_produk'); ?>
            </div>

            <div class="col-md-4">
                <label for="status_produk" class="form-label fw-semibold">Status Produk <span class="text-danger">*</span></label>
                <?php $stt = set_value('status_produk', $produk['status_produk']); ?>
                <select class="form-select" id="status_produk" name="status_produk" required>
                    <option value="Aktif" <?= ($stt === 'Aktif') ? 'selected' : ''; ?>>Aktif</option>
                    <option value="Tidak Aktif" <?= ($stt === 'Tidak Aktif') ? 'selected' : ''; ?>>Tidak Aktif</option>
                </select>
                <?= form_error('status_produk'); ?>
            </div>
        </div>

        <hr class="my-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <div>
                <h5 class="fw-bold mb-0" style="color: var(--warna-utama);"><i class="bi bi-palette me-2"></i>Variasi Warna & Ukuran</h5>
            </div>
            <button type="button" class="btn btn-outline-success btn-sm" id="tombol_tambah_warna">
                <i class="bi bi-plus-lg me-1"></i> Tambah Warna
            </button>
        </div>

        <div id="wadah_variasi_warna"></div>

        <div class="mt-4 pt-3 border-top d-flex gap-2">
            <button type="submit" class="btn btn-utama px-4"><i class="bi bi-save me-1"></i> Perbarui Produk</button>
            <a href="<?= base_url('produk'); ?>" class="btn btn-light border px-4">Batal</a>
        </div>
    </form>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    let indeksWarna = 0;
    const wadahVariasi = document.getElementById('wadah_variasi_warna');
    const tombolTambahWarna = document.getElementById('tombol_tambah_warna');

    const dataVariasiEksisting = <?= json_encode($produk['variasi_warna']); ?>;

    function buatBarisWarna(indeks, dataWarna = '', dataUkuran = []) {
        const div = document.createElement('div');
        div.className = 'card card-custom bg-light p-3 mb-3 border baris-warna';

        div.innerHTML = `
            <div class="row g-3 align-items-center">
                <div class="col-md-4">
                    <label class="form-label fw-semibold small">Nama Warna</label>
                    <input type="text" name="variasi[${indeks}][nama_warna]" class="form-control" value="${dataWarna}" required>
                </div>
                <div class="col-md-7">
                    <label class="form-label fw-semibold small">Ukuran untuk Warna Ini</label>
                    <div class="wadah-ukuran d-flex flex-wrap gap-2 align-items-center" id="wadah_ukuran_${indeks}"></div>
                </div>
                <div class="col-md-1 text-end">
                    <button type="button" class="btn btn-outline-danger btn-sm tombol-hapus-warna mt-4">
                        <i class="bi bi-trash"></i>
                    </button>
                </div>
            </div>
        `;

        wadahVariasi.appendChild(div);

        const wadahUkuran = div.querySelector(`#wadah_ukuran_${indeks}`);
        
        dataUkuran.forEach(uk => {
            const namaUkuran = typeof uk === 'object' ? uk.nama_ukuran : uk;
            tambahBadgeUkuran(wadahUkuran, indeks, namaUkuran);
        });

        const btnTambahUkuran = document.createElement('button');
        btnTambahUkuran.type = 'button';
        btnTambahUkuran.className = 'btn btn-sm btn-outline-secondary rounded-pill';
        btnTambahUkuran.innerHTML = '<i class="bi bi-plus"></i> Ukuran';
        btnTambahUkuran.onclick = function() {
            let inputUkuranBaru = prompt("Masukkan Ukuran Baru:");
            if (inputUkuranBaru && inputUkuranBaru.trim() !== "") {
                tambahBadgeUkuran(wadahUkuran, indeks, inputUkuranBaru.trim());
            }
        };
        wadahUkuran.appendChild(btnTambahUkuran);

        div.querySelector('.tombol-hapus-warna').addEventListener('click', function() {
            div.remove();
        });
    }

    function tambahBadgeUkuran(wadah, indeks, nilaiUkuran) {
        const span = document.createElement('span');
        span.className = 'badge bg-white text-dark border p-2 d-flex align-items-center gap-1';
        span.innerHTML = `
            ${nilaiUkuran}
            <input type="hidden" name="variasi[${indeks}][ukuran][]" value="${nilaiUkuran}">
            <i class="bi bi-x-circle text-danger ms-1 hapus-ukuran" style="cursor:pointer;"></i>
        `;
        span.querySelector('.hapus-ukuran').addEventListener('click', function() {
            span.remove();
        });
        wadah.insertBefore(span, wadah.lastChild);
    }

    if (dataVariasiEksisting && dataVariasiEksisting.length > 0) {
        dataVariasiEksisting.forEach(item => {
            buatBarisWarna(indeksWarna++, item.nama_warna, item.daftar_ukuran);
        });
    } else {
        buatBarisWarna(indeksWarna++, 'Default', ['S', 'M', 'L']);
    }

    tombolTambahWarna.addEventListener('click', function() {
        buatBarisWarna(indeksWarna++, '', ['S', 'M', 'L']);
    });
});
</script>