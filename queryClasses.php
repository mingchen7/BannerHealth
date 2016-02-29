<?php

	 
	// initilize all variable
	$params = $totalRecords = $data = array();

	$params = $_REQUEST;
		//include connection file 
	include_once("control/connection.php");

	// getting total number records without any search
	$sql = "CALL GetCurrentClasses(0);";

	$queryRecords = mysqli_query($conn, $sql) or die("error fetching data");

	$totalRecords = mysqli_num_rows($queryRecords);

	//iterate on results row and create new index array of data
	while( $row = mysqli_fetch_row($queryRecords) ) { 
		$data[] = $row;
	}	

	$json_data = array(
			"draw"            => intval( $params['draw'] ),   
			"recordsTotal"    => intval( $totalRecords ),  
			"recordsFiltered" => intval($totalRecords),
			"data"            => $data   // total data array
			);

	echo json_encode($json_data);  // send data as json format
?>
	