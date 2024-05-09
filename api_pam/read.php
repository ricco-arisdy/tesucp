<?php

$connect = new mysqli("localhost", "root", "", "dbkuliner", 3307);

// Periksa koneksi
if ($connect->connect_error) {
    die("Connection failed: " . $connect->connect_error);
}

// Contoh penggunaan: Ambil data dari tabel 'tbkuliner'
$sql = "SELECT * FROM tbkuliner";
$result = $connect->query($sql);

// Array untuk menyimpan data
$data = array();

// Periksa apakah query berhasil dieksekusi
if ($result->num_rows > 0) {
    // Output data setiap baris
    while ($row = $result->fetch_assoc()) {
        // Tambahkan data ke dalam array
        $data[] = $row;
    }
    // Encode data menjadi format JSON dan kirimkan sebagai respons
    echo json_encode($data);
} else {
    echo "0 results";
}

// Tutup koneksi
$connect->close();
