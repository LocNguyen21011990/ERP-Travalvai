(function(){
  var myapp = angular.module('pattern.main', ['datatables']);
  myapp.controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)
  var vm         = this;
  $.ajax({
      async: false,
      type: 'GET',
      url: '/index.cfm/basicdata/getUserLevel',
      success: function(data) {
           //callback
             vm.userInfo = data;
            if( vm.userInfo.TYPEUSER == 4){
              $("#btnCreate").hide();
            }
        }
  });

  function BindAngularDirectiveCtrl($scope , $http ,$compile, DTOptionsBuilder, DTColumnBuilder)
  {
     var vm              = this;
     vm.showAddNew        = showAddNew;
     vm.showEdit          = showEdit;
     vm.deletePattern     = deletePattern;
     vm.patterns          = {};
     vm.user              = {};
     vm.dtInstance        = {};
     var original         = angular.copy(vm.user);
     vm.dtOptions  = DTOptionsBuilder.fromSource('/index.cfm/patterns.getPatternList')
      .withPaginationType('full_numbers')
      .withOption('createdRow', createdRow).withOption('order', [1, 'desc']);
    vm.dtColumns  = [
          DTColumnBuilder.newColumn('CODE').withTitle('CODE').withOption('width',"2%"),
          DTColumnBuilder.newColumn('IDPATTERN').withTitle('ID'),
          DTColumnBuilder.newColumn('GROUPPRODUCTNAME').withTitle('GROUP').withOption('width',"2%"),
          DTColumnBuilder.newColumn('DESCRIPTION').withTitle('DESCRIPTION').withOption('width',"10%"),
          DTColumnBuilder.newColumn('CREATEDATE').withTitle('DATE').withOption('width',"12%"),
          DTColumnBuilder.newColumn('UPDATEDATE').withTitle('UPDATE').withOption('width',"12%"),
          DTColumnBuilder.newColumn('NOTES').withTitle('NOTES').withOption('width',"40%"),
          DTColumnBuilder.newColumn('SKETCH').withTitle('SKETCH').withOption('width',"20%"),
          DTColumnBuilder.newColumn(null).renderWith(actionsHtml).notSortable().withOption('width',"2%")
        ];
       vm.dtColumns[1].visible = false;

  function showAddNew () {
    // body...
     window.location.href = "/index.cfm/patterns.edit";
  }

  function showEdit (array) {
    // body...
     window.location.href = "/index.cfm/patterns.edit?id="+array.IDPATTERN;
  }

  function deletePattern(array) {

    console.log(array);
    $.ajax({
         type: "POST",
         url: "/index.cfm/patterns/deletePattern",
         async: false,
         data: {'id_pattern' : array
      },
      success: function( data ) {
          if(data.success)
          {
              noticeSuccess(data.message);
              vm.dtInstance.reloadData();
          }else{
              noticeFailed("This pattern is using for product. If you want to delete this patter vari, please delete product first!");
          }
      }
    });
  }

  function actionsHtml(data, type, full, meta) {
      vm.patterns[data.IDPATTERN] = data;
      return '<span class="txt-color-green btnedit" title="Edit pattern" ng-click="showCase.showEdit(showCase.patterns[' + data.IDPATTERN + '])">' +
                '<i class="ace-icon bigger-130 fa fa-pencil"></i></span></a>' +
              '<span class="txt-color-red btndelete" title="Delete pattern" ng-click="showCase.deletePattern(' + data.IDPATTERN + ')">' +
                '<i class="ace-icon bigger-130 fa fa-trash-o"></i></span>';
  }
  function createdRow(row, data, dataIndex,iDisplayIndexFull) {
      // Recompiling so we can bind Angular directive to the DT
      $compile(angular.element(row).contents())($scope);
        return row;
  };


  };
})();
