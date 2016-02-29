<?php
	//include connection file 
	include_once("control/connection.php");
	 
	// initilize all variable
	$params = $columns = $totalRecords = $data = array();

	$params = $_REQUEST;

	//define index of column
	$columns = array( 
		0 =>'Name',
		1 =>'empType', 
		2 => 'certName',
		3 => 'certDate'
	);

	$where = $sqlTot = $sqlRec = "";

	// check search value exist	
	if( !empty($params['search']['value']) ) {   
		$where .=" AND ";
		$where .=" ( empfName LIKE '%".$params['search']['value']."%' ";  
		$where .=" OR emplName LIKE '%".$params['search']['value']."%' ";  
		$where .=" OR certName LIKE '%".$params['search']['value']."%' )";	
	}

	// getting total number records without any search
	$sql = "SELECT CONCAT_WS(' ',EMPLOYEES.empfName,EMPLOYEES.emplName) as 'Name',
				EMPLOYEES.empType as 'Type', CERTCLASSTYPES.certName as 'Certification', 
				DATE_FORMAT(MAX(CERTHISTORY.certDate),'%d %b %y') as 'Date' 
			FROM EMPLOYEES, CERTHISTORY,CERTCLASSTYPES,CERTCLASSES 
			WHERE EMPLOYEES.empID = CERTHISTORY.empID AND CERTHISTORY.clsID = CERTCLASSES.clsID AND CERTCLASSES.certID = CERTCLASSTYPES.certID";
	$sqlTot .= $sql;
	$sqlRec .= $sql;

	//concatenate search sql if value exist
	if(isset($where) && $where != '') {

		$sqlTot .= $where;
		$sqlRec .= $where;
	}

	$sqlRec .= " GROUP BY EMPLOYEES.empID, CERTCLASSES.certID, CONCAT_WS(' ',EMPLOYEES.empfName,EMPLOYEES.emplName),
				EMPLOYEES.empType, CERTCLASSTYPES.certName";

 	$sqlTot = $sqlRec;

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
	