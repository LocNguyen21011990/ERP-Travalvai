<cfoutput>
 	<section id="widget-grid" class="" ng-app="project.list" ng-controller="BindAngularDirectiveCtrl as showCase">
		<div class="row">
			<article class="col-sm-12 col-md-12 col-lg-12">
				<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
					<header>
						<span class="widget-icon"> <i class="fa fa-check"></i> </span>
						<h2> Project Information </h2>
					</header>
					<div>
						<div class="widget-body">
							<div class="widget-body-toolbar">
								<div class="row">
									<div class="col-sm-4">
										<div id="thShowHideColumnid" style="float:left"></div>
										<div class="input-group">
											<input class="form-control" type="text" placeholder="Search..." id="searchbox">
											<div class="input-group-btn">
												<button class="btn btn-default" type="button">
													<i class="fa fa-search"></i> Search
												</button>
											</div>
										</div>
									</div>
									<div class="col-sm-8 text-align-right">
										<div class="btn-group">
											<a class="btn bg-color-blueDark txt-color-white" id="btnAddNew" ng-click="showCase.showAddNew()"> <i class="fa fa-plus"></i> Create New </a>
										</div>
									</div>
									<div class="modal fade" id="addNew" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
		                                <div class="modal-dialog">
		                                    <div class="modal-content">
		                                        <div class="modal-body">
													<legend class="fcollapsible" id="titleID" style="text-align:left;">Create</legend>
													<div class="fcontent">
														<form class="form-horizontal" name="userForm" ng-submit="showCase.submitForm()" novalidate>
															<div class="row">
																<div class="col-md-6">
																	<input type='hidden' name="id_Project" id="id_Project" value="0">
																	<div class="form-group">
								                                        <label class="control-label col-sm-4 text-left">Project</label>
								                                        <div class="col-sm-8">
								                                            <input class="form-control" readonly placeholder="" type="text" name="display" id="display" ng-model="showCase.user.display" ng-pattern="showCase.regex"  required>
								                                        </div>
								                                    </div>
																</div>
																<div class="col-md-6">
														    		<div class="form-group">
																    	<label class="control-label col-sm-4 text-left">Date</label>
																    	<div class="col-sm-8" ng-class="{'has-error':userForm.date.$invalid && !userForm.date.$pristine}">
																    		<input class="form-control" placeholder="" type="text" name="date" id="date" ng-model="showCase.user.date">
							                                                <p ng-show="userForm.date.$error.required && !userForm.date.$pristine" class="help-block">Date is required</p>
							                                                <p ng-show="userForm.date.$error.pattern  && !userForm.date.$pristine" class="help-block">Can not enter special char</p>
																    	</div>
																  	</div>
																</div>
															</div>
															<div class="row">
																<div class="col-md-6">
																	<div class="form-group" ng-class="{'has-error':userForm.customer.$invalid && !userForm.customer.$pristine}">
								                                        <label class="control-label col-sm-4 text-left">Customer</label>
								                                        <div class="col-sm-8">
								                                        	<select ui-select2  id="customer" name="customer" ng-model="showCase.user.customerID" required>
																				<option value="">Choose</option>
																				<option ng-repeat="cus in showCase.customers" value="{{cus.ID}}">{{cus.NAME}}</option>
																			</select>
																			<p ng-show="userForm.customer.$invalid && !userForm.customer.$pristine" class="help-block">Please choose customer</p>
								                                        </div>
								                                    </div>
																</div>
																<div class="col-md-6">
																	<div class="form-group">
																    	<label class="control-label col-sm-4 text-left">Status</label>
																    	<div class="col-sm-8" ng-class="{'has-error':userForm.status.$invalid && !userForm.status.$pristine}">
																    		<select ui-select2 id="status"  name="status" ng-model="showCase.user.statusID" required>
																				<option value="">Choose</option>
																				<option ng-repeat="sta in showCase.status" value="{{sta.id_pj_Status}}">{{sta.pj_stat_desc}}</option>
																			</select>
																			<p ng-show="userForm.status.$invalid && !userForm.status.$pristine" class="help-block">Please choose status</p>
																    	</div>
																  	</div>
																</div>
															</div>
															<div class="row">
																<div class="col-md-12">
																  	<div class="form-group" ng-class="{'has-error':userForm.description.$invalid && !userForm.description.$pristine}">
								                                        <label class="control-label col-sm-2 text-left">Description</label>
								                                        <div class="col-sm-10">
								                                        	<textarea name="" id="" class="form-control" placeholder="" name="description" id="description" ng-model="showCase.user.description" required></textarea>
							                                                <p ng-show="userForm.description.$error.required && !userForm.description.$pristine" class="help-block">Description is required</p>
								                                        </div>
								                                    </div>
								                                </div>
								                            </div>
															<div class="row well"  style="background-color:white;">
																<div class="col-md-12"  style="margin-left: -20px;">
																	<label class="col-md-2 control-label  text-left"><strong>Action :</strong></label>
																</div>
																<div class="col-md-3">
																	<div class="form-group">
																		<div class="col-md-12">
																			<div class="row">
																				<label class="col-md-12 control-label text-left">
																					<input type="checkbox" ng-model="showCase.user.groupWaitingFD" ng-true-value="'YES'" ng-false-value="'NO'"> Waiting for design
																				</label>
																			</div>
																			<div class="row">
																				<label class="col-md-12 control-label text-left">
																					<input type="checkbox" ng-model="showCase.user.groupUrgent" ng-true-value="'YES'" ng-false-value="'NO'"> Urgent
																				</label>
																			</div>
																			<div class="row">
																				<label class="col-md-12 control-label text-left"><input type="checkbox" ng-model="showCase.user.groupVUrgent" ng-true-value="'YES'" ng-false-value="'NO'"> Very Urgent</label>
																			</div>
																			<div class="row">
																				<label class="col-md-12 control-label text-left"><input type="checkbox" ng-model="showCase.user.groupSentTCom" ng-true-value="'YES'" ng-false-value="'NO'"> Sent to Commercial</label>
																			</div>
																		</div>
																	</div>
																</div>
																<div class="col-md-3 col-md-offset-1">
																	<div class="form-group">
																		<div class="col-md-12">
																			<div class="row">
																				<label class="col-md-12 control-label text-left"><input type="checkbox" ng-model="showCase.user.groupSentTCus" ng-true-value="'YES'" ng-false-value="'NO'"> Sent to Customer</label>
																			</div>
																			<div class="row">
																				<label class="col-md-12 control-label text-left"><input type="checkbox" ng-model="showCase.user.groupSentTD" ng-true-value="'YES'" ng-false-value="'NO'"> Sent to design</label>
																			</div>
																			<div class="row">
																				<label class="col-md-12 control-label text-left"><input type="checkbox" ng-model="showCase.user.groupWaitingFC" ng-true-value="'YES'" ng-false-value="'NO'"> Waiting for Comments</label>
																			</div>
																			<div class="row">
																				<label class="col-md-12 control-label text-left"><input type="checkbox" ng-model="showCase.user.pj_act_8" ng-true-value="'YES'" ng-false-value="'NO'"> Action 8</label>
																			</div>
																		</div>
																	</div>
																</div>
																<div class="col-md-4 col-md-offset-1">
																	<div class="row">
																		<label class="col-md-12 control-label text-left"><input type="checkbox" ng-model="showCase.user.pj_act_9" ng-true-value="'YES'" ng-false-value="'NO'"> Action 9</label>
																	</div>
																	<div class="row">
																		<label class="col-md-12 control-label text-left"><input type="checkbox" ng-model="showCase.user.pj_act_10" ng-true-value="'YES'" ng-false-value="'NO'"> Action 10</label>
																	</div>
																</div>
															</div>
															<div class="row">
																<div class="col-md-12 text-center">
																	<div class="btn bg-color-blueDark txt-color-white" id="save_order" ng-disabled="userForm.$invalid" ng-click="showCase.addRow()">
																		<i class="fa fa-save"></i>
																		&nbsp;Save
																	</div>
																</div>
															</div>
														</form>
													</div>
												</div>
											</div>
										</div>
									</div>
							</div>
							<div class="table-responsive">
								<table id="datatable_fixed_column" class="table table-striped table-bordered" width="100%">
							        <thead>
										<tr>
											<th class="hasinput" style="width:5%;">
												<input type="text" class="form-control" placeholder="Filter Project" />
											</th>
											<th class="hasinput" style="width:22%;">
												<input type="text" class="form-control" placeholder="Filter Description" />
											</th>
											<th class="hasinput"  style="width:5%;">
												<input type="text" class="form-control" placeholder="Filter Cus" />
											</th>
											<th class="hasinput" style="width:9%;">
												<input type="text" class="form-control" placeholder="Filter Customer Name" />
											</th>
											<th class="hasinput" style="width:9%;">
												<input type="text" class="form-control" placeholder="Filter Agent" />
											</th>
											<th class="hasinput" style="width:10%;">
												<input type="text" class="form-control" placeholder="Filter Zone" />
											</th>
											<th class="hasinput" style="width:10%;">
												<input type="text" class="form-control inputDate" placeholder="Filter Date" />
											</th>
											<th class="hasinput"  style="width:5%;">
												<input type="text" class="form-control" placeholder="Filter Status" />
											</th>
											<th class="hasinput" style="width:20%;">
												<div class="label-action" id="label-action">Filter Action</div>
												<div class="filter-action">
													<div class="content-filter-action">
														<label class="actionLabel action-yellow" value="WD" id="labelAction-WD">
															<!--- <input type="checkbox"> --->
															Waiting for design </label>

														<label class="actionLabel action-red" value="U" id="labelAction-U">
															<!--- <input type="checkbox"> --->
															Urgent </label>

														<label class="actionLabel action-orange" value="VC" id="labelAction-VC">
															<!--- <input type="checkbox"> --->
															Very Urgent </label>

														<label class="actionLabel action-blueViolet" value="SC" id="labelAction-SC">
															<!--- <input type="checkbox"> --->
															Sent to Commercial </label>

														<label class="actionLabel action-blue" value="STC" id="labelAction-STC">
															<!--- <input type="checkbox"> --->
															Sent to Customer </label>

														<label class="actionLabel action-green" value="SD" id="labelAction-SD">
															<!--- <input type="checkbox"> --->
															Sent to Design </label>

														<label class="actionLabel action-pink" value="WC" id="labelAction-WC">
															<!--- <input type="checkbox"> --->
															Waiting for Comments </label>
													</div>
												</div>
											</th>
										</tr>
							            <tr>
						                    <th>PROJECT</th>
											<th>DESCRIPTION</th>
											<th>ID CUS</th>
											<th>CUSTOMER NAME</th>
											<th>AGENT</th>
											<th>ZONE</th>
											<th>DATE</th>
											<th>STATUS</th>
											<th></th>
											<th>ACTIONS</th>
							            </tr>
							        </thead>
			        				<tbody>
										<cfloop array="#prc.projects#" index="pj">
											<tr>
												<input type='hidden' name="id_Project" id="id_Project" value="#pj.id_project#">
												<td>PJ-#pj.id_display#</td>
												<td>#pj.pj_description#</td>
												<td>#pj.id_customer#</td>
												<td>#pj.cs_name#</td>
												<td>#pj.agent#</td>
												<td>#pj.zone#</td>
												<td>#LSDATEFORMAT(pj.date,'dd/mm/yyyy')#</td>
												<td>#pj.name_status#</td>
												<td>
													<!--- <cfdump var="#pj.status#"> --->
													<cfloop array="#pj.status#" index="stt">
														<span class="action action-#stt.color#">#stt.char#</span>
													</cfloop>
												</td>
												<td>
													<span class="txt-color-red btndelete" title="Delete project" ng-click="showCase.deleteProject(#pj.id_project#)">
		                    							<i class="ace-icon bigger-130 fa fa-trash-o"></i>
		                    						</span>
												</td>
											</tr>
										</cfloop>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</article>
		</div>
	</section>

	<script type="text/javascript">
		$(document).ready(function() {
			$("##date").datepicker();
			var responsiveHelper_datatable_fixed_column = undefined;

			var breakpointDefinition = {
				tablet : 1024,
				phone : 480
			};

			$("##datatable_fixed_column tbody tr").click(function(){
				$(".highlight").removeClass("highlight");
				$(this).addClass("highlight");
			});


			/* COLUMN FILTER  */
		    var otable = $('##datatable_fixed_column').DataTable({
				// "dom": '<"top"<"clear">>rt<"bottom"iflp<"clear">>',
				// "bFilter": false,
				"autoWidth" : true,
				"bLengthChange": false,
				"info": false,
				"pageLength": 50,
				preDrawCallback : function() {
					// Initialize the responsive datatables helper once.
					if (!responsiveHelper_datatable_fixed_column) {
						responsiveHelper_datatable_fixed_column = new ResponsiveDatatablesHelper($('##datatable_fixed_column'), breakpointDefinition);
					}
				},
				rowCallback : function(nRow) {
					responsiveHelper_datatable_fixed_column.createExpandIcon(nRow);
				},
				drawCallback : function(oSettings) {
					responsiveHelper_datatable_fixed_column.respond();
				}

		    });

		    $("##searchbox").keyup(function() {
			   otable.search( this.value).draw();
			});

		    var colvis = new $.fn.dataTable.ColVis( otable, {
		        buttonText: 'Select columns'
		    } );

		    $('##thShowHideColumnid').append($( colvis.button() ));

		    // Apply the filter
		    $("##datatable_fixed_column thead th input[type=text]").on( 'keyup change', function () {
		        otable
		            .column( $(this).parent().index()+':visible' )
		            .search( this.value )
		            .draw();
		    });

		    $('##datatable_fixed_column tbody').on('dblclick', 'tr', function () {
		        var data = otable.row(this).data();
		        // console.log($(this).children('##id_Project').val());
		        var url = '/index.cfm/project.edit?id=';
			   	// var inputURL = data[0];
			   	var inputURL = $(this).children('##id_Project').val();
			   	window.location.href = url + inputURL;
		    });

		    var arrActionSelect = [];

			$('.label-action').on('click', function () {
				$('.filter-action').toggleClass( "showfilter" );
			})

			$(document).on("click",'.btn-label-close', function (event) {
				var labelSelect = $(this).parent(".actionSelected");
				$('##labelAction-'+labelSelect.attr('value')).css('display','block');
				var item = labelSelect.prop('outerHTML')+ ';;' +labelSelect.attr('value');
				var indexItem = jQuery.inArray( item, arrActionSelect );
				arrActionSelect.splice(indexItem, 1);
				$(this).parent(".actionSelected").remove();
		    	var totalWidth = 0;
		    	$('.actionSelected').each(function (item) {
		    		totalWidth += $(this).width()+3;
		    	})
		    	$('##label-action').width(totalWidth+25);
				searchAction();
			})

			$('label.actionLabel').on('click', function(e) {
			    var currencyAction = $(this);
			    // if(!currencyAction.find('input[type="checkbox"]').is(':checked')){
			    	$(this).css('display','none');
			    	var textAppend = '<label class="actionSelected '+ currencyAction.attr('class').split(' ')[1] +'" value="'+currencyAction.attr('value')+'">'+currencyAction.attr('value')+'<span class="btn-label-close"><i class="glyphicon glyphicon-remove"></i></span></label>';
			    	$('##label-action').html('');
			    	var itemArray = textAppend + ';;' +currencyAction.attr('value');
			    	arrActionSelect.push(itemArray);
			    	textAppend = '';
			    	for (var i = 0; i <= arrActionSelect.length - 1; i++) {
			    		textAppend += arrActionSelect[i].split(';;')[0];
			    	};
			    	$('##label-action').append(textAppend);
			    	var totalWidth = 0;
			    	$('.actionSelected').each(function (item) {
			    		totalWidth += $(this).width()+3;
			    	})
			    	$('##label-action').width(totalWidth+25);
			    // }
			   	searchAction();
			})

			function searchAction () {
				$('.filter-action').removeClass( "showfilter" );
				var textSearch = "";
				for (var i = 0; i <= arrActionSelect.length - 1; i++) {
		    		textSearch = textSearch + ' '+ arrActionSelect[i].split(';;')[1];
		    	};
				otable.column( '8:visible' ).search(textSearch).draw();
			}

			// .on('change', 'input', function(e) {
			// 	// alert('change');
			//     e.stopPropagation();
			// }).on('click', 'input', function(e) {
			// 	// alert('click');
			//     e.stopPropagation();
			// });

			// $("label.actionLabel input[type=checkbox]").change(function() {
			// 	// console.log($(this).is(':checked'));
			// 	if($(this).is(':checked')){
			// 		// alert("ghjgdfhdfghd");
			//         $(this).attr('checked', false);
			// 	}
			// 	if(!$(this).is(':checked')){
			// 		$(this).parent().css('display','none');
			//     	$('##label-action').append($(this).parent().attr('value'));
			//     	$(this).attr('checked', true);
			// 	}
			// });
		});
	</script>

	<script src="/includes/js/angular-datatables.min.js"></script>
	<script src="/includes/js/angular-datatables.columnfilter.min.js"></script>
	<script src="/includes/js/views/project.list.js"></script>

 </cfoutput>


