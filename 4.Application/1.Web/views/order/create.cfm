<style type="text/css">
	.select2-container{
		width:100%;
	}
</style>
<section id="widget-grid" class="" ng-app="order.create" ng-controller="BindAngularDirectiveCtrl as showCase" ng-cloak>
	<div class="row">
		<article class="col-sm-12 col-md-12 col-lg-12">

			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-check"></i> </span>
					<h2> Order Information </h2>
				</header>
				<div>
					<!-- widget edit box -->
					<div class="jarviswidget-editbox">
						<!-- This area used as dropdown edit box -->
					</div>
					<div class="widget-body">
						<form class="form-horizontal col-md-12" name="userForm" ng-submit="showCase.submitForm()" role="form" id="order_infomation" style="background-color:white;" novalidate>
							<fieldset>
								<legend class="fcollapsible"></legend>
								<div class="fcontent">
									<div class="row">
										<!--- !!!!!!!!!!!!!!!!!! --->
										<div class="col-md-3">
											<div class="form-group">
										    	<label class="control-label col-md-5 text-left">Order</label>
										    	<div class="col-md-7">
										      		<input type="text" class="form-control" id="id_order" name="id_order" ng-model="showCase.order.id_order" placeholder="" disabled>
										    	</div>
										  	</div>
										  	<div class="form-group" ng-class="{'has-error':userForm.ord_description.$invalid && !userForm.ord_description.$pristine}">
										    	<label class="control-label col-md-5 text-left">Description</label>
										    	<div class="col-md-7">
										      		<input type="text" class="form-control" id="ord_description" name="ord_description" ng-model="showCase.order.ord_description" placeholder="">
										      		<p ng-show="userForm.ord_description.$error.required && !userForm.ord_description.$pristine" class="help-block">Description is required</p>
										    	</div>										    	
										  	</div>
										  	<div class="form-group" ng-class="{'has-error':userForm.ord_date.$invalid && !userForm.ord_date.$pristine}">
										    	<label class="control-label col-md-5 text-left">Date</label>
										    	<div class="col-md-7">
										      		<input type="text" class="form-control dateInput" id="ord_date" name="ord_date" ng-model="showCase.order.ord_date" placeholder="">
										      		<p ng-show="userForm.ord_date.$error.required && !userForm.ord_date.$pristine" class="help-block">Date is required</p>
										    	</div>										    	
										  	</div>
										</div>

										<!--- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! --->
										<div class="col-md-3">
											<div class="form-group" ng-class="{'has-error':userForm.agent_customer.$invalid && !userForm.agent_customer.$pristine}" id="divPrlz">
				                                <label class="control-label col-md-5 text-left">Customer Name</label>
				                                <div class="col-md-7">
				                                    <select  ui-select2 id="agent_customer" name="agent_customer" ng-model="showCase.order.agent_customer_id" data-placeholder="Choose" <!--- ng-required="true" ---> ng-change="showCase.changePriceListZone();">
				                                        <option value="">Choose</option>
				                                        <option ng-repeat="cus in showCase.ord_agent_customer" value="{{cus.id_Customer}}">{{cus.cs_name}}</option>
				                                    </select>
				                                    <p ng-show="userForm.agent_customer.$error.required && !userForm.agent_customer.$pristine" class="help-block">Please choose Customer Name</p>
				                                </div>
				                            </div>
										  	<div class="form-group" ng-class="{'has-error':userForm.customer_no.$invalid && !userForm.customer_no.$pristine}">
										    	<label class="control-label col-md-5 text-left">Customer No.</label>
										    	<div class="col-md-7">
										    		<input class="form-control" id="ord_date" name="ord_date" ng-model="showCase.order.agent_customer_id" placeholder="" disabled>
										    	</div>
										  	</div>
										  	<div class="form-group" ng-class="{'has-error':userForm.payment.$invalid && !userForm.payment.$pristine}">
										    	<label class="control-label col-md-5 text-left">Payment</label>
										    	<div class="col-md-7">
										      		<select ui-select2 id="payment" name="payment" ng-model="showCase.order.id_payment" required >
														<option value="">Choose</option>
														<option ng-repeat="p in showCase.ord_payment" value="{{p.id_payment}}">{{p.pay_description}}</option>
													</select>
													<p ng-show="userForm.payment.$invalid && !userForm.payment.$pristine" class="help-block">Please choose payment</p>
										    	</div>
										  	</div>									  	
										</div>

										<!--- !!!!!!!!!!!!!!!!!!!! --->
										<div class="col-md-3">
										  	<div class="form-group" ng-class="{'has-error':userForm.condition.$invalid && !userForm.condition.$pristine}">
										    	<label class="control-label col-md-5 text-left">Order Condition</label>
										    	<div class="col-md-7">
										    		<select ui-select2 id="condition" name="condition" ng-model="showCase.order.id_order_condition" required>
														<option value="">Choose</option>
														<option ng-repeat="con in showCase.ord_condition" value="{{con.id_order_condition}}">{{con.oc_description}}</option>
													</select>
													<p ng-show="userForm.condition.$invalid && !userForm.condition.$pristine" class="help-block">Please choose order condition</p>
										    	</div>
										  	</div>
										  	<div class="form-group" ng-class="{'has-error':userForm.order_type.$invalid && !userForm.order_type.$pristine}">
										    	<label class="control-label col-md-5 text-left">Order Type</label>
										    	<div class="col-md-7">
										    		<select ui-select2 id="order_type" name="order_type" ng-model="showCase.order.id_order_type" required>
														<option value="">Choose</option>
														<option ng-repeat="ordtype in showCase.ord_type" value="{{ordtype.id_order_type}}">{{ordtype.ot_description}}</option>
													</select>
													<p ng-show="userForm.order_type.$invalid && !userForm.order_type.$pristine" class="help-block">Please choose order type</p>
										    	</div>
										  	</div>
										  	<div class="form-group" ng-class="{'has-error':userForm.ord_status.$invalid && !userForm.ord_status.$pristine}">
										    	<label class="control-label col-md-5 text-left">Order Status</label>
										    	<div class="col-md-7">
										    		<select ui-select2 id="ord_status" name="ord_status" ng-model="showCase.order.id_order_status" required>
														<option value="">Choose</option>
														<option ng-repeat="status in showCase.ord_status" value="{{status.id_order_status}}">{{status.os_description}}</option>
													</select>
													<p ng-show="userForm.ord_status.$invalid && !userForm.ord_status.$pristine" class="help-block">Please choose order status</p>
										    	</div>
										  	</div>
										</div>
										<!--- !!!!!!!!!!!!!!!!!!!! --->
										<div class="col-md-3">
											<div class="form-group" ng-class="{'has-error':userForm.discount1.$invalid && !userForm.discount1.$pristine}">
										    	<label class="control-label col-md-4 text-left">Discount 1</label>
										    	<div class="col-md-7">
										      		<input type="number" class="form-control" id="discount1" name="discount1" ng-model="showCase.order.discount1" ng-pattern="showCase.regexNumber" required>
										      		<p ng-show="userForm.discount1.$invalid && !userForm.discount1.$pristine" class="help-block">Please choose discount 1</p>
										    	</div>
										    	<label class="row control-label col-md-1 text-left">%</label>										    	
										  	</div>
										  	<div class="form-group" ng-class="{'has-error':userForm.discount2.$invalid && !userForm.discount2.$pristine}">
										    	<label class="control-label col-md-4 text-left">Discount 2</label>
										    	<div class="col-md-7">
										      		<input type="text" class="form-control" id="discount2" name="discount2" ng-model="showCase.order.discount2" disabled>
										      		<p ng-show="userForm.discount2.$invalid && !userForm.discount2.$pristine" class="help-block">Please choose discount 2</p>
										    	</div>
										    	<label class="row control-label col-md-1 text-left">%</label>										    	
										  	</div>
										</div>
									</div>
								</div>
							</fieldset>

							<fieldset>
								<legend class="fcollapsible"></legend>
								<div class="fcontent">
									<div class="row">
										<div class="col-md-3">
											<div class="form-group">
										    	<label class="control-label col-md-5 text-left">Group</label>
										    	<div class="col-md-7">
										      		<input type="text" class="form-control" id="pr_description" name="pr_description" ng-model="showCase.order.pr_description" placeholder="">
										    	</div>
										  	</div>										
											<div class="form-group" ng-class="{'has-error':userForm.product_status.$invalid && !userForm.product_status.$pristine}">
										    	<label class="control-label col-md-5 text-left">Product</label>
										    	<div class="col-md-7">
										    		<select ui-select2 id="product_status" name="product_status" ng-model="showCase.order.product_status" required>
														<option value="">Choose</option>
														<option ng-repeat="pst in showCase.PrStts" value="{{pst.ID}}">{{pst.DES}}</option>
													</select>
													<p ng-show="userForm.product_status.$invalid && !userForm.product_status.$pristine" class="help-block">Please choose product status</p>
										    	</div>
										  	</div>
											<div class="form-group">
										    	<label class="control-label col-md-5 text-left">Garment Code</label>
										    	<div class="col-md-7">
										      		<input type="text" class="form-control" id="pr_description" name="pr_description" ng-model="showCase.order.pr_description" placeholder="" disabled>
										    	</div>
										  	</div>
											<div class="form-group">
										    	<label class="control-label col-md-5 text-left">Garment Version</label>
										    	<div class="col-md-7">
										      		<input type="text" class="form-control" id="pr_description" name="pr_description" ng-model="showCase.order.pr_description" placeholder="" disabled>
										    	</div>
										  	</div>
										  	<div>
										  		<div style="position: absolute; margin-top: -10px; background-color: white">Sketch</div>
										  		<div style="border-style: dashed; border-width: 1px; width:100%;"><img style="margin-top: 7px"class="img-responsive" src="/includes/img/ao/120729442.jpg">
										  		</div>
										  	</div>
										</div>
										<div class="col-md-9">
											<div class="form-group">
										    	<label class="control-label col-md-2 text-left">&nbsp;</label>
										    	<label class="control-label col-md-2 text-left">On Price List</label>
										    	<label class="control-label col-md-2 text-left">Price on Product</label>
										    	<label class="control-label col-md-2 text-left">Custom</label>
										    	<label class="control-label col-md-2 text-left">Total Price</label>
										  	</div>
										  	<div class="form-group">
										    	<label class="control-label col-md-2 text-left">Product Price (EUR)</label>
										    	<div class="col-md-2 text-left">
										    		<span class="form-control" disabled>123,000</span>
										    	</div>
										    	<div class="col-md-2 text-left">
										    		<span class="form-control" disabled>123,000</span>
										    	</div>
										    	<div class="col-md-2 text-left">
										    		<span class="form-control" disabled>123,000</span>
										    	</div>
										    	<div class="col-md-2 text-left">
										    		<span class="form-control" disabled>123,000</span>
										    	</div>
										  	</div>
										  	<!--- table size detail --->
											<table id="" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptionsSizes" dt-columns="showCase.dtColumnsSizes" dt-instance="showCase.dtInstanceSizes">
											</table>

											<!--- end table size detail --->
											<div class="form-group">
												<div class="col-md-3 pull-left">
													<input  type="radio" id="size_quantity" name="radio_choose" value="size_quantity"> Add Size Quantity<br>
												</div>

												<div class="col-md-6 pull-left">
													<input  type="radio" id="name_size_number" name="radio_choose" value="name_size_number"> Add Name, Size & Number<br>
												</div>												
											</div>
											<div class="col-md-12" id="table_size_quantity">
												<div class="row">
													<table class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptionsCus" dt-columns="showCase.dtColumnsCus" dt-instance="showCase.dtInstanceCus">
													</table>
												</div>
											</div>
											<div class="form-group hidden" id="table_name_size_number">
												<div class="col-md-12">
													<div class="row">
														<div class="col-md-8">
															<table class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptionsCus" dt-columns="showCase.dtColumnsCus" dt-instance="showCase.dtInstanceCus">
															</table>
														</div>
														<div class="col-md-2" style="margin-top: 100px">
															<div style="margin-bottom: 50px">													
																<a href="">Template</a> <font color="green"><i class="fa fa-file-excel-o fa-lg" aria-hidden="true"></i></font>
															</div>
															<div class="btn bg-color-blueDark txt-color-white pull-left" style="width: 100%" id="btnAddNew" ng-click="showCase.showModalAddNew()">
																<div class="pull-left">Import</div>
																<div class="pull-right">
																	<font color="green">  <i class="fa fa-file-excel-o fa-lg" aria-hidden="true"></i></font>
																</div>
								                            </div>
															<div class="btn bg-color-blueDark txt-color-white pull-left" style="width: 100%; margin-top: 2px" id="btnAddNew" ng-click="showCase.showModalAddNew()">Add New
								                            </div>
								                            <div class="btn bg-color-blueDark txt-color-white pull-left" style="width: 100%; margin-top: 20px" id="btnAddNew" ng-click="showCase.showModalAddNew()">Save
								                            </div>
														</div>														
													</div>
												</div>
											</div>
											<div class="col-md-2 col-md-offset-10" >
												<div style="width: 100%;" class="btn bg-color-blueDark txt-color-white"id="btnAddRow"  ng-click="showCase.saveProduct()" ng-disabled="userForm.$invalid">
													<i class="fa fa-save"></i>
													&nbsp;Add Product
												</div>
											</div>

										</div>										
									</div>
								</div>
							</fieldset>						
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

<script src="/includes/js/jquery-ui.js"></script>
<script src="/includes/js/jquery.dataTables.min.js"></script>
<script src="/includes/js/angular-datatables.min.js"></script>
<script src="/includes/js/dataTables.lightColumnFilter.min.js"></script>
<script src="/includes/js/angular-datatables.light-columnfilter.min.js"></script>
<script src="/includes/js/views/order.create.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		$(".dateInput").datepicker();
		$('input:radio[id=size_quantity]').prop('checked', true);

		$('#order_infomation input').on('change', function() {
			var check = $('input[name=radio_choose]:checked', '#order_infomation').val();
		  	if(check == "size_quantity"){
		  		$("#table_size_quantity").removeClass("hidden");
		  		$("#table_name_size_number").addClass("hidden");
		  	}else{
		  		$("#table_name_size_number").removeClass("hidden");
		  		$("#table_size_quantity").addClass("hidden");
		  	}
		});
	})
</script>