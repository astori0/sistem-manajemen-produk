<div class="mb-3">
    <a href="<?= base_url('produk'); ?>" class="text-decoration-none text-muted small">
        <i class="bi bi-arrow-left me-1"></i> Kembali ke Daftar Produk
    </a>
</div>

<div class="card card-custom p-4 bg-white">
    <h4 class="fw-bold mb-4" style="color: var(--warna-utama);"><i class="bi bi-plus-square me-2"></i>Tambah Produk Baru</h4>

    <form action="<?= base_url('produk/tambah'); ?>" method="POST">
        <div class="row g-3 mb-4">
            <div class="col-md-4">
                <label for="kategori_produk" class="form-label fw-semibold">Kategori <span class="text-danger">*</span></label>
                <select class="form-select" id="kategori_produk" name="kategori_produk" required>
                    <option value="">-- Pilih Kategori --</option>
                    <option value="Gamis" <?= set_select('kategori_produk', 'Gamis'); ?>>Gamis (GMS)</option>
                    <option value="Baju Koko" <?= set_select('kategori_produk', 'Baju Koko'); ?>>Baju Koko (KKO)</option>
                    <option value="Hijab" <?= set_select('kategori_produk', 'Hijab'); ?>>Hijab / Jilbab (HJB)</option>
                    <option value="Mukena" <?= set_select('kategori_produk', 'Mukena'); ?>>Mukena (MKN)</option>
                    <option value="Tunik" <?= set_select('kategori_produk', 'Tunik'); ?>>Tunik (TNK)</option>
                </select>
                <?= form_error('kategori_produk'); ?>
            </div>

            <div class="col-md-4">
                <label for="kode_produk" class="form-label fw-semibold">Kode Produk (Otomatis)</label>
                <input type="text" class="form-control bg-light" id="kode_produk" name="kode_produk" placeholder="Pilih kategori dahulu..." readonly>
            </div>

            <div class="col-md-4">
                <label for="nama_produk" class="form-label fw-semibold">Nama Produk <span class="text-danger">*</span></label>
                <input type="text" class="form-control" id="nama_produk" name="nama_produk" value="<?= set_value('nama_produk'); ?>" placeholder="Contoh: Gamis Abaya Silk" required>
                <?= form_error('nama_produk'); ?>
            </div>

            <div class="col-md-6">
                <label for="harga_produk" class="form-label fw-semibold">Harga (Rp) <span class="text-danger">*</span></label>
                <input type="number" class="form-control" id="harga_produk" name="harga_produk" value="<?= set_value('harga_produk'); ?>" placeholder="250000" min="1" required>
                <?= form_error('harga_produk'); ?>
            </div>

            <div class="col-md-6">
                <label for="status_produk" class="form-label fw-semibold">Status Produk <span class="text-danger">*</span></label>
                <select class="form-select" id="status_produk" name="status_produk" required>
                    <option value="Aktif" <?= set_select('status_produk', 'Aktif', TRUE); ?>>Aktif</option>
                    <option value="Tidak Aktif" <?= set_select('status_produk', 'Tidak Aktif'); ?>>Tidak Aktif</option>
                </select>
                <?= form_error('status_produk'); ?>
            </div>
        </div>

        <hr class="my-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <div>
                <h5 class="fw-bold mb-0" style="color: var(--warna-utama);"><i class="bi bi-palette me-2"></i>Variasi Warna & Ukuran</h5>
                <small class="text-muted">Klik "+ Ukuran" untuk menambah ukuran pada warna terkait.</small>
            </div>
            <button type="button" class="btn btn-outline-success btn-sm" id="tombol_tambah_warna">
                <i class="bi bi-plus-lg me-1"></i> Tambah Warna
            </button>
        </div>

        <div id="wadah_variasi_warna"></div>

        <div class="mt-4 pt-3 border-top d-flex gap-2">
            <button type="submit" class="btn btn-utama px-4"><i class="bi bi-save me-1"></i> Simpan Produk</button>
            <a href="<?= base_url('produk'); ?>" class="btn btn-light border px-4">Batal</a>
        </div>
    </form>
</div>
<div class="modal fade" id="modalTambahUkuran" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-sm">
        <div class="modal-content border-0 shadow">
            <div class="modal-header text-white" style="background-color: var(--warna-utama);">
                <h6 class="modal-title fw-bold"><i class="bi bi-ruler me-1"></i> Tambah Ukuran</h6>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <label for="input_nama_ukuran" class="form-label small fw-semibold">Nama Ukuran</label>
                <input type="text" id="input_nama_ukuran" class="form-control" placeholder="Contoh: XL, XXL, All Size">
            </div>
            <div class="modal-footer bg-light p-2">
                <button type="button" class="btn btn-sm btn-light border" data-bs-dismiss="modal">Batal</button>
                <button type="button" id="btn_simpan_ukuran_modal" class="btn btn-sm btn-utama">Tambah</button>
            </div>
        </div>
    </div>
