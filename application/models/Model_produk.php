<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Model_produk extends CI_Model {

    public function ambil_semua_produk()
    {
        $this->db->order_by('id_produk', 'DESC');
        return $this->db->get('produk')->result_array();
    }

    public function ambil_produk_by_id($id_produk)
    {
        $this->db->where('id_produk', $id_produk);
        $produk = $this->db->get('produk')->row_array();

        if (!$produk) {
            return null;
        }

        $this->db->where('id_produk', $id_produk);
        $daftar_warna = $this->db->get('variasi_warna')->result_array();

        foreach ($daftar_warna as $kunci => $warna) {
            $this->db->where('id_warna', $warna['id_warna']);
            $daftar_ukuran = $this->db->get('variasi_ukuran')->result_array();
            $daftar_warna[$kunci]['daftar_ukuran'] = $daftar_ukuran;
        }

        $produk['variasi_warna'] = $daftar_warna;
        return $produk;
    }

    public function cek_kode_produk_unik($kode_produk, $id_produk_abaikan = null)
    {
        $this->db->where('kode_produk', $kode_produk);
        if ($id_produk_abaikan !== null) {
            $this->db->where('id_produk !=', $id_produk_abaikan);
        }
        $query = $this->db->get('produk');
        return $query->num_rows() === 0;
    }

    public function simpan_produk($data_produk, $data_variasi)
    {
        $this->db->trans_start();

        $this->db->insert('produk', $data_produk);
        $id_produk_baru = $this->db->insert_id();

        if (!empty($data_variasi) && is_array($data_variasi)) {
            foreach ($data_variasi as $item_warna) {
                if (!empty($item_warna['nama_warna'])) {
                    $data_warna = [
                        'id_produk'  => $id_produk_baru,
                        'nama_warna' => trim($item_warna['nama_warna'])
                    ];
                    $this->db->insert('variasi_warna', $data_warna);
                    $id_warna_baru = $this->db->insert_id();

                    if (!empty($item_warna['ukuran']) && is_array($item_warna['ukuran'])) {
                        foreach ($item_warna['ukuran'] as $nama_ukuran) {
                            if (!empty(trim($nama_ukuran))) {
                                $data_ukuran = [
                                    'id_warna'    => $id_warna_baru,
                                    'nama_ukuran' => trim($nama_ukuran)
                                ];
                                $this->db->insert('variasi_ukuran', $data_ukuran);
                            }
                        }
                    }
                }
            }
        }

        $this->db->trans_complete();
        return $this->db->trans_status();
    }

    public function perbarui_produk($id_produk, $data_produk, $data_variasi)
    {
        $this->db->trans_start();

        $this->db->where('id_produk', $id_produk);
        $this->db->update('produk', $data_produk);

        $this->db->where('id_produk', $id_produk);
        $this->db->delete('variasi_warna');

        if (!empty($data_variasi) && is_array($data_variasi)) {
            foreach ($data_variasi as $item_warna) {
                if (!empty($item_warna['nama_warna'])) {
                    $data_warna = [
                        'id_produk'  => $id_produk,
                        'nama_warna' => trim($item_warna['nama_warna'])
                    ];
                    $this->db->insert('variasi_warna', $data_warna);
                    $id_warna_baru = $this->db->insert_id();

                    if (!empty($item_warna['ukuran']) && is_array($item_warna['ukuran'])) {
                        foreach ($item_warna['ukuran'] as $nama_ukuran) {
                            if (!empty(trim($nama_ukuran))) {
                                $data_ukuran = [
                                    'id_warna'    => $id_warna_baru,
                                    'nama_ukuran' => trim($nama_ukuran)
                                ];
                                $this->db->insert('variasi_ukuran', $data_ukuran);
                            }
                        }
                    }
                }
            }
        }

        $this->db->trans_complete();
        return $this->db->trans_status();
    }

    // Fungsi Kode Otomatis

    public function buat_kode_otomatis($kategori)
    {
        $awalan_kategori = [
            'Gamis'     => 'GMS',
            'Baju Koko' => 'KKO',
            'Hijab'     => 'HJB',
            'Mukena'    => 'MKN',
            'Tunik'     => 'TNK'
        ];

        $prefix = isset($awalan_kategori[$kategori]) ? $awalan_kategori[$kategori] : 'PRD';

        $this->db->select('kode_produk');
        $this->db->like('kode_produk', $prefix . '-', 'after');
        $this->db->order_by('kode_produk', 'DESC');
        $this->db->limit(1);
        $query = $this->db->get('produk');

        if ($query->num_rows() > 0) {
            $row = $query->row_array();
            $nomor = (int) substr($row['kode_produk'], strlen($prefix) + 1);
            $nomor++;
        } else {
            $nomor = 1;
        }

        return $prefix . '-' . sprintf('%04d', $nomor);
    }

    public function get_produk_filtered($keyword = null, $kategori = null, $warna = null, $ukuran = null, $status = null)
    {
        $this->db->select('p.*');
        $this->db->from('produk p');
        $this->db->join('variasi_warna w', 'w.id_produk = p.id_produk', 'left');
        $this->db->join('variasi_ukuran u', 'u.id_warna = w.id_warna', 'left');

        // Filter berdasarkan Kode Produk atau Nama Produk
        if (!empty($keyword)) {
            $this->db->group_start();
            $this->db->like('p.kode_produk', $keyword);
            $this->db->or_like('p.nama_produk', $keyword);
            $this->db->group_end();
        }

        // Filter Kategori
        if (!empty($kategori)) {
            $this->db->where('p.kategori_produk', $kategori);
        }

        // Filter Status
        if (!empty($status)) {
            $this->db->where('p.status_produk', $status);
        }

        // Filter Warna
        if (!empty($warna)) {
            $this->db->like('w.nama_warna', $warna);
        }

        // Filter Ukuran
        if (!empty($ukuran)) {
            $this->db->like('u.nama_ukuran', $ukuran);
        }

        // Mencegah duplikasi data hasil JOIN
        $this->db->group_by('p.id_produk');
        $this->db->order_by('p.id_produk', 'DESC');

        $query = $this->db->get();
        $produk = $query->result_array();

        // Lampirkan data variasi untuk setiap produk
        foreach ($produk as &$p) {
            $p['variasi'] = $this->get_variasi_lengkap($p['id_produk']);
        }

        return $produk;
    }

    public function get_variasi_lengkap($id_produk)
    {
        $this->db->where('id_produk', $id_produk);
        $warna_list = $this->db->get('variasi_warna')->result_array();

        foreach ($warna_list as &$w) {
            $this->db->where('id_warna', $w['id_warna']);
            $w['ukuran'] = $this->db->get('variasi_ukuran')->result_array();
        }

        return $warna_list;
    }

    public function hapus_produk($id_produk)
    {
        $this->db->where('id_produk', $id_produk);
        return $this->db->delete('produk');
    }
}