(function(){
  	var app = angular.module('price_list_zone_detail', ['datatables', 'datatables.light-columnfilter', 'ui.select2']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)
  	function BindAngularDirectiveCtrl($scope ,$filter, $http ,$compile, DTOptionsBuilder, DTColumnBuilder)
  	{
    	var vm = this;

    	vm.user            = {};
    	vm.user.disable    = false;
    	vm.regexNumber     = /^[0-9]+([\.][0-9]+)?$/;
    	vm.dtInstance      = {};
    	vm.plz_dets        = {};
    	vm.changePLC       = changePLC;
    	vm.UpdatePLZD 	   = UpdatePLZD;
    	vm.enableEditing	= enableEditing;
    	vm.refreshEdit 		= refreshEdit;
    	vm.editing 		   = false;
    	vm.metadata 	   = -1;
    	vm.UpdatePLZ 	   = UpdatePLZ;
    	vm.refreshEditPLZD = refreshEditPLZD;
    	vm.resetRecomendedManual = resetRecomendedManual;
    	vm.resetAgentManual = resetAgentManual;
    	vm.plzdEditData		= [];
    	vm.seasons      	= [2016,2017,2018,2019,2020,2021,2022,2023,2024,2025,2026,2027,2028,2029,2030,2031,2032,2033,2034,2035,2036,2037,2038,2039,2040,2041,2042,2043,2044,2045,2046,2047,2048,2049,2050];
    	var originalPLZD   = angular.copy(vm.plz_dets);

     	vm.dtColumns_detail  = [
     		DTColumnBuilder.newColumn('COST_CODE').withTitle('CODE'),
			DTColumnBuilder.newColumn('CD_DESCRIPTION').withTitle('DESCRIPTION'),
     		DTColumnBuilder.newColumn('CV_VERSION').withTitle('No.').withClass("text-center"),
			DTColumnBuilder.newColumn('CVD_DESCRIPTION').withTitle('DESCRIPTION'),
			DTColumnBuilder.newColumn('PLZD_WEIGHT').withTitle('WEIGHT').withClass("text-right th-align-left"),
			DTColumnBuilder.newColumn('PLFD_FTY_SELL_3').withTitle('SELL PRICE').renderWith(formatNumber).withClass("text-right th-align-left"),
			DTColumnBuilder.newColumn('PLF_CURR_CODE').withTitle('CURRENCY'),
			DTColumnBuilder.newColumn('PLZD_FTY_SELL_4').withTitle('SELL PRICE').renderWith(formatNumber).withClass("text-right th-align-left"),
			DTColumnBuilder.newColumn('PLZ_CURR_CODE').withTitle('CURRENCY'),
			DTColumnBuilder.newColumn('PLZD_FREIGHT').withTitle('FREIGHT').renderWith(formatNumber).withClass("text-right th-align-left"),
			DTColumnBuilder.newColumn('PLZD_TAXES').withTitle('TAXES').renderWith(formatNumber).withClass("text-right th-align-left"),
			DTColumnBuilder.newColumn('PLZD_MARGIN').withTitle('MARGIN').renderWith(formatNumber).withClass("text-right th-align-left"),
			DTColumnBuilder.newColumn('PLZD_ZONE_SELL_5').withTitle('SELL CALC').renderWith(formatNumber).withClass("text-right th-align-left"),
			DTColumnBuilder.newColumn('PLZD_ZONE_SELL_6').withTitle('AGENT SELL PRICE').renderWith(plzZoneSell6Edit).withClass("text-right th-align-left"),
			DTColumnBuilder.newColumn('PLZD_MARGIN_1').withTitle('MARGIN APPLIED').renderWith(formatNumber).withClass("text-right th-align-left"),
			DTColumnBuilder.newColumn('PLZD_PVPR_7').withTitle('RECOMENDED PRICE - CALC').renderWith(formatNumber).withClass("text-right th-align-left"),
			DTColumnBuilder.newColumn('PLZD_PVPR_8').withTitle('RECOMENDED PRICE').renderWith(plzPVPR8Edit).withClass("text-right th-align-left"),
			DTColumnBuilder.newColumn('PLZD_MARGIN_2').withTitle('AGENT MARGIN').renderWith(formatNumber).withClass("text-right th-align-left")
      	];

      	function formatNumber(data, type, full, meta){
      		if(data < 1) return roundDecimalPlaces(data,2);
        	return $filter("number")(roundDecimalPlaces(data, 2),2);
        }

        function formatNumberThousand(data, places){
      		if(data < 1) return roundDecimalPlaces(data,places);
        	return $filter("number")(roundDecimalPlaces(data, places),places);
        }

        function plzZoneSell6Edit(data, type, full, meta){
        	var strStyle = '';
      		if(full.PLZD_ZONE_SELL_5 < full.PLZD_ZONE_SELL_6) {
      			strStyle = 'style="color: red;"';
      		}
        	return '<span '+ strStyle +'ng-hide="showCase.editing && showCase.isSell6 && showCase.metadata == '+meta.row+'" ng-click="showCase.enableEditing('+meta.row+',true)">' + $filter('number')(data, 2) + '</span>' +
  					'<input ng-show="showCase.editing && showCase.isSell6 && showCase.metadata == '+meta.row+'" ng-enter="showCase.UpdatePLZD(showCase.plzdEditData['+meta.row+'].ID,showCase.plzdEditData['+meta.row+'].PLZD_ZONE_SELL_6,showCase.plzdEditData['+meta.row+'].PLZD_PVPR_8)" autofocus ng-model="showCase.plzdEditData['+meta.row+'].PLZD_ZONE_SELL_6"/>' +
      				'<br/><span class="txt-color-green btnedit" title="Edit" ng-show="!(showCase.editing && showCase.isSell6 && showCase.metadata == '+meta.row+')" ng-click="showCase.enableEditing('+meta.row+',true)"><i class="ace-icon bigger-130 fa fa-pencil"></i></span>' +
      				'<span class="txt-color-red btnSave" ng-show="showCase.editing && showCase.isSell6 && showCase.metadata == '+meta.row+'" ng-click="showCase.UpdatePLZD(showCase.plzdEditData['+meta.row+'].ID,showCase.plzdEditData['+meta.row+'].PLZD_ZONE_SELL_6,showCase.plzdEditData['+meta.row+'].PLZD_PVPR_8)">' +
					'   <i class="ace-icon bigger-130 fa fa-floppy-o"></i>' +
					'</span>'+
					'<span class="txt-color-red btnSave" ng-show="showCase.editing && showCase.isSell6 && showCase.metadata == '+meta.row+'" ng-click="showCase.refreshEdit()">' +
					'   <i class="ace-icon bigger-130 fa fa-close"></i>' +
					'</span>';
        }

        function plzPVPR8Edit(data, type, full, meta){
        	var strStyle = '';
      		if(full.PLZD_PVPR_7 < full.PLZD_PVPR_8) {
      			strStyle = 'style="color: red;"';
      		}
        	return '<span '+ strStyle +'ng-hide="showCase.editing && !showCase.isSell6 && showCase.metadata == '+meta.row+'" ng-click="showCase.enableEditing('+meta.row+',false)">' + $filter('number')(data, 2) + '</span>' +
  					'<input ng-show="showCase.editing  && !showCase.isSell6 && showCase.metadata == '+meta.row+'" ng-enter="showCase.UpdatePLZD(showCase.plzdEditData['+meta.row+'].ID,showCase.plzdEditData['+meta.row+'].PLZD_ZONE_SELL_6,showCase.plzdEditData['+meta.row+'].PLZD_PVPR_8)" autofocus ng-model="showCase.plzdEditData['+meta.row+'].PLZD_PVPR_8"/>' +
      				'<br/><span class="txt-color-green btnedit" title="Edit" ng-show="!(showCase.editing  && !showCase.isSell6 && showCase.metadata == '+meta.row+')" ng-click="showCase.enableEditing('+meta.row+',false)"><i class="ace-icon bigger-130 fa fa-pencil"></i></span>' +
      				'<span class="txt-color-red btnSave" ng-show="showCase.editing  && !showCase.isSell6 && showCase.metadata == '+meta.row+'" ng-click="showCase.UpdatePLZD(showCase.plzdEditData['+meta.row+'].ID,showCase.plzdEditData['+meta.row+'].PLZD_ZONE_SELL_6,showCase.plzdEditData['+meta.row+'].PLZD_PVPR_8)">' +
					'   <i class="ace-icon bigger-130 fa fa-floppy-o"></i>' +
					'</span>'+
					'<span class="txt-color-red btnSave" ng-show="showCase.editing  && !showCase.isSell6 && showCase.metadata == '+meta.row+'" ng-click="showCase.refreshEdit()">' +
					'   <i class="ace-icon bigger-130 fa fa-close"></i>' +
					'</span>';
        }

        function enableEditing(metarow, isSell6){
        	vm.editing = true;
        	vm.metadata = metarow;
        	vm.isSell6 = isSell6;
        }

        function refreshEdit(){
        	vm.editing = true;
        	vm.metadata = -1;
        	vm.isSell6 = true;
        }

        $("#plz_ex_rate").keyup(function(){
        	var convertEx_rate = 1/$(this).val();
        	vm.user.convert_plz_ex_rate = formatNumberThousand(convertEx_rate,2);
        	$scope.$apply();
        });

      	function getQueryVariable(variable) {
		    var query = window.location.search.substring(1);
		    var vars = query.split('&');
		    for (var i = 0; i < vars.length; i++) {
		        var pair = vars[i].split('=');
		        if (decodeURIComponent(pair[0]) == variable) {
		            return decodeURIComponent(pair[1]);
		        }
		    }
		}
		function resetManual(isRecomended){
			$.ajax({
	          async:false,
	          type: 'POST',
	          url: '/index.cfm/price_list_zone_detail/resetManual',
	          data: {isRecomended : isRecomended?1:0, idplz: getQueryVariable('id')},
	          success: function(data){
	            if(data.success){
	            	noticeSuccess(data.message);
	            }else{
	            	noticeFailed(data.message);
	            }
	            vm.refreshEditPLZD();
	          }
	        });
		}
		function resetRecomendedManual(){
			var result = confirm('Do you want to reset Recomended Price?');
			if(result){
				resetManual(true);
			}
		}

		function resetAgentManual(){
			var result = confirm('Do you want to reset Agent Sell Price?');
			if(result){
				resetManual(false);
			}
		}

		function changePLC() {
	        $.ajax({
	          async:false,
	          type: 'POST',
	          url: '/index.cfm/price_list_zone/getCurr_convert',
	          data: {currency : vm.user.plz_curr},
	          success: function(data){
	             vm.user.cc_value = data.currency_convert.cc_value;
	             var ex_ratecc = roundDecimalPlaces(vm.user.plf_cc_ex_rate/data.currency_convert.cc_value,2);
	             var convert_exrate = formatNumberThousand(1/ex_ratecc,2);
	             vm.user.plz_ex_rate_1  = ex_ratecc;
	             vm.user.plz_ex_rate  = ex_ratecc;
	             vm.user.convert_plz_ex_rate = convert_exrate;
	             vm.user.convert_plz_ex_rate_1 = convert_exrate;
	          }
	        });
	    }

	    $("#plf_code").change(function(){
	    	var plfid = $(this).val();
	    	vm.user.plf_curr_code = vm.plftys[plfid].CURRENCY;
	    });

      	$.ajax({
	        async: false,
	        type: 'GET',
	        url: '/index.cfm/basicdata/getUserLevel',
	        success: function(data) {
	             //callback
	               vm.userInfo = data;
	               if( vm.userInfo.TYPEUSER == 1 || vm.userInfo.TYPEUSER == 2){
	               	sumColumnFilter = {'0' : {type : 'text'}, '1' : {type : 'text'}, '2' : {type : 'text'}, '3' : {type : 'text'}, '4' : {type : 'text'}, '5' : {type : 'text'}, '7' : {type : 'text'}, '9' : {type : 'text'}, '10' : {type : 'text'}, '11' : {type : 'text'}, '12' : {type : 'text'}, '13' : {type : 'text'}, '14' : {type : 'text'}, '15' : {type : 'text'}, '16' : {type : 'text'}, '17' : {type : 'text'}};
	               }
	               else if( vm.userInfo.TYPEUSER == 3){
	               	  userForm.$invalid = true;
	                  vm.dtColumns_detail.splice(4,9);
	                  vm.dtColumns_detail.splice(5,2);
	                  sumColumnFilter = {'0' : {type : 'text'}, '1' : {type : 'text'}, '2' : {type : 'text'}, '3' : {type : 'text'}, '4' : {type : 'text'}, '5' : {type : 'text'}, '6' : {type : 'text'}};
	                }
	                else{
	                  userForm.$invalid = true;
	                  vm.dtColumns_detail.splice(0,18);
	                  sumColumnFilter = {};
	                }
	        }
	      });

      	vm.dtOptions_detail  = DTOptionsBuilder.fromSource('/index.cfm/price_list_zone_detail/getPLZ_details?id_plz=' + getQueryVariable('id'))
          	.withPaginationType('full_numbers')
          	.withLightColumnFilter(sumColumnFilter)
          	.withOption('createdRow', createdRow)
          	.withOption('select', { style: 'single' });


      	$http.get("/index.cfm/basicdata/getlanguage").success(function(dataResponse){
	    	vm.languages = dataResponse;
	    });

	    // $http.get("/index.cfm/basicdata/getAgent").success(function(dataResponse){
	    // 	vm.agents = dataResponse;
	    // });

	    $http.get("/index.cfm/basicdata/getcurrency").success(function(dataResponse){
	        vm.currencylist = dataResponse;
	    });
	    $http.get("/index.cfm/price_list_zone_detail/getPlfty").success(function(dataResponse){
	        vm.plftys = dataResponse;
	    });

	    $(document).ready(function(){
	    	$.ajax({
	     		type: "POST",
				url: "/index.cfm/price_list_zone_detail/getplz",
				async: false,
				data: {
					'id_plz': getQueryVariable('id')
				},
				success: function(data) {
					vm.user.id              = data.id;
					vm.user.plz_code        = data.plz_code;
					vm.user.plz_curr_code   = data.plz_curr_code;
					vm.user.plz_curr        = data.plz_curr;
					vm.user.plz_correction  = data.plz_correction;
					vm.user.plz_description = data.plz_description;
					vm.user.plz_commission  = data.plz_commission;
					vm.user.plz_season      = data.plz_season;
					vm.user.plz_freight     = data.plz_freight;
					vm.user.id_plf          = data.id_plf;
					vm.user.plf_code        = data.plf_code;
					vm.user.plf_curr_code   = data.plf_curr_code;
					vm.user.plz_ex_rate     = data.plz_ex_rate;
					vm.user.plz_ex_rate_1 	= roundDecimalPlaces(data.plf_cc_ex_rate/data.cc_value,2);
					vm.user.plz_taxes       = data.plz_taxes;

					vm.user.plz_date      = data.plz_date ;//== "" ? new Date() : new Date(dateParts[2], (dateParts[1] - 1), dateParts[0]);
					vm.user.cc_value        = data.cc_value;
					vm.user.plz_margin      = data.plz_margin;
					vm.user.plf_cc_ex_rate  = data.plf_cc_ex_rate;
					vm.user.plz_update      = data.plz_update;//new Date(dateParts[2], (dateParts[1] - 1), dateParts[0]);
					vm.user.language        = data.language;
					vm.user.lg_name         = data.lg_name;

					vm.user.convert_plz_ex_rate = formatNumberThousand(1/data.plz_ex_rate,2);
					vm.user.convert_plz_ex_rate_1 = formatNumberThousand(1/vm.user.plz_ex_rate_1,2);

					$("#id_plz").val(data.id);
					$scope.$apply();
				}
	     	});
	    });


	    function UpdatePLZ(){
	    	$.ajax({
		        async: false,
		        type: 'POST',
		        url: '/index.cfm/price_list_zone_detail/updatePLZ',
		        data: {
					id_plz 		 	: $("#id_plz").val(),
					plz_code        : vm.user.plz_code,
					plz_description : vm.user.plz_description,
					plz_season      : vm.user.plz_season,
					id_plf          : vm.user.plf_code,
					plz_curr        : vm.user.plz_curr,
					plz_ex_rate     : vm.user.plz_ex_rate,
					plz_correction  : vm.user.plz_correction,
					plz_commission  : vm.user.plz_commission,
					plz_freight     : vm.user.plz_freight,
					// plz_agent       : vm.user.agent,
					plz_taxes       : vm.user.plz_taxes,
					plz_margin      : vm.user.plz_margin,
					language        : vm.user.language
		        },
		        success: function(data) {
		        	if(data.success){
		        		noticeSuccess(data.message);
		        	}
		        	else{
		        		noticeFailed(data.message);
		        	}
		        	vm.refreshEditPLZD();
		        }
		    });
	    }

	    function UpdatePLZD(id, sell6, pvpr8){
	    	vm.editing = false;
        	vm.metadata = -1;
	    	$.ajax({
		        async: false,
		        type: 'POST',
		        url: '/index.cfm/price_list_zone_detail/addEdit',
		        data: {
		        	id_plz_det 		 : id,
					plzd_zone_sell_6 : sell6,
					plzd_pvpr_8      : pvpr8
		        },
		        success: function(data) {
		        	if(data.success){
		        		noticeSuccess(data.message);
		        	}
		        	else{
		        		noticeFailed(data.message);
		        	}
		        	$("#editRow").modal("hide");
		        	vm.refreshEditPLZD();
		        }
		      });
	    }

      	function createdRow(row, data, dataIndex) {
      		var newdata = {
      			"ID": data.ID,
      			"PLZD_ZONE_SELL_6": Number($filter("number")(data.PLZD_ZONE_SELL_6,2).replace(/,/g,"")),
      			"PLZD_PVPR_8": Number($filter("number")(data.PLZD_PVPR_8,2).replace(/,/g,""))
      		};
      		vm.plzdEditData.push(newdata);
        	$compile(angular.element(row).contents())($scope);
       	}

       	function refreshEditPLZD(){
       		vm.plz_dets = originalPLZD;
       		vm.plzdEditData = [];
       		$('#id_plz_det').val(0);
       		vm.dtInstance.reloadData();
       	}
  	};
  	app.directive('ngEnter', function () {
	    return function (scope, element, attrs) {
	        element.bind("keydown keypress", function (event) {
	            if(event.which === 13) {
	                scope.$apply(function (){
	                    scope.$eval(attrs.ngEnter);
	                });
	                event.preventDefault();
	            }
	        });
	    };
	});
})();