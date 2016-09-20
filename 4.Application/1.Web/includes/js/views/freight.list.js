(function(){
  angular.module('freight.list', ['datatables']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  function BindAngularDirectiveCtrl($scope, $http, $filter, $compile, DTOptionsBuilder, DTColumnBuilder)
  {
     var vm         = this;
      vm.message    = '';
      vm.edit       = editrow;
      vm.delete     = deleteRow;
      vm.deleteUser = deleteUser;
      vm.addRow     = addRow;
      vm.refresh    = refresh;
      vm.dtInstance = {};
      vm.freights    = {};
      vm.user       =[];
      vm.regex      = "[a-z A-Z 0-9-\_\.]+";
      var original = angular.copy(vm.user);
      vm.dtOptions = DTOptionsBuilder.fromSource('/index.cfm/basicdata/getFreight')
          .withPaginationType('full_numbers')
          .withOption('createdRow', createdRow);

      vm.dtColumns = [
          DTColumnBuilder.newColumn('fr_description').withTitle('Freight'),
          DTColumnBuilder.newColumn(null).withTitle('Actions').notSortable()
              .renderWith(actionsHtml)
      ];


      $http.get("/index.cfm/basicdata/getFreight").success(function(dataResponse){
          vm.freights = dataResponse;
      });

      function editrow(fdata) {
        console.log(fdata);
          vm.user.fr_description= fdata.fr_description;
          $('#id_freight').val(fdata.id_freight);
      }

      function deleteRow(freight) {
          vm.did = freight.id_freight;
          // console.log(vm.did);
          $('#showDelete').modal('show');
      }

      function deleteUser(m) {
        $('#showDelete').modal('hide');
        $.ajax({
               type: "POST",
               url: "/index.cfm/freight/delete",
               async: false,
               data: {'id_freight' : vm.did
            },
            success: function( data ) {
                if(data.success)
                {
                    noticeSuccess(data.message);
                    vm.dtInstance.reloadData();
                }else{
                    noticeFailed("Can not delete this type");
                }
            }
         });
        // Delete some data and call server to make changes...
        // Then reload the data so that DT is refreshed

      }

      function addRow() {
        $.ajax({
               type: "POST",
               url: "/index.cfm/freight/addNew",
               async: false,
               data: {
                'description' : vm.user.fr_description,
                'id_freight' : $('#id_freight').val()
            },
            success: function( data ) {
              if(data.success){
                noticeSuccess(data.message);
                vm.dtInstance.reloadData();
              }
              else
              {
                noticeFailed("Please try again!");
              }

              refresh();
            }
         });
      }

       function createdRow(row, data, dataIndex) {
        // Recompiling so we can bind Angular directive to the DT
        $compile(angular.element(row).contents())($scope);
       }
      function actionsHtml(data, type, full, meta) {
          vm.freights[data.id_freight] = data;
          return '<span class="txt-color-green btnedit" title="Edit" ng-click="showCase.edit(showCase.freights[' + data.id_freight + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
              '</span>&nbsp;' +
              '<span class="txt-color-red btnDelete" title="Delete" ng-click="showCase.delete(showCase.freights[' + data.id_freight + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-trash-o"></i>' +
              '</span>';
      }

      function refresh () {
          $('#id_freight').val(0);
          vm.user= angular.copy(original);
          $scope.userForm.$setPristine();
      }

  };

})();
