<?php

/*
 * Editor server script for DB table EMPLOYEES
 * Created by http://editor.datatables.net/generator
 */

// DataTables PHP library and database connection
include( "lib/DataTables.php" );

// Alias Editor classes so they are easy to use
use
	DataTables\Editor,
	DataTables\Editor\Field,
	DataTables\Editor\Format,
	DataTables\Editor\Mjoin,
	DataTables\Editor\Upload,
	DataTables\Editor\Validate;


// Build our Editor instance and process the data coming from _POST
Editor::inst( $db, 'EMPLOYEES', 'empID' )
	->fields(
		Field::inst( 'empType' )
			->validator( 'Validate::notEmpty' ),
		Field::inst( 'empfName' )
			->validator( 'Validate::notEmpty' ),
		Field::inst( 'emplName' )
			->validator( 'Validate::notEmpty' ),
		Field::inst( 'empPhone' )
			->validator( 'Validate::notEmpty' ),
		Field::inst( 'empStreet' )
			->validator( 'Validate::notEmpty' ),
		Field::inst( 'empCity' )
			->validator( 'Validate::notEmpty' ),
		Field::inst( 'empState' )
			->validator( 'Validate::notEmpty' ),
		Field::inst( 'currPosition' )
	)
	->process( $_POST )
	->json();
