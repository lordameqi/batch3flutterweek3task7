<?php

// $koneksi = mysqli_connect("localhost","root","","udacoding")or die(mysqli_connect_error());;
include "koneksi.php";
 if ($_SERVER['REQUEST_METHOD'] == 'POST') {
$response = array();

// menangkap data yang di kirim dari form
$username = $_POST['username'];
$password = md5($_POST['password']);
$email = $_POST['email'];
 
// menginput data ke database
$cek = "insert into user values('','$username','$password','$email')";
$a = mysqli_query($koneksi, $cek)or die("Error: " . mysqli_error($koneksi));
//$result = mysqli_fetch_array($a);

if (isset($a)) {
$response['value'] = 2;
$response['message'] = "Username telah digunakan";
echo json_encode($response);
} else {
$insert = "INSERT INTO user VALUE('',
'$username','$password', '$email', NOW())";
if (mysqli_query($koneksi, $insert)) {
$response['value'] = 1;
$response['message'] = "Berhasil didaftarkan";

echo json_encode($response);
} else {
$response['value'] = 0;
$response['message'] = "Gagal didaftarkan";
echo json_encode($response);
}
}
}
?>