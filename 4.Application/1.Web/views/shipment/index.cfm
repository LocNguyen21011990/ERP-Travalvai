<cfoutput>
	<section id="widget-grid" class="">
		<div class="row">
			<article class="col-sm-12 col-md-12 col-lg-12">

				<!-- Widget ID (each widget will need unique ID)-->
				<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
					<header>
						<span class="widget-icon"> <i class="fa fa-check"></i> </span>
						<h2> Shipment Information </h2>
					</header>

					<!-- widget div-->
					<div>

						<!-- widget edit box -->
						<div class="jarviswidget-editbox">
							<!-- This area used as dropdown edit box -->

						</div>
						<!-- end widget edit box -->

						<!-- widget content -->

						<div class="widget-body">

							<ul id="myTab1" class="nav nav-tabs">
								<li class="active">
									<a href="##s1" data-toggle="tab">Views</a>
								</li>
								<li>
									<a href="##s2" data-toggle="tab">Zone</a>
								</li>
								<li>
									<a href="##s3" data-toggle="tab">Agent</a>
								</li>
							</ul>

							
							<div id="myTabContent1" class="tab-content padding-10">
								
								<div class="tab-pane fade in active" id="s1">
									<div class="table-responsive">
										<table id="datatable_fixed_column_1" class="table table-striped table-bordered" width="100%">

									        <thead>
												<tr>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Shipment" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Type" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Sender" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Destination" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Status" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Forwarder" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Freight" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Incoterm" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Total Units" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter NO. Boxes" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Weight" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Volume" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control inputDate" placeholder="Filter Open Date"/>
													</th>
													<th class="hasinput">
														<input type="text" class="form-control inputDate" placeholder="Filter Estimated Delivery Date" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control inputDate" placeholder="Filter Delivery Date" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control inputDate" placeholder="Filter Estimated Arrival Date" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control inputDate" placeholder="Filter Arrival Date" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Freight Cost" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Taxes" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Import Duty" />
													</th>
													<th><div class="icon-action"></div></th>
												</tr>
									            <tr>
								                    <th>Shipment</th>
													<th>Type</th>
													<th>Sender</th>
													<th>Destination</th>
													<th>Status</th>
													<th>Forwarder</th>
													<th>Freight</th>
													<th>Incoterm</th>
													<th>Total Units</th>
													<th>NO. Boxes</th>
													<th>Weight</th>
													<th>Volume</th>
													<th>Open Date</th>
													<th>Estimated Delivery Date</th>
													<th>Delivery Date</th>
													<th>Estimated Arrival Date</th>
													<th>Arrival Date</th>
													<th>Freight Cost</th>
													<th>Taxes</th>
													<th>Import Duty</th>
													<th></th>
									            </tr>
									        </thead>

					        				<tbody>
					        					<tr>
													<td>SH-55568</td>
													<td>FT2</td>
													<td>TV1</td>
													<td>BCN</td>
													<td>Delivered</td>
													<td>Emirates</td>
													<td>Air</td>
													<td>FOB</td>
													<td>356</td>
													<td>6</td>
													<td>160.00</td>
													<td>0.60</td>
													<td>01-01-16</td>
													<td>12-01-16</td>
													<td>12-01-16</td>
													<td>17-01-16</td>
													<td>18-01-16</td>
													<td>500</td>
													<td>250</td>
													<td>100</td>
													<td class="icon-action">
														<span class="txt-color-green report" href="javascript:void(0)" title="Edit"><i class="ace-icon bigger-130 fa fa-pencil"></i></span>
														<span class="txt-color-red btnDelete" title="Delete"><i class="ace-icon bigger-130 fa fa-trash-o"></i></span>
													</td>
												</tr>
												<tr>
													<td>SH-55569</td>
													<td>ZTA</td>
													<td>BCN</td>
													<td>MAD</td>
													<td>Received</td>
													<td>Seur</td>
													<td>Courrier</td>
													<td>DDP</td>
													<td>76</td>
													<td>1</td>
													<td>20.00</td>
													<td>0.10</td>
													<td>18-01-16</td>
													<td>19-01-16</td>
													<td>19-01-16</td>
													<td>20-01-16</td>
													<td>19-01-16</td>
													<td>100</td>
													<td></td>
													<td></td>
													<td>
														<span class="txt-color-green report" href="javascript:void(0)" title="Edit"><i class="ace-icon bigger-130 fa fa-pencil"></i></span>
														<span class="txt-color-red btnDelete" title="Delete"><i class="ace-icon bigger-130 fa fa-trash-o"></i></span>
													</td>
												</tr>
												<tr>
													<td>SH-55570</td>
													<td>ATC</td>
													<td>MAD</td>
													<td>CA Las Rozas</td>
													<td>Received</td>
													<td>MRW</td>
													<td>Courrier</td>
													<td>DDP</td>
													<td>120</td>
													<td>3</td>
													<td>60.00</td>
													<td>0.30</td>
													<td>21-01-16</td>
													<td>22-01-16</td>
													<td>22-01-16</td>
													<td>23-01-16</td>
													<td>13-01-16</td>
													<td>150</td>
													<td></td>
													<td></td>
													<td>
														<span class="txt-color-green report" href="javascript:void(0)" title="Edit"><i class="ace-icon bigger-130 fa fa-pencil"></i></span>
														<span class="txt-color-red btnDelete" title="Delete"><i class="ace-icon bigger-130 fa fa-trash-o"></i></span>
													</td>
												</tr>
												<tr>
													<td>SH-55571</td>
													<td>FTZ</td>
													<td>TV1</td>
													<td>BCN</td>
													<td>Open</td>
													<td>Blue Water</td>
													<td>Sea</td>
													<td>FOB</td>
													<td>1.255</td>
													<td>10</td>
													<td>250.00</td>
													<td>1.00</td>
													<td>04-01-16</td>
													<td>15-01-16</td>
													<td></td>
													<td>20-01-16</td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td>
														<span class="txt-color-green report" href="javascript:void(0)" title="Edit"><i class="ace-icon bigger-130 fa fa-pencil"></i></span>
														<span class="txt-color-red btnDelete" title="Delete"><i class="ace-icon bigger-130 fa fa-trash-o"></i></span>
													</td>
												</tr>
												<tr>
													<td>SH-55572</td>
													<td>ZTC</td>
													<td>BCN</td>
													<td>MKT</td>
													<td>Delivered</td>
													<td>Carry Express</td>
													<td>Courrier</td>
													<td>DDP</td>
													<td>2.300</td>
													<td>60</td>
													<td>350.00</td>
													<td>6.00</td>
													<td>01-02-16</td>
													<td>12-02-16</td>
													<td>12-02-16</td>
													<td>17-02-16</td>
													<td>17-02-16</td>
													<td>120</td>
													<td></td>
													<td></td>
													<td>
														<span class="txt-color-green report" href="javascript:void(0)" title="Edit"><i class="ace-icon bigger-130 fa fa-pencil"></i></span>
														<span class="txt-color-red btnDelete" title="Delete"><i class="ace-icon bigger-130 fa fa-trash-o"></i></span>
													</td>
												</tr>
												<tr>
													<td>SH-55573</td>
													<td>FTZ</td>
													<td>TV1</td>
													<td>MKT</td>
													<td>Delivered</td>
													<td>Carry Express</td>
													<td>Courrier</td>
													<td>DDP</td>
													<td>2.300</td>
													<td>60</td>
													<td>350.00</td>
													<td>6.00</td>
													<td>18-02-16</td>
													<td>19-02-16</td>
													<td>19-02-16</td>
													<td>20-02-16</td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td>
														<span class="txt-color-green report" href="javascript:void(0)" title="Edit"><i class="ace-icon bigger-130 fa fa-pencil"></i></span>
														<span class="txt-color-red btnDelete" title="Delete"><i class="ace-icon bigger-130 fa fa-trash-o"></i></span>
													</td>
												</tr>
												<tr>
													<td>SH-55574</td>
													<td>ZTP</td>
													<td>BCN</td>
													<td>982620</td>
													<td>Received</td>
													<td>Seur</td>
													<td>Courrier</td>
													<td>DDP</td>
													<td>5</td>
													<td>1</td>
													<td>2.00</td>
													<td>0.05</td>
													<td>21-02-16</td>
													<td>22-02-16</td>
													<td>22-02-16</td>
													<td>23-02-16</td>
													<td>23-02-16</td>
													<td>6y</td>
													<td></td>
													<td></td>
													<td>
														<span class="txt-color-green report" href="javascript:void(0)" title="Edit"><i class="ace-icon bigger-130 fa fa-pencil"></i></span>
														<span class="txt-color-red btnDelete" title="Delete"><i class="ace-icon bigger-130 fa fa-trash-o"></i></span>
													</td>
												</tr>
											</tbody>

										</table>
									</div>

								</div>
								<div class="tab-pane fade" id="s2">
									<div class="table-responsive">
										<table id="datatable_fixed_column_2" class="table table-striped table-bordered" width="100%">

									        <thead>
												<tr>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Shipment" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Type" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Sender" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Destination" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Status" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Forwarder" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Freight" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Incoterm" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Total Units" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter NO. Boxes" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Weight" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Volume" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control inputDate" placeholder="Filter Open Date" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control inputDate" placeholder="Filter Estimated Delivery Date" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control inputDate" placeholder="Filter Delivery Date" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control inputDate" placeholder="Filter Estimated Arrival Date" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control inputDate" placeholder="Filter Arrival Date" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Freight Cost" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Taxes" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Import Duty" />
													</th>
													<th style="width:25px"></th>
												</tr>
									            <tr>
								                    <th>Shipment</th>
													<th>Type</th>
													<th>Sender</th>
													<th>Destination</th>
													<th>Status</th>
													<th>Forwarder</th>
													<th>Freight</th>
													<th>Incoterm</th>
													<th>Total Units</th>
													<th>NO. Boxes</th>
													<th>Weight</th>
													<th>Volume</th>
													<th>Open Date</th>
													<th>Estimated Delivery Date</th>
													<th>Delivery Date</th>
													<th>Estimated Arrival Date</th>
													<th>Arrival Date</th>
													<th>Freight Cost</th>
													<th>Taxes</th>
													<th>Import Duty</th>
													<th style="width:25px"></th>
									            </tr>
									        </thead>

					        				<tbody>
												
											</tbody>

										</table>
									</div>
								</div>
								<div class="tab-pane fade" id="s3">
									<div class="table-responsive">
										<table id="datatable_fixed_column_3" class="table table-striped table-bordered" width="100%">

									        <thead>
												<tr>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Shipment" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Type" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Sender" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Destination" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Status" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Forwarder" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Freight" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Incoterm" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Total Units" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter NO. Boxes" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Weight" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Volume" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control inputDate" placeholder="Filter Open Date" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control inputDate" placeholder="Filter Estimated Delivery Date" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control inputDate" placeholder="Filter Delivery Date" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control inputDate" placeholder="Filter Estimated Arrival Date" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control inputDate" placeholder="Filter Arrival Date" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Freight Cost" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Taxes" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Import Duty" />
													</th>
													<th style="width:25px"></th>
												</tr>
									            <tr>
								                    <th>Shipment</th>
													<th>Type</th>
													<th>Sender</th>
													<th>Destination</th>
													<th>Status</th>
													<th>Forwarder</th>
													<th>Freight</th>
													<th>Incoterm</th>
													<th>Total Units</th>
													<th>NO. Boxes</th>
													<th>Weight</th>
													<th>Volume</th>
													<th>Open Date</th>
													<th>Estimated Delivery Date</th>
													<th>Delivery Date</th>
													<th>Estimated Arrival Date</th>
													<th>Arrival Date</th>
													<th>Freight Cost</th>
													<th>Taxes</th>
													<th>Import Duty</th>
													<th style="width:25px"></th>
									            </tr>
									        </thead>

					        				<tbody>
												
											</tbody>

										</table>
									</div>
								</div>
								
							</div>
						</div>
						<!-- end widget content -->

					</div>
					<!-- end widget div -->

				</div>
				<!-- end widget -->

			</article>

		</div>
	</section>
