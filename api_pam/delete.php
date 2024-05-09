<?php

$connect = new mysqli("localhost", "root", "", "dbkuliner", 3307);

// Periksa koneksi
if ($connect->connect_error) {
    die("Connection failed: " . $connect->connect_error);
}

$id = $_POST['id'];


// Query untuk menambahkan data ke tabel 'tbkuliner'
$sql = "DELETE FROM tbkuliner  WHERE id = '$id'";

if ($connect->query($sql) === TRUE) {
    // Jika berhasil, kirimkan respons JSON dengan pesan berhasil
    echo json_encode(array("message" => "Data berhasil diHapus"));
} else {
    // Jika terjadi kesalahan, kirimkan respons JSON dengan pesan error
    echo json_encode(array("message" => "Error: " . $sql . "<br>" . $connect->error));
}

// Tutup koneksi
$connect->close();
