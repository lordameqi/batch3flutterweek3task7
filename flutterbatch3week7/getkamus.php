<?php
include "koneksi.php";
function matchper($s1,$s2){
	similar_text(strtolower($s1), strtolower($s2),$per);
	return $per;
}
if (isset($_REQUEST["query"])) {
	$query = strtolower($_REQUEST["query"]);
}else{
	$query = "";
}
$json["error"] = false;
$json["errmsg"] ="";
$json["data"] = array();

$sql = "select * from kamus order by singkatan asc";
$res = mysqli_query($koneksi, $sql);
$numrows = mysqli_num_rows($res);
if ($numrows > 0) {
	# code...
	while ($obj = mysqli_fetch_object($res)) {
			$matching = matchper($query, $obj->singkatan);
	$namelist[$matching][$obj->id_kamus] = $obj->singkatan;
	}


krsort($namelist);
foreach ($namelist as $innerarray) {
	foreach ($innerarray as $id_kamus => $singkatan) {
		$subdata = array();
		$subdata["id_kamus"] = "$id_kamus";
		$subdata["singkatan"] = $singkatan;
		array_push($json["data"], $subdata);
	}
}
}else{
	$json["error"] = true;
	$json["errmsg"] = "no any data to show";
}
mysqli_close($koneksi);
header('Content-Type: application/json');
echo json_encode($json);
?>