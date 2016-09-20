<section id="widget-grid" class="">
	<!-- row -->
	<div class="row">

		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i> </span>
					<h2>Shipment Type</h2>

				</header>

				<!-- widget div-->
				<div>
					<!-- widget content -->
					<div class="widget-body">
						
						<div class="row">
							<div class="col-md-6">
								<legend class="fcollapsible">Shipment Type Detail</legend>
								<div class="fcontent">
									<form class="form-horizontal">
										<div class="form-group">
											<label class="col-md-3 control-label text-left">Shipment Code</label>
											<div class="col-md-9">
												<input class="form-control" placeholder="" type="text" name="" id="code">
											</div>
										</div>
										<div class="form-group">
											<label class="col-md-3 control-label text-left">Shipment Type</label>
											<div class="col-md-9">
												<input class="form-control" placeholder="" type="text" name="" id="description">
											</div>
										</div>
										<div class="form-group text-center">
											<div class="btn bg-color-blueDark txt-color-white" id="btnAddRow">
												<i class="fa fa-save"></i>
												&nbsp;Add/Update
											</div>
											<div class="btn btn-default" id="btnRefresh">
												<i class="fa fa-refresh"></i>
												&nbsp;Refresh
											</div>
										</div>
									</form>
								</div>		
							</div>
							<div class="col-md-6">
								<fieldset>
									<legend class="fcollapsible">Currency List</legend>

									<div class="fcontent">
										
										<table id="datatable_fixed_column" class="table table-striped table-bordered" width="100%">
					
									        <thead>
												<tr>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Shipment Code " />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Shipment Type" />
													</th>
													<th></th>									
												</tr>
									            <tr>
								                    <th>Shipment Code</th>
													<th>Shipment Type</th>
													<th style="width: 10%"></th>
									            </tr>
									        </thead>
											<tbody>
												<tr>
													<td>FTZ</td>
													<td>Factory to Zone</td>
													<td>
														<span class="txt-color-red btnDelete" title="Delete"><i class="ace-icon bigger-130 fa fa-trash-o"></i></span>
													</td>
												</tr>
												<tr>
													<td>FTA</td>
													<td>Factory to Agent</td>
													<td>
														<span class="txt-color-red btnDelete" title="Delete"><i class="ace-icon bigger-130 fa fa-trash-o"></i></span>
													</td>
												</tr>
												<tr>
													<td>FTC</td>
													<td>Factory to Customer</td>
													<td>
														<span class="txt-color-red btnDelete" title="Delete"><i class="ace-icon bigger-130 fa fa-trash-o"></i></span>
													</td>
												</tr>
												<tr>
													<td>FTP</td>
													<td>Factory to Particular</td>
													<td>
														<span class="txt-color-red btnDelete" title="Delete"><i class="ace-icon bigger-130 fa fa-trash-o"></i></span>
													</td>
												</tr>
												<tr>
													<td>ZTA</td>
													<td>Zone to Agent</td>
													<td>
														<span class="txt-color-red btnDelete" title="Delete"><i class="ace-icon bigger-130 fa fa-trash-o"></i></span>
													</td>
												</tr>
												<tr>
													<td>ZTC</td>
													<td>Zone to Customer</td>
													<td>
														<span class="txt-color-red btnDelete" title="Delete"><i class="ace-icon bigger-130 fa fa-trash-o"></i></span>
													</td>
												</tr>
												<tr>
													<td>ZTP</td>
													<td>Zone to Particular</td>
													<td>
														<span class="txt-color-red btnDelete" title="Delete"><i class="ace-icon bigger-130 fa fa-trash-o"></i></span>
													</td>
												</tr>
												<tr>
													<td>ATC</td>
													<td>Agent to Customer</td>
													<td>
														<span class="txt-color-red btnDelete" title="Delete"><i class="ace-icon bigger-130 fa fa-trash-o"></i></span>
													</td>
												</tr>
												<tr>
													<td>ATP</td>
													<td>Agent to Particular</td>
													<td>
														<span class="txt-color-red btnDelete" title="Delete"><i class="ace-icon bigger-130 fa fa-trash-o"></i></span>
													</td>
												</tr>
											</tbody>
										</table>
											
									</div>
								</fieldset>
							</div>
						</div>
					</div>
				</div>
			</div>
		</article>
	</div>
</section>
<script type="text/javascript">
$(document).ready(function() {
	var responsiveHelper_datatable_fixed_column = undefined;

	var breakpointDefinition = {
		tablet : 1024,
		phone : 480
	};

	
	/* COLUMN FILTER  */
    var otable = $('#datatable_fixed_column').DataTable({
		"sDom": "<'dt-toolbar'<'col-xs-12 col-sm-6 hidden-xs'f><'col-sm-6 col-xs-12 hidden-xs'C>r>"+
				"t"+
				"<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-xs-12 col-sm-6'p>>",
		"autoWidth" : true,
		"preDrawCallback" : function() {
			// Initialize the responsive datatables helper once.
			if (!responsiveHelper_datatable_fixed_column) {
				responsiveHelper_datatable_fixed_column = new ResponsiveDatatablesHelper($('#datatable_fixed_column'), breakpointDefinition);
			}
		},
		"rowCallback" : function(nRow) {
			responsiveHelper_datatable_fixed_column.createExpandIcon(nRow);
		},
		"drawCallback" : function(oSettings) {
			responsiveHelper_datatable_fixed_column.respond();
		}		
	
    });
    	   
    // Apply the filter
    $("#datatable_fixed_column thead th input[type=text]").on( 'keyup change', function () {
        otable
            .column( $(this).parent().index()+':visible' )
            .search( this.value )
            .draw();
    } );

    $('.editField').editable({
    	mode: 'inline',
        type: 'text'
    });

    $("#datatable_fixed_column").on( 'click', '.btnDelete', function () {
	    var result = confirm('Are you sure you want to delete this item?');
    	if(result)
    	{
    		otable.row( $(this).parents('tr') )
		        .remove()
		        .draw();
    	}
    } );

    $('#btnAddRow').on( 'click', function () {

		otable.row.add( [
            $('#code').val(),
            $('#description').val(),
            '<span class="txt-color-red btnDelete" title="Delete"><i class="ace-icon bigger-130 fa fa-trash-o"></i></span>'
        ] ).draw( false );

        refreshCurrency();
    });

    function refreshCurrency () {
    	$('#code').val('');
        $('#description').val('');
    }

    $('#btnRefresh').on( 'click', function () {
        refreshCurrency();
    });
})
</script>