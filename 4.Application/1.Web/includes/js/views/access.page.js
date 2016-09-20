(function(){
  angular.module('agent.price', ['datatables']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  function BindAngularDirectiveCtrl($scope ,$filter,$http ,$compile, DTOptionsBuilder, DTColumnBuilder)
  {
     var vm        = this;
     vm.dtInstance = {};
     vm.dtOptions  = DTOptionsBuilder.fromSource('/index.cfm/basicdata/getAccessPage')
          .withPaginationType('full_numbers')
          .withOption('createdRow', createdRow);
     vm.dtColumns  = [
          DTColumnBuilder.newColumn('id').withTitle('ID'),
          DTColumnBuilder.newColumn('name').withTitle('NAME'),
          DTColumnBuilder.newColumn('idPage').withTitle('PAGE ID')
      ];

    function createdRow(row, data, dataIndex) {
      $compile(angular.element(row).contents())($scope);
     }
  };

})();