</div>
<script>
document.addEventListener('DOMContentLoaded', function() {
    // 1. Elemen Kategori & Kode Otomatis
    const selectKategori = document.getElementById('kategori_produk');
    const inputKode = document.getElementById('kode_produk');

    function ambilKodeOtomatis(kategori) {
        if (!kategori) {
            inputKode.value = '';
            return;
        }
        fetch('<?= base_url("produk/get_kode_otomatis"); ?>?kategori=' + encodeURIComponent(kategori))
            .then(response => response.json())
            .then(data => {
                if (data && data.kode) inputKode.value = data.kode;
            })
            .catch(err => console.error('Error Kode Otomatis:', err));
    }

    if (selectKategori && inputKode) {
        selectKategori.addEventListener('change', function() {
            ambilKodeOtomatis(this.value);
        });
        if (selectKategori.value) ambilKodeOtomatis(selectKategori.value);
    }

    // 2. Modal Ukuran Bootstrap
    const modalUkuranElement = document.getElementById('modalTambahUkuran');
    const modalUkuran = new bootstrap.Modal(modalUkuranElement);
    const inputNamaUkuran = document.getElementById('input_nama_ukuran');
    const btnSimpanUkuran = document.getElementById('btn_simpan_ukuran_modal');

    let targetWadahUkuran = null;
    let targetIdxWarna = null;

    // 3. Manajemen Variasi Warna & Ukuran
    let counterWarna = 0;
    const wadahVariasi = document.getElementById('wadah_variasi_warna');
    const tombolTambahWarna = document.getElementById('tombol_tambah_warna');

    function tambahBarisWarna(namaWarna = '', daftarUkuran = ['S', 'M', 'L']) {
        if (!wadahVariasi) return;

        const idx = counterWarna++;
        const cardWarna = document.createElement('div');
        cardWarna.className = 'card card-custom bg-light p-3 mb-3 border baris-warna';

        cardWarna.innerHTML = `
            <div class="row g-3 align-items-center">
                <div class="col-md-4">
                    <label class="form-label fw-semibold small">Nama Warna <span class="text-danger">*</span></label>
                    <input type="text" name="variasi[${idx}][nama_warna]" class="form-control" placeholder="Contoh: Hitam" value="${namaWarna}" required>
                </div>
                <div class="col-md-7">
                    <label class="form-label fw-semibold small">Ukuran untuk Warna Ini</label>
                    <div class="d-flex flex-wrap gap-2 align-items-center">
                        <div class="area-badge-ukuran d-flex flex-wrap gap-2 align-items-center"></div>
                        <button type="button" class="btn btn-sm btn-outline-secondary rounded-pill btn-tambah-ukuran">
                            <i class="bi bi-plus"></i> Ukuran
                        </button>
                    </div>
                </div>
                <div class="col-md-1 text-end">
                    <button type="button" class="btn btn-outline-danger btn-sm tombol-hapus-warna mt-4" title="Hapus Warna">
                        <i class="bi bi-trash"></i>
                    </button>
                </div>
            </div>
        `;

        wadahVariasi.appendChild(cardWarna);

        const areaBadge = cardWarna.querySelector('.area-badge-ukuran');
        const btnTambahUkuran = cardWarna.querySelector('.btn-tambah-ukuran');
        const btnHapusWarna = cardWarna.querySelector('.tombol-hapus-warna');

        if (Array.isArray(daftarUkuran)) {
            daftarUkuran.forEach(uk => buatBadgeUkuran(areaBadge, idx, uk));
        }

        // Trigger Pop-up Modal Bootstrap saat tombol "+ Ukuran" diklik
        btnTambahUkuran.addEventListener('click', function() {
            targetWadahUkuran = areaBadge;
            targetIdxWarna = idx;
            inputNamaUkuran.value = '';
            modalUkuran.show();
        });

        btnHapusWarna.addEventListener('click', function() {
            cardWarna.remove();
        });
    }

    // Eksekusi Simpan Ukuran dari Modal Bootstrap
    btnSimpanUkuran.addEventListener('click', function() {
        const nilaiUkuran = inputNamaUkuran.value.trim();
        if (nilaiUkuran !== '' && targetWadahUkuran !== null) {
            buatBadgeUkuran(targetWadahUkuran, targetIdxWarna, nilaiUkuran);
            modalUkuran.hide();
        }
    });

    function buatBadgeUkuran(container, idxWarna, nilaiUkuran) {
        if (!container) return;

        const span = document.createElement('span');
        span.className = 'badge bg-white text-dark border p-2 d-flex align-items-center gap-1';
        span.innerHTML = `
            <span>${nilaiUkuran}</span>
            <input type="hidden" name="variasi[${idxWarna}][ukuran][]" value="${nilaiUkuran}">
            <i class="bi bi-x-circle text-danger ms-1 hapus-ukuran" style="cursor:pointer;" title="Hapus Ukuran"></i>
        `;

        span.querySelector('.hapus-ukuran').addEventListener('click', function() {
            span.remove();
        });

        container.appendChild(span);
    }

    // Inisialisasi awal baris warna
    tambahBarisWarna('Hitam', ['S', 'M', 'L']);

    if (tombolTambahWarna) {
        tombolTambahWarna.addEventListener('click', function() {
            tambahBarisWarna('', ['S', 'M', 'L']);
        });
    }
});
</script>