</cfoutput>


<script type="text/javascript">
	$(document).ready(function() {
		var responsiveHelper_datatable_fixed_column_1 = undefined;
		var responsiveHelper_datatable_fixed_column_2 = undefined;
		var responsiveHelper_datatable_fixed_column_3 = undefined;
		var breakpointDefinition = {
			tablet : 1024,
			phone : 480
		};

		/* COLUMN FILTER  */
	    var otable_1 = $('#datatable_fixed_column_1').DataTable({
			"sDom": "<<'col-xs-12 col-sm-10 hidden-xs filter'><'col-sm-2 col-xs-12 hidden-xs'>r>"+
					"t"+
					"<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-xs-12 col-sm-6'p>>",
			"bFilter": false,
			"autoWidth" : true,
			"preDrawCallback" : function() {
				// Initialize the responsive datatables helper once.
				if (!responsiveHelper_datatable_fixed_column_1) {
					responsiveHelper_datatable_fixed_column_1 = new ResponsiveDatatablesHelper($('#datatable_fixed_column_1'), breakpointDefinition);
				}
			},
			"rowCallback" : function(nRow) {
				responsiveHelper_datatable_fixed_column_1.createExpandIcon(nRow);
			},
			"drawCallback" : function(oSettings) {
				responsiveHelper_datatable_fixed_column_1.respond();
			}

	    });

	    var otable_2 = $('#datatable_fixed_column_2').DataTable({
			"sDom": "<<'col-xs-12 col-sm-10 hidden-xs filter'><'col-sm-2 col-xs-12 hidden-xs'>r>"+
					"t"+
					"<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-xs-12 col-sm-6'p>>",
			"bFilter": false,
			"order": [[ 2, "desc" ], [ 3, "asc" ]],
			"autoWidth" : true,
			"preDrawCallback" : function() {
				// Initialize the responsive datatables helper once.
				if (!responsiveHelper_datatable_fixed_column_2) {
					responsiveHelper_datatable_fixed_column_2 = new ResponsiveDatatablesHelper($('#datatable_fixed_column_2'), breakpointDefinition);
				}
			},
			"rowCallback" : function(nRow) {
				responsiveHelper_datatable_fixed_column_2.createExpandIcon(nRow);
			},
			"drawCallback" : function(oSettings) {
				responsiveHelper_datatable_fixed_column_2.respond();
			}

	    });

	    var otable_3 = $('#datatable_fixed_column_3').DataTable({
			"sDom": "<<'col-xs-12 col-sm-10 hidden-xs filter'><'col-sm-2 col-xs-12 hidden-xs'>r>"+
					"t"+
					"<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-xs-12 col-sm-6'p>>",
			"bFilter": false,
			"order": [[ 2, "desc" ], [ 3, "asc" ]],
			"autoWidth" : true,
			"preDrawCallback" : function() {
				// Initialize the responsive datatables helper once.
				if (!responsiveHelper_datatable_fixed_column_3) {
					responsiveHelper_datatable_fixed_column_3 = new ResponsiveDatatablesHelper($('#datatable_fixed_column_3'), breakpointDefinition);
				}
			},
			"rowCallback" : function(nRow) {
				responsiveHelper_datatable_fixed_column_3.createExpandIcon(nRow);
			},
			"drawCallback" : function(oSettings) {
				responsiveHelper_datatable_fixed_column_3.respond();
			}

	    });

	    // Apply the filter
	    $("#datatable_fixed_column_1 thead th input[type=text]").on( 'keyup change', function () {

	    	if ($(this).val().length < 3)	return false;
	        otable_1
	            .column( $(this).parent().index()+':visible' )
	            .search( this.value )
	            .draw();

	    } );

	    $("#datatable_fixed_column_2 thead th input[type=text]").on( 'keyup change', function () {

	    	if ($(this).val().length < 3)	return false;
	        otable_2
	            .column( $(this).parent().index()+':visible' )
	            .search( this.value )
	            .draw();

	    } );

	    $("#datatable_fixed_column_3 thead th input[type=text]").on( 'keyup change', function () {

	    	if ($(this).val().length < 3)	return false;
	        otable_3
	            .column( $(this).parent().index()+':visible' )
	            .search( this.value )
	            .draw();

	    } );			
	})
</script>