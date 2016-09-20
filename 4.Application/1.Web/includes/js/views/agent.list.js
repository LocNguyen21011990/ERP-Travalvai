(function(){
  angular.module('agent.List', ['Formcontact', 'datatables','datatables.light-columnfilter']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  function BindAngularDirectiveCtrl($scope ,$http , $filter, $compile, DTOptionsBuilder, DTColumnBuilder)
  {
     var vm        = this;
     vm.message    = '';
     vm.edit       = edit;
     vm.delete     = deleteRow;
     vm.deleteUser = deleteUser;
     vm.addRow     = addRow;
     vm.showAddNew = showAddNew;
     vm.editRowContact = editRowContact;
     vm.refresh    = refresh;
     vm.dtInstance = {};
     vm.agents    = {};
     vm.regex      = "[a-z A-Z 0-9-\_\.]+";
     vm.regex_email = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
     vm.user       = [];
     var original  = angular.copy(vm.user);

      vm.userInfo = {};
      $.ajax({
        async: false,
        type: 'GET',
        url: '/index.cfm/basicdata/getUserLevel',
        success: function(data) {
          vm.userInfo = data;
          //if it is zone admin
          if( vm.userInfo.TYPEUSER == 2 ){
            $('#btnAddNew').show();
          }
        }
      });

     vm.dtOptions  = DTOptionsBuilder.fromSource('/index.cfm/basicdata/getagent')
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
            }
          })
          .withOption('createdRow', createdRow);
     vm.dtColumns  = [
          DTColumnBuilder.newColumn('CODE').withTitle('Code').withOption('width', '7%'),
          DTColumnBuilder.newColumn('DES').withTitle('Description'),
          DTColumnBuilder.newColumn('ZONE').withTitle('Zone'),
          DTColumnBuilder.newColumn('LANGUAGE').withTitle('Language'),
          DTColumnBuilder.newColumn('COMMISSION').withTitle('Commission').withOption('width', '9%'),
          DTColumnBuilder.newColumn('CONTACT').withTitle('Contact'),
          DTColumnBuilder.newColumn(null).withTitle('Actions').withOption('width', '80px').notSortable()
              .renderWith(actionsHtml)
      ];


      $http.get("/index.cfm/basicdata/getlanguage").success(function(dataResponse){
        vm.languages = dataResponse;
      });

      $http.get("/index.cfm/basicdata/getzone").success(function(dataResponse){
        vm.zones = dataResponse;
      });

       $http.get("/index.cfm/contact/getcontacts").success(function(dataResponse){
          vm.contacts = dataResponse;
      });

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

      function edit(agent) {
          $('#addNew').modal('show');
          $('#btnRefresh').css('display','none');

          $(document).ready(function(){
            $("#addNew").on('shown.bs.modal', function(){
            $(this).find('#code').focus();
            });
          });

          if(agent.CONTACT != ""){
            $('#editContact').css("display", "inline-block");
            $('#createContact').css("display", "none");
          }else{
            $('#editContact').css("display", "none");
            $('#createContact').css("display", "inline-block");
          }

          //highlight row being edit
          $(".highlight").removeClass("highlight");
          $("#mytable td").filter(function() { return $.text([this]) == agent.CODE; })
            .parent()
            .addClass("highlight");
          vm.user.code=agent.CODE;
          vm.user.description=agent.DES;
          vm.user.zone = agent.ZONEID;
          vm.user.language = agent.LANGUAGEID;
          vm.user.commission = agent.COMMISSION;
          vm.user.contact = agent.CONTACTID;
          $('#id_agent').val(agent.ID);
          $scope.idContactEdit = agent.CONTACTID;
          $("#id_Contact").val(agent.CONTACTID);
          vm.user.contact = agent.CONTACT;
          document.getElementById("titleID").innerHTML="Edit";
      }

      function deleteRow(agent) {
          vm.did = agent.ID;
          // console.log(vm.did);
          $('#showDelete').modal('show');
      }

      function deleteUser(agent) {
          $('#showDelete').modal('hide');
          $.ajax({
             type: "POST",
             url: "/index.cfm/agent/delete",
             async: false,
             data: {'aId' : vm.did
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

      function addRow() {
          $.ajax({
                 type: "POST",
                 url: "/index.cfm/agent/addNew",
                 async: false,
                 data: {
                      'code' : vm.user.code,
                      'description' : vm.user.description,
                      'commission' : vm.user.commission,
                      'language' : vm.user.language,
                      'zone' : vm.user.zone,
                      'contact' : $("#id_Contact").val(),
                      'id_Agent':$('#id_agent').val()
              },
              success: function( data ) {
                if(data.success)
                {
                  $('#addNew').modal('hide');
                   noticeSuccess(data.message);
                   vm.dtInstance.reloadData();
                   tempCode = data.code_Agent;
                    setTimeout(function() {
                      $('#addNew').modal('hide');
                    }, 1000);
                 }
                 else
                 {
                     noticeFailed("Please try again!");
                 }
                  refresh();
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
          $(document).ready(function(){
            $("#addNew").on('shown.bs.modal', function(){
            $(this).find('#code').focus();
            });
          });
          $('#createContact').css("display", "inline-block");
          $('#editContact').css("display", "none");
          $scope.idContactEdit = 0;
          $("#id_Contact").val(0);
      }

       function createdRow(row, data, dataIndex) {
        // Recompiling so we can bind Angular directive to the DT
        $compile(angular.element(row).contents())($scope);
       }


      function actionsHtml(data, type, full, meta) {
          vm.agents[data.ID] = data;
          if(vm.userInfo.TYPEUSER == 1 || vm.userInfo.TYPEUSER == 2){
            return '<span class="txt-color-green btnedit" title="Edit" ng-click="showCase.edit(showCase.agents[' + data.ID + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
              '</span>&nbsp;' +
              '<span class="txt-color-red btnDelete" title="Delete" ng-click="showCase.delete(showCase.agents[' + data.ID + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-trash-o"></i>' +
              '</span>';
          }else if(vm.userInfo.TYPEUSER == 3){
            return  '<span class="txt-color-green btnedit" title="Edit" ng-click="showCase.edit(showCase.agents[' + data.ID + '])">' +
              '   <i class="ace-icon bigger-130 fa fa-pencil"></i>' +
              '</span>&nbsp;'
          }else{
            return"";
          }
      }

      function refresh () {
          $('#id_agent').val(0);
          vm.user= angular.copy(original);
          $scope.userForm.$setPristine();
          $('#code').val('');
          $('#description').val('');
          $('#commission').val('');
      }

      //--------------------------------End Agent---------------------------------------

  };

})();
