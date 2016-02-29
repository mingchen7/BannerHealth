<?php
 $title = "Banner UMC Educator Portal";
 $description = "Educator Resource for Banner UMC Employees";
 include 'includes/header.php';
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
          <div class="filters">
            <h2>Placeholder for any filters or anything else</h2>
          </div>
          <div class="row">
            <br>
            <div class="col-lg-12">
              <div class="">                                
                <div class="">
                  <table id="employee_grid" class="display" width="100%" cellspacing="0">
                    <thead>
                      <tr>
                        <th>Name</th>
                        <th>Role</th>
                        <th>Date Approved</th>
                        <th>Approving Manager</th>
                      </tr>
                    </thead>

                    <tfoot>
                      <tr>
                        <th>Name</th>
                        <th>Role</th>
                        <th>Date Approved</th>
                        <th>Approving Manager</th>
                      </tr>
                   </tfoot>
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
    $(document).ready(function() {
        $('#employee_grid').DataTable({
           "serverSide": true,
           "autoWidth" : true,
           "ajax":{
                    url :"queryEmpLeaders.php", // json datasource
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