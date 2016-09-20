(function(){
  angular.module('forwarder.List', ['Formcontact','datatables', 'datatables.light-columnfilter']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  function BindAngularDirectiveCtrl($scope ,$http, $filter, $compile, DTOptionsBuilder, DTColumnBuilder)
  {
     var vm         = this;
      vm.message    = '';
      vm.deleteUser = deleteUser;
      vm.edit       = edit;
      vm.delete     = deleteRow;
      vm.showAddNew = showAddNew;
      vm.editRowContact = editRowContact;
      vm.addRow     = addRow;
      vm.refresh    = refresh;
      vm.dtInstance = {};
      vm.forwarder  = {};
      vm.user       =[];
      vm.regex      = "[a-z A-Z 0-9-\_\.]+";
      vm.regex_email = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      var original = angular.copy(vm.user);
      vm.dtOptions = DTOptionsBuilder.fromSource('/index.cfm/forwarder/getforwarder')
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

      vm.dtColumns = [
          // DTColumnBuilder.newColumn('ID').withTitle('No.'),
          DTColumnBuilder.newColumn('NAME').withTitle('Forwarder'),
          DTColumnBuilder.newColumn('CONTACT').withTitle('Contact'),
          DTColumnBuilder.newColumn(null).withTitle('Actions').notSortable()
              .renderWith(actionsHtml)
      ];

      $http.get("/index.cfm/contact/getcontacts").success(function(dataResponse){
        vm.contacts = dataResponse;
      });

      // $http.get("/index.cfm/basicdata/getcurrency").success(function(dataResponse){
      //   vm.currencys = dataResponse;
      // });

      var tempCode = "";
      function editRowContact () {
        $('#myModalContact').modal('show');
      }
      // vm.contact = "asfasf";
      $('#addNew').on('hidden.bs.modal', function () {
          $(".highlight").removeClass("highlight");
           $("#mytable td").filter(function() { return $.text([this]) == tempCode; })
                .parent()
                .addClass("highlight");
        });

      $('#myModalContact').on('hidden.bs.modal', function () {
        var contact = $("#name_Contact").val();
        vm.user.contact = contact;
        $scope.$apply();
        $('#editContact').css("display", "inline-block");
        $('#createContact').css("display", "none");
      })

      $("#createContact").on('click', function () {
        // body...
        $('#id_Contact').val(0);
      })

      function edit(forwarder) {
        $('#addNew').modal('show');
        $('#btnRefresh').css('display','none');
        if(forwarder.CONTACT != ""){
          $('#editContact').css("display", "inline-block");
          $('#createContact').css("display", "none");
        }else{
          $('#editContact').css("display", "none");
          $('#createContact').css("display", "inline-block");
        }
          //highlight row
        $(".highlight").removeClass("highlight");
        $("#mytable td").filter(function() { return $.text([this]) == forwarder.NAME; })
          .parent()
          .addClass("highlight");
        vm.user.forwarder=forwarder.NAME;
        vm.user.contactID = forwarder.CONTACTID;
        $('#id_Forwarder').val(forwarder.ID);
        $scope.idContactEdit = forwarder.CONTACTID;
        vm.user.contact = forwarder.CONTACT;
        $("#id_Contact").val(forwarder.CONTACTID);
        document.getElementById("titleID").innerHTML="Edit";
      }
      function deleteRow(forwarder) {
          vm.did = forwarder.ID;
          $('#showDelete').modal('show');
      }

    function deleteUser(forwarder){
      $('#showDelete').modal('hide');
        $.ajax({
             type: "POST",
             url: "/index.cfm/forwarder/delete",
             async: false,
             data: {'forwarderID' : vm.did
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
      }

     function showAddNew (argument) {
      // body...
        refresh();
        document.getElementById("titleID").innerHTML="Create";
        $(".highlight").removeClass("highlight");
        $('#btnRefresh').css('display','inline-block');
        $('#addNew').modal('show');
//          vm.user.title_formtypeOfCust = "Create new Type of Customer";
        $(document).ready(function(){
          $("#addNew").on('shown.bs.modal', function(){
          $(this).find('#forwarder').focus();
          });
        });
        $('#createContact').css("display", "inline-block");
        $('#editContact').css("display", "none");
        $scope.idContactEdit = 0;
        $("#id_Contact").val(0);
      }

      function addRow() {
        $.ajax({
                 type: "POST",
                 url: "/index.cfm/basicdata/checkExistCode",
                 async: false,
                 data: {'code' : vm.user.forwarder,
                        'table':'forwarder',
                        'nameCol':'fw_name',
                        'id':$('#id_Forwarder').val(),
                        'idfield':'id_forwarder'
              },
              success: function( data ) {
                  flag = data.isExist;
                  if(!flag)
                  {
                    $.ajax({
                             type: "POST",
                             url: "/index.cfm/forwarder/addNew",
                             async: false,
                             data: {
                                  'name' : vm.user.forwarder,
                                  'contact' : $("#id_Contact").val(),
                                  'id_Forwarder':$('#id_Forwarder').val()
                          },
                          success: function( data ) {
                            if(data.success){
                              $('#addNew').modal('hide');
                              noticeSuccess(data.message);
                              vm.dtInstance.reloadData();
                              tempCode = data.forw_Name;
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
          vm.forwarder[data.ID] = data;
          return '<span class="txt-color-green btnedit" title="Edit" ng-click="showCase.edit(showCase.forwarder[' + data.ID + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
              '</span>&nbsp;' +
              '<span class="txt-color-red btnDelete" title="Delete" ng-click="showCase.delete(showCase.forwarder[' + data.ID + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-trash-o"></i>' +
              '</span>';
      }

      function refresh () {
          $('#id_Forwarder').val(0);
          vm.user= angular.copy(original);
          // $scope.userForm.$setPristine();
      }

      // -----------------------------End Forwarder--------------------------------------------


  };

})();

