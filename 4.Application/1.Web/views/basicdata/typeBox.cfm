<section id="widget-grid" class="">
	<!-- row -->
	<div class="row">

		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i> </span>
					<h2>Type Box</h2>

				</header>

				<!-- widget div-->
				<div>
					<!-- widget content -->
					<div class="widget-body">
						
						<div class="row">
							<div class="col-md-6">
								<legend class="fcollapsible">Type Box Detail</legend>
								<div class="fcontent">
									<form class="form-horizontal">
										<div class="form-group">
											<label class="col-md-2 control-label text-left">Type Box</label>
											<div class="col-md-10">
												<input class="form-control" placeholder="" type="text" name="" id="textName">
											</div>
										</div>
										<div class="form-group">
											<label class="col-md-2 control-label text-left">Depth</label>
											<div class="col-md-2">
												<input class="form-control" placeholder="" type="text" name="" id="depth">
											</div>
											<label class="col-md-2 control-label text-left">Length</label>
											<div class="col-md-2">
												<input class="form-control" placeholder="" type="text" name="" id="length">
											</div>
											<label class="col-md-2 control-label text-left">Width</label>
											<div class="col-md-2">
												<input class="form-control" placeholder="" type="text" name="" id="width">
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
									<legend class="fcollapsible">Type Box List</legend>

									<div class="fcontent">
										
										<table id="datatable_fixed_column" class="table table-striped table-bordered" width="100%">
					
									        <thead>
												<tr>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Type Box " />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Depth" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Length" />
													</th>
													<th class="hasinput">
														<input type="text" class="form-control" placeholder="Filter Width" />
													</th>
													<th></th>									
												</tr>
									            <tr>
								                    <th>Type Box</th>
													<th>Depth</th>
													<th>Length</th>
													<th>Width</th>
													<th style="width: 10%"></th>
									            </tr>
									        </thead>
											<tbody>
												<tr>
													<td>40*40*60</td>
													<td>40</td>
													<td>40</td>
													<td>60</td>
													<td>
														<span class="txt-color-red btnDelete" title="Delete"><i class="ace-icon bigger-130 fa fa-trash-o"></i></span>
													</td>
												</tr>
												<tr>
													<td>20*40*60</td>
													<td>20</td>
													<td>40</td>
													<td>60</td>
													<td>
														<span class="txt-color-red btnDelete" title="Delete"><i class="ace-icon bigger-130 fa fa-trash-o"></i></span>
													</td>
												</tr>
												<tr>
													<td>10*40*60</td>
													<td>10</td>
													<td>40</td>
													<td>60</td>
													<td>
														<span class="txt-color-red btnDelete" title="Delete"><i class="ace-icon bigger-130 fa fa-trash-o"></i></span>
													</td>
												</tr>
												<tr>
													<td>ENV*30*45</td>
													<td>3</td>
													<td>30</td>
													<td>45</td>
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

    $("#datatable_fixed_column").on( 'click', '.btnDelete', function () {
        otable.row( $(this).parents('tr') )
		        .remove()
		        .draw();
    } );

    $('#btnAddRow').on( 'click', function () {

		otable.row.add( [
            $('#textName').val(),
            $('#depth').val(),
            $('#length').val(),
            $('#width').val(),
            '<span class="txt-color-red btnDelete" title="Delete"><i class="ace-icon bigger-130 fa fa-trash-o"></i></span>'
        ] ).draw( false );

        refreshCurrency();
    });

    function refreshCurrency () {
    	$('#textName').val('');
        $('#depth').val('');
        $('#length').val('');
        $('#width').val('');
    }

    $('#btnRefresh').on( 'click', function () {
        refreshCurrency();
    });
})
</script>