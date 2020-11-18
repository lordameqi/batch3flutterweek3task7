<?php

// $koneksi = mysqli_connect("localhost","root","","udacoding");
// if($_SERVER['REQUEST_METHOD']=='POST'){
// 	$response = array();
// 	$username = $_POST['username'];
// 	$password = md5($_POST['password']);

// 	// langkah 2
// $cek = ​"select * from user where username = '$username' and
// password ='$password'"​;
// $result = mysqli_query($koneksi, $cek);
// if(isset($result)){
// $response[​'value'​] = ​1​;
// $response[​'message'​] = ​"Login berhasil"​;
// ​echo​ json_encode($response);
// }else{
// 	$response[​'value'​] = ​0​;
// $response[​'message'​] = ​"Login gagal"​;
// ​echo​ json_encode($response);
// }

// }
define('HOST', 'localhost');
define('USER', 'root');
define('PASS', '');
define('DB', 'udacoding');

$con = mysqli_connect(HOST, USER, PASS, DB) or die('tidak bisa konek');
if($_SERVER['REQUEST_METHOD'] == "POST"){
    $response = array();
    $email = $_POST['username'];
    $password = md5($_POST['password']);
    
    $cek = "SELECT * FROM user WHERE username='$email' and password='$password'";
    $result = mysqli_fetch_array(mysqli_query($con, $cek));

    if(isset($result)){
        $response['value'] = 1;
        $response['message'] = 'Login Berhasil';
        echo json_encode($response);

    } else{
            $response['value'] = 0;
            $response['message'] = "login gagal";
            echo json_encode($response);
        }
    }

?>
