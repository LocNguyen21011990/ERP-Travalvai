<style type="text/css">
	.modal-lg {
	    width: 50%;
	}
	.factory-detail>div{
		padding-right: 0;
		padding-left: 10px;

	}
	.factory-detail>div:last-child{
		padding-right: 10px;
	}
	th.text-right{
		text-align: left !important;
	}
</style>
<section id="widget-grid" class="" ng-app="price_list_factory_detail" ng-controller="BindAngularDirectiveCtrl as showCase"  ng-cloak>
    <div class="row">
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
                <header>
                    <span class="widget-icon"> <i class="fa fa-arrow-left" style="cursor:pointer !important;" ng-click="showCase.backState()"></i> </span>
                    <h2>Price List Factory Detail</h2>
                </header>
                <div>
                    <div class="widget-body">
                        <div class="row">
                        	<div class="col-md-2 col-sm-2 col-xs-12 pull-right">
                            	<div class="btn col-md-12 col-sm-12 col-xs-12 bg-color-blueDark txt-color-white" id="btnAddArticle" ng-show="{{showCase.isShowCreateBtn}}" ng-click="showCase.showFilterModal()">
	                            	Add Article
	                            </div>
	                            <div class="btn col-md-12 col-sm-12 col-xs-12 bg-color-blueDark txt-color-white" style="margin-top:10px;" id="btnResetPrice" ng-show="{{showCase.isShowCreateBtn}}" ng-click="showCase.ResetPrice(showCase)">
	                            	Reset Price
	                            </div>
                        	</div>
                        	<div class="col-md-10 col-sm-10 col-xs-12 pull-left" style="border: 1px solid black;padding: 10px;">
                        		<div class="row factory-detail">
									<div class ="col-md-3 col-sm-3 col-xs-12">
										<div class="text-left" style="display: block;">
											<span style="font-weight:bolder;">PR.LST.CODE: </span>
											<span data-ng-bind="::showCase.user.CODE"></span>
										</div>
								    	<div class="text-left" style="display: block;">
								    		<span style="font-weight:bolder;">DESCRIPTION: </span>
								    		<span data-ng-bind="::showCase.user.DES"></span>
								    	</div>
								    	<div class="text-left" style="display: block;">
								    		<span style="font-weight:bolder;">ZONE: </span>
								    		<span data-ng-bind="::showCase.user.Z_DES"></span>
								    	</div>

								    	<div class="text-left" style="display: block;">
								    		<span style="font-weight:bolder;">SEASON: </span>
								      		<span data-ng-bind="::showCase.user.SEASON"></span>
								    	</div>
									</div>
									<div class ="col-md-3 col-sm-3 col-xs-12">
										<div class="col-md-12 col-sm-12 col-xs-12 text-left">
											<span style="font-weight:bolder;">FACTORY CURRENCY: </span>
								      		<span data-ng-bind="::showCase.user.FTYCURRENCY"></span>
										</div>
								    	<div class="col-md-12 col-sm-12 col-xs-12 text-left">
								    		<span style="font-weight:bolder;">PRICE LIST CURRENCY: </span>
								      		<span data-ng-bind="::showCase.user.CURRPL"></span>
								    	</div>
								    	<div class="col-md-12 col-sm-12 col-xs-12 text-left">
								    		
												 <span style="font-weight:bolder;">	EX. RATE (<span data-ng-bind="showCase.user.FTYCURRENCY"> </span>/<span data-ng-bind="showCase.user.CURRPL"></span>)</span>: 
													<span data-ng-bind="showCase.user.calcuExRate"></span></br>

									      			<span style="font-weight:bolder; color:#fff">	
													  EX. RATE (<span data-ng-bind="showCase.user.FTYCURRENCY"> </span>/<span data-ng-bind="showCase.user.CURRPL"></span>):
													</span> 
													<span style="background-color:#f2f2f2" data-ng-bind="showCase.user.devidedCalcuExRate"></span>												
								    	</div>
									</div>
									<div class ="col-md-3 col-sm-3 col-xs-12">
										<div class="col-md-12 col-sm-12 col-xs-12 text-left">
											<span style="font-weight:bolder;">EX. RATE (USD/<span data-ng-bind="showCase.user.FTYCURRENCY"></span>): </span>
								      		<span data-ng-bind="::showCase.user.exRateUSDToFtyCurrency"></span>
										</div>
								    	<div class="col-md-12 col-sm-12 col-xs-12 text-left">
								    		<span style="font-weight:bolder;">EX. RATE (USD/<span data-ng-bind="showCase.user.CURRPL"></span>): </span>
								      		<span data-ng-bind="::showCase.user.CREATION_DATE"></span>
								    	</div>
								    	<div class="col-md-12 col-sm-12 col-xs-12 text-left">

											<span style="font-weight:bolder;">	MANUAL EX. RATE</span>: 
													<span data-ng-bind="showCase.user.EX_RATE"></span></br>

									      			<span style="font-weight:bolder; color:#fff">	
													  MANUAL EX. RATE:
													</span> 
													<span style="background-color:#f2f2f2" data-ng-bind="showCase.user.devidedExRate"></span>									    		
								    	</div>
									</div>
									<div class ="col-md-3 col-sm-3 col-xs-12">
										<div class="col-md-12 col-sm-12 col-xs-12 text-left">
											<span style="font-weight:bolder;">CORRECTION (%): </span>
								      		<span data-ng-bind="::showCase.user.CORRECTION"></span>
										</div>
								    	<div class="col-md-12 col-sm-12 col-xs-12 text-left">
								    		<span style="font-weight:bolder;">CREATION DATE: </span>
								      		<span data-ng-bind="::showCase.user.PLFDATE"></span>
								    	</div>
								    	<div class="col-md-12 col-sm-12 col-xs-12 text-left">
								    		<span style="font-weight:bolder;">LAST UPDATE: </span>
								      		<span data-ng-bind="::showCase.user.PLFUPDATE"></span>
								    	</div>
								    	<div class="col-md-12 col-sm-12 col-xs-12 text-left">
								    		<span style="font-weight:bolder;">LANGUAGE: </span>
								      		<span data-ng-bind="::showCase.user.LANGUAGE"></span>
								    	</div>
									</div>
                        		</div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="table-responsive">
                                <table id="mytable" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptions_detail" dt-columns="showCase.dtColumns_detail" dt-instance="showCase.dtInstance">
                                	<thead>
                                		<tr>
											<th colspan="2" class="text-center">COSTING</th>

											<th colspan="2" class="text-center">VERSION</th>


											<th colspan="2" class="text-center">FACTORY</th>

											<th colspan="2" class="text-center">FTY SELL CALC</th>

											<th colspan="2" class="text-center">P.L. SELL CALC</th>

											<th colspan="2" class="text-center">FTY SELL PRICE</th>
											<th></th>
                                		</tr>
                                		<tr>
											<th></th>
											<th></th>

											<th></th>
											<th></th>

											<th></th>
											<th></th>

											<th></th>
											<th></th>

											<th></th>
											<th></th>
											<th></th>
											<th></th>
											<th></th>
                                		</tr>
                                	</thead>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </article>
    </div>
