(function(){
  angular.module('product.List', ['datatables', 'datatables.light-columnfilter', 'ui.select2']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  function BindAngularDirectiveCtrl($scope ,$filter,$http ,$compile, DTOptionsBuilder, DTColumnBuilder, $window)
  {
		var vm                   = this;
		vm.message               = '';
		vm.addNewProduct         = addNewProduct;
		vm.deleteProduct         = deleteProduct;
		vm.doubleclickHandler    = doubleclickHandler;
		vm.showModalAddNew       = showModalAddNew;
		vm.showModalEditProduct  = showModalEditProduct;
		vm.saveUpdateProduct     = saveUpdateProduct;
		vm.goToDetail     		 = goToDetail;
		vm.refresh               = refresh;
		vm.dtInstance1           = {};
		vm.dtInstance2           = {};
		vm.dtInstance3           = {};
		vm.regex                 = "[a-z A-Z 0-9-\_\.]+";
		vm.isDisabledVer         = true;
		vm.isDisabledPatVar      = true;
		vm.changecost_season     = changecost_season;
		vm.changepattern 	     = changepattern;
		vm.getPrdType 		     = getPrdType;
		vm.getPattern 		     = getPattern;
		vm.changePriceListZone 	 = changePriceListZone;
		vm.changeZone 			 = changeZone;
		vm.changeAgent 			 = changeAgent;
		vm.user                  = [];
		vm.zoneRequired		     = true;
		vm.agentRequired	     = true;
		var original             = angular.copy(vm.user);
		vm.isFullEdit = false;
		vm.prd = {};

	  	// $http.get("/index.cfm/product/getprojects").success(function(dataResponse){
    //     	vm.projects = dataResponse;
    //   	});
      	$.ajax({
	      async: false,
	      type: 'GET',
	      url: '/index.cfm/basicdata/getUserLevel',
	      success: function(data) {
	           //callback
	             vm.userInfo = data;
	            if( vm.userInfo.TYPEUSER == 1){
	           		$('#divTagZone').removeClass('display-none');
	            	$('#divTagAgent').removeClass('display-none');
	            	$http.get("/index.cfm/product/getZone").success(function(dataResponse){
			        	vm.zone = dataResponse;
			      	});
	            }else if( vm.userInfo.TYPEUSER == 2){
	            	vm.zoneRequired = false;
	            	$('#divTagAgent').removeClass('display-none');
	            	$http.get("/index.cfm/product/getAgent").success(function(dataResponse){
			        	vm.agent = dataResponse;
			      	});
	            }else if(vm.userInfo.TYPEUSER == 3){
	            	vm.zoneRequired  = false;
	            	vm.agentRequired = false;
	            	$http.get("/index.cfm/product/getplz_id").success(function(dataResponse){
			        	vm.plz 		= dataResponse.priceList;
					   	vm.projects = dataResponse.project;
			      	});
	            }
	        }
	  	});

	  	// $http.get("/index.cfm/product/getcost_code").success(function(dataResponse){
    //     	vm.cost_codes = dataResponse;
    //   	});


	  	// $http.get("/index.cfm/product/getproducttype").success(function(dataResponse){
    //     	vm.tpList = dataResponse;
    //   	});


	  	// $http.get("/index.cfm/product/getPattern").success(function(dataResponse){
    //     	vm.patterns = dataResponse;
    //   	});


	  	$http.get("/index.cfm/product/getSizes").success(function(dataResponse){
        	vm.sizes = dataResponse;
      	});

      	$http.get("/index.cfm/product/getImagesOfProducts").success(function(dataResponse){
        	vm.lstImages = dataResponse;
      	});

		vm.dtOptionsTextViewTable = DTOptionsBuilder.fromSource('/index.cfm/product/getProduct')
		  .withPaginationType('full_numbers')
		  .withLightColumnFilter({
	            '0' : {
	                type : 'text'
	            },
	            '1' : {
	                type : 'text'
	            },
	            '2' : {
	                type : 'text'
	            },
	            '3' : {
	                type : 'text'
	            },
	            '4' : {
	                type : 'text'
	            },
	            '5' : {
	                type : 'text'
	            },
	            '6' : {
	                type : 'text'
	            },
	            '7' : {
	                type : 'text'
	            },
	            '8' : {
	                type : 'text'
	            },
	            '9' : {
	                type : 'text'
	            },
	            '10' : {
	                type : 'text'
	            },
	            '11' : {
	                type : 'text'
	            },
	            '12' : {
	                type : 'text'
	            },
	            '13' : {
	                type : 'text'
	            },
	            '14' : {
	                type : 'text'
	            },
	            '15' : {
	                type : 'text'
	            }
          	})
		  	.withOption('createdRow', createdRow)
		  	.withOption('select', { style: 'single' });

		vm.dtColumnsTextViewTable = [
			DTColumnBuilder.newColumn('IDPRODUCT').withTitle('PRODUCT'),
		  	DTColumnBuilder.newColumn('GARMENTCODE').withTitle('CODE'),
		  	DTColumnBuilder.newColumn('VERSION').withTitle('VERSION'),
		  	DTColumnBuilder.newColumn('COST_CODE').withTitle('CODE'),
		  	DTColumnBuilder.newColumn('COST_CODE_VERS').withTitle('VERSION'),
		  	DTColumnBuilder.newColumn('DESCRIPTION').withTitle('DESCRIPTION'),
		  	DTColumnBuilder.newColumn('SIZES').withTitle('SIZES'),
		  	DTColumnBuilder.newColumn('ZONE').withTitle('ZONE'),
		  	DTColumnBuilder.newColumn('AGENT').withTitle('AGENT'),
		  	DTColumnBuilder.newColumn('CUSTOMER').withTitle('CUSTOMER'),
		  	DTColumnBuilder.newColumn('SECTION').withTitle('SECTION'),
		  	DTColumnBuilder.newColumn('STATUS').withTitle('STATUS'),
		  	DTColumnBuilder.newColumn(null).withTitle('DETAIL').renderWith(actionsHtmlDetail).withOption('width', "4%").withClass("text-center").notSortable(),
		  	DTColumnBuilder.newColumn(null).withTitle('ACTIONS').renderWith(actionsHtml).notSortable()
		];

		vm.dtColumnsTextImagesViewTable = [
			DTColumnBuilder.newColumn('IDPRODUCT').withTitle('PRODUCT'),
		  	DTColumnBuilder.newColumn('GARMENTCODE').withTitle('CODE'),
		  	DTColumnBuilder.newColumn('VERSION').withTitle('VERSION'),
		  	DTColumnBuilder.newColumn('COST_CODE').withTitle('CODE'),
		  	DTColumnBuilder.newColumn('COST_CODE_VERS').withTitle('VERSION'),
		  	DTColumnBuilder.newColumn('DESCRIPTION').withTitle('DESCRIPTION'),
		  	DTColumnBuilder.newColumn('SIZES').withTitle('SIZES'),
		  	DTColumnBuilder.newColumn('ZONE').withTitle('ZONE'),
		  	DTColumnBuilder.newColumn('AGENT').withTitle('AGENT'),
		  	DTColumnBuilder.newColumn('CUSTOMER').withTitle('CUSTOMER'),
		  	DTColumnBuilder.newColumn('SECTION').withTitle('SECTION'),
		  	DTColumnBuilder.newColumn('STATUS').withTitle('STATUS'),
		  	DTColumnBuilder.newColumn('SKETCH').withTitle('SKETCH').renderWith(sketchDisplay),
		  	DTColumnBuilder.newColumn(null).withTitle('DETAIL').renderWith(actionsHtmlDetail).withOption('width', "4%").withClass("text-center").notSortable(),
		  	DTColumnBuilder.newColumn(null).withTitle('ACTIONS').renderWith(actionsHtml).notSortable()
		];

		vm.dtColumnsTextPricesViewTable = [
			DTColumnBuilder.newColumn('IDPRODUCT').withTitle('PRODUCT'),
		  	DTColumnBuilder.newColumn('GARMENTCODE').withTitle('CODE'),
		  	DTColumnBuilder.newColumn('VERSION').withTitle('VERSION'),
		  	DTColumnBuilder.newColumn('COST_CODE').withTitle('CODE'),
		  	DTColumnBuilder.newColumn('COST_CODE_VERS').withTitle('VERSION'),
		  	DTColumnBuilder.newColumn('DESCRIPTION').withTitle('DESCRIPTION'),
		  	DTColumnBuilder.newColumn('CUSTOMER').withTitle('CUSTOMER'),
		  	DTColumnBuilder.newColumn('STATUS').withTitle('STATUS'),
		  	DTColumnBuilder.newColumn('PRICE').withTitle('PRICE LIST').renderWith(priceDisplay).withClass('text-right  th-align-left'),
		  	DTColumnBuilder.newColumn('MANUAL').withTitle('MANUAL').renderWith(manualDisplay).withClass('text-right  th-align-left'),
		  	DTColumnBuilder.newColumn('CUSTOMIZE').withTitle('CUSTOM').renderWith(customizeDisplay).withClass('text-right  th-align-left'),
		  	DTColumnBuilder.newColumn('VALID').withTitle('FINAL').renderWith(validDisplay).withClass('text-right  th-align-left'),
		  	DTColumnBuilder.newColumn('CLUB_12').withTitle('PRICE CLUB').renderWith(priceClubDisplay).withClass('text-right  th-align-left'),
		  	DTColumnBuilder.newColumn('WEB_13').withTitle('PRICE WEB').renderWith(priceWebDisplay).withClass('text-right  th-align-left'),
		  	DTColumnBuilder.newColumn('SKETCH').withTitle('SKETCH').renderWith(sketchDisplay),
		  	DTColumnBuilder.newColumn(null).withTitle('DETAIL').renderWith(actionsHtmlDetail).withOption('width', "4%").withClass("text-center").notSortable(),
		  	DTColumnBuilder.newColumn(null).withTitle('ACTIONS').renderWith(actionsHtmlFull).notSortable()
		];
		function goToDetail(productID) {
            window.location.href = "/index.cfm/product.edit?id=" + productID;
        }
		function actionsHtmlDetail(data, type, full, meta) {
            return '<span class="txt-color-green btngotodetail" title="Go to product detail" ng-click="showCase.goToDetail(' + data.IDPRODUCT + ')">' +
                '<i class="ace-icon bigger-130 fa fa-sign-out"></i></span>';
        }
		function priceDisplay(data, type, full, meta) {
			 if( vm.userInfo.TYPEUSER == 1 || vm.userInfo.TYPEUSER == 0){
				return '<span style="minheight:50px;">' +$filter("number")(data.sell_4,2) + '</span><hr><span style="minheight:50px;">' + $filter("number")(data.sell_6,2) + '</span><hr><span style="minheight:50px;">' + $filter("number")(data.pvpr_8,2) + '</span>';
			}else if(vm.userInfo.TYPEUSER == 2){
				return '</span><span style="minheight:50px;">' + $filter("number")(data.sell_6,2) + '</span><hr><span style="minheight:50px;">' + $filter("number")(data.pvpr_8,2) + '</span>';
			}else if(vm.userInfo.TYPEUSER == 3){
				return '</span><span style="minheight:50px;">' + $filter("number")(data.pvpr_8,2) + '</span>';
			}else{
				return '';
			}
		}
		function priceClubDisplay(data, type, full, meta) {
			return '<span style="minheight:50px;">' +$filter("number")(data,2)+'</span>';
		}
		function priceWebDisplay(data, type, full, meta) {
			return '<span style="minheight:50px;">' +$filter("number")(data,2)+'</span>';
		}

		function customizeDisplay(data, type, full, meta) {
			if( vm.userInfo.TYPEUSER == 1 || vm.userInfo.TYPEUSER == 0){
				return '<span style="minheight:50px;">' + $filter("number")(data.cst_fty,2) + '</span><hr><span style="minheight:50px;">' + $filter("number")(data.cst_zone,2) + '</span><hr><span style="minheight:50px;">' + $filter("number")(data.cst_cs,2) + '</span>';
			}else if(vm.userInfo.TYPEUSER == 2){
				return '</span><span style="minheight:50px;">' + $filter("number")(data.cst_zone,2) + '</span><hr><span style="minheight:50px;">' + $filter("number")(data.cst_cs,2) + '</span>';
			}else if(vm.userInfo.TYPEUSER == 3){
				return '</span><span style="minheight:50px;">' + $filter("number")(data.cst_cs,2) + '</span>';
			}else{
				return '';
			}

		}

		function manualDisplay(data, type, full, meta) {
			if( vm.userInfo.TYPEUSER == 1 || vm.userInfo.TYPEUSER == 0){
				return '<span style="minheight:50px;">' + $filter("number")(data.sell_9,2) + '</span><hr><span style="minheight:50px;">' + $filter("number")(data.sell_10,2) + '</span><hr><span style="minheight:50px;">' + $filter("number")(data.pvpr_11,2) + '</span>';
			}else if(vm.userInfo.TYPEUSER == 2){
				return '</span><span style="minheight:50px;">' + $filter("number")(data.sell_10,2) + '</span><hr><span style="minheight:50px;">' + $filter("number")(data.pvpr_11,2) + '</span>';
			}else if(vm.userInfo.TYPEUSER == 3){
				return '</span><span style="minheight:50px;">' + $filter("number")(data.pvpr_11,2) + '</span>';
			}else{
				return '';
			}
		}

		function validDisplay(data, type, full, meta) {
			if( vm.userInfo.TYPEUSER == 1 || vm.userInfo.TYPEUSER == 0){
				return '<span style="minheight:50px;">' + $filter("number")(data.valid9,2) + '</span><hr><span style="minheight:50px;">' + $filter("number")(data.valid10,2) + '</span><hr><span style="minheight:50px;">' + $filter("number")(data.valid11,2) + '</span>';
			}else if(vm.userInfo.TYPEUSER == 2){
				return '</span><span style="minheight:50px;">' + $filter("number")(data.valid10,2) + '</span><hr><span style="minheight:50px;">' + $filter("number")(data.valid11,2) + '</span>';
			}else if(vm.userInfo.TYPEUSER == 3){
				return '</span><span style="minheight:50px;">' + $filter("number")(data.valid11,2) + '</span>';
			}else{
				return '';
			}
		}

		function actionsHtml(data, type, full, meta) {
          	return '<span class="txt-color-green btnedit" title="Edit product" ng-click="showCase.showModalEditProduct(' + full.IDPRODUCT + ', false)">' +
	                    '<i class="ace-icon bigger-130 fa fa-pencil"></i></span>' +
	                '<span class="txt-color-red btndelete" title="Delete product" ng-click="showCase.deleteProduct(' + full.IDPRODUCT + ')">' +
	                    '<i class="ace-icon bigger-130 fa fa-trash-o"></i></span>';
      	}

      	function actionsHtmlFull(data, type, full, meta) {
          	return '<span class="txt-color-green btnedit" title="Edit product" ng-click="showCase.showModalEditProduct(' + full.IDPRODUCT + ', true)">' +
	                    '<i class="ace-icon bigger-130 fa fa-pencil"></i></span>' +
	                '<span class="txt-color-red btndelete" title="Delete product" ng-click="showCase.deleteProduct(' + full.IDPRODUCT + ')">' +
	                    '<i class="ace-icon bigger-130 fa fa-trash-o"></i></span>';
      	}

      	function showModalEditProduct(id, isfull) {
      		$http.get("/index.cfm/product/getInfoToEditById/?id_product=" + id).success(function(dataResponse){
	        	if(dataResponse.success == true) {
	        		vm.user.pr_version = dataResponse.data.PRVERSION;
		        	vm.user.pr_des	   = dataResponse.data.PRDES;
		        	vm.user.pricefty	   = dataResponse.data.SELL_9;
		        	vm.user.pricezone	   = dataResponse.data.SELL_10;
		        	vm.user.pricecustomer	   = dataResponse.data.PVPR_11;
		        	vm.user.priceclub	   = dataResponse.data.CLUB_12;
		        	vm.user.priceweb	   = dataResponse.data.WEB_13;
		        	vm.user.prId 		   = dataResponse.data.PRID;
		        	vm.isFullEdit = isfull;
	      			$('#editProduct').modal("show");
	        	}
	        	else {
	        		noticeFailed(data.message);
	        	}
	      	});
      	}

		function sketchDisplay(data, type, full, meta){
	        return ' <a href="/includes/img/ao/' + data + '" data-lightbox="gallery">' +
	        		'<img src="/includes/img/ao/' + data + '" class="img-responsive"  alt="' + data + '" width="150"> ' +
	        		'</a>';
       	}

		vm.fd = new FormData();
     	$scope.uploadFile = function(files) {
          	//Take the first selected file
          	vm.fd.append("image", files[0]);
      	};

      	$scope.uploadPicture = function(files) {
          	//Take the first selected file
          	vm.fd.append("picture", files[0]);
      	};

      	function showModalAddNew() {
      		$('#addNew').modal("show");
      	}

      	function addNewProduct() {
      		vm.fd.append('pr_version',  	vm.user.pr_version);
      		vm.fd.append('id_project',  		vm.user.project);
      		vm.fd.append('id_cost',  	vm.user.cost_code);
      		vm.fd.append('id_cost_version',  	vm.user.cost_version);
      		vm.fd.append('id_tp_code',  		vm.user.tp_id);
      		vm.fd.append('id_pattern',  		vm.user.pattern);
      		vm.fd.append('id_pattern_var',  	vm.user.pattern_var);
      		vm.fd.append('id_size',  			vm.user.size);
      		vm.fd.append('section',  		vm.user.section);
      		vm.fd.append('pr_des', 			vm.user.pr_des);
      		vm.fd.append('id_plz_id', 			vm.user.plz_id);
      		$.ajax({
				type: "POST",
				url: "/index.cfm/product/addNewProduct",
				async: false,
				data: vm.fd,
				processData: false,
				contentType: false,
				success: function( data ) {
					if(data.success)
					{
					  noticeSuccess(data.message);
					  vm.dtInstance1.reloadData();
					  vm.dtInstance2.reloadData();
					  window.location.href = "/index.cfm/product.edit?id=" + data.id_product;
					}
					else
					{
					  noticeFailed(data.message);
					}
					$("addNew").modal('hide');

					vm.fd = null;
					vm.fd = new FormData();
				}
	        });
      	}

  	 	function doubleclickHandler(info) {
	        window.location.href = "/index.cfm/product.edit?id=" + info.IDPRODUCT;
      	}

       	function createdRow(row, data, dataIndex) {
	        // Recompiling so we can bind Angular directive to the DT
         	$('td', row).unbind('dblclick');
	        $('td', row).bind('dblclick', function() {
	            $scope.$apply(function() {
	                vm.doubleclickHandler(data);
	            });
	        });
	        $compile(angular.element(row).contents())($scope);
       	}


      	function refresh () {
			vm.user= angular.copy(original);
			$scope.userForm.$setPristine();
      	}

      	function changeZone(){
      		$.ajax({
			    async: false,
			    type: 'POST',
			    url: '/index.cfm/product/getAgent',
			    data: {
			    	id_zone : vm.user.zoneID
			    },
			    success: function(data) {
			    	if(data.length > 0){
			    		vm.agent = data;
	      			}else{

	      			}
		      	}
		  	});
      	}
      	function changeAgent(){
      		$.ajax({
			    async: false,
			    type: 'POST',
			    url: '/index.cfm/product/getplz_id',
			    data: {
			    	id_agent : vm.user.agentID
			    	,id_zone  : vm.user.zoneID
			    },
			    success: function(data) {
			    	if(data.priceList.length > 0){
			    		vm.plz = data.priceList;

	      			}else{
	      				noticeFailed("No price list for this agent!");
	      			}

	      			if(data.project.length > 0){
	      				vm.projects = data.project;
	      			}else{
	      				noticeFailed("No project for this agent!");
	      			}
		      	}
		  	});
      	}

      	function changecost_season() {
      		$.ajax({
			    async: false,
			    type: 'POST',
			    url: '/index.cfm/product/getcost_version',
			    data: {
			    	id_cost : vm.user.cost_code
			    },
			    success: function(data) {
			    	if(data.length > 0){
			    		vm.pattern_vars = "";
			    		vm.user.pattern_var = "";
						vm.versions = data;
	      				vm.isDisabledVer = false;
	      				getPrdType();
	      				getPattern();
	      			}else{
	      				noticeFailed("No cost version for this cost code!");
	      				refreshValue();
	      				vm.pattern_vars = "";
	      			}
		      	}
		  	});
      	}
      	function refreshValue(){
      		vm.versions = "";
			vm.tpList 	= "";
			vm.patterns = "";
      	}

      	function getPattern(){
      		$.ajax({
			    async: false,
			    type: 'POST',
			    url: '/index.cfm/product/getPattern',
			    data: {
			    	tp_id : vm.user.tp_id
			    },
			    success: function(data) {
			    	if(data.length > 0){
			    		vm.patterns = data;
			    	}else{
			    		noticeFailed("No pattern for this type of product!");
			    		vm.patterns = "";
			    	}
		      	}
		  	});
      	}
      	function changePriceListZone(){
      		$.ajax({
			    async: false,
			    type: 'POST',
			    url: '/index.cfm/product/getcost_code',
			    data: {
			    	plz_id : vm.user.plz_id
			    },
			    success: function(data) {
			    	if(data.length > 0){
			    		refreshValue();
				    	vm.cost_codes = data;
				    	vm.versions = "";
			    	}else{
			    		var message = "No cost for this price list!";
			    		if(data.message != null){
			    			message = data.message;
			    		}
			    		noticeFailed(message);
			    		refreshValue();
				    	vm.versions 	= "";
				    	vm.cost_codes 	= "";
			    	}
		      	}
		  	});

      	}

     //  	function getplz_id(){
     //  		$.ajax({
			  //   async: false,
			  //   type: 'POST',
			  //   url: '/index.cfm/product/getplz_id',
			  //   data: {
			  //   	id_project : vm.user.project
			  //   },
			  //   success: function(data) {
			  //   	if(data.length > 0){

			  //   	}else{

			  //   	}

		   //    	}
		  	// });
     //  	}

      	function refreshValue(){
      		vm.versions = "";
			vm.tpList 	= "";
			vm.patterns = "";
      	}

      	function getPrdType(){
      		$.ajax({
			    async: false,
			    type: 'POST',
			    url: '/index.cfm/product/getPrdTypeByCost',
			    data: {
			    	id_cost : vm.user.cost_code
			    },
			    success: function(data) {
			    	if(data.length > 0){
			    		vm.tpList = data;
			    		vm.user.tp_id = data[0].tp_id;
			    	}else{
			    		noticeFailed("No product type for this cost code!");
			    	}
		      	}
		  	});
      	}

      	function changepattern() {

      		$.ajax({
			    async: false,
			    type: 'POST',
			    url: '/index.cfm/product/getPattern',
			    data: {
			    	tp_id : vm.user.tp_id
			    },
			    success: function(data) {
			    	if(data.length > 0){
//
// 						vm.pattern_vars = data;
// 	      				vm.isDisabledPatVar = false;
// 	      			}else{
// 	      				noticeFailed("No pattern variations type for this pattern!");
// 	      				vm.pattern_vars = "";
// 	      			}
//
			    		vm.patterns = data;
			    	}else{
			    		noticeFailed("No pattern for this type of product!");
			    		vm.patterns = "";
			    	}
		      	}
		  	});
      	}
      	function changePriceListZone(){
      		$.ajax({
			    async: false,
			    type: 'POST',
			    url: '/index.cfm/product/getcost_code',
			    data: {
			    	plz_id : vm.user.plz_id
			    },
			    success: function(data) {
			    	if(data.length > 0){
			    		refreshValue();
				    	vm.cost_codes = data;
				    	vm.versions = "";
			    	}else{
			    		var message = "No cost for this price list!";
			    		if(data.message != null){
			    			message = data.message;
			    		}
			    		noticeFailed(message);
			    		refreshValue();
				    	vm.versions 	= "";
				    	vm.cost_codes 	= "";
			    	}
		      	}
		  	});

      	}

      	function getPrdType(){
      		$.ajax({
			    async: false,
			    type: 'POST',
			    url: '/index.cfm/product/getPrdTypeByCost',
			    data: {
			    	id_cost : vm.user.cost_code
			    },
			    success: function(data) {
			    	if(data.length > 0){
			    		vm.tpList = data;
			    		vm.user.tp_id = data[0].tp_id;
			    	}else{
			    		noticeFailed("No product type for this cost code!");
			    	}
		      	}
		  	});
      	}

      	function changepattern() {
      		$.ajax({
			    async: false,
			    type: 'POST',
			    url: '/index.cfm/product/getPatternVar',
			    data: {
			    	id_pattern : vm.user.pattern
			    },
			    success: function(data) {
			    	if(data.length > 0){
						vm.pattern_vars = data;
	      				vm.isDisabledPatVar = false;
	      			}else{
	      				noticeFailed("No pattern variations type for this pattern!");
	      				vm.pattern_vars = "";
	      			}
		      	}
		  	});
      	}

      	function deleteProduct(id) {
      		var confirm = window.confirm("Do you want to delete this Product?");
      		if(confirm){
	      		$.ajax({
				    async: false,
				    type: 'POST',
				    url: '/index.cfm/product/deleteProduct',
				    data: {
				    	id_product : id
				    },success: function(data) {
						if(data.success) {
							noticeSuccess(data.message);
						  	vm.dtInstance1.reloadData();
				  			vm.dtInstance2.reloadData();
						}
						else {
							noticeFailed(data.message);
						}
			      	}
			  	});
      		}
      	}

      	function saveUpdateProduct() {
      		$.ajax({
			    async: false,
			    type: 'POST',
			    url: '/index.cfm/product/updateInfoProduct',
			    data: {
			    	prversion : vm.user.pr_version,
		        	prdes : vm.user.pr_des,
		        	pricefty : vm.user.pricefty,
		        	pricezone : vm.user.pricezone,
		        	pricecustomer : vm.user.pricecustomer,
		        	priceclub : vm.user.priceclub,
		        	priceweb : vm.user.priceweb,
		        	prId : vm.user.prId,
		        	isFullEdit : vm.isFullEdit
			    },
			    success: function(data) {
					if(data.success) {
						noticeSuccess(data.message);
					  	vm.dtInstance1.reloadData();
			  			vm.dtInstance2.reloadData();
			  			vm.dtInstance3.reloadData();
			  			$('#editProduct').modal("hide");
					}
					else {
						noticeFailed(data.message);
					}
		      	}
		  	});
      	}
  	};

})();
