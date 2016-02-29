
/*
 * Editor client script for DB table EMPLOYEES
 * Created by http://editor.datatables.net/generator
 */

(function($){

$(document).ready(function() {
	var editor = new $.fn.dataTable.Editor( {
		ajax: 'php/table.EMPLOYEES.php',
		table: '#EMPLOYEES',
		fields: [
			{
				"label": "Type",
				"name": "empType",
				"type": "select",
				"def": "Other",
				"options": [
					"Instructor",
					"Emergency Tech",
					"CE Paramedia",
					"Registered Nurse",
					"Other"
				]
			},
			{
				"label": "First Name",
				"name": "empfName"
			},
			{
				"label": "Last Name",
				"name": "emplName"
			},
			{
				"label": "Phone",
				"name": "empPhone"
			},
			{
				"label": "Street",
				"name": "empStreet"
			},
			{
				"label": "City",
				"name": "empCity"
			},
			{
				"label": "State",
				"name": "empState"
			},
			{
				"label": "Position",
				"name": "currPosition"
			}
		]
	} );

	var table = $('#EMPLOYEES').DataTable( {
		dom: 'Bfrtip',
		ajax: 'php/table.EMPLOYEES.php',
		columns: [
			{
				"data": "empType"
			},
			{
				"data": "empfName"
			},
			{
				"data": "emplName"
			},
			{
				"data": "empPhone"
			},
			{
				"data": "empStreet"
			},
			{
				"data": "empCity"
			},
			{
				"data": "empState"
			},
			{
				"data": "currPosition"
			}
		],
		select: true,
		lengthChange: false,
		buttons: [
			{ extend: 'create', editor: editor },
			{ extend: 'edit',   editor: editor },
			{ extend: 'remove', editor: editor }
		]
	} );
} );

}(jQuery));

