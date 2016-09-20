(function(){
  angular.module('customer.List', ['datatables.light-columnfilter','Formcontact','datatables']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  function BindAngularDirectiveCtrl($scope ,$http  , $filter,$compile, DTOptionsBuilder, DTColumnBuilder)
  {
       // -----------------------------Start Customer--------------------------------------------

     var vm         = this;
      vm.message    = '';
      vm.edit       = edit;
      vm.delete     = deleteRow;
      vm.deleteUser = deleteUser;
      vm.addRow     = addRow;
      vm.refresh    = refresh;
      vm.dtInstance = {};
      vm.customers    = {};
      vm.showAddNew = showAddNew;
      vm.editRowContact = editRowContact;
      vm.user       ={};

      vm.regex      = "[a-z A-Z 0-9-\_\.]+";
      vm.regex_email = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      var original  = angular.copy(vm.user);

//       $.ajax({
//         async: false,
//         type: 'GET',
//         url: '/index.cfm/basicdata/getCustomerRight',
//         success: function(data) {
//              //callback
// //            console.log(data);
//              vm.user_right = data;
//                if( vm.user_right == 1){
//                   $('#btnAddNew').show();
//                }
//         }
//       });

      vm.userInfo = {};
      $.ajax({
        async: false,
        type: 'GET',
        url: '/index.cfm/basicdata/getUserLevel',
        success: function(data) {
          vm.userInfo = data;
          //if it is agent admin
          if( vm.userInfo.TYPEUSER == 3 ){
            $('#btnAddNew').show();
          }
        }
      });

      vm.dtOptions = DTOptionsBuilder.fromSource('/index.cfm/basicdata/getcustomer')
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
          .withOption('createdRow', createdRow);;

      vm.dtColumns = [
          DTColumnBuilder.newColumn('ID').withTitle('Code'),
          DTColumnBuilder.newColumn('NAME').withTitle('Name'),
          DTColumnBuilder.newColumn('ZONE').withTitle('Zone'),
          DTColumnBuilder.newColumn('AGENT').withTitle('Agent'),
          DTColumnBuilder.newColumn('LANGUAGE').withTitle('Language'),
          DTColumnBuilder.newColumn('TOC').withTitle('Type'),
          DTColumnBuilder.newColumn('CONTACT').withTitle('Contact'),
          DTColumnBuilder.newColumn(null).withTitle('Actions').notSortable()
              .renderWith(actionsHtml)
      ];

      $http.get("/index.cfm/basicdata/getlanguage").success(function(dataResponse){
        vm.languages = dataResponse;
      });

      // $http.get("/index.cfm/basicdata/getzone").success(function(dataResponse){
      //   vm.zones = dataResponse;
      // });

      $http.get("/index.cfm/basicdata/getagent").success(function(dataResponse){
        vm.agents = dataResponse;
      });

      $http.get("/index.cfm/basicdata/gettype_customer").success(function(dataResponse){
        vm.tocs = dataResponse;
      });

      $http.get("/index.cfm/contact/getcontacts").success(function(dataResponse){
        vm.contacts = dataResponse;
      });

      var tempCode = "";
      $( "#agent" ).change(function() {
            var singleValues = $("#agent").val();
            // console.log(singleValues);
            var idcus = singleValues.slice(7);
            if(idcus > 0){
              $.ajax({
                    type: "POST",
                    url: "/index.cfm/customer/getzoneforid",
                    async: false,
                    data: {
                          'idcus' : idcus
                    },
                      success: function( data ) {
                        if(data.success){
                            vm.user.zone = data.name_zone;
                      }
                    }
              });
            }else{
              vm.user.zone = "";
            }
        });


      function edit(customer) {
          document.getElementById("titleID").innerHTML="Edit";
          $('#addNew').modal('show');
          $('#btnRefresh').css('display','none');

           $(document).ready(function(){
            $("#addNew").on('shown.bs.modal', function(){
            $(this).find('#code').focus();
            });
          });
          if(customer.CONTACT != ""){
            $('#editContact').css("display", "inline-block");
            $('#createContact').css("display", "none");
          }else{
            $('#editContact').css("display", "none");
            $('#createContact').css("display", "inline-block");
          }

          //highlight row being edit
          $(".highlight").removeClass("highlight");
          $("#mytable td").filter(function() { return $.text([this]) == customer.CODE; })
            .parent()
            .addClass("highlight");

          // vm.user.code=customer.CODE;
          // vm.code = customer.CODE;
          vm.user.description=customer.NAME;
          vm.user.zone = customer.ZONE;
          vm.user.language = customer.LANGUAGEID;
          vm.user.agent = customer.AGENTID;
          vm.user.toc = customer.TOCID;
          vm.user.contactID = customer.CONTACTID;
          $('#id_Customer').val(customer.ID);
          $scope.idContactEdit = customer.CONTACTID;
          vm.user.contact = customer.CONTACT;
          $("#id_Contact").val(customer.CONTACTID);

      }

      function showAddNew (argument) {
        // body...
          refresh();
          document.getElementById("titleID").innerHTML="Create";
          $(".highlight").removeClass("highlight");
          $('#btnRefresh').css('display','inline-block');
          $('#addNew').modal('show');
//          vm.user.title_formcustomer = "Create new Customer";
          $(document).ready(function(){
            $("#addNew").on('shown.bs.modal', function(){
            $(this).find('#name').focus();
          });

          $('#createContact').css("display", "inline-block");
          $('#editContact').css("display", "none");
          $scope.idContactEdit = 0;
          $("#id_Contact").val(0);
        });
      }

      function editRowContact () {
        $('#myModalContact').modal('show');
      }

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

      function deleteRow(customer){
           vm.did = customer.ID;
          // console.log(vm.did);
          $('#showDelete').modal('show');
      }

      function deleteUser(customer) {
        $('#showDelete').modal('hide');
          $.ajax({
               type: "POST",
               url: "/index.cfm/customer/delete",
               async: false,
               data: {'id' : vm.did
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
                 url: "/index.cfm/customer/addNewCus",
                 async: false,
                 data: {
                      'name'    : vm.user.description,
                      'zone'    : vm.user.zone,
                      'language' : vm.user.language,
                      'agent'   : vm.user.agent,
                      'type'    : vm.user.toc,
                      'contact' : $("#id_Contact").val(),
                      'id_Cu':$('#id_Customer').val()
              },
              success: function( data ) {
                if(data.success){
                  noticeSuccess(data.message);
                  vm.dtInstance.reloadData();
                  tempCode = data.code_Cust;
                  setTimeout(function() {
                    $('#addNew').modal('hide');
                  }, 1000);
                }
                else
                {
                  noticeFailed("Please try again!");
                }

//                refresh();
              }
           });
      }

       function createdRow(row, data, dataIndex) {
        // Recompiling so we can bind Angular directive to the DT
        $compile(angular.element(row).contents())($scope);
       }
      function actionsHtml(data, type, full, meta) {
          vm.customers[data.ID] = data;
          if(vm.userInfo.TYPEUSER < 4){
            return '<span class="txt-color-green btnedit" title="Edit" ng-click="showCase.edit(showCase.customers[' + data.ID + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
              '</span>&nbsp;' +
              '<span class="txt-color-red btnDelete" title="Delete" ng-click="showCase.delete(showCase.customers[' + data.ID + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-trash-o"></i>' +
              '</span>';
          }else {
            return "";
          }
      }

      function refresh () {
          $('#id_Customer').val(0);
          vm.user= angular.copy(original);
          vm.code = Math.floor((Math.random()*9999)+1);
          $scope.userForm.$setPristine();
      }

       // -----------------------------End Customer--------------------------------------------


  };

})();
