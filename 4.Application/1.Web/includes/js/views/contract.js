(function(){
  angular.module('contract.List', ['datatables','datatables.light-columnfilter', "ui.select2"]).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  function BindAngularDirectiveCtrl($scope ,$http , $filter, $compile, DTOptionsBuilder, DTColumnBuilder)
  {
     var vm             = this;
     vm.deleteContract  = deleteContract;
     vm.addEditContract = addEditContract;
     vm.showAddNew      = showAddNew;
     vm.editContract    = editContract;
     vm.refresh         = refresh;
     vm.firstload       = false;
     vm.dtInstance      = {};
     vm.contracts       = [];
     vm.regex           = "[a-z A-Z 0-9-\_\.]+";
     vm.regexNumber     = /^[0-9]+([\.][0-9]+)?$/;
     vm.user            = [];
     var original       = angular.copy(vm.user);

     vm.dtOptions  = DTOptionsBuilder.fromSource('/index.cfm/contract/getContracts')
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
            }
          })
          .withOption('createdRow', createdRow);
     vm.dtColumns  = [
          DTColumnBuilder.newColumn('id_Contract').withTitle('CODE').withOption('width', '10%'),
          DTColumnBuilder.newColumn('cs_name').withTitle('CUSTOMER').withOption('width', '12%'),
          DTColumnBuilder.newColumn('ag_Code').withTitle('AGENT').withOption('width', '12%'),
          DTColumnBuilder.newColumn('z_code').withTitle('ZONE').withOption('width', '12%'),
          DTColumnBuilder.newColumn('startDate').withTitle('START DATE').withOption('width', '12%'),
          DTColumnBuilder.newColumn('noofyear').withTitle('NO OF YEARS'),
          DTColumnBuilder.newColumn('increaseYear').withTitle('INCREASE EACH YEAR'),
          DTColumnBuilder.newColumn(null).withTitle('ACTIONS').withOption('width', '9%').notSortable()
              .renderWith(actionsHtml)
      ];

      $("#zone").change(function(){
        if($(this).val()){
          $.ajax({
            async: false,
            type: 'POST',
            data: {
              "idzone": $(this).val()
            },
            url: '/index.cfm/basicdata/getagent',
            success: function(data) {
              vm.agents = data
            }
          });
        }
      });

      $("#agent").change(function(){
        if($(this).val()){
          $.ajax({
            async: false,
            type: 'POST',
            data: {
              "idagent": $(this).val()
            },
            url: '/index.cfm/basicdata/getCustomer',
            success: function(data) {
              vm.customers = data
            }
          });
        }
      });

      $('#addNewContract').on('show.bs.modal', function () {
        if(!vm.firstload){
          $http.get("/index.cfm/basicdata/getzone").success(function(dataResponse){
            vm.zones = dataResponse;
          });
          vm.firstload = true;
        }
      });

      $('#addNewContract').on('hide.bs.modal', function () {
        refresh();
      });

      function showAddNew(){
        $("#addNewContract").modal('show');
      }

      function addEditContract(){
        $scope.userForm.$invalid=true;
        $.ajax({
                 type: "POST",
                 url: "/index.cfm/contract/addEditContract",
                 async: false,
                 data: {
                      'startDate'    : vm.user.startDate,
                      'noofyear'     : vm.user.noofyear,
                      'increaseYear' : vm.user.increaseYear,
                      'customer'     : vm.user.customer,
                      'agent'        : vm.user.agent,
                      'zone'         : vm.user.zone,
                      'id_Contract': $('#id_Contract').val()
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
                $('#addNewContract').modal('hide');
                refresh();
              }
           });
      }

      function editContract(item){
        $.ajax({
          async: false,
          type: 'POST',
          data: {
            "idzone": item.id_Zone
          },
          url: '/index.cfm/basicdata/getagent',
          success: function(data) {
            vm.agents = data
          }
        });

        $.ajax({
          async: false,
          type: 'POST',
          data: {
            "idagent": item.id_Agent
          },
          url: '/index.cfm/basicdata/getCustomer',
          success: function(data) {
            vm.customers = data
          }
        });

        vm.user.startDate    = item.startDate;
        vm.user.noofyear     = item.noofyear;
        vm.user.increaseYear = item.increaseYear;
        vm.user.customer     = item.id_Customer;
        vm.user.agent        = item.id_Agent;
        vm.user.zone         = item.id_Zone;
        $("#id_Contract").val(item.id_Contract)
        $("#addNewContract").modal('show');
        $scope.userForm.$invalid=true;
      }

      function deleteContract(ct){
        $.ajax({
              type: "POST",
              url: "/index.cfm/contract/delete",
              async: false,
              data: {'id_Contract' : ct.id_Contract},
              success: function( data ) {
                if(data.success)
                {
                    noticeSuccess(data.message);
                    vm.dtInstance.reloadData();
                }else{
                    noticeFailed(data.message);
                }
              }
        });
      }

      function createdRow(row, data, dataIndex) {
        $compile(angular.element(row).contents())($scope);
      }

      function actionsHtml(data, type, full, meta){
        vm.contracts[data.id_Contract] = data;
        return  '<span class="txt-color-green btnedit" title="Edit" ng-click="showCase.editContract(showCase.contracts[' + data.id_Contract + '])">' +
                '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
                '</span>&nbsp;' +
                '<span class="txt-color-red btnDelete" title="Delete" ng-click="showCase.deleteContract(showCase.contracts[' + data.id_Contract + '])">' +
                '   <i class="ace-icon bigger-130 fa fa-trash-o"></i>' +
                '</span>';
      }

      function refresh(){
        $('#id_Contract').val(0);
        vm.agents = [];
        vm.customers = [];
        vm.user = angular.copy(original);
        $scope.userForm.$setPristine();
      }

      //--------------------------------End Cpntract---------------------------------------
  };

})();
