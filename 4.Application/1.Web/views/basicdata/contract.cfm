<style type="text/css">
	.select2-container{
		width:100%;
	}
</style>
<section id="widget-grid" class="" ng-app='contract.List' ng-controller="BindAngularDirectiveCtrl as showCase">
	<div class="row">

		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i> </span>
					<h2>Contract</h2>

				</header>

				<!-- widget div-->
				<div>
					<!-- widget content -->
					<div class="widget-body" >
						<div class="row">
							<div class="modal fade" id="addNewContract" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-body">
											<legend class="fcollapsible" id="titleID">Create</legend>
											<div class="fcontent">
												<form class="form-horizontal" name="userForm" ng-submit="showCase.submitForm()" novalidate>
													<input type="hidden" id="id_Contract" value="0">
													<div class="form-group" ng-class="{'has-error':userForm.startdate.$invalid && !userForm.startdate.$pristine}">
				                                        <label class="col-md-3 control-label text-left">Start Date</label>
				                                        <div class="col-md-7">
				                                            <input class="form-control" placeholder="" type="text" name="startdate" id="startdate" ng-model="showCase.user.startDate" required>
			                                                <p ng-show="userForm.startdate.$error.required && !userForm.startdate.$pristine" class="help-block">Start Date is required</p>
				                                        </div>
				                                    </div>
				                                    <div class="form-group" ng-class="{'has-error':userForm.noofyear.$invalid && !userForm.noofyear.$pristine}">
				                                        <label class="col-md-3 control-label text-left">No of Years</label>
				                                        <div class="col-md-7">
				                                            <input class="form-control" placeholder="" type="text" name="noofyear" id="noofyear" ng-pattern="showCase.regexNumber" ng-model="showCase.user.noofyear" required>
			                                                <p ng-show="userForm.noofyear.$error.required && !userForm.noofyear.$pristine" class="help-block">No of years is required</p>
			                                                <p ng-show="userForm.noofyear.$error.pattern && !userForm.noofyear.$pristine" class="help-block">please, enter number format</p>
				                                        </div>
				                                    </div>
				                                    <div class="form-group" ng-class="{'has-error':userForm.increaseYear.$invalid && !userForm.increaseYear.$pristine}">
				                                        <label class="col-md-3 control-label text-left">Increase each Year</label>
				                                        <div class="col-md-7">
				                                            <input class="form-control" placeholder="" type="text" name="increaseYear" id="increaseYear" ng-model="showCase.user.increaseYear" ng-pattern="showCase.regexNumber" required>
			                                                <p ng-show="userForm.increaseYear.$error.required && !userForm.increaseYear.$pristine" class="help-block">Increase each year is required</p>
			                                                 <p ng-show="userForm.increaseYear.$error.pattern && !userForm.increaseYear.$pristine" class="help-block">please, enter number format</p>
				                                        </div>
				                                    </div>
													<div class="form-group">
														<label class="control-label col-md-3 text-left">Zone</label>
														<div class="col-md-7">
															<select ui-select2 id="zone" name='zone' ng-model="showCase.user.zone" required>
																<option value="">Choose Zone</option>
																<option ng-repeat="zone in showCase.zones" value="{{zone.ID}}">{{zone.DES}}</option>
															</select>
														</div>
													</div>
													<div class="form-group">
														<label class="control-label col-md-3 text-left">Agent</label>
														<div class="col-md-7">
															<select ui-select2 id="agent" name='agent' ng-model="showCase.user.agent" required>
																<option value="">Choose Agent</option>
																<option ng-repeat="agent in showCase.agents" value="{{agent.ID}}">{{agent.DES}}</option>
															</select>
														</div>
													</div>
													<div class="form-group">
														<label class="control-label col-md-3 text-left">Customer</label>
														<div class="col-md-7">
															<select ui-select2 id="customer" name='customer' ng-model="showCase.user.customer" required>
																<option value="">Choose Customer</option>
																<option ng-repeat="customer in showCase.customers" value="{{customer.ID}}">{{customer.NAME}}</option>
															</select>
														</div>
													</div>
													<div class="form-group text-center">
														<div class="col-md-12">
															<div class="btn bg-color-blueDark txt-color-white" id="btnAddRow"  ng-click="showCase.addEditContract()" ng-disabled="userForm.$invalid">
																<i class="fa fa-save"></i>
																&nbsp;Add/Update
															</div>
															<div class="btn btn-default" id="btnRefresh" ng-click="showCase.refresh()">
																<i class="fa fa-refresh"></i>
																&nbsp;Refresh
															</div>
														</div>
													</div>
												</form>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="row width-table-content">
								<fieldset>
									<div class="col-md-10"><legend class="fcollapsible">Contract List</legend></div>
									<div class="btn col-md-2 bg-color-blueDark txt-color-white" id="btnAddNew" ng-click="showCase.showAddNew()">
                                        <i class="fa fa-save"></i>&nbsp;Create
                                    </div>

									<div class="fcontent">
										<table id="mytable" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptions" dt-columns="showCase.dtColumns" dt-instance="showCase.dtInstance">
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
	<div class="modal fade" id="showDelete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
        <div class="modal-dialog" id="modalForm">
            <div class="modal-content">
                <div class="modal-header alert-info">
                    <h3 class="modal-title" id="myModalLabel">Are you sure you want to delete this Contract?</h3>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                    <button type="submit" id="butsubmit" class="btn btn-info" ng-click="showCase.deleteContract()">Yes</button>
                </div>
            </div>
        </div>
    </div>
</section>
<script src="/includes/js/jquery.dataTables.min.js"></script>
<script src="/includes/js/angular-datatables.min.js"></script>
<script src="/includes/js/dataTables.lightColumnFilter.min.js"></script>
<script src="/includes/js/angular-datatables.light-columnfilter.min.js"></script>
<script src="/includes/js/views/contract.js"></script>
<script type="text/javascript">
	$("#startdate").datepicker({
      changeMonth: true,
      changeYear: true,
      dateFormat: "dd/mm/yy"
    });
</script>