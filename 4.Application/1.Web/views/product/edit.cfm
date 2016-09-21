<style type="text/css">
	.select2-container{
		width:100%;
	}
</style>
<section id="widget-grid" class="" ng-app="product.edit" ng-controller="BindAngularDirectiveCtrl as showCase" ng-cloak>
	<div class="row">
		<article class="col-sm-12 col-md-12 col-lg-12">

			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-check"></i> </span>
					<h2> Product Information </h2>
				</header>
				<div>
					<!-- widget edit box -->
					<div class="jarviswidget-editbox">
						<!-- This area used as dropdown edit box -->
					</div>
					<div class="widget-body">

						<ul id="myTab1" class="nav nav-tabs">
							<li class="active">
								<a href="#s1" data-toggle="tab">Product General</a>
							</li>
							<!--- <li>
								<a href="#s4" data-toggle="tab">Product Components</a>
							</li>
							<li>
								<a href="#s2" data-toggle="tab">Product Process</a>
							</li> --->
							<li>
								<a href="#s3" data-toggle="tab">Product Custom</a>
							</li>
							<!--- <li>
								<a href="#s5" data-toggle="tab">Contract</a>
							</li> --->
						</ul>

						<div id="myTabContent1" class="tab-content padding-10">
							<div class="tab-pane fade in active" id="s1">
								<form class="form-horizontal col-md-12" name="userForm" ng-submit="showCase.submitForm()" role="form" id="product_infomation" style="background-color:white;" novalidate>
									<fieldset>
										<legend class="fcollapsible">General</legend>
										<div class="fcontent">
											<div class="row">
												<div class="col-md-4">
													<div class="form-group">
												    	<label class="control-label col-sm-4 text-left">Project</label>
												    	<div class="col-sm-8">
												      		<select ui-select2 data-placeholder="Choose" id="project" name="project" ng-model="showCase.prd.project" ng-required="true" ng-change="showCase.changeProject();">
												      			<option ng-repeat="prje in showCase.projects" value={{prje.id_Project}}>{{prje.pj_description}}</option>
															</select>
															<p ng-show="userForm.project.$invalid && !userForm.project.$pristine" class="help-block">Please choose project</p>
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<label class="control-label col-sm-4 text-left">Product</label>
												    	<div class="col-sm-8">
												      		<input type="number" class="form-control" id="product" name="product" ng-model="showCase.prd.id_product" disabled required>
												    	</div>
												  	</div>
												  	<div class="form-group" ng-class="{'has-error':userForm.pattern.$invalid && !userForm.pattern.$pristine}">
												    	<label class="control-label col-sm-4 text-left">Pattern</label>
												    	<div class="col-sm-8">
												      		<select ui-select2 id="pattern" name="pattern"  ng-model="showCase.prd.pattern" ng-change="showCase.changePattern()" required  >
																<option value="">Choose</option>
																 <option ng-repeat="p in showCase.patterns" value="{{p.IDPATTERN}}">{{p.CODE}}</option>
															</select>
															<p ng-show="userForm.pattern.$invalid && !userForm.pattern.$pristine" class="help-block">Please choose pattern</p>
												    	</div>
												  	</div>
												  	<div class="form-group" ng-class="{'has-error':userForm.pv_variation.$invalid && !userForm.pv_variation.$pristine}">
												    	<label class="control-label col-sm-4 text-left">P. Variation</label>
												    	<div class="col-sm-8">
												      		<select ui-select2 id="pattern_var" name="pattern_var" ng-model="showCase.prd.pattern_var" >
																<option value="">Choose</option>
																<option ng-repeat="pv in showCase.pattern_vars" value="{{pv.id_pattern_var}}">{{pv.pv_code}}</option>
															</select>
															<p ng-show="userForm.pattern_var.$invalid && !userForm.pattern_var.$pristine" class="help-block">Please choose pattern Variation</p>
												    	</div>
												  	</div>
												  	<div class="form-group" ng-class="{'has-error':userForm.pr_version.$invalid && !userForm.pr_version.$pristine}">
												    	<label class="control-label col-sm-4 text-left">Version</label>
												    	<div class="col-sm-8">
												      		<input class="form-control" type="number" name="pr_version" id="pr_version" ng-model="showCase.prd.pr_version" required ng-pattern="showCase.regexNumber">
												      		<p ng-show="userForm.pr_version.$error.required && !userForm.pr_version.$pristine" class="help-block">Version of product is required</p>
                                    						<p ng-show="userForm.pr_version.$error.pattern  && !userForm.pr_version.$pristine" class="help-block">Can not enter special char</p>
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<label class="control-label col-sm-4 text-left">Description</label>
												    	<div class="col-sm-8">
												      		<input type="text" class="form-control" id="pr_description" name="pr_description" ng-model="showCase.prd.pr_description" placeholder="">
												    	</div>
												  	</div>
												</div>
												<div class="col-md-4">
													<div class="form-group" ng-class="{'has-error':userForm.plz_id.$invalid && !userForm.plz_id.$pristine}" id="divPrlz">
						                                <label class="control-label col-md-4 text-left">Price List</label>
						                                <div class="col-md-8">
						                                    <select  ui-select2 id="plz_id" name="plz_id" ng-model="showCase.prd.plz_id" data-placeholder="Choose" <!--- ng-required="true" ---> ng-change="showCase.changePriceListZone();">
						                                        <option value="">Choose</option>
						                                        <option ng-repeat="pj in showCase.plz_id" value="{{pj.id_plz}}">{{pj.des}}</option>
						                                    </select>
						                                   <!---  <p ng-show="userForm.plz_id.$error.required && !userForm.plz_id.$pristine" class="help-block">Price list of product is required</p> --->
						                                </div>
						                            </div>
												  	<div class="form-group" ng-class="{'has-error':userForm.cost.$invalid && !userForm.cost.$pristine}">
												    	<label class="control-label col-sm-4 text-left">Cost Code</label>
												    	<div class="col-sm-8">
												      		<select ui-select2 id="cost" name="cost" ng-model="showCase.prd.cost" ng-required ng-change="showCase.changecost_season();">
												      			<option value="">Choose</option>
																<option ng-repeat="icost in showCase.costs" value="{{icost.id_cost}}" >{{icost.cost_code}}</option>
															</select>
															<p ng-show="userForm.cost.$invald && !userForm.cost.$pristine" class="help-block">Please choose costing</p>
												    	</div>
												  	</div>
												  	<div class="form-group" ng-class="{'has-error':userForm.cost_version.$invalid && !userForm.cost_version.$pristine}">
												    	<label class="control-label col-sm-4 text-left">Cost Code Ver</label>
												    	<div class="col-sm-8">
												      		<select ui-select2 id="cost_version" name="cost_version" ng-model="showCase.prd.cost_version" required >
																<option value="">Choose</option>
																<option ng-repeat="c_v in showCase.cost_vs" value="{{c_v.id_cost_version}}">{{c_v.cv_version}}</option>
															</select>
															<p ng-show="userForm.cost_version.$invalid && !userForm.cost_version.$pristine" class="help-block">Please choose costing version</p>
												    	</div>
												  	</div>
												  	<div class="form-group" ng-class="{'has-error':userForm.sz.$invalid && !userForm.sz.$pristine}">
												    	<label class="control-label col-sm-4 text-left">Sizes</label>
												    	<div class="col-sm-8">
												      		<select ui-select2 id="sz" name="sz" ng-model="showCase.prd.sz"required>
																<option value="">Choose</option>
																<option ng-repeat="s in showCase.sizes" value="{{s.id_size}}">{{s.sz_description}}</option>
															</select>
															<p ng-show="userForm.sz.$invalid && !userForm.sz.$pristine" class="help-block">Please choose size</p>
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<label class="control-label col-sm-4 text-left">Date</label>
												    	<div class="col-sm-8">
												      		<input type="text" class="form-control dateInput" id="pr_date" name="pr_date" ng-model="showCase.prd.pr_date" placeholder="">
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<label class="control-label col-sm-4 text-left">Update</label>
												    	<div class="col-sm-8">
												      		<input type="text" class="form-control dateInput" id="pr_date_update" name="pr_date_update" ng-model="showCase.prd.pr_date_update" placeholder="">
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<label class="control-label col-sm-4 text-left">Contract</label>
												    	<div class="col-sm-8">
												    		<select ui-select2 id="prdContract" name="prdContract" ng-model="showCase.prd.contract" ng-change="showCase.getFinalPrice()" >
																<option value="0"> None </option>
																<option ng-repeat="con in showCase.contract" value="{{con.id_contract}}">{{con.c_date_i}}</option>
															</select>
												    	</div>
												  	</div>
												</div>
												<div class="col-md-4">
													<div class="form-group" ng-class="{'has-error':userForm.pr_web.$invalid && !userForm.pr_web.$pristine}">
												    	<label class="control-label col-sm-4 text-left">Web</label>
												    	<div class="col-sm-8">
												      		<input type="number" class="form-control" id="pr_web" name="pr_web" ng-model="showCase.prd.pr_web" ng-pattern="showCase.regexNumber" required>
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<label class="control-label col-sm-4 text-left">Zone</label>
												    	<div class="col-sm-8">
												      		<input type="text" class="form-control" id="z_description" name="z_description" ng-model="showCase.prd.z_description" disabled>
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<label class="control-label col-sm-4 text-left">Agent</label>
												    	<div class="col-sm-8">
												      		<input type="text" class="form-control" id="ag_description" name="ag_description" ng-model="showCase.prd.ag_description" disabled>
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<label class="control-label col-sm-4 text-left">Customer</label>
												    	<div class="col-sm-8">
												      		<input type="text" class="form-control" id="cs_name" name="cs_name" ng-model="showCase.prd.cs_name" disabled>
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<label class="control-label col-sm-4 text-left">Section</label>
												    	<div class="col-sm-8">
												      		<input type="text" class="form-control" id="pr_section" name="pr_section" ng-model="showCase.prd.pr_section">
												    	</div>
												  	</div>
												  	<div class="form-group" ng-class="{'has-error':userForm.product_status.$invalid && !userForm.product_status.$pristine}">
												    	<label class="control-label col-sm-4 text-left">Status</label>
												    	<div class="col-sm-8">
												    		<select ui-select2 id="product_status" name="product_status" ng-model="showCase.prd.product_status" required>
																<option value="">Choose</option>
																<option ng-repeat="pst in showCase.PrStts" value="{{pst.ID}}">{{pst.DES}}</option>
															</select>
															<p ng-show="userForm.product_status.$invalid && !userForm.product_status.$pristine" class="help-block">Please choose product status</p>
												    	</div>
												  	</div>
												</div>
											</div>
										</div>
									</fieldset>

									<fieldset>
										<legend class="fcollapsible">Prices</legend>
										<div class="fcontent">
											<div class="row">
												<div class="col-md-4">
													<div class="form-group">
														<div class="col-md-12">
															<label class="col-md-4 control-label text-left">Sketch</label>
															<div class="col-md-8">
																<input type="file" class="btn btn-default btn-block" multiple onchange="angular.element(this).scope().uploadFileSketch(this.files)" id="pr_sketch" name="pr_sketch">
															</div>
														</div>
														<div class="col-md-12">
															<label class="col-md-4 control-label text-left">Picture</label>
															<div class="col-md-8">
																<input type="file" class="btn btn-default btn-block" id="pr_picture" name="pr_picture" multiple onchange="angular.element(this).scope().uploadFilePicture(this.files)">
															</div>
														</div>
													</div>
													<div class="form-group">
														<div class="col-md-6">
															<a href="/includes/img/ao/{{showCase.prd.pr_sketch}}" data-lightbox="gallery">
																<img class="img-responsive" src="/includes/img/ao/{{showCase.prd.pr_sketch}}">
															</a>
														</div>
														<div class="col-md-6">
															<a href="/includes/img/ao/{{showCase.prd.pr_picture}}" data-lightbox="gallery">
																<img class="img-responsive" src="/includes/img/ao/{{showCase.prd.pr_picture}}">
															</a>
														</div>
													</div>
												</div>
												<div class="col-md-3">
													<div class="form-group">
												    	<label class="control-label col-sm-6 text-left">&nbsp;</label>
												    	<label class="control-label col-sm-6 text-left">On Price List</label>
												  	</div>
												  	<div class="form-group" id="factoryPriceList">
												    	<label class="control-label col-sm-5 text-left">Factory Price</label>
												    	<div class="col-sm-7 pull-right" style="width: 55.6%;">
												      		<span class="form-control" id="fty_sell_4" name="fty_sell_4" min="0" ng-model="showCase.prd.fty_sell_4" disabled>{{showCase.prd.fty_sell_4 | number}}</span>
												    	</div>
												  	</div>
												  	<div class="form-group" id="agentPriceList">
												    	<label class="control-label col-sm-5 text-left">Agent Price</label>
												    	<div class="col-sm-7 pull-right" style="width: 55.6%;">
												      		<span class="form-control" id="plzd_zone_sell_6" name="plzd_zone_sell_6" min="0" ng-model="showCase.prd.plzd_zone_sell_6" disabled>{{showCase.prd.plzd_zone_sell_6 | number}}</span>

												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<label class="control-label col-sm-5 text-left">Final Price</label>
												    	<div class="col-sm-7 pull-right" style="width: 55.6%;">
												      		<span class="form-control" id="plzd_pvpr_8" name="plzd_pvpr_8" min="0" ng-model="showCase.prd.plzd_pvpr_8" disabled>{{showCase.prd.plzd_pvpr_8 | number}}</span>
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<label class="control-label col-sm-5 text-left">Club Price</label>
												    	<div class="col-sm-7 pull-right" style="width: 55.6%;">
												      		<!--- <input type="text" class="form-control" id="" placeholder=""> --->
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<label class="control-label col-sm-5 text-left">Web Price</label>
												    	<div class="col-sm-7 pull-right" style="width: 55.6%;">
												      		<!--- <input type="text" class="form-control" id="" placeholder=""> --->
												    	</div>
												  	</div>
												</div>
												<div class="col-md-5">
													<div class="form-group">
												    	<label class="control-label col-sm-4 text-center">Manual</label>
												    	<label class="control-label col-sm-4 text-center">Custom</label>
												    	<label class="control-label col-sm-4 text-center">Total Price</label>
												  	</div>
												  	<div class="form-group" id="factoryPriceManual_Valid">
												    	<div class="col-sm-4" ng-class="{'has-error':userForm.pr_fty_sell_9.$invalid && !userForm.pr_fty_sell_9.$pristine}">
												      		<input type="number" class="form-control" id="pr_fty_sell_9" name="pr_fty_sell_9" ng-model="showCase.prd.pr_fty_sell_9" ng-pattern="showCase.regexNumber" ng-change="showCase.onChangeFactoryPriceManual()" min="0">
                                    						<p ng-show="userForm.pr_fty_sell_9.$error.pattern  && !userForm.pr_fty_sell_9.$pristine" class="help-block">Can not enter special char</p>
												    	</div>
												    	<div class="col-sm-4">
												      		<span class="form-control" id="plFactoryCus" name="plFactoryCus" min="0" ng-model="showCase.prd.plFactoryCus" disabled>{{showCase.prd.plFactoryCus | number}}</span>
												    	</div>
												    	<div class="col-sm-4">
												      		<span class="form-control" id="pr_9_valid" name="pr_9_valid" min="0" ng-model="showCase.prd.pr_9_valid" disabled>{{showCase.prd.pr_9_valid | number}}</span>
												    	</div>
												  	</div>
												  	<div class="form-group" id="agentPriceManual_Valid">
												    	<div class="col-sm-4">
												      		<input type="number" class="form-control" id="pr_zone_sell_10" name="pr_zone_sell_10" ng-model="showCase.prd.pr_zone_sell_10" ng-pattern="showCase.regexNumber" ng-change="showCase.onChangeAgentPriceManual()" min="0">
												    	</div>
												    	<div class="col-sm-4">
												      		<span class="form-control" id="plZoneCus" name="plZoneCus" min="0" ng-model="showCase.prd.plZoneCus" disabled>{{showCase.prd.plZoneCus | number}}</span>
												    	</div>
												    	<div class="col-sm-4">
												      		<span class="form-control" id="pr_10_valid" name="pr_10_valid" min="0" ng-model="showCase.prd.pr_10_valid" disabled>{{showCase.prd.pr_10_valid | number}}</span>
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<div class="col-sm-4" ng-class="{'has-error':userForm.pr_fty_sell_9.$invalid && !userForm.pr_fty_sell_9.$pristine}">
												      		<input type="number" class="form-control" d="pr_pvpr_11" name="pr_pvpr_11" ng-model="showCase.prd.pr_pvpr_11"  ng-pattern="showCase.regexNumber" ng-change="showCase.onChangeFinalPriceManual()" min="0">
												      		<p ng-show="userForm.pr_pvpr_11.$error.pattern  && !userForm.pr_pvpr_11.$pristine" class="help-block">Can not enter special char</p>
												    	</div>
												    	<div class="col-sm-4">
												      		<span class="form-control" id="plFinalCus" name="plFinalCus" min="0" ng-model="showCase.prd.plFinalCus" disabled>{{showCase.prd.plFinalCus | number}}</span>
												    	</div>
												    	<div class="col-sm-4">
												      		<span class="form-control" id="pr_11_valid" name="pr_11_valid" min="0" ng-model="showCase.prd.pr_11_valid" disabled>{{showCase.prd.pr_11_valid | number}}</span>
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<div class="col-sm-4">
												      		<input type="number" class="form-control" id="pr_club_12" name="pr_club_12" ng-model="showCase.prd.pr_club_12" ng-pattern="showCase.regexNumber" ng-change="showCase.onChangeFinalPriceClub()" min="0">
												      		<p ng-show="userForm.pr_club_12.$error.pattern  && !userForm.pr_club_12.$pristine" class="help-block">Can not enter special char</p>
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<div class="col-sm-4">
												      		<input type="number" class="form-control" id="pr_web_13" name="pr_web_13" ng-model="showCase.prd.pr_web_13" ng-pattern="showCase.regexNumber" ng-change="showCase.onChangeFinalPriceWeb()" min="0">
												      		<p ng-show="userForm.pr_web_13.$error.pattern  && !userForm.pr_web_13.$pristine" class="help-block">Can not enter special char</p>
												    	</div>
												  	</div>
												</div>
											</div>
										</div>
									</fieldset>

									<div class="row form-actions" style="margin:0px;">
										<div class="col-md-12 pull-right">
											<div class="btn bg-color-blueDark txt-color-white"id="btnAddRow"  ng-click="showCase.saveProduct()" ng-disabled="userForm.$invalid">
												<i class="fa fa-save"></i>
												&nbsp;Save
											</div>
											<!--- <div class="btn btn-default">
												<i ="fa fa-sign-out"></i>
												&nbsp;Quit
											</div>
											<div class="btn btn-default">
												<i class="fa fa-files-o"></i>
												&nbsp;Create by Copy
											</div> --->
										</div>
									</div>
								</form>
							</div>

							<div class="tab-pane fade" id="s3">
								<input type="hidden" id="id_prdcust" value="0">
								<form class="form-horizontal" role="form" id="product_cust" name="productCustForm" ng-submit="showCase.submitForm()" novalidate>
									<legend class="fcollapsible">Product Custom Information</legend>
									<div class="fcontent">
										<div class="row">
											<div class="col-md-6">
												<div class="form-group" ng-class="{'has-error':productCustForm.plz_id_cus.$invalid && !productCustForm.plz_id_cus.$pristine}" id="divPrlz">
					                                <label class="control-label col-md-2 col-sm-2 text-left">Price List</label>
					                                <div class="col-md-2 col-sm-2">
					                                    <select  ui-select2 id="plz_id_cus" name="plz_id_cus" ng-model="showCase.product_custom.plz_id" data-placeholder="Choose" ng-change="showCase.changePriceListZoneCus();" style="width: 200px !important;">
					                                        <option value="">Choose</option>
					                                        <option ng-repeat="pj in showCase.plz_id" value="{{pj.id_plz}}">{{pj.des}}</option>
					                                    </select>
					                                    <p ng-show="productCustForm.plz_id_cus.$error.required && !productCustForm.plz_id_cus.$pristine" class="help-block">Price list of product is required</p>
					                                </div>
					                            </div>

											  	<div class="form-group">
													<label class="col-md-2 col-sm-2 control-label text-left bold">Code</label>
													<div class="col-md-2 col-sm-2">
														<select ui-select2 id="costsCST_Id" style="width: 200px !important;" name="costsCST_Id" ng-model="showCase.product_custom.costsCSTid" data-placeholder="Choose" required ng-change="showCase.changeCost_prdCus();">
															<option value="">Choose</option>
														    <option ng-repeat="cost in showCase.costsCST" value="{{cost.id_cost}}">{{cost.cost_code}}</option>
														</select>
														<p ng-show="productCustForm.costsCST_Id.$error.required && !productCustForm.costsCST_Id.$pristine" class="help-block">Code is required</p>
													</div>
												</div>

												<div class="form-group display-none">
													<label class="col-md-2 col-sm-2 control-label text-left bold">Version</label>
													<div class="col-md-2 col-sm-2">
														<select ui-select2 id="cv_CST_id" name="cv_CST_id" style="width: 200px !important;" ng-model="showCase.product_custom.cvCSTid" data-placeholder="Choose" required>
															<option value="">Choose</option>
														    <option ng-repeat="costvs in showCase.costsVS_CST" value="{{costvs.id_cost_version}}">{{costvs.cv_version}}</option>
														</select>
														<p ng-show="productCustForm.cv_CST_id.$error.required && !productCustForm.cv_CST_id.$pristine" class="help-block">Version is required</p>
													</div>
												</div>

											  	<div class="form-group">
											    	<label class="control-label col-md-2 col-sm-2 text-left bold">QTTY</label>
											    	<div class="col-md-5 col-sm-2">
											      		 <input class="form-control" placeholder="" min="1" type="number" style="width: 200px !important;" name="quantity_cus" id="quantity_cus" ng-pattern="showCase.regexNumber" ng-model="showCase.product_custom.quantity_cus" required>
											      		 <p ng-show="productCustForm.quantity_cus.$error.required && !productCustForm.quantity_cus.$pristine" class="help-block">QTTY is required</p>
                                                        <p ng-show="productCustForm.quantity_cus.$error.pattern && !productCustForm.quantity_cus.$pristine" class="help-block">Can not enter special char</p>
											    	</div>
											  	</div>

											  	<div class="form-group">
											    	<label class="control-label col-md-2 col-sm-2 text-left">Description</label>
											    	<div class="col-sm-10 col-md-10">
											      		<input type="text" class="form-control" id="description_cus" name="description_cus" ng-model="showCase.product_custom.description_cus" placeholder="">
											    	</div>
										  		</div>

											</div>
											<div class="col-md-6">

											</div>
										</div>
										<div class="row">
											<div class="col-sm-12 text-center">
										      	<div class="btn bg-color-blueDark txt-color-white" id="save_prd_cust" ng-click="showCase.addPrdCus()" ng-disabled="productCustForm.$invalid">
													<i class="fa fa-save"></i>
													&nbsp;Add/Update
												</div>
										      	<div class="btn btn-default" id="" ng-click="showCase.refreshCus()">
													<i class="fa fa-refresh"></i>
													&nbsp;Refresh
												</div>
										    </div>
										</div>
									</div>
									<fieldset>
										<legend class="fcollapsible">Product Custom List</legend>
										<div class="fcontent">
											<div class="table-responsive">
												<table id="datatable_cus" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptionsCus" dt-columns="showCase.dtColumnsCus" dt-instance="showCase.dtInstanceCus">
												</table>
											</div>
										</div>
									</fieldset>
								</form>
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

<script src="/includes/js/jquery-ui.js"></script>
<script src="/includes/js/jquery.dataTables.min.js"></script>
<script src="/includes/js/angular-datatables.min.js"></script>
<script src="/includes/js/dataTables.lightColumnFilter.min.js"></script>
<script src="/includes/js/angular-datatables.light-columnfilter.min.js"></script>
<script src="/includes/js/views/product.edit.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		$(".dateInput").datepicker();
	})
</script>