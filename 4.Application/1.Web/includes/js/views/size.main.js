(function(){
  angular.module('size.List', ['datatables', 'datatables.light-columnfilter', 'ui.select2']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  	function BindAngularDirectiveCtrl($scope ,$filter,$http ,$compile, DTOptionsBuilder, DTColumnBuilder, $window)
  	{
		var vm = this;
		vm.dtInstance = {};
		vm.showEdit = showEdit;
		vm.refresh = refresh;
		vm.insertData = insertData;
		vm.deleteSize = deleteSize;
		vm.doubleclickHandler = doubleclickHandler;
		vm.size = [];
		var original = angular.copy(vm.size);

		vm.dtOptionsSizesViewTable = DTOptionsBuilder.fromSource('/index.cfm/sizes/getSizes')
		  .withPaginationType('full_numbers')
		  .withLightColumnFilter({
	            '0' : {
	                type : 'text'
	            },
	            '1' : {
	                type : 'text'
	            }
          	})
		  	.withOption('createdRow', createdRow);

		vm.dtColumnsSizesViewTable = [
		  	DTColumnBuilder.newColumn('DES').withTitle('DESCRIPTION'),
		  	DTColumnBuilder.newColumn('QTTY').withTitle('QTTY'),
		  	DTColumnBuilder.newColumn(null).withTitle('ACTIONS').renderWith(actionsHtml)
		];

		function actionsHtml(data, type, full, meta) {
          	return '<span class="txt-color-red btndelete" title="Edit product" ng-click="showCase.showEdit(' + full.IDSIZE + ', false)">' +
	                    '<i class="ace-icon bigger-130 fa fa-pencil"></i></span>' + 
	                '<span class="txt-color-red btndelete" title="Delete product" ng-click="showCase.deleteSize(' + full.IDSIZE + ')">' +
	                    '<i class="ace-icon bigger-130 fa fa-trash-o"></i></span>';
      	}
      	function doubleclickHandler(info) {
	        window.location.href = "/index.cfm/size.detail?idsize=" + info.IDSIZE;
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

       	function showEdit(id) {
       		$.ajax({
		        async: false,
		        type: 'GET',
		        url: '/index.cfm/sizes/getSizeById?idsize=' + id,
		        success: function(data) {
		          if(data.success == true) {
		          	vm.size.sz_des = data.size.DES;
		          	vm.size.sz_qtty = data.size.QTTY;
		          	$('#sizeId').val(data.size.IDSIZE);
		          }
		          else {
		          	noticeFailed(data.message)
		          }
		        }
	      	});
       	}

       	function refresh() {
       		vm.size = angular.copy(original);
       		$('#sizeId').val(0);
       		$scope.sizeForm.$setPristine();
       	}

       	function insertData() {
       		$.ajax({
				type: "POST",
				url: "/index.cfm/sizes/insertData",
				async: false,
				data: {
					'des': vm.size.sz_des,
					'qtty': vm.size.sz_qtty,
					'idsize': $('#sizeId').val()
				},
				success: function( data ) {
					if(data.success)
					{
					  noticeSuccess(data.message);
					  vm.dtInstance.reloadData();
					  if($('#sizeId').val() == 0) {
					  	window.location.href = "/index.cfm/size.detail?idsize=" + data.idsize;
					  }
					}
					else
					{
					  noticeFailed(data.message);
					}
				  	refresh();
				}
	        });
       	}
       	function deleteSize(id) {
       		$.ajax({
				type: "POST",
				url: "/index.cfm/sizes/deleteDataById",
				async: false,
				data: {
					'idsize': id
				},
				success: function( data ) {
					if(data.success)
					{
					  noticeSuccess(data.message);
					  vm.dtInstance.reloadData();
					}
					else
					{
					  noticeFailed(data.message);
					}
				}
	        });
       	}
   	}
})();
