<style type="text/css">
.select2-container {
    width: 100% !important;
}
.modal-lg {
    width: 724px;
}

hr {
	margin: 5px;
}
</style>
<section id="widget-grid" class="" ng-app="order.main" ng-controller="BindAngularDirectiveCtrl as showCase">
	<div class="row">
		<article class="col-sm-12 col-md-12 col-lg-12">
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-check"></i> </span>
					<h2> Order Infomation </h2>
				</header>
				<div>
					<div class="jarviswidget-editbox">
					</div>
					<div class="widget-body">
                        <div class="row">
                            <div class="col-md-12">
	                            <ul id="myTab1" class="nav nav-tabs">
	                                <li class="active">
	                                    <a href="#s1" data-toggle="tab">View</a>
	                                </li>
	                                <li>
	                                    <a href="#s2" data-toggle="tab">Resume</a>
	                                </li>
	                                 <div class="btn col-md-offset-2 bg-color-blueDark  pull-right" id="btnAddNew">
	                                	<a href="/index.cfm/order.create" class="txt-color-white">New Order</a>
	                            	</div>
	                            </ul>	                           
                        	</div>
                        </div>

						<div id="myTabContent1" class="tab-content padding-10">
							<div class="tab-pane fade in active" id="s1">
								<div class="table-responsive">
									<table id="orderviewTable1" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptions1" dt-columns="showCase.dtColumns1" dt-instance="showCase.dtInstance1">
										<tfoot>
											<tr></tr>
										</tfoot>
										
                                    </table>
								</div>
							</div>
							<div class="tab-pane fade" id="s2">
								<div class="table-responsive">
									<table id="datatable_fixed_column_2" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptions2" dt-columns="showCase.dtColumns2" dt-instance="showCase.dtInstance2">
										<tfoot>
											<tr></tr>
										</tfoot>
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
<script src="/includes/js/jquery.dataTables.min.js"></script>
<script src="/includes/js/angular-datatables.min.js"></script>
<script src="/includes/js/dataTables.lightColumnFilter.min.js"></script>
<script src="/includes/js/angular-datatables.light-columnfilter.min.js"></script>
<script src="/includes/js/views/order.main.js"></script>