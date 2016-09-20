(function(){
  angular.module('contact', ['Formcontact','datatables', 'datatables.light-columnfilter']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  function BindAngularDirectiveCtrl($scope ,$http ,$filter ,$compile, DTOptionsBuilder, DTColumnBuilder)
  {
      $scope.abcxxx = "asdfasdf";
     var vm = this;
      vm.typeOptions = [
      { id: 1, name: 'Factory' }, 
      { id: 2, name: 'Zone' }, 
      { id: 3, name: 'Agent' },
      { id: 4, name: 'Customer' },
      { id: 5, name: 'Particular' }
      ];
      
      vm.form = {type : vm.typeOptions[0].value};
      vm.message = '';
      vm.edit = edit;
      vm.delete = deleteRow;
      // vm.addRow = addRow;
      // vm.refresh = refresh;
      vm.dtInstance = {};
      vm.contacts = {};
      vm.user=[];
      vm.user.cn_name = "";
      vm.regex = "[a-z A-Z 0-9-\_\.]+";
      vm.regex_email = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      var original = vm.user;
      vm.dtOptions = DTOptionsBuilder.fromSource('/index.cfm/contact/getcontacts')
          .withPaginationType('full_numbers')
          .withOption('createdRow', createdRow)
          .withOption('stateSave', true)
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
            }
          });
      vm.dtColumns = [
          DTColumnBuilder.newColumn('COUNT').withTitle('Code').withOption('width', '6%'),
          DTColumnBuilder.newColumn('NAME').withTitle('Name').withOption('width', '20%'),
          DTColumnBuilder.newColumn('CITY').withTitle('City'),
          DTColumnBuilder.newColumn('COUNTRY').withTitle('Country'),
          DTColumnBuilder.newColumn('PHONE').withTitle('Telephone'),
          DTColumnBuilder.newColumn('EMAIL').withTitle('E_mail'),
          DTColumnBuilder.newColumn('VAT_CODE').withTitle('VAT Code'),
          DTColumnBuilder.newColumn('TYPE').withTitle('Contact Type'),
          DTColumnBuilder.newColumn(null).withTitle('Actions').notSortable()
              .renderWith(actionsHtml)
      ];
      
      function edit(contact) {
        $('#id_Contact').val(contact.ID);
        $scope.idContactEdit = contact.ID;
        $('#myModalContact').modal('show');
      }

      $('#myModalContact').on('hidden.bs.modal', function () {
          vm.dtInstance.reloadData();
          // $scope.$apply();
          setTimeout(function() {
            $("#mytable td").filter(function() { return $.text([this]) == $('#id_Contact').val(); })
                .parent()
                .addClass("highlight");
          }, 2000);
      })

      function deleteRow(contact) {
        var result = confirm('Are you sure you want to delete this item?');
        if(result)
        {
          $.ajax({
             type: "POST",
             url: "/index.cfm/product/deleteProductStatus",
             async: false,
             data: {'sId' : contact.ID
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
      }

       function createdRow(row, data, dataIndex) {
        // Recompiling so we can bind Angular directive to the DT
        $compile(angular.element(row).contents())($scope);
       }
      function actionsHtml(data, type, full, meta) {
          vm.contacts[data.ID] = data;
          return '<span class="txt-color-green btnedit" title="Edit" data-toggle="modal" data-target="#myModal" ng-click="showCase.edit(showCase.contacts[' + data.ID + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
              '</span>&nbsp;';
      }

      function refresh () {
          $('#id_Contact').val(0);
          vm.user= angular.copy(original);
          $scope.userForm.$setPristine();
      }

      // -----------------------------End Contact--------------------------------------------
  };

})();
