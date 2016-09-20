(function(){
  angular.module('sizedetail.List', ['datatables', 'datatables.light-columnfilter', 'ui.select2']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  	function BindAngularDirectiveCtrl($scope ,$filter,$http ,$compile, DTOptionsBuilder, DTColumnBuilder, $window)
  	{
		var vm = this;
		vm.dtInstance = {};
		vm.sizedet = [];
		var original = angular.copy(vm.sizedet);
		vm.doubleclickHandler = doubleclickHandler;
		vm.editing = false;
		vm.saveDetail = saveDetail;
		vm.quit = quit;

		vm.dtOptionsSizesViewTable = DTOptionsBuilder.fromSource('/index.cfm/sizes/getSizeDetailBySizeId' + window.location.search)
		  .withPaginationType('full_numbers')
		  .withLightColumnFilter({
	            '0' : {
	                type : 'text'
	            },
	            '1' : {
	                type : 'text'
	            }
          	})
		  	.withOption('createdRow', createdRow)
		  	.withOption("iDisplayLength", 15);

		vm.dtColumnsSizesViewTable = [
		  	DTColumnBuilder.newColumn('POSITION').withTitle('POSITION'),
		  	DTColumnBuilder.newColumn('SIZE').withTitle('CODE').renderWith(actionEdit)
		];


		function actionEdit(data, type, full, meta) {
			vm.sizedet[meta.row] = {
					'idsizedet': full.IDSIZEDET,
	  				'size' : full.SIZE,
					'pos'  : full.POSITION
  			}
			return '<span ng-hide="showCase.editing">'+data+'</span>' +
  					'<input ng-show="showCase.editing" autofocus ng-model="showCase.sizedet['+meta.row+'].size"/>'
      				;
		}	

		function doubleclickHandler(info) {
		    vm.editing = true;
      	}

      	function createdRow(row, data, dataIndex) {
      		if( data && data.SIZE) {
      			$scope.$apply(function () {
      				vm.sizedet[dataIndex] = {
      					'idsizedet': data.IDSIZEDET,
	      				'size' : data.SIZE,
						'pos'  : data.POSITION
	      			}
      			});
      		}
      		$('td', row).unbind('dblclick');
	        $('td', row).bind('dblclick', function() {
	            $scope.$apply(function() {
	                vm.doubleclickHandler(data);
	            });
	        });
	        $compile(angular.element(row).contents())($scope);
       	}

       	function saveDetail() {
       		$.ajax({
				type: "POST",
				url: "/index.cfm/sizes/updateSizeDetails",
				async: false,
				data: {
					"arrdata": JSON.stringify( vm.sizedet)
				},
				success: function( data ) {
					if(data.success)
					{
					  noticeSuccess(data.message);
					}
					else
					{
					  noticeFailed(data.message);
					}
				  	vm.dtInstance.reloadData();
				}
	        });
       		vm.editing = false;
       	}

       	function quit() {
       		window.location.href = "/index.cfm/size.index";
       	}
   	}
})();
