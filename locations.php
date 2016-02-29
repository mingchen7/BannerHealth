<?php
 $title = "Banner UMC Educator Portal";
 $description = "Educator Resource for Banner UMC Employees";
 include 'includes/header.php';
 include 'includes/nav.php';
 echo PHP_EOL;
?>

    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript">
      google.load('visualization', '1', {'packages': ['table', 'map', 'corechart']});
      google.setOnLoadCallback(drawmap);

      function drawmap(){

        var geoData = new google.visualization.DataTable();
        geoData.addColumn('number', 'Lat');
        geoData.addColumn('number','Lon');
        geoData.addColumn('string','Name');
        geoData.addColumn('string','City');
        geoData.addColumn('string','Country');        
        geoData.addRows([
        [32.232035, -110.950141, 'University of Arizona','Tucson','USA'],
        [32.240595, -110.946005, 'Banner-University Medical Center Tucson Campus','Tucson','USA'],
        [32.237039, -110.954421, 'Eller College of Management','Tucson','USA'],
        [32.232568, -110.951968, 'Student Union','Tucson','USA']
        ]);

        var geoView = new google.visualization.DataView(geoData);
        geoView.setColumns([0, 1]);


        var map =
            new google.visualization.Map(document.getElementById('map_div'));
        map.draw(geoView, {showTip: true});

        // Set a 'select' event listener for the table.
        // When the table is selected, we set the selection on the map.
        google.visualization.events.addListener(table, 'select',
            function() {
              map.setSelection(table.getSelection());
            });

        // Set a 'select' event listener for the map.
        // When the map is selected, we set the selection on the table.
        google.visualization.events.addListener(map, 'select',
            function() {
              table.setSelection(map.getSelection());
            });
      }
      </script>
       

    <!-- Page Content -->
    <div id="page-content-wrapper">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12">
                    <div class="row">
                      <div class="col-md-8">   
                        <a href="#menu-toggle" class="btn btn-default" id="menu-toggle">Toggle Menu</a>                         
                    </div>
                    <div class="col-md-4">
                      <button type="button" class="btn btn-default" style="float: right;">Sign Out</button>
                  </div>
              </div>
              <br>                                    
              <div class="row">
                <div class="col-lg-12">
                    <h4><span class="label label-primary">Please Choose Classroom</span>
                        <select id="classrooms">
                            <option></option>                        
                        </select>  
                    </h4> 
                    <br>                       
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-md-8">
                                <div class="input-group">
                                    <span class="input-group-addon" id="basic-addon1">Campus</span>
                                    <input id="inputCampus" type="text" class="form-control" placeholder="Example: Banner - University Medical Center Tucson Campus" aria-describedby="basic-addon1">
                                </div>              
                                <br>                  
                                <div class="input-group">
                                    <span class="input-group-addon" id="basic-addon1">Building</span>
                                    <input id="inputBuilding" type="text" class="form-control" placeholder="Example: Thomas W. Keating Biosearch Building" aria-describedby="basic-addon1">
                                </div>         
                                <br>                       
                                <div class="input-group">
                                    <span class="input-group-addon" id="basic-addon1">Floor</span>
                                    <input id="inputFloor" type="text" class="form-control" placeholder="Example: 1" aria-describedby="basic-addon1">
                                </div>        
                                <br>                        
                                <div class="input-group">
                                    <span class="input-group-addon" id="basic-addon1">Room Number</span>
                                    <input id="inputRoom" type="text" class="form-control" placeholder="Example: 101" aria-describedby="basic-addon1">
                                </div>    
                                <br>                           
                                <div class="input-group">
                                    <span class="input-group-addon" id="basic-addon1">Capacity</span>
                                    <input id="inputCapacity" type="text" class="form-control" placeholder="Example: 50" aria-describedby="basic-addon1">
                                </div>
                                <br>  
                                <button id="AddClassroom" type="button" class="btn btn-default">Add Classroom</button>                              
                                <button id="DeleteClassroom" type="button" class="btn btn-default">Delete Classroom</button>                           
                            </div>
                        </div>
                        
                        <br>
                        <div class="row">
                            <div class="col-md-12">                                                                                   
                                <div id="map_div"></div>
                            </div>
                        </div>


                    </div>

                </div>
            </div>
            <div>

            </div>


        </div>
    </div>
</div>
</div>
<!-- /#page-content-wrapper -->

</div>
<!-- /#wrapper -->


<script>
$(document).ready(function() {
    $('#classrooms').load("getclassrooms.php");        
});
</script>    

<script>
$(document).ready(function() {        
    $('#classrooms').change(function (e){                
        //alert('test' + $('#classrooms').val());
        e.preventDefault();        
        $.ajax({
            type: 'post',
            url: 'queryClassroom.php',            
            data: {'clsroomID': $('#classrooms').val()},
            success: function(json){          
                var tmp = jQuery.parseJSON(json);
                //console.log(tmp);                                                  
                $('#inputCampus').val(tmp[0][0]);
                $('#inputBuilding').val(tmp[0][1]);
                $('#inputFloor').val(tmp[0][2]);
                $('#inputRoom').val(tmp[0][3]);
                $('#inputCapacity').val(tmp[0][4]);
                //console.log(tmp);
                
            },
            error: function(xhr,desc,err){
                console.log(xhr + "\n" + err);
            }
        });

    });
});
</script>  

<?php
 include 'includes/footer.php';
 echo PHP_EOL;
?>