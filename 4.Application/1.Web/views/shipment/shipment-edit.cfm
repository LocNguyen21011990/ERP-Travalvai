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
						<form class="form-horizontal" role="form" id="order_information">
							<div class="row">
								<div class="col-md-12">
									<fieldset>
										<legend class="fcollapsible">General</legend>

										<div class="fcontent">											
										  	<div class="form-group">
										    	<label class="control-label col-sm-2 text-left">Shipment</label>
										    	<div class="col-sm-4">
										      		<input type="text" class="form-control" id="" placeholder="">
										    	</div>
										    	<label class="control-label col-sm-2 text-left">Type Shipment</label>
										    	<div class="col-sm-4">
										      		<select class="form-control" id="">
														<option>Choose</option>
														<option></option>
													</select>
										    	</div>
										  	</div>
										  	<div class="form-group">
										    	<label class="control-label col-sm-2 text-left">Sender</label>
										    	<div class="col-sm-4">
										      		<input type="text" class="form-control" id="" placeholder="">
										    	</div>
										    	<label class="control-label col-sm-2 text-left">Status</label>
										    	<div class="col-sm-4">
										      		<select class="form-control" id="">
														<option>Choose</option>
													</select>
										    	</div>
										  	</div>
										  	<div class="form-group">
										    	<label class="control-label col-sm-2 text-left">Name</label>
										    	<div class="col-sm-4">
										      		<input type="text" class="form-control" id="" placeholder="">
										    	</div>
										    	<label class="control-label col-sm-2 text-left">Forwarder</label>
										    	<div class="col-sm-4">
										      		<select class="form-control" id="">
														<option>Choose</option>
													</select>
										    	</div>
										  	</div>
										  	<div class="form-group">
										    	<label class="control-label col-sm-2 text-left">Destination</label>
										    	<div class="col-sm-4">
										      		<input type="text" class="form-control" id="" placeholder="">
										    	</div>
										    	<label class="control-label col-sm-2 text-left">Freight</label>
										    	<div class="col-sm-4">
										      		<select class="form-control" id="">
														<option>Choose</option>
													</select>
										    	</div>
										  	</div>
										  	<div class="form-group">
										    	<label class="control-label col-sm-2 text-left">Name</label>
										    	<div class="col-sm-4">
										      		<input type="text" class="form-control" id="" placeholder="">
										    	</div>
										    	<label class="control-label col-sm-2 text-left">Incoterm</label>
										    	<div class="col-sm-4">
										      		<select class="form-control" id="">
														<option>Choose</option>
													</select>
										    	</div>
										  	</div>
										</div>
									</fieldset>
									<fieldset>
										<legend class="fcollapsible">Shipment Information</legend>

										<div class="fcontent">
										  	<div class="form-group">
										    	<label class="control-label col-sm-2 text-left">Open Date</label>
										    	<div class="col-sm-4">
										      		<input type="text" class="form-control inputDate" id="" placeholder="">
										    	</div>
										    	<label class="control-label col-sm-2 text-left">Arrival Date</label>
										    	<div class="col-sm-4">
										      		<input type="text" class="form-control inputDate" id="" placeholder="">
										    	</div>
										  	</div>
										  	<div class="form-group">
										    	<label class="control-label col-sm-2 text-left">Estimated Delivery Date</label>
										    	<div class="col-sm-4">
										      		<input type="text" class="form-control inputDate" id="" placeholder="">
										    	</div>
										    	<label class="control-label col-sm-2 text-left">Freight Cost</label>
										    	<div class="col-sm-4">
										      		<input type="text" class="form-control" id="" placeholder="">
										    	</div>
										  	</div>
										  	<div class="form-group">
										    	<label class="control-label col-sm-2 text-left">Delivery Date</label>
										    	<div class="col-sm-4">
										      		<input type="text" class="form-control inputDate" id="" placeholder="">
										    	</div>
										    	<label class="control-label col-sm-2 text-left">Taxes</label>
										    	<div class="col-sm-4">
										      		<input type="text" class="form-control" id="" placeholder="">
										    	</div>
										  	</div>
										  	<div class="form-group">
										    	<label class="control-label col-sm-2 text-left">Estimated Arrival Date</label>
										    	<div class="col-sm-4">
										      		<input type="text" class="form-control inputDate" id="" placeholder="">
										    	</div>
										    	<label class="control-label col-sm-2 text-left">Import Duty</label>
										    	<div class="col-sm-4">
										      		<input type="text" class="form-control" id="" placeholder="">
										    	</div>
										  	</div>
										</div>
									</fieldset>
									<fieldset>
										<legend class="fcollapsible">Shipment Line List </legend>

										<div class="fcontent">		  	
											<div class="table-responsive">
												<table id="datatable_fixed_column_1" class="table table-striped table-bordered datatable_fixed_column" width="100%">

											        <thead>
														<tr>
															<th class="hasinput">
																<input type="text" class="form-control" placeholder="Filter Shipment Line" />
															</th>
															<th class="hasinput">
																<input type="text" class="form-control" placeholder="Filter Order Line" />
															</th>
															<th class="hasinput">
																<input type="text" class="form-control" placeholder="Filter Garment Code" />
															</th>
															<th class="hasinput">
																<input type="text" class="form-control" placeholder="Filter Version" />
															</th>
															<th class="hasinput">
																<input type="text" class="form-control" placeholder="Filter Description" />
															</th>
															<th class="hasinput">
																<input type="text" class="form-control" placeholder="Filter Name" />
															</th>
															<th class="hasinput">
																<input type="text" class="form-control" placeholder="Filter Number" />
															</th>
															<th class="hasinput">
																<input type="text" class="form-control" placeholder="Filter Size" />
															</th>
															<th class="hasinput">
																<input type="text" class="form-control" placeholder="Filter QTTY" />
															</th>
															<th class="hasinput">
																<input type="text" class="form-control" placeholder="Filter Box" />
															</th>
														</tr>
											            <tr>
															<th>Shipment Line</th>
															<th>Order Line</th>
															<th>Garment Code</th>
															<th>Version</th>
															<th>Description</th>
															<th>Name</th>
															<th>Number</th>
															<th>Size</th>
															<th>QTTY</th>
															<th>Box</th>
											            </tr>
											        </thead>

							        				<tbody>
							        					<tr>
							        						<td>SHD-55568-010</td>
							        						<td>ORDD-1246-001</td>
							        						<td>0235-0040-SP</td>
							        						<td>1</td>
							        						<td>Pantal'o Joc</td>
							        						<td></td>
							        						<td>10</td>
							        						<td>M</td>
							        						<td>1</td>
							        						<td>BX-15568</td>
							        					</tr>
							        					<tr>
							        						<td>SHD-55568-011</td>
							        						<td>ORDD-1246-002</td>
							        						<td>0235-0040-SP</td>
							        						<td>1</td>
							        						<td>Pantal'o Joc</td>
							        						<td></td>
							        						<td>23</td>
							        						<td>L</td>
							        						<td>1</td>
							        						<td>BX-15568</td>
							        					</tr>
							        					<tr>
							        						<td>SHD-55568-012</td>
							        						<td>ORDD-1246-003</td>
							        						<td>0235-0040-SP</td>
							        						<td>2</td>
							        						<td>Pantal'o Joc</td>
							        						<td></td>
							        						<td></td>
							        						<td>XL</td>
							        						<td>3</td>
							        						<td>BX-15568</td>
							        					</tr>
							        					<tr>
							        						<td>SHD-55568-013</td>
							        						<td>ORDD-1246-004</td>
							        						<td>0235-0040-VT</td>
							        						<td>6</td>
							        						<td>Camiseta 2a</td>
							        						<td>JOAN</td>
							        						<td>10</td>
							        						<td>M</td>
							        						<td>1</td>
							        						<td>BX-15568</td>
							        					</tr>
							        					<tr>
							        						<td>SHD-55568-014</td>
							        						<td>ORDD-1246-005</td>
							        						<td>0235-0040-VT</td>
							        						<td>6</td>
							        						<td>Camiseta 2a</td>
							        						<td>PERE</td>
							        						<td>23</td>
							        						<td>L</td>
							        						<td>1</td>
							        						<td>BX-15570</td>
							        					</tr>
							        					<tr>
							        						<td>SHD-55568-015</td>
							        						<td>ORDD-1246-006</td>
							        						<td>0235-0040-VT</td>
							        						<td>8</td>
							        						<td>Camiseta 2a</td>
							        						<td>JOAN</td>
							        						<td>10</td>
							        						<td>M</td>
							        						<td>1</td>
							        						<td>BX-15570</td>
							        					</tr>
							        					<tr>
							        						<td>SHD-55568-016</td>
							        						<td>ORDD-1246-007</td>
							        						<td>0235-0040-VT</td>
							        						<td>8</td>
							        						<td>Camiseta 2a</td>
							        						<td>PERE</td>
							        						<td>23</td>
							        						<td>L</td>
							        						<td>1</td>
							        						<td>BX-15568</td>
							        					</tr>
													</tbody>

												</table>
											</div>
										</div>
									</fieldset>
								</div>					
							</div>
							<div class="row form-actions">
								<div class="col-md-12 text-center">
									<div class="btn bg-color-blueDark txt-color-white" id="save_order">
										<i class="fa fa-save"></i>
										&nbsp;Save
									</div>
									<div class="btn btn-default">
										<i class="fa fa-sign-out"></i>
										&nbsp;Quit
									</div>
								</div>
							</div>
						</form>
					</div>
					<!-- end widget content -->

				</div>
				<!-- end widget div -->

			</div>
			<!-- end widget -->

		</article>

	</div>
</section>

<script type="text/javascript">
	$(document).ready(function() {
		var responsiveHelper_datatable_fixed_column_1 = undefined;
		var responsiveHelper_datatable_fixed_column_2 = undefined;
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

	    // Apply the filter
	    $("#datatable_fixed_column_1 thead th input[type=text]").on( 'keyup change', function () {

	    	if ($(this).val().length < 3)	return false;
	        otable_1
	            .column( $(this).parent().index()+':visible' )
	            .search( this.value )
	            .draw();

	    } );		
	})
</script>