<style type="text/css">

	.dataTables_filter{
		display: none;
	}

	.select2-container-multi .select2-choices .select2-search-field input{
		font-size: 13px;
	}

	.label-action{
		display: block;
		background: #fff;
		font-size: 13px;
		color: #ccc;
		border: 1px solid #ccc;
		height: 32px;
	    padding: 6px 12px;
	    margin-bottom: 0px;
	    min-width: 175px;
	}

	.modal-dialog{
		width: 800px;
	}

	.filter-action{
		position: relative;
		width: 100%;
		display: none;
	}

	.filter-action.showfilter{
		display: block;
		z-index: 100;
	}

	.content-filter-action{
		position: absolute;
		width: 100%;
		background: #fff;
	}

	.filter-action .actionLabel{
	  	color: #fff;
	  	padding-left: 20px;
	  	line-height: 23px;
	  	font-weight: bold;
	  	display: block;
	  	margin-top: 3px;
	}

	table.dataTable thead>tr>th input[type="checkbox"]{
		display: inline-block;
		width: auto !important;
		margin-left: -15px;
	}

	.filter-action .checkbox-inline+.checkbox-inline{
		margin-left: 0px;
	}


	.btn-label-close{
		position: relative;
	    display: inline-block;
	    padding: 2px 4px;
	    background: rgba(0,0,0,.15);
	    margin-left: 4px;
	}

	.btn-label-close:hover{
		cursor: pointer;
	}

	label.actionSelected {
	    padding-left: 4px;
	    margin-bottom: 0px;
	    font-size: 10px;
	    font-weight: bold;
	    color: #fff;
	    margin-right: 2px;
	}
</style>