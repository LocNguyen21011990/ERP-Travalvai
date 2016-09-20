<section id="widget-grid"  ng-app='size.List' ng-controller="BindAngularDirectiveCtrl as showCase" ng-cloak>
	<!-- row -->
	<div class="row">

		<!-- NEW WIDGET START -->
		<article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i> </span>
					<h2>Sizes</h2>

				</header>

				<!-- widget div-->
				<div>
					<!-- widget content -->
					<div class="widget-body">

						<div class="row">
							<div class="col-md-6">
								<legend class="fcollapsible">Sizes Information</legend>
								<div class="fcontent">
									<form class="form-horizontal" name="sizeForm" ng-submit="showCase.submitForm()" novalidate>
										<input class="form-control" placeholder="" type="hidden" id="sizeId" value="0">

										<div class="form-group" ng-class="{'has-error':sizeForm.sz_des.$invalid && !sizeForm.sz_des.$pristine}">
			                                <label class="col-md-3 control-label text-left">Description</label>
			                                <div class="col-md-5">
			                                    <input class="form-control" placeholder="" type="text" name="sz_des" id="sz_des" ng-model="showCase.size.sz_des" required>
			                                    <p ng-show="sizeForm.sz_des.$error.required && !sizeForm.sz_des.$pristine" class="help-block">Description is required</p>
			                                </div>
			                            </div>
			                            <div class="form-group" ng-class="{'has-error':sizeForm.sz_qtty.$invalid && !sizeForm.sz_qtty.$pristine}">
			                                <label class="col-md-3 control-label text-left">QTTY</label>
			                                <div class="col-md-5">
			                                    <input class="form-control" placeholder="" type="number" name="sz_qtty" id="sz_qtty" ng-model="showCase.size.sz_qtty" required>
			                                    <p ng-show="sizeForm.sz_qtty.$error.required && !sizeForm.sz_qtty.$pristine" class="help-block">Quatity is required</p>
			                                </div>
			                            </div>

										<div class="form-group text-center">
											<button class="btn bg-color-blueDark txt-color-white" id="btnsave" ng-click="showCase.insertData()" ng-disabled="sizeForm.$invalid">
												<i class="fa fa-save"></i>
												&nbsp;Save
											</button>
											<button class="btn btn-default" id="btnRefresh" ng-click="showCase.refresh()">
												<i class="fa fa-refresh"></i>
												&nbsp;Refresh
											</button>
										</div>
									</form>
								</div>
							</div>
							<div class="col-md-6">
								<div class="table-responsive">
                                    <table id="sizesviewTable" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptionsSizesViewTable" dt-columns="showCase.dtColumnsSizesViewTable" dt-instance="showCase.dtInstance">
                                    </table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</article>
	</div>
</section>
<script src="/includes/js/jquery.dataTables.min.js"></script>
<script src="/includes/js/angular-datatables.min.js"></script>
<script src="/includes/js/dataTables.lightColumnFilter.min.js"></script>
<script src="/includes/js/angular-datatables.light-columnfilter.min.js"></script>
<script src="/includes/js/views/size.main.js"></script>