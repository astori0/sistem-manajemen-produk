<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Produk extends CI_Controller {

    public function __construct()
    {
        parent::__construct();
        $this->load->model('Model_produk');
    }

    public function index()
    {
        // Tangkap parameter filter dari GET request
        $keyword  = $this->input->get('keyword', TRUE);
        $kategori = $this->input->get('kategori', TRUE);
        $warna    = $this->input->get('warna', TRUE);
        $ukuran   = $this->input->get('ukuran', TRUE);
        $status   = $this->input->get('status', TRUE);

        $data['judul_halaman'] = 'Daftar Produk';
        $data['produk']        = $this->Model_produk->get_produk_filtered($keyword, $kategori, $warna, $ukuran, $status);
        
        // Simpan status filter agar form tidak terreset setelah submit
        $data['filters'] = [
            'keyword'  => $keyword,
            'kategori' => $kategori,
            'warna'    => $warna,
            'ukuran'   => $ukuran,
            'status'   => $status
        ];

        $this->load->view('templat/header', $data);
        $this->load->view('produk/index', $data);
        $this->load->view('templat/footer');
    }

    public function detail($id_produk)
    {
        $produk = $this->Model_produk->ambil_produk_by_id($id_produk);

        if (!$produk) {
            $this->session->set_flashdata('pesan_error', 'Data produk tidak ditemukan!');
            redirect('produk');
        }

        $data['judul_halaman'] = 'Detail Produk - ' . $produk['nama_produk'];
        $data['produk']        = $produk;

        $this->load->view('templat/header', $data);
        $this->load->view('produk/detail', $data);
        $this->load->view('templat/footer');
    }

    public function tambah()
    {
        $this->_set_aturan_validasi();

        if ($this->form_validation->run() === FALSE) {
            $data['judul_halaman'] = 'Tambah Produk Baru';
            $this->load->view('templat/header', $data);
            $this->load->view('produk/tambah');
            $this->load->view('templat/footer');
        } else {
            $kategori = $this->input->post('kategori_produk', TRUE);
            
            // Buat kode produk otomatis secara server-side
            $kode_produk_otomatis = $this->Model_produk->buat_kode_otomatis($kategori);

            $data_produk = [
                'kode_produk'     => $kode_produk_otomatis,
                'nama_produk'     => $this->input->post('nama_produk', TRUE),
                'kategori_produk' => $kategori,
                'harga_produk'    => $this->input->post('harga_produk', TRUE),
                'status_produk'   => $this->input->post('status_produk', TRUE)
            ];

            // Mematikan XSS filter array dinamis secara eksplisit untuk mencegah error deprecated PHP 8
            $data_variasi = $this->input->post('variasi');

            $berhasil = $this->Model_produk->simpan_produk($data_produk, $data_variasi);

            if ($berhasil) {
                $this->session->set_flashdata('pesan_sukses', 'Produk berhasil ditambahkan dengan Kode: ' . $kode_produk_otomatis);
            } else {
                $this->session->set_flashdata('pesan_error', 'Gagal menambahkan produk. Silakan coba lagi.');
            }

            redirect('produk');
        }
    }

    public function edit($id_produk)
    {
        $produk = $this->Model_produk->ambil_produk_by_id($id_produk);

        if (!$produk) {
            $this->session->set_flashdata('pesan_error', 'Data produk tidak ditemukan!');
            redirect('produk');
        }

        $this->_set_aturan_validasi($id_produk);

        if ($this->form_validation->run() === FALSE) {
            $data['judul_halaman'] = 'Edit Produk - ' . $produk['nama_produk'];
            $data['produk']        = $produk;

            $this->load->view('templat/header', $data);
            $this->load->view('produk/edit', $data);
            $this->load->view('templat/footer');
        } else {
            $data_produk = [
                'kode_produk'     => $this->input->post('kode_produk', TRUE),
                'nama_produk'     => $this->input->post('nama_produk', TRUE),
                'kategori_produk' => $this->input->post('kategori_produk', TRUE),
                'harga_produk'    => $this->input->post('harga_produk', TRUE),
                'status_produk'   => $this->input->post('status_produk', TRUE)
            ];

            $data_variasi = $this->input->post('variasi', TRUE);

            $berhasil = $this->Model_produk->perbarui_produk($id_produk, $data_produk, $data_variasi);

            if ($berhasil) {
                $this->session->set_flashdata('pesan_sukses', 'Data produk berhasil diperbarui!');
            } else {
                $this->session->set_flashdata('pesan_error', 'Gagal memperbarui data produk.');
            }

            redirect('produk');
        }
    }

    public function hapus($id_produk)
    {
        $produk = $this->Model_produk->ambil_produk_by_id($id_produk);

        if ($produk) {
            $this->Model_produk->hapus_produk($id_produk);
            $this->session->set_flashdata('pesan_sukses', 'Produk berhasil dihapus!');
        } else {
            $this->session->set_flashdata('pesan_error', 'Produk tidak ditemukan!');
        }

        redirect('produk');
    }

    public function validasi_kode_unik($kode_produk, $id_produk = null)
    {
        $status_unik = $this->Model_produk->cek_kode_produk_unik($kode_produk, $id_produk);
        if (!$status_unik) {
            $this->form_validation->set_message('validasi_kode_unik', 'Kode Produk "{field}" sudah terdaftar pada sistem.');
            return FALSE;
        }
        return TRUE;
    }

    private function _set_aturan_validasi($id_produk = null)
    {
        if ($id_produk !== null) {
            $this->form_validation->set_rules('kode_produk', 'Kode Produk', 'required|trim|callback_validasi_kode_unik[' . $id_produk . ']');
        }
        $this->form_validation->set_rules('nama_produk', 'Nama Produk', 'required|trim');
        $this->form_validation->set_rules('kategori_produk', 'Kategori Produk', 'required|trim');
        $this->form_validation->set_rules('harga_produk', 'Harga Produk', 'required|numeric|greater_than[0]');
        $this->form_validation->set_rules('status_produk', 'Status Produk', 'required|in_list[Aktif,Tidak Aktif]');

        $this->form_validation->set_error_delimiters('<div class="text-danger small mt-1">', '</div>');
    }
    public function get_kode_otomatis()
    {
        $kategori = $this->input->get('kategori', TRUE);
        if (!empty($kategori)) {
            $kode_otomatis = $this->Model_produk->buat_kode_otomatis($kategori);
            echo json_encode(['kode' => $kode_otomatis]);
        } else {
            echo json_encode(['kode' => '']);
        }
    }
    public function get_detail_ajax($id_produk)
    {
        $produk = $this->Model_produk->ambil_produk_by_id($id_produk);
        if ($produk) {
            $produk['variasi'] = $this->Model_produk->get_variasi_lengkap($id_produk);
            echo json_encode(['status' => true, 'data' => $produk]);
        } else {
            echo json_encode(['status' => false, 'message' => 'Data tidak ditemukan']);
        }
    }
}