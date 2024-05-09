<?php

$connect = new mysqli("localhost", "root", "", "dbkuliner", 3307);

// Periksa koneksi
if ($connect->connect_error) {
    die("Connection failed: " . $connect->connect_error);
}

$id = $_POST['id'];
$nama_toko = $_POST['nama_toko'];
$alamat = $_POST['alamat'];
$notelp = $_POST['notelp'];
$kesan = $_POST['kesan'];

// Query untuk menambahkan data ke tabel 'tbkuliner'
$sql = "UPDATE tbkuliner SET nama_toko = '$nama_toko', alamat = '$alamat', notelp = '$notelp', kesan = '$kesan' WHERE id = '$id'";

if ($connect->query($sql) === TRUE) {
    // Jika berhasil, kirimkan respons JSON dengan pesan berhasil
    echo json_encode(array("message" => "Data berhasil diubah"));
} else {
    // Jika terjadi kesalahan, kirimkan respons JSON dengan pesan error
    echo json_encode(array("message" => "Error: " . $sql . "<br>" . $connect->error));
}

// Tutup koneksi
$connect->close();
