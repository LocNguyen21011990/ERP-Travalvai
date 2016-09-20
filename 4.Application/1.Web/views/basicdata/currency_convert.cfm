<style type="text/css">
.select2-container{
	width: 200px;
}
</style>
<section id="widget-grid" class="" ng-app="currency_convert.List" ng-controller="BindAngularDirectiveCtrl as showCase" ng-cloak>
	<!-- row -->
	<div class="row">

		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i> </span>
					<h2>Currency Convert</h2>

				</header>

				<!-- widget div-->
				<div>
					<!-- widget content -->
					<div class="widget-body">
						
						<div class="row">
							<div class="col-md-6">
								<legend class="fcollapsible">Currency Convert Detail</legend>
								<div class="fcontent">
									<form class="form-horizontal" name="userForm" ng-submit="showCase.submitForm()" novalidate>
										<input type='hidden' name="id_Convert" id="id_Convert" value="0">
										<div class="form-group" ng-class="{'has-error':userForm.currency.$invalid && !userForm.currency.$pristine}">
											<label class="control-label col-md-3 text-left">Currency</label>
											<div class="col-md-9">
												<!--- <select ui-select2 id="currency" name="currency" ng-model="showCase.user.currencyID" ng-options="lang.id_currency as lang.curr_code for lang in showCase.currencies" required>
													
												</select>
												<p ng-show="userForm.currency.$invalid && !userForm.currency.$pristine" class="help-block">Please choose currency</p> --->


												<!--- <select ui-select2 ng-model="select2" data-placeholder="Pick a number">
												    <option value=""></option>
												    <option value="one">First</option>
												    <option value="two">Second</option>
												    <option value="three">Third</option>
												</select> --->

												<select ui-select2 id="currency" name="currency" ng-model="showCase.user.currencyID" data-placeholder="Choose" ng-required="true">
												    <option ng-repeat="lang in showCase.currencies" value="{{lang.id_currency}}">{{lang.curr_code}}</option>
												</select>
											</div>
										</div>

										<div class="form-group" ng-class="{'has-error':userForm.date.$invalid && !userForm.date.$pristine}">
	                                        <label class="col-md-3 control-label text-left">Date</label>
	                                        <div class="col-md-9">
	                                            <input class="form-control" type="date" id="date" ng-model="showCase.user.date" required>
	                                                <p ng-show="userForm.date.$error.required && !userForm.date.$pristine" class="help-block">Date is required</p>
	                                                <p ng-show="userForm.date.$error.pattern  && !userForm.date.$pristine" class="help-block">Can not enter special char</p>
	                                        </div>
	                                    </div>
	                                    <div class="form-group" ng-class="{'has-error':userForm.convention.$invalid && !userForm.convention.$pristine}">
	                                        <label class="col-md-3 control-label text-left">Conversion</label>
	                                        <div class="col-md-9">
	                                            <input class="form-control" placeholder="" type="text" name="convention" id="convention" ng-model="showCase.user.convention" ng-pattern="showCase.regex"  required>
	                                                <p ng-show="userForm.convention.$error.required && !userForm.convention.$pristine" class="help-block">Convention is required</p>
	                                                <p ng-show="userForm.convention.$error.pattern  && !userForm.convention.$pristine" class="help-block">Can not enter special char</p>
	                                        </div>
	                                    </div>
										<div class="form-group text-center">
											<div class="btn bg-color-blueDark txt-color-white" id="btnAddRow" ng-disabled="userForm.$invalid" ng-click="showCase.addRow()">
												<i class="fa fa-save"  ></i>
												&nbsp;Add/Update
											</div>
											<div class="btn btn-default" id="btnRefresh" ng-click="showCase.refresh()">
												<i class="fa fa-refresh"></i>
												&nbsp;Refresh
											</div>
										</div>
									</form>
								</div>		
							</div>
							<div class="col-md-6">
								<fieldset>
									<legend class="fcollapsible">Currency Convert List</legend>

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
					<!--- <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">#getLabel('Close')#</span></button> --->
					<h3 class="modal-title" id="myModalLabel">Are you sure you want to delete this item?</h3>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">No</button>
					<button type="submit" id="butsubmit" class="btn btn-info" ng-click="showCase.deleteUser()">Yes</button>
				</div>
			</div>
		</div>
	</div>
</section>
<script src="/includes/js/jquery.dataTables.min.js"></script>
<script src="/includes/js/angular-datatables.min.js"></script>
<script src="/includes/js/dataTables.lightColumnFilter.min.js"></script>
<script src="/includes/js/angular-datatables.light-columnfilter.min.js"></script>

<script src="/includes/js/views/currency.convert.js"></script>
<script type="text/javascript">
	$(document).on('click','.butTopLand',function(){
		$('#addNew').modal('show');
	});
</script>