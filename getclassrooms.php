<?php
	include_once("control/connection.php");
	$sql = "SELECT clsrmID FROM CLASSROOMS";
	$query = mysqli_query($conn,$sql) or die("error to fetch classrooms data");
	while($row = mysqli_fetch_array($query)){		
		echo "<option>" . $row[0] . "</option>";
	}
?>