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
          <div class="row">
            <br>
            <div class="col-lg-12">
              <div class="">                                
                <div id="area_div" style="height : 350px; width: 800px">
                </div>
                <div id="chartLinear" style="height : 350px; width: 800px">
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
        <!-- /#page-content-wrapper -->

      </div>
      <!-- /#wrapper -->

    <!-- DataTables Query -->


    <!-- /DataTables Query -->
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
  <script type="text/javascript">
    google.load("visualization", "1", {packages:["corechart"]});
    google.setOnLoadCallback(drawArea);
    function drawArea() {
      var data = google.visualization.arrayToDataTable([
        ['Year', 'RNs', 'Paramedics', 'Techs'],
        ['2013',  280,      25,       65],
        ['2014',  300,      28,       67],
        ['2015',  330,      20,       70],
        ['2016',  350,      20,       76]
      ]);
  
      var options = {
        title: 'Staff Numbers',
        hAxis: {title: 'Year',  titleTextStyle: {color: '#333'}},
        vAxis: {minValue: 0},
        chartArea: {width: '70%'},
        'width':800,
        'height':400
      };
  
      var chart = new google.visualization.AreaChart(document.getElementById('area_div'));
      chart.draw(data, options);
    }
  </script>

  <script type="text/javascript">
      google.load("visualization", "1", {packages:["corechart"]});
      google.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Month', 'Students'],
          [ 8,      12],
          [ 4,      5.5],
          [ 11,     14],
          [ 4,      5],
          [ 3,      3.5],
          [ 6,    7]
        ]);

        var options = {
          title: 'Class Attendance',
          hAxis: {title: 'Month',  titleTextStyle: {color: '#333'}, minValue: 0, maxValue: 12},
          vAxis: {minValue: 0, maxValue: 15},
          chartArea: {width:'70%'},
          trendlines: {
            0: {
              type: 'linear',
              showR2: true,
              visibleInLegend: true
            }
          }
        };

        var chartLinear = new google.visualization.ScatterChart(document.getElementById('chartLinear'));
        chartLinear.draw(data, options);        
      }
    </script>

<?php
 include 'includes/footer.php';
 echo PHP_EOL;
?>