<style type="text/css">
	.select2-container{
		width: 200px;
	}
	.dt-toolbar-footer{
		padding: 5px 5px;
	}
	.bold{
		font-weight: bold;
	}
</style>
<section id="widget-grid" class="" ng-app="pattern.list" ng-controller="BindAngularDirectiveCtrl as showCase" ng-cloak>
	<div class="row">
		<article class="col-sm-12 col-md-12 col-lg-12">
			<!-- Widget ID (each widget will need unique ID)-->
			<div class="jarviswidget jarviswidget-color-darken" id="wid-id-0" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">
				<header>
					<span class="widget-icon"> <i class="fa fa-check"></i> </span>
					<h2> Pattern Information </h2>
				</header>

				<!-- widget div-->
				<div>

					<!-- widget edit box -->
					<div class="jarviswidget-editbox">
						<!-- This area used as dropdown edit box -->

					</div>
					<!-- end widget edit box -->

					<!-- widget content -->

					<div class="widget-body">

						<ul id="myTab1" class="nav nav-tabs">
							<li class="active">
								<a href="##s1" data-toggle="tab">Pattern Detail</a>
							</li>
							<li id="pattern_part">
								<a href="##s4" data-toggle="tab">Pattern Part</a>
							</li>
							<li id="pattern_vari">
								<a href="##s2" data-toggle="tab">Pattern Vari</a>
							</li>
							<!--- <li>
								<a href="##s3" data-toggle="tab">Pattern Note</a>
							</li> --->
						</ul>

						<input type='hidden' name="id_pattern" id="id_pattern" value="0">
						<div id="myTabContent1" class="tab-content padding-10">
							<div class="tab-pane fade in active" id="s1">
								<form class="form-horizontal" role="form" id="order_information" name="userForm" ng-submit="showCase.submitForm()" novalidate>
									<fieldset>
										<legend class="fcollapsible">General</legend>
										<div class="fcontent">
											<div class="row">
												<div class="col-md-6">
													<div class="form-group" ng-class="{'has-error' : userForm.code.$invalid && !userForm.code.$pristine}">
														<label class="col-md-3 control-label text-left bold">Pattern</label>
														<div class="col-md-5">
															<input class="form-control" placeholder="" type="text" name="code" id="code" ng-model="showCase.user.code" ng-pattern="showCase.regex"  required>
															<p ng-show="userForm.code.$error.required && !userForm.code.$pristine" class="help-block">Code is required</p>
                                                            <p ng-show="userForm.code.$error.pattern  && !userForm.code.$pristine" class="help-block">Can not enter special char</p>
														</div>
													</div>
													<div class="form-group">
														<label class="col-md-3 control-label text-left">Create Date</label>
														<div class="col-md-3">
															<label class="control-label" name="craeateDate" id="craeateDate" ng-model="showCase.user.craeateDate" readonly> {{showCase.user.craeateDate}}</label>
														</div>
														<label class="col-md-3 control-label text-right">Update Date</label>
														<div class="col-md-3">
															<label class="control-label" name="updateDate" id="updateDate" ng-model="showCase.user.updateDate" readonly>{{showCase.user.updateDate}}</label>
														</div>
													</div>
													<div class="form-group">
														<label class="col-md-3 control-label text-left bold">Group PROD.</label>
														<div class="col-md-6">
															<select ui-select2 id="groupProduct" name="groupProduct" ng-model="showCase.user.groupID" data-placeholder="Choose" required>
															    <option ng-repeat="group in showCase.groupProduct" value="{{group.id_group_products}}">{{group.gp_code}}</option>
															</select>
														</div>
													</div>

                                                    <div class="form-group">
                                                    	<label class="col-md-3 control-label text-left bold">Description</label>
                                                    </div>

                                                    <div class="form-group">
                                                    	<div class="col-md-12 pull-left">
                                                        	 <ul class="nav nav-tabs">
				                                                <li ng-repeat="item in showCase.dataDes" ng-class="{'active':$first}"><a data-toggle="tab" href="##{{item.id_language}}{{item.lg_code}}">{{item.lg_code}}</a></li>
				                                            </ul>
				                                            <div class="tab-content">
				                                                <div ng-repeat="item in showCase.dataDes" id="{{item.id_language}}{{item.lg_code}}" class="tab-pane fade" ng-class="{'in active':$first}">
				                                                    <textarea class="form-control pdescription" placeholder="in {{item.lg_name}}" name="{{item.lg_code}}" id="{{item.lg_code}}{{item.id_language}}{{item.id_language}}" ng-model="item.description"></textarea>
				                                                </div>
				                                            </div>
                                                    	</div>
                                                    </div>

													<div class="form-group">
														<label class="col-md-3 control-label text-left bold">Notes</label>
													</div>
													<div class="form-group">
														<div class="col-md-10">
															<input class="form-control" placeholder="" type="text" id="patternnode" name="patternnode" ng-model="showCase.user.patternnode">
														</div>
														<div class="btn col-md-2 bg-color-blueDark txt-color-white" id="btnCreateNotes" ng-click="showCase.showAddNew()" disabled="disabled">
					                                        <i class="fa fa-save"></i>&nbsp;Add
					                                    </div>
													</div>
													<div class="row">
														<div class="table-responsive">
															<table id="datatable_notes" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptions2" dt-columns="showCase.dtColumns2" dt-instance="showCase.dtInstance2">
															</table>
														</div>
													</div>
												</div>
												<div class="col-md-6">
													<div class="form-group">
														<label class="col-md-3 control-label text-left bold">Sketch</label>
													</div>
													<div class="form-group">
														<div class="col-md-6">
															<input type="file" class="btn btn-default btn-block" id="sketch" name="sketch" ng-model="showCase.user.sketch" onchange="angular.element(this).scope().uploadSketch(this.files)" required>
															<p ng-show="userForm.sketch.$error.required && !userForm.sketch.$pristine" class="help-block">Sketch is required</p>
														</div>
													</div>
													<div class="form-group" id="divImgSketch">
														<div class="col-md-12">
															<a href="" data-lightbox="gallery">
																<img id="imgSketch" class="img-responsive" src="">
															</a>
														</div>
													</div>
												</div>

												<div class="col-md-6">
													<div class="form-group">
														<label class="col-md-3 control-label text-left bold">Parts</label>
													</div>
													<div class="form-group">
														<div class="col-md-6">
															<input type="file" class="btn btn-default btn-block" id="parts" name="parts" ng-model="showCase.user.parts" onchange="angular.element(this).scope().uploadParts(this.files)">
														</div>
													</div>
													<div class="form-group" id="divImgParts">
														<div class="col-md-12">
															<a href="" data-lightbox="gallery">
																<img id="imgParts" class="img-responsive" src="">
															</a>
														</div>
													</div>
												</div>
												<div class="col-md-6 pull-right" style="margin-right: 0px">
													<div class="col-md-12 text-center">
														<div class="btn bg-color-blueDark txt-color-white" id="save_order" ng-click="showCase.addRow()" ng-disabled="userForm.$invalid">
															<i class="fa fa-save"></i>
															&nbsp;Save
														</div>
														<div class="btn btn-default">
															<i class="fa fa-sign-out"></i>
															&nbsp;Cancel
														</div>
													</div>
												</div>
											</div>
										</div>
									</fieldset>
								</form>
							</div>
							<div class="tab-pane fade" id="s4">
								<input type='hidden' name="pp_code" id="pp_code" value="">
								<form class="form-horizontal" role="form" id="order_information" name="partForm" ng-submit="showCase.submitForm()" novalidate>
									<div class="row">
										<div class="col-md-6">
											<fieldset>
												<legend class="fcollapsible">Pattern Part</legend>
												<div class="fcontent">
													<div class="form-group">
												    	<label class="control-label col-sm-3 text-left">Part</label>
												    	<div class="col-sm-9">
												      		<input type="text" class="form-control" id="partcode" placeholder="" ng-model="showCase.user.partcode" ng-pattern="showCase.regex"  required>
												      		<p ng-show="partForm.partcode.$error.required && !partForm.partcode.$pristine" class="help-block">Code is required</p>
                                                            <p ng-show="partForm.partcode.$error.pattern  && !partForm.partcode.$pristine" class="help-block">Can not enter special char</p>
												    	</div>
												  	</div>
												  	<div class="form-group">
												    	<label class="control-label col-sm-3 text-left">Description</label>

												  	</div>
												  	<div class="form-group">
                                                    	<div class="col-md-12 pull-left">
                                                        	 <ul class="nav nav-tabs">
				                                                <li ng-repeat="item in showCase.dataDesPart" ng-class="{'active':$first}"><a data-toggle="tab" href="##{{item.id_language}}{{item.lg_code}}{{item.id_language}}">{{item.lg_code}}</a></li>
				                                            </ul>
				                                            <div class="tab-content">
				                                                <div ng-repeat="item in showCase.dataDesPart" id="{{item.id_language}}{{item.lg_code}}{{item.id_language}}" class="tab-pane fade" ng-class="{'in active':$first}">
				                                                    <textarea class="form-control partDescription" placeholder="in {{item.lg_name}}" name="{{item.lg_code}}" id="{{item.lg_code}}{{item.id_language}}{{item.id_language}}{{item.lg_code}}" ng-model="item.description"></textarea>
				                                                </div>
				                                            </div>
                                                    	</div>
                                                    </div>
												  	<div class="form-group text-center">
												      	<div class="btn bg-color-blueDark txt-color-white" id="btnAddPatternPart" ng-click="showCase.addPatternPart()" ng-disabled="partForm.$invalid">
															<i class="fa fa-save"></i>
															&nbsp;Add/Update
														</div>
												      	<div class="btn btn-default" id="btnRefreshPatternPart" ng-click="showCase.refreshPart()">
															<i class="fa fa-refresh"></i>
															&nbsp;Refresh
														</div>
												  	</div>
												</div>
											</fieldset>
										</div>
										<div class="col-md-6">
											<fieldset>
												<legend class="fcollapsible">Pattern Part List</legend>
												<div class="fcontent">
													<div class="table-responsive">
														<table id="datatable_part" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptions3" dt-columns="showCase.dtColumns3" dt-instance="showCase.dtInstance3">
														</table>
													</div>
												</div>
											</fieldset>
										</div>
									</div>
								</form>
							</div>
							<div class="tab-pane fade" id="s2">
								<form class="form-horizontal" role="form" id="order_information" name="variForm" ng-submit="showCase.submitForm()" novalidate>
									<input type='hidden' name="pv_code_temp" id="pv_code_temp" value="">
									<div class="row">
										<div class="col-md-6">
											<legend class="fcollapsible">Pattern Vari</legend>
											<div class="fcontent">
												<div class="form-group">
											    	<label class="control-label col-sm-2 text-left">VAR. Code</label>
											    	<div class="col-sm-10">
											      		<input type="text" class="form-control" id="varicode" placeholder="" ng-model="showCase.user.varicode" ng-pattern="showCase.regex"  required>
											      		<p ng-show="variForm.varicode.$error.required && !variForm.varicode.$pristine" class="help-block">Code is required</p>
                                                        <p ng-show="variForm.varicode.$error.pattern  && !variForm.varicode.$pristine" class="help-block">Can not enter special char</p>
											    	</div>
											  	</div>
											  	<div class="form-group">
											    	<label class="control-label col-sm-2 text-left">Description</label>
											   	</div>
											    <div class="form-group">
                                                	<div class="col-md-12 pull-left">
                                                    	 <ul class="nav nav-tabs">
			                                                <li ng-repeat="item in showCase.dataDesVari" ng-class="{'active':$first}"><a data-toggle="tab" href="##{{item.id_language}}{{item.lg_code}}{{item.id_language}}{{item.id_language}}">{{item.lg_code}}</a></li>
			                                            </ul>
			                                            <div class="tab-content">
			                                                <div ng-repeat="item in showCase.dataDesVari" id="{{item.id_language}}{{item.lg_code}}{{item.id_language}}{{item.id_language}}" class="tab-pane fade" ng-class="{'in active':$first}">
			                                                    <textarea class="form-control variDescription" placeholder="in {{item.lg_name}}" name="{{item.lg_code}}" id="{{item.lg_code}}{{item.id_language}}{{item.id_language}}{{item.lg_code}}" ng-model="item.description"></textarea>
			                                                </div>
			                                            </div>
                                                	</div>
                                                </div>
												<div class="form-group">
											    	<label class="control-label col-sm-2 text-left">Part</label>
											    	<div class="col-sm-10">
											      		<input type="text" class="form-control" id="varipart" placeholder="" ng-model="showCase.user.varipart" ng-pattern="showCase.regexPartVari"  required>
											      		<p ng-show="variForm.varipart.$error.required && !variForm.varipart.$pristine" class="help-block">Code is required</p>
                                                        <p ng-show="variForm.varipart.$error.pattern  && !variForm.varipart.$pristine" class="help-block">Can not enter special char</p>
											    	</div>
											  	</div>
											  	<div class="form-group">
													<label class="col-md-2 control-label text-left">Sketch</label>
													<div class="col-md-7">
														<input type="file" class="btn btn-default btn-block" id="varisketch" name="varisketch" ng-model="showCase.user.varisketch" onchange="angular.element(this).scope().uploadVariSketch(this.files)">
															<!--- <p ng-show="userForm.varisketch.$error.required && !userForm.varisketch.$pristine" class="help-block">Sketch is required</p> --->
													</div>
												</div>
												<div class="form-group">
													<div class="col-md-2"></div>
													<div class="col-md-8"  id="divImgVari">
														<a href="" data-lightbox="galleryVari">
															<img class="img-responsive" id="imgVari" src="">
														</a>
													</div>
													<div class="col-md-2"></div>
												</div>
											  	<div class="form-group text-center">
											      	<div class="btn bg-color-blueDark txt-color-white" id="btnVariAddRow" ng-click="showCase.addPatternVari()" ng-disabled="variForm.$invalid">
														<i class="fa fa-save"></i>
														&nbsp;Add/Update
													</div>
											      	<div class="btn btn-default" id="btnVariRefresh">
														<i class="fa fa-refresh"></i>
														&nbsp;Refresh
													</div>
											  	</div>
											</div>
										</div>
										<div class="col-md-6">
											<fieldset>
												<legend class="fcollapsible">Pattern Vari List</legend>
												<div class="fcontent">
													<div class="table-responsive">
														<table id="datatable_vari" class="table table-striped table-bordered" width="100%" datatable dt-options="showCase.dtOptions4" dt-columns="showCase.dtColumns4" dt-instance="showCase.dtInstance4">
														</table>
													</div>
												</div>
											</fieldset>
										</div>
									</div>
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
<script src="/includes/js/jquery.dataTables.min.js"></script>
<script src="/includes/js/angular-datatables.min.js"></script>
<script src="/includes/js/dataTables.lightColumnFilter.min.js"></script>
<script src="/includes/js/views/pattern.list.js"></script>
<script src="/includes/js/angular-datatables.light-columnfilter.min.js"></script>