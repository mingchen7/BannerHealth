<?php
	//include connection file 
	include_once("control/connection.php");
	 
	// initilize all variable
	$params = $columns = $totalRecords = $data = array();

	$params = $_REQUEST;

	//define index of column
	$columns = array( 
		0 =>'Name',
		1 =>'Role', 
		2 => 'Date Approved',
		3 => 'Approving Manager'
	);

	$where = $sqlTot = $sqlRec = "";

	// getting total number records without any search
	$sql = "SELECT CONCAT_WS(' ',EMPLOYEES.empfName,EMPLOYEES.emplName) as 'Name', 
				LEADERSHIPPOSITIONS.posName as 'Role',
				DATE_FORMAT(MANAGEMENTAPPROVAL.apprvDate,'%d %b %y') as 'Date Approved',
				MANAGEMENTAPPROVAL.apprvManager as 'Approving Manager' 
			FROM EMPLOYEES, LEADERSHIPPOSITIONS,MANAGEMENTAPPROVAL
			WHERE EMPLOYEES.empID = MANAGEMENTAPPROVAL.empID
				AND MANAGEMENTAPPROVAL.posID = LEADERSHIPPOSITIONS.posID";
	$sqlTot .= $sql;
	$sqlRec .= $sql;

	//concatenate search sql if value exist
	if(isset($where) && $where != '') {

		$sqlTot .= $where;
		$sqlRec .= $where;
	}


 	$sqlRec .=  " ORDER BY ". $columns[$params['order'][0]['column']]."   ".$params['order'][0]['dir']."  LIMIT ".$params['start']." ,".$params['length']." ";

	$queryTot = mysqli_query($conn, $sqlTot) or die("database error:". mysqli_error($conn));


	$totalRecords = mysqli_num_rows($queryTot);

	$queryRecords = mysqli_query($conn, $sqlRec) or die("error to fetch employees data");

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
	