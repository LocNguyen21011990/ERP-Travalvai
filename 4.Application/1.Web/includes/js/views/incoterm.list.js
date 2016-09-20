(function(){
  angular.module('zone.List', ['datatables']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  function BindAngularDirectiveCtrl($scope ,$http ,$compile, DTOptionsBuilder, DTColumnBuilder)
  {
     var vm = this;
      vm.message = '';
      vm.edit = edit;
      vm.delete = deleteRow;
      vm.addRow = addRow;
      vm.refresh = refresh;
      vm.dtInstance = {};
      vm.persons = {};
      vm.user=[];
      vm.regex = "[a-z A-Z 0-9-\_\.]+";
      var original = vm.user;
      vm.dtOptions = DTOptionsBuilder.fromSource('/index.cfm/basicdata/getzone')
          .withPaginationType('full_numbers')
          .withOption('createdRow', createdRow);
      vm.dtColumns = [
          DTColumnBuilder.newColumn('CODE').withTitle('Code'),
          DTColumnBuilder.newColumn('DES').withTitle('Description'),
          DTColumnBuilder.newColumn('CURRENCY').withTitle('Currency'),
          DTColumnBuilder.newColumn('LANGUAGE').withTitle('Language'),
          DTColumnBuilder.newColumn('CONTACT').withTitle('Contact'),
          DTColumnBuilder.newColumn(null).withTitle('Actions').notSortable()
              .renderWith(actionsHtml)
      ];

      $http.get("/index.cfm/basicdata/getlanguage").success(function(dataResponse){
        vm.languages = dataResponse;
      });

      $http.get("/index.cfm/basicdata/getcurrency").success(function(dataResponse){
        vm.currencys = dataResponse;
      });

      $http.get("/index.cfm/contact/getcontacts").success(function(dataResponse){
        vm.contacts = dataResponse;
      });

      function edit(person) {
          vm.user.code=person.CODE;
          vm.user.description=person.DES;
          vm.user.currency = person.CURRENCYID;
          vm.user.language = person.LANGUAGEID;
          vm.user.contactID = person.CONTACTID;
          $('#id_Zone').val(person.ID);
      }
      function deleteRow(person) {
        $('#addNew').modal('show');
        $('#butsubmit').click(function(){
          $.ajax({
                 type: "POST",
                 url: "/index.cfm/zone/delete",
                 async: false,
                 data: {'zId' : person.ID
              },
              success: function( data ) {
                  if(data.success)
                  {
                      $('#addNew').modal('hide');
                      noticeSuccess(data.message);
                      vm.dtInstance.reloadData();
                  }else{
                      noticeFailed("Can not delete this type");
                  }
              }
           });
          // Delete some data and call server to make changes...
          // Then reload the data so that DT is refreshed
        });
      }
      function addRow() {
         var flag = false;

        $.ajax({
                 type: "POST",
                 url: "/index.cfm/basicdata/checkExistCode",
                 async: false,
                 data: {'code' : vm.user.code,
                        'table':'zone',
                        'nameCol':'z_code',
                        'id':$('#id_incoterm').val(),
                        'idfield':'id_incoterm'
              },
              success: function( data ) {
                  flag = data.isExist;
                  if(flag == false || $('#id_Zone').val()!="0")
                  {
                    $.ajax({
                             type: "POST",
                             url: "/index.cfm/zone/addNew",
                             async: false,
                             data: {'code' : vm.user.code,
                                  'description' : vm.user.description,
                                  'currency' : vm.user.currency,
                                  'language' : vm.user.language,
                                  'contact' : vm.user.contactID,
                                  'id_Zone':$('#id_Zone').val()
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
                  else
                  {
                    noticeFailed("Code is exist in systems!");
                  }
              }
           });
      }

       function createdRow(row, data, dataIndex) {
        // Recompiling so we can bind Angular directive to the DT
        $compile(angular.element(row).contents())($scope);
       }
      function actionsHtml(data, type, full, meta) {
          vm.persons[data.ID] = data;
          return '<span class="txt-color-green btnedit" title="Edit" ng-click="showCase.edit(showCase.persons[' + data.ID + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
              '</span>&nbsp;' +
              '<span class="txt-color-red btnDelete" title="Delete" ng-click="showCase.delete(showCase.persons[' + data.ID + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-trash-o"></i>' +
              '</span>';
      }

      function refresh () {
          $('#id_Zone').val(0);
          vm.user= angular.copy(original);
          $scope.userForm.$setPristine();
      }

  };

})();
