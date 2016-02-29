<?php
 $title = "Banner UMC Educator Portal";
 $description = "Educator Resource for Banner UMC Employees";
 include 'includes/headerTables.php';
 include 'includes/nav.php';
 echo PHP_EOL;
?>

    <script type="text/javascript" charset="utf-8" src="js/table.EMPLOYEES.js"></script>

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
                  <h1>Employees</h1>
                  <br>
                  <table cellpadding="0" cellspacing="0" border="0" class="display" id="EMPLOYEES" width="100%">
                  <thead>
                    <tr>
                      <th>Type</th>
                      <th>First Name</th>
                      <th>Last Name</th>
                      <th>Phone</th>
                      <th>Street</th>
                      <th>City</th>
                      <th>State</th>
                      <th>Position</th>
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
<?php
 include 'includes/footer.php';
 echo PHP_EOL;
?>