<div class="modal fade" id="modalCostListing" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria=hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-body">
				<button type="button" class="close" id="close" data-dismiss="modal" style="display:none;float:right;">&times;</button>
				<legend class="fcollapsible" id="">Costing Select</legend>
				<div class="table-responsive" id="modalCostingContainer">
					<table id="datatable_costing_listing" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptions_costing" dt-columns="showCase.dtColumns_costing" dt-instance="showCase.dtInstance_costing">
	                </table>
				</div>
			</div>
			<div class="modal-footer">
				<div class="form-group text-center">
                    <div class="col-md-8"></div>
                    <div class="col-md-4">
                        <div class="btn bg-color-blueDark txt-color-white" id="btnSearchCosting" ng-click="showCase.addCostingVersion()" >
                           	Add
                        </div>
                        <div class="btn bg-color-blueDark txt-color-white" id="btnSearchCosting"  ng-click="showCase.returnFilter()" ng-disabled="userForm1.$invalid">
                           	Back
                        </div>
                    </div>
                </div>
            </div>
		</div>
	</div>
</div>
<div class="modal fade" id="modalFilterArticle" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <button type="button" class="close" id="close" data-dismiss="modal" style="display:none;float:right;">&times;</button>
                <legend class="fcollapsible" id="">Filter Article</legend>
                <div class="fcontent">
                    <form class="form-horizontal" name="userForm1" ng-submit="showCase.submitForm()" novalidate>
                        <div class="form-group" ng-class="{'has-error' : userForm1.season.$invalid && !userForm1.season.$pristine}">
                            <div class="col-md-6">
                            	<label class="control-label text-left">Source Season</label>
                            	<select ui-select2 id="oseason" name="oseason" ng-model="showCase.user.oseason" data-placeholder="Choose" ng-required="true">
								    <option ng-repeat="lang in showCase.old_seasons" value="{{lang.ID}}">{{lang.SEASON}}</option>
								</select>
                                <p ng-show="userForm1.oseason.$invalid && !userForm1.oseason.$pristine" class="help-block">Please Choose Season</p>
                            </div>

                            <div class="col-md-6">
                            	<label class="control-label text-left">Source Code</label>
                            	<select ui-select2 id="oCode" name="oCode" ng-model="showCase.user.oCode" data-placeholder="Choose" ng-required="true" multiple>
                            		<option value="all">All codes</option>
								    <option ng-repeat="lang in showCase.oCodes" value="{{lang.ID_COST}}">{{lang.COST_CODE}}</option>
								</select>
                            </div>
                        </div>
                        <div class="form-group text-center">
                            <div class="col-md-8"></div>
                            <div class="col-md-4">
                                <div class="btn bg-color-blueDark txt-color-white" id="btnSearchCosting"  ng-click="showCase.searchCosting()" ng-disabled="userForm1.$invalid">
                                   	Search
                                </div>
                                <div class="btn bg-color-blueDark txt-color-white" id="btnSearchCosting" data-dismiss="modal">
                                   	Cancel
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</section>
<script src="/includes/js/jquery.dataTables.min.js"></script>

<script src="/includes/js/views/price_list_factory_detail.js"></script>
<script src="/includes/js/angular-datatables.min.js"></script>
<script src="/includes/js/dataTables.lightColumnFilter.min.js"></script>
<script src="/includes/js/angular-datatables.light-columnfilter.min.js"></script>