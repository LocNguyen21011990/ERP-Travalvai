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
<section id="widget-grid" class="" ng-app="order.lines" ng-controller="BindAngularDirectiveCtrl as showCase" ng-cloak>
	<div class="row">
		<article class="col-sm-12 col-md-12 col-lg-12">
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-check"></i> </span>
					<h2> Order Detail Infomation </h2>
				</header>
				<div>
					<div class="jarviswidget-editbox">
					</div>
					<div class="widget-body">
						<fieldset>
							<legend class="fcollapsible">Order Information</legend>
							<div class="fcontent">
								<div class="row">
									<div class="col-md-12 col-xs-12">
										<div class="row">
											<div class="col-md-2 col-xs-12">
												<div class="row">
											    	<label class="control-label col-sm-6 text-left strongFont">ORDER:</label>
											    	<div class="col-sm-6">
											      		{{showCase.order.id_order}}
											    	</div>
											  	</div>
											  	<div class="row">
											    	<label class="control-label col-sm-6 text-left strongFont">DESCRIPTION:</label>
											    	<div class="col-sm-6">
											      		{{showCase.order.ord_description}}
											    	</div>
											  	</div>
											  	<div class="row">
											    	<label class="control-label col-sm-6 text-left strongFont">CUSTOMER No.:</label>
											    	<div class="col-sm-6">
											      		{{showCase.order.id_customer}}
											    	</div>
											  	</div>
											  	<div class="row">
											    	<label class="control-label col-sm-6 text-left strongFont">CUS.NAME:</label>
											    	<div class="col-sm-6">
											      		{{showCase.order.cs_name}}
											    	</div>
											  	</div>
											  	<div class="row">
											    	<label class="control-label col-sm-6 text-left strongFont">AGENT:</label>
											    	<div class="col-sm-6">
											      		{{showCase.order.ag_description}}
											    	</div>
											  	</div>
											  	<div class="row" ng-show="!showCase.isAgent">
											    	<label class="control-label col-sm-6 text-left strongFont">ZONE:</label>
											    	<div class="col-sm-6">
											      		{{showCase.order.z_description}}
											    	</div>
											  	</div>
											</div>
											<div class="col-md-2 col-xs-12">
												<div class="row">
					                                <label class="control-label col-md-6 text-left strongFont">DATE:</label>
					                                <div class="col-md-6">
					                                    {{showCase.order.ord_date}}
					                                </div>
					                            </div>
					                            <div class="row">
					                                <label class="control-label col-md-6 text-left strongFont">ORD.CONDITION:</label>
					                                <div class="col-md-6">
					                                    {{showCase.order.oc_description}}
					                                </div>
					                            </div>
					                            <div class="row">
					                                <label class="control-label col-md-6 text-left strongFont">ORDER TYPE:</label>
					                                <div class="col-md-6">
					                                    {{showCase.order.ot_description}}
					                                </div>
					                            </div>
					                            <div class="row">
					                                <label class="control-label col-md-6 text-left strongFont">STATUS:</label>
					                                <div class="col-md-6">
					                                    {{showCase.order.os_description}}
					                                </div>
					                            </div>
					                            <div class="row">
					                                <label class="control-label col-md-6 text-left strongFont">UNITS:</label>
					                                <div class="col-md-6">
					                                    {{showCase.order.ord_units}}
					                                </div>
					                            </div>
					                            <div class="row">
					                                <label class="control-label col-md-6 text-left strongFont">OFFER:</label>
					                                <div class="col-md-6">
					                                </div>
					                            </div>
											</div>
											<div class="col-md-2 col-xs-12" ng-show="showCase.isAgent">
												<div class="row">
					                                <label class="control-label col-md-6 text-left strongFont">CONFIRM.DATE:</label>
					                                <div class="col-md-6">
					                                    {{showCase.order.ord_zone_confirm}}
					                                </div>
					                            </div>
					                            <div class="row">
					                                <label class="control-label col-md-6 text-left strongFont">RECEIVING DATE:</label>
					                                <div class="col-md-6">
					                                    {{showCase.order.ord_zone_del_date}}
					                                </div>
					                            </div>
					                            <div class="row">
					                                <label class="control-label col-md-6 text-left strongFont">DELIVERY DATE:</label>
					                                <div class="col-md-6">
					                                    {{showCase.order.ord_ag_del_date}}
					                                </div>
					                            </div>
					                            <div class="row">
					                                <label class="control-label col-md-6 text-left strongFont">PRICE LIST:</label>
					                                <div class="col-md-6">
					                                    {{showCase.order.ord_plz}}
					                                </div>
					                            </div>
					                            <div class="row">
					                                <label class="control-label col-md-6 text-left strongFont">PAYMENT:</label>
					                                <div class="col-md-6">
					                                    {{showCase.order.pm_description}}
					                                </div>
					                            </div>
											</div>
											<div class="col-md-2 col-xs-12" ng-show="showCase.isAgent">
												<div class="row">
					                                <label class="control-label col-md-6 text-left strongFont">PAYMENT:</label>
					                                <div class="col-md-6">
					                                    {{showCase.order.pm_description}}
					                                </div>
					                            </div>
					                            <div class="row">
					                                <label class="control-label col-md-6 text-left strongFont">RECEIVED:</label>
					                                <div class="col-md-6">
					                                    {{showCase.order.ord_zone_delivered}}
					                                </div>
					                            </div>
					                            <div class="row">
					                                <label class="control-label col-md-6 text-left strongFont">TO RECEIVE:</label>
					                                <div class="col-md-6">
					                                    {{}}
					                                </div>
					                            </div>
					                            <div class="row">
					                                <label class="control-label col-md-6 text-left strongFont">DELIVERED:</label>
					                                <div class="col-md-6">
					                                    {{showCase.order.ord_ag_delivered}}
					                                </div>
					                            </div>
					                            <div class="row">
					                                <label class="control-label col-md-6 text-left strongFont">TO DELIVERY:</label>
					                                <div class="col-md-6">
					                                    
					                                </div>
					                            </div>
											</div>
											<div class="col-md-2 col-xs-12" ng-show="showCase.isAgent">
												<div class="row">
					                                <label class="control-label col-md-6 text-left strongFont">VALUE:</label>
					                                <div class="col-md-6">
					                                    {{showCase.order.ord_ag_value}}
					                                </div>
					                            </div>
					                            <div class="row">
					                                <label class="control-label col-md-6 text-left strongFont">DISCOUNT 1:</label>
					                                <div class="col-md-6">
					                                    {{showCase.order.ord_discount_1}}
					                                </div>
					                            </div>
					                            <div class="row">
					                                <label class="control-label col-md-6 text-left strongFont">VALUE DISC 1:</label>
					                                <div class="col-md-6">
					                                    {{showCase.order.ord_ag_value * 1 * showCase.order.ord_discount_1 / 100}}
					                                </div>
					                            </div>
					                            <div class="row">
					                                <label class="control-label col-md-6 text-left strongFont">REMAIN DISC 1:</label>
					                                <div class="col-md-6">
					                                    {{showCase.order.ord_ag_value_disc1}}
					                                </div>
					                            </div>
					                            <div class="row">
					                                <label class="control-label col-md-6 text-left strongFont">DISCOUNT 2:</label>
					                                <div class="col-md-6">
					                                    {{showCase.order.ord_discount_2}}
					                                </div>
					                            </div>
					                            <div class="row">
					                                <label class="control-label col-md-6 text-left strongFont">VALUE DISC 2:</label>
					                                <div class="col-md-6">
					                                    {{showCase.order.ord_ag_value_disc1 * 1 * showCase.order.ord_discount_2 / 100}}
					                                </div>
					                            </div>
					                            <div class="row">
					                                <label class="control-label col-md-6 text-left strongFont">REMAIN DISC 2:</label>
					                                <div class="col-md-6">
					                                    {{showCase.order.ord_ag_value_disc2}}
					                                </div>
					                            </div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</fieldset>
						<fieldset  ng-show="!showCase.isAgent">
							<legend class="fcollapsible">LINE BY LINE</legend>
							<div class="fcontent">
								<div class="row">
									<div class="col-md-2 col-xs-12 {{showCase.classHideForZone}}">
										<div class="row">
									    	<label class="control-label col-sm-6 text-left strongFont">CONFIRM.DATE:</label>
									    	<div class="col-sm-6">
									      		{{showCase.order.ord_fty_confirm}}
									    	</div>
									  	</div>
									  	<div class="row">
									    	<label class="control-label col-sm-6 text-left strongFont">DELIVERY DATE:</label>
									    	<div class="col-sm-6">
									      		{{showCase.order.ord_fty_del_date}}
									    	</div>
									  	</div>
									  	<div class="row">
									    	<label class="control-label col-sm-6 text-left strongFont">PRICE LIST:</label>
									    	<div class="col-sm-6">
									      		{{showCase.order.ord_plf}}
									    	</div>
									  	</div>
									  	<div class="row">
									    	<label class="control-label col-sm-6 text-left strongFont">VALUE:</label>
									    	<div class="col-sm-6">
									      		{{showCase.order.ord_fty_value}}
									    	</div>
									  	</div>
									  	<div class="row">
									    	<label class="control-label col-sm-6 text-left strongFont">DELIVERED:</label>
									    	<div class="col-sm-6">
									      		{{showCase.order.ord_fty_delivered}}
									    	</div>
									  	</div>
									  	<div class="row">
									    	<label class="control-label col-sm-6 text-left strongFont">TO DELIVERY:</label>
									    	<div class="col-sm-6">
									      		CALC
									    	</div>
									  	</div>
									</div>
									<div ng-show="!showCase.isAgent" class="col-md-2 col-xs-12">
										<div class="row">
									    	<label class="control-label col-sm-6 text-left strongFont">CONFIRM.DATE:</label>
									    	<div class="col-sm-6">
									      		{{showCase.order.ord_zone_confirm}}
									    	</div>
									  	</div>
									  	<div class="row">
									    	<label class="control-label col-sm-6 text-left strongFont">DELIVERY DATE:</label>
									    	<div class="col-sm-6">
									      		{{showCase.order.ord_zone_del_date}}
									    	</div>
									  	</div>
									  	<div class="row">
									    	<label class="control-label col-sm-6 text-left strongFont">VALUE:</label>
									    	<div class="col-sm-6">
									      		{{showCase.order.ord_zone_value}}
									    	</div>
									  	</div>
									  	<div class="row">
									    	<label class="control-label col-sm-6 text-left strongFont">DELIVERED:</label>
									    	<div class="col-sm-6">
									      		{{showCase.order.ord_zone_delivered}}
									    	</div>
									  	</div>
									  	<div class="row">
									    	<label class="control-label col-sm-6 text-left strongFont">TO DELIVERY:</label>
									    	<div class="col-sm-6">
									      		
									    	</div>
									  	</div>
									</div>
									<div ng-show="!showCase.isAgent" class="col-md-2 col-xs-12">
										<div class="row">
									    	<label class="control-label col-sm-6 text-left strongFont">DATE:</label>
									    	<div class="col-sm-6">
									      		{{showCase.order.ord_date}}
									    	</div>
									  	</div>
									  	<div class="row">
									    	<label class="control-label col-sm-6 text-left strongFont">DELIVERY DATE:</label>
									    	<div class="col-sm-6">
									      		{{showCase.order.ord_ag_del_date}}
									    	</div>
									  	</div>
									  	<div class="row">
									    	<label class="control-label col-sm-6 text-left strongFont">PRICE LIST:</label>
									    	<div class="col-sm-6">
									      		{{showCase.order.ord_plz}}
									    	</div>
									  	</div>
									  	<div class="row">
									    	<label class="control-label col-sm-6 text-left strongFont">PAYMENT:</label>
									    	<div class="col-sm-6">
									      		{{showCase.order.pm_description}}
									    	</div>
									  	</div>
									  	<div class="row">
									    	<label class="control-label col-sm-6 text-left strongFont">DELIVERED:</label>
									    	<div class="col-sm-6">
									      		{{showCase.order.ord_ag_delivered}}
									    	</div>
									  	</div>
									  	<div class="row">
									    	<label class="control-label col-sm-6 text-left strongFont">TO DELIVERY:</label>
									    	<div class="col-sm-6">
									      		CALC
									    	</div>
									  	</div>
									</div>
									<div ng-show="!showCase.isAgent" class="col-md-2 col-xs-12">
										<div class="row">
									    	<label class="control-label col-sm-6 text-left strongFont">VALUE:</label>
									    	<div class="col-sm-6">
									      		{{showCase.order.ord_ag_value}}
									    	</div>
									  	</div>
									  	<div class="row">
									    	<label class="control-label col-sm-6 text-left strongFont">DISCOUNT 1:</label>
									    	<div class="col-sm-6">
									      		{{showCase.order.ord_discount_1}}
									    	</div>
									  	</div>
									  	<div class="row">
									    	<label class="control-label col-sm-6 text-left strongFont">VALUE DISC 1:</label>
									    	<div class="col-sm-6">
									      		{{showCase.order.ord_ag_value * 1 * showCase.order.ord_discount_1 / 100}}
									    	</div>
									  	</div>
									  	<div class="row">
									    	<label class="control-label col-sm-6 text-left strongFont">REMAIN DISC 1:</label>
									    	<div class="col-sm-6">
									      		{{showCase.order.ord_ag_value_dsc1}}
									    	</div>
									  	</div>
									  	<div class="row">
									    	<label class="control-label col-sm-6 text-left strongFont">DISCOUNT 2:</label>
									    	<div class="col-sm-6">
									      		{{showCase.order.ord_discount_2}}
									    	</div>
									  	</div>
									  	<div class="row">
									    	<label class="control-label col-sm-6 text-left strongFont">VALUE DISC 2:</label>
									    	<div class="col-sm-6">
									      		{{showCase.order.ord_ag_value_dsc1 * 1 * showCase.order.ord_discount_2 / 100}}
									    	</div>
									  	</div>
									  	<div class="row">
									    	<label class="control-label col-sm-6 text-left strongFont">REMAIN DISC 2:</label>
									    	<div class="col-sm-6">
									      		{{showCase.order.ord_ag_value_dsc2}}
									    	</div>
									  	</div>
									</div>
								</div>
							</div>
						</fieldset>
						<fieldset>
							<div class="table-responsive">
								<table id="orderDetailsTable" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptions1" dt-columns="showCase.dtColumns1" dt-instance="showCase.dtInstance1">
									<tfoot>
										<tr></tr>
									</tfoot>
									
                                </table>
							</div>
						</fieldset>
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
<script src="/includes/js/views/order.lines.js"></script>