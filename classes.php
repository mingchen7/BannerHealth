<?php
 $title = "Banner UMC Educator Portal";
 $description = "Educator Resource for Banner UMC Employees";
 include 'includes/headerTables.php';
 include 'includes/nav.php';
 echo PHP_EOL;
?>

      <!-- Page Content -->
      <div id="page-content-wrapper">
        <div class="container-fluid">
          <div class="row">
            <div class="col-lg-12">
              <div>
                <div class="row">
                  <div class="col-md-8">                                
                    <a href="#menu-toggle" class="btn btn-default" id="menu-toggle">Toggle Menu</a>                                
                  </div>
                  <div class="col-md-4">
                    <button type="button" class="btn btn-default" style="float: right;">Sign Out</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
         <div class="row">
            <br>
            <div class="col-lg-12">
              <div class="dataTables">                                
                <div class="container">
                  <h1>Classes</h1>
                  <br>
                  <table id="employee_grid" class="display" width="100%" cellspacing="0">
                    <thead>
                      <tr>
                        <th>Class</th>
                        <th>Applicable To</th>
                        <th>Date</th>
                        <th>Campus</th>
                        <th>Building</th>
                        <th>Room</th>
                        <th>Ratio</th>
                        <th>Enrollment</th>
                      </tr>
                    </thead>
                  </table>
               </div>
              </div>
            </div>
          </div>
        </div>
        <!-- /#page-content-wrapper -->

      </div>
      <!-- /#wrapper -->

    <script type="text/javascript">    
    $( document ).ready(function() {
        $('#employee_grid').DataTable({
           "serverSide": true,
           "bAutoWidth" : true,
           "bSearching" : true,
           "ajax":{
                    url :"queryClasses.php", // json datasource
                    type: "post",  // type of method  ,GET/POST/DELETE
                    error: function(){
                      $("#employee_grid_processing").css("display","none");
                  }
              }
          });
    });
    </script>

<?php
 include 'includes/footer.php';
 echo PHP_EOL;
?>
