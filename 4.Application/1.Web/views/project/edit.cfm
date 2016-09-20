<!--- #structKeyExists(URL,"id")?'':randId# --->
<cfoutput>
	<!--- <cfset randId = "">
	<cfif !structKeyExists(URL,"id")>
		<cfset randId ="pj"&"-"&RandRange(1,99999, "SHA1PRNG")>
	</cfif> --->
	<style>
		.select2-container{
			width:100%;
		}
	</style>
	<section id="widget-grid" class="" ng-app="project" ng-controller="BindAngularDirectiveCtrl as showCase" ng-cloak>
		<div class="row">
			<article class="col-sm-12 col-md-12 col-lg-12">

				<!-- Widget ID (each widget will need unique ID)-->
				<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
					<header>
						<span class="widget-icon"> <i class="fa fa-check"></i> </span>
						<h2> Project Information </h2>
					</header>
					<div>
						<div class="jarviswidget-editbox">
						</div>
						<div class="widget-body">
							<div class="form-horizontal" >
								<div class="row">
									<div class="col-md-8 col-sm-8 col-xs-12">
										<fieldset>
											<legend class="fcollapsible">General</legend>
											<div class="fcontent">
												<form class="form-horizontal col-md-12" name="userForm" ng-submit="showCase.submitForm()" novalidate>
													<input type='hidden' name="id_Project" id="id_Project" value="0">
													<div class="row">
														<div class="col-md-4">
															<div class="form-group">
						                                        <label class="control-label col-sm-3 text-left" style="padding-left: 0px !important;">Project</label>
						                                        <div class="col-sm-9">
						                                            <input class="form-control" readonly placeholder="" type="text" name="display" id="display" ng-model="showCase.user.display" ng-pattern="showCase.regex"  required>
						                                        </div>
						                                    </div>
														</div>
														<div class="col-md-4">
															<div class="form-group">
														    	<label class="control-label col-sm-3 text-left" style="padding-left: 0px !important;">Date</label>
														    	<div class="col-sm-9" ng-class="{'has-error':userForm.date.$invalid && !userForm.date.$pristine}">
														    		<input class="form-control" placeholder="" type="text" name="date" id="date" ng-model="showCase.user.date">
					                                                <p ng-show="userForm.date.$error.required && !userForm.date.$pristine" class="help-block">Date is required</p>
					                                                <p ng-show="userForm.date.$error.pattern  && !userForm.date.$pristine" class="help-block">Can not enter special char</p>
														    	</div>
														  	</div>
														</div>
														<div class="col-md-4">
															<div class="form-group">
														    	<label class="control-label col-sm-3 text-left" style="padding-left: 0px !important;">Status</label>
														    	<div class="col-sm-9" ng-class="{'has-error':userForm.status.$invalid && !userForm.status.$pristine}">
														    		<select ui-select2 id="status" name="status" ng-model="showCase.user.statusID" required>
																		<option value="">Choose</option>
																		<option ng-repeat="sta in showCase.status" value="{{sta.id_pj_Status}}">{{sta.pj_stat_desc}}</option>
																	</select>
																	<p ng-show="userForm.status.$invalid && !userForm.status.$pristine" class="help-block">Please choose status</p>
														    	</div>
														  	</div>
														</div>
													</div>
													<div class="row">
														<div class="col-md-4">
															<div class="form-group">
														    	<label class="control-label col-sm-3 text-left" style="padding-left: 0px !important;">Zone</label>
														    	<div class="col-sm-9">
														    		<input class="form-control" readonly placeholder="" type="text" name="zone" id="zone" ng-model="showCase.user.zone">
													    		</div>
												    		</div>
												    		<div class="row">
														    	<label class="control-label col-sm-3 text-left" style="padding-left: 0px !important;">Description</label>
														    	<div class="col-sm-9">
														    		<input class="form-control" placeholder="" type="agent" name="agent" id="agent" ng-model="showCase.user.z_des" readonly>
														    	</div>
														    </div>
														</div>
														<div class="col-md-4">
															<div class="form-group">
														    	<label class="control-label col-sm-3 text-left" style="padding-left: 0px !important;">Agent</label>
														    	<div class="col-sm-9">
														    		<input class="form-control" placeholder="" type="agent" name="agent" id="agent" ng-model="showCase.user.agent" readonly>
														    	</div>
														    </div>
														    <div class="row">
														    	<label class="control-label col-sm-3 text-left" style="padding-left: 0px !important;">Description</label>
														    	<div class="col-sm-9">
														    		<input class="form-control" placeholder="" type="agent" name="agent" id="agent" ng-model="showCase.user.ag_des" readonly>
														    	</div>
														    </div>
														</div>
														<div class="col-md-4">
															<div class="form-group" ng-class="{'has-error':userForm.customer.$invalid && !userForm.customer.$pristine}">
						                                        <label class="control-label col-sm-3 text-left" style="padding-left: 0px !important;">Customer</label>
						                                        <div class="col-sm-9">
						                                        	<select ui-select2 id="customer" name="customer" ng-model="showCase.user.customerID"  required>
																		<option value="">Choose Customer</option>
																		<option ng-repeat="cus in showCase.customers" value="{{cus.ID}}">{{cus.NAME}}</option>
																	</select>
																	<p ng-show="userForm.customer.$invalid && !userForm.customer.$pristine" class="help-block">Please choose customer</p>
						                                        </div>
						                                    </div>
														</div>
													</div>
													<div class="form-group" style="margin-top:7px;">
														<div class="col-md-12">
															<div class="form-group" ng-class="{'has-error':userForm.description.$invalid && !userForm.description.$pristine}">
						                                        <label class="control-label col-sm-2 text-left" style="padding-left: 0px !important;">Description</label>
						                                        <div class="col-sm-10">
						                                        	<textarea name="pro_des" id="pro_des" class="form-control" placeholder="Project Description" name="description" id="description" ng-model="showCase.user.description" required></textarea>
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
													<div class="form-group">
														<div class="col-md-12 text-center" style="margin-top:5px;">
															<div class="btn bg-color-blueDark txt-color-white" id="save_order" ng-disabled="userForm.$invalid" ng-click="showCase.addRow()">
																<i class="fa fa-save"></i>
																&nbsp;Save
															</div>
														</div>
													</div>
												</form>
											</div>
										</fieldset>
									</div>
									<div class="col-md-4 col-sm-4 col-xs-12">
										<fieldset>
											<legend class="fcollapsible">Project Comment Information</legend>
											<div class="fcontent">
												<form id="commentForm" name="commentForm" class="form-horizontal col-md-12" ng-submit="showCase.submitForm()" novalidate>
													<input type='hidden' name="id_Comment" id="id_Comment" value="0">
													<div class="form-group">
														<div class="col-md-12">
														    <textarea class="form-control" rows="1" placeholder="" name="commentContent" id="commentContent" ng-model="showCase.comment.commentContent" required></textarea>
					                                        <p ng-show="commentForm.commentContent.$error.required && !commentForm.commentContent.$pristine" class="help-block">Description is required</p>
														</div>
													</div>
													<div class="form-group">
														<div class="col-md-1">
															<div class="btn bg-color-blueDark txt-color-white" id="btnAddComment" ng-disabled="commentForm.$invalid" ng-click="showCase.addRowComment()" style="">
																comment
															</div>
														</div>
														<div class="col-md-4 col-md-offset-7">
															<input type="date" class="form-control" name="todayComment" id="todayComment" ng-model="showCase.comment.todaycomment" readonly required/>
														</div>
													</div>
													<div id="table_comment" class="row" style="margin-top:10px;">
														<table class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptions" dt-columns="showCase.dtColumns" dt-instance="showCase.dtInstance">
				                                        </table>
													</div>
												</form>
											</div>
										</fieldset>
									</div>
								</div>
								<div class="row" style="padding:0px 15px;">
									<fieldset>
										<legend class="fcollapsible">Project Product List</legend>
										<div class="fcontent">
											<div class="table-responsive">
												<table class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.pddtOptions" dt-columns="showCase.pddtColumns" dt-instance="showCase.pddtInstance">
			                                    </table>
											</div>
										</div>
									</fieldset>
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

	<script type="text/javascript">
		$(document).ready(function() {
			$("##date").datepicker();
			var queryString = window.location.search;
			if(queryString){
				$('##id_Project').val(queryString.slice(4));
			}

			var responsiveHelper_datatable_fixed_column_1 = undefined;
			var responsiveHelper_datatable_fixed_column_2 = undefined;
			var breakpointDefinition = {
				tablet : 1024,
				phone : 480
			};

			/* COLUMN FILTER  */
		    var otable_1 = $('##datatable_fixed_column_1').DataTable({
				"sDom": "<'dt-toolbar'<'col-xs-12 col-sm-6 hidden-xs'f><'col-sm-6 col-xs-12 hidden-xs'C>r>"+
						"t"+
						"<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-xs-12 col-sm-6'p>>",
				"autoWidth" : true,
				"preDrawCallback" : function() {
					// Initialize the responsive datatables helper once.
					if (!responsiveHelper_datatable_fixed_column_1) {
						responsiveHelper_datatable_fixed_column_1 = new ResponsiveDatatablesHelper($('##datatable_fixed_column_1'), breakpointDefinition);
					}
				},
				"rowCallback" : function(nRow) {
					responsiveHelper_datatable_fixed_column_1.createExpandIcon(nRow);
				},
				"drawCallback" : function(oSettings) {
					responsiveHelper_datatable_fixed_column_1.respond();
				}

		    });

		    var otable_2 = $('##datatable_fixed_column_2').DataTable({
				"sDom": "<'dt-toolbar'<'col-xs-12 col-sm-6 hidden-xs'f><'col-sm-6 col-xs-12 hidden-xs'C>r>"+
						"t"+
						"<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-xs-12 col-sm-6'p>>",
				"autoWidth" : true,
				"preDrawCallback" : function() {
					// Initialize the responsive datatables helper once.
					if (!responsiveHelper_datatable_fixed_column_2) {
						responsiveHelper_datatable_fixed_column_2 = new ResponsiveDatatablesHelper($('##datatable_fixed_column_2'), breakpointDefinition);
					}
				},
				"rowCallback" : function(nRow) {
					responsiveHelper_datatable_fixed_column_2.createExpandIcon(nRow);
				},
				"drawCallback" : function(oSettings) {
					responsiveHelper_datatable_fixed_column_2.respond();
				}

		    });

		    // Apply the filter
		    $("##datatable_fixed_column_1 thead th input[type=text]").on( 'keyup change', function () {

		    	if ($(this).val().length < 3)	return false;
		        otable_1
		            .column( $(this).parent().index()+':visible' )
		            .search( this.value )
		            .draw();

		    } );

		    $("##datatable_fixed_column_2 thead th input[type=text]").on( 'keyup change', function () {

		    	if ($(this).val().length < 3)	return false;
		        otable_2
		            .column( $(this).parent().index()+':visible' )
		            .search( this.value )
		            .draw();

		    } );

		    $('##addProjectProduct').on( 'click', function () {
		        otable_1.row.add( [
		            $('##productName').val(),
		            $('##productGarmentCode').val(),
		            $('##productVersion').val(),
		            $('##productCostCode').val(),
		            $('##productCostCodeVers').val(),
		            $('##productStatus').val(),
		            $('##productDescription').val(),
		            '<img class="img-responsive" src="/includes/img/ao/images.jpg">',
		            '<span class="txt-color-green report" href="javascript:void(0)" title="Edit"><i class="ace-icon bigger-130 fa fa-pencil"></i></span><span class="txt-color-red btnDelete" title="Delete"><i class="ace-icon bigger-130 fa fa-trash-o"></i></span>'
		        ] ).draw( false );

		        resetProjectProductForm();
		    } );

			function resetProjectProductForm () {
				$('##productName').val('');
	            $('##productGarmentCode').val('');
	            $('##productVersion').val('');
	            $('##productCostCode').val('');
	            $('##productCostCodeVers').val('');
	            $('##productStatus').val('');
	            $('##productDescription').val('');
			}

		    // $('##btnAddComment').on( 'click', function () {
		    //     otable_2.row.add( [
		    //         $('##commentDate').val(),
		    //         $('##commentUser').val(),
		    //         $('##commentContent').val().replace(/\r\n|\r|\n/g,"<br />"),
		    //         '<span class="txt-color-green report" href="javascript:void(0)" title="Edit"><i class="ace-icon bigger-130 fa fa-pencil"></i></span><span class="txt-color-red btnDelete" title="Delete"><i class="ace-icon bigger-130 fa fa-trash-o"></i></span>'
		    //     ] ).draw( false );

		    //     $('##commentDate').val('');
		    //     $('##commentUser').val('');
		    //     $('##commentContent').val('');
		    // } );

		    $("##datatable_fixed_column_2").on( 'click', '.btnDelete', function () {
		        otable_2.row( $(this).parents('tr') )
				        .remove()
				        .draw();
		    } );
		});
	</script>
<script src="/includes/js/angular-datatables.min.js"></script>
<script src="/includes/js/angular-datatables.columnfilter.min.js"></script>
<script src="/includes/js/views/project.js"></script>

</cfoutput>
<style type="text/css">
#table_comment .dt-toolbar,#table_comment .dt-toolbar-footer{
	display:none;
}

#table_comment{
	background-color: white;
}

.well{
	padding: 5px;
}
</style>