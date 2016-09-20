(function(){
  angular.module('costing.main', ['datatables', 'datatables.light-columnfilter', 'ui.select2']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  function BindAngularDirectiveCtrl($scope ,$http , $filter, $compile, DTOptionsBuilder, DTColumnBuilder)
  {
     var vm                = this;
     vm.message            = '';
     vm.addRow             = addRow;
     vm.showAddNew         = showAddNew;
     vm.showCopyData       = showCopyData;
     vm.doubleclickHandler = doubleclickHandler;
     vm.deleteCosting      = deleteCosting;
     vm.gotoVersion        = gotoVersion;
     vm.CopyData           = CopyData;
     vm.refresh            = refresh;
     vm.typeProductAction  = typeProductAction;
     vm.typeCostingAction  = typeCostingAction;
     vm.onChangeCostingCode  = onChangeCostingCode;
     vm.onChangeSourceSeason = onChangeSourceSeason;
     vm.copyDataBlank        = copyDataBlank;
     vm.getCostingLst        = getCostingLst;
     vm.oCodeIsDisable     = true;
     vm.sameCodeIsDisable  = true;
     vm.increaseIsDisabled = true;
     vm.showEditCosting    = showEditCosting;
     vm.newDes             = {};
     vm.persons            = {};
     vm.dtInstance1        = {};
     vm.dtInstance2        = {};
     vm.costings           = {};
     vm.regex              = "[a-z A-Z 0-9-\_\.]+";
     vm.regexNumber        =  /^[0-9]+([\.][0-9]+)?$/;
     vm.regex_email        = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
     vm.user               = [];
     vm.oCodes             = [];
     var original          = angular.copy(vm.user);
     vm.newseasons         = [2016,2017,2018,2019,2020,2021,2022,2023,2024,2025,2026,2027,2028,2029,2030,2031,2032,2033,2034,2035,2036,2037,2038,2039,2040,2041,2042,2043,2044,2045,2046,2047,2048,2049,2050];
     vm.isReadOnly         = false;
     vm.isExist            = false;
     vm.user.increase      = 0;
     //set valid
     vm.isRequiredPrdType  = true;
     // end set valid
     vm.kindOfCopy         = {type: 'type_product'};
     vm.oProductTypeIsDisable = false;
     vm.dtOptions  = DTOptionsBuilder.fromSource('/index.cfm/costing/getCostingLst')
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
            },
            '7' : {
                type : 'text'
            },
            '8' : {
                type : 'text'
            },
            '9' : {
                type : 'text'
            },
            '10' : {
                type : 'text'
            },
            '11' : {
                type : 'text'
            },
            '12' : {
                type : 'text'
            }
          })
          .withOption('createdRow', createdRow)
          .withOption('order', [9, 'desc']);

     vm.dtColumns1  = [
          DTColumnBuilder.newColumn('COST_CODE').withTitle('CODE'),

          DTColumnBuilder.newColumn('DESCRIPTION').withTitle('DESCRIPTION'),

          DTColumnBuilder.newColumn('COST_SEASON').withTitle('SEASON').withClass('text-right  th-align-left'),

          DTColumnBuilder.newColumn('COST_PL').withTitle('PRICE LIST'),

          DTColumnBuilder.newColumn('TP_CODE').withTitle('CODE'),
          DTColumnBuilder.newColumn('TP_DESCRIPTION').withTitle('DESCRIPTION'),

          DTColumnBuilder.newColumn('IDCUSTOMER').withTitle('ID').withClass('text-right  th-align-left'),
          DTColumnBuilder.newColumn('CS_NAME').withTitle('NAME'),

          DTColumnBuilder.newColumn('COST_DATE').withTitle('DATE').withClass('text-right th-align-left'),

          DTColumnBuilder.newColumn('COST_UPDATE').withTitle('LAST UPDATE').withOption('width',"62px").withClass('text-right  th-align-left'),
          DTColumnBuilder.newColumn('COST_WEIGHT').withTitle('WEIGHT (gr)').withOption('width',"25px").withClass('text-right  th-align-left'),
          DTColumnBuilder.newColumn('COST_VOLUME').withTitle('VOLUME (cm3)').withOption('width',"25px").withClass('text-right  th-align-left'),
          DTColumnBuilder.newColumn('COST_VARIANTS').withTitle('VERS.').withOption('width',"32px").withClass('text-right  th-align-left'),
          DTColumnBuilder.newColumn(null).withTitle('DETAIL').renderWith(actionsHtmlDetail).withOption('width',"4%").withClass("text-center").notSortable(),
          DTColumnBuilder.newColumn(null).withTitle('EDIT/ DELETE').renderWith(actionsHtml).notSortable()
        ];

      vm.dtColumns2  = [
          DTColumnBuilder.newColumn('COST_CODE').withTitle('CODE'),
          DTColumnBuilder.newColumn('DESCRIPTION').withTitle('DESCRIPTION'),
          DTColumnBuilder.newColumn('COST_SEASON').withTitle('SEASON').withClass('text-right  th-align-left'),
          DTColumnBuilder.newColumn('COST_PL').withTitle('PRICE LIST'),
          DTColumnBuilder.newColumn('TP_CODE').withTitle('PRODUCT CODE'),
          DTColumnBuilder.newColumn('TP_DESCRIPTION').withTitle('DESCRIPTION'),
          DTColumnBuilder.newColumn('IDCUSTOMER').withTitle('ID').withClass('text-right  th-align-left'),
          DTColumnBuilder.newColumn('CS_NAME').withTitle('NAME'),
          DTColumnBuilder.newColumn('COST_DATE').withTitle('DATE'),
          DTColumnBuilder.newColumn('COST_UPDATE').withTitle('LAST UPDATE').withOption('width',"62px").withClass('text-right  th-align-left'),
          DTColumnBuilder.newColumn('COST_WEIGHT').withTitle('WEIGHT (gr)').withOption('width',"25px").withClass('text-right  th-align-left'),
          DTColumnBuilder.newColumn('COST_VOLUME').withTitle('VOLUME (cm3)').withOption('width',"25px").withClass('text-right  th-align-left'),
          DTColumnBuilder.newColumn('COST_VARIANTS').withTitle('VERS.').withOption('width',"45px").withClass('text-right  th-align-left'),
          DTColumnBuilder.newColumn(null).withTitle('SKETCH').renderWith(sketchDisplay).notSortable(),
          DTColumnBuilder.newColumn(null).withTitle('DETAIL').renderWith(actionsHtmlDetail2).withOption('width',"4%").withClass("text-center").notSortable()
      ];

      $.ajax({
        async: false,
        type: 'GET',
        url: '/index.cfm/basicdata/getUserLevel',
        success: function(data) {
             //callback             
               vm.userInfo = data;
               if( vm.userInfo.TYPEUSER == 0 ){
                $("#btnCopyData").closest(".col-md-6").addClass("display-none");
              }else if( vm.userInfo.TYPEUSER == 1 ){
                $("#btnCopyData").closest(".col-md-6").removeClass("display-none");
              }
          }
      });

      $.ajax({
        async: false,
        type: 'POST',
        url: '/index.cfm/basicdata/getLanguage',
        success: function(data) {
             //callback
               vm.newDes = data.slice();
               vm.languages = data.slice();
          }
      });

      $http.get("/index.cfm/basicdata/getcustomer").success(function(dataResponse){
        vm.customers = dataResponse;
      });

      $http.get("/index.cfm/basicdata/getfactory").success(function(dataResponse){
        vm.factories = dataResponse;
      });

      $http.get("/index.cfm/costing/gettype_of_products").success(function(dataResponse){
        vm.tpList = dataResponse;
      });

      function showCopyData(){
          vm.user.typecopy = 0;
          reloadOseason().then(function(dataResponse){
            vm.oseasons = dataResponse;
            $scope.$apply();
          });
          //reset copy data
          refreshCopy();
          // end reset
          $('#copydata').modal('show');
          $(document).ready(function(){
            $("#copydata").on('shown.bs.modal', function(){            
            $(this).find('#season').focus();
            });
          });
      }

      function reloadOseason(){
        return new Promise(function(resolve, reject){
          $http.get("/index.cfm/costing/getAllSeason").success(function(dataResponse){
            resolve(dataResponse);
          });
        });
      }

      function typeProductAction(){
          vm.isExist = false;
         //check type of copy data
          vm.oCodeIsDisable        = true;
          vm.sameCodeIsDisable     = true;
          vm.increaseIsDisabled    = true;
          vm.oProductTypeIsDisable = false;
          // check valid
          vm.isRequiredCostingCode  = false;
          vm.isRequiredSameCode     = false;
          vm.isRequiredIncrease     = false;
          vm.isRequiredPrdType      = true;
          // end check valid
          $scope.$applyAsync();
      }
      function typeCostingAction(){
       //check type of copy data
        vm.oCodeIsDisable     = false;
        vm.sameCodeIsDisable  = false;
        vm.increaseIsDisabled = false;
        vm.oProductTypeIsDisable = true;
        // check valid          
        vm.isRequiredPrdType      = false;
        vm.isRequiredIncrease     = true;
        vm.isRequiredCostingCode  = true;
        vm.isRequiredSameCode     = true;
        $scope.$applyAsync();
        if(vm.user.oCode == "all"){
          vm.sameCodeIsDisable  = true;
          vm.isRequiredSameCode = false;
          $scope.$applyAsync();
        }
      }
      function onChangeSourceSeason(){
        getCostingLst();
      }

      function getCostingLst(){
          // get costing
          var oseason = $("#oseason").val();
          $.ajax({
            type: "POST",
            url: "/index.cfm/costing/getCostingLst",
            async: false,
            data:{
              'season'   : oseason,
            },
            success: function( data ) {
                  vm.oCodes = data;
                  $("#sameCode").attr("disabled","disabled");
                  $scope.$applyAsync();
            }
          });
      }
      $("#tp_code").change(function(){
        if($(this).val()) {
          vm.newDes = vm.tpList[$(this).val()].DES;
        }else{
          vm.newDes = vm.languages;
        }
      });

      function onChangeCostingCode(){
        if(vm.user.oCode == "all"){
          vm.sameCodeIsDisable  = true;
          // catch valid
          vm.isRequiredCostingCode  = false;
          vm.isRequiredSameCode     = false;
        }else{
          vm.sameCodeIsDisable  = false;
          //catch valid
          vm.isRequiredCostingCode  = true;
          vm.isRequiredSameCode     = true;
        }
        $scope.$applyAsync();
      };

      function checkcodeseason() {
        $.ajax({
          type: "POST",
          url: "/index.cfm/costing/checkseasoncode",
          async: false,
          data:{
            'newseason'   : $("#newSeason").val() ? $("#newSeason").val():0,
            'newcode'     : vm.user.sameCode ? vm.user.sameCode:0
          },
          success: function( data ) {
              vm.isExist = data;
              if(data==true) {
                vm.user.code_season = 'ok';
                // vm.user.sameCode = '';
              }
              else {
                vm.user.code_season = 'ok';
              }
              $scope.$apply();
          }
        });
      }

      $("#newSeason").change(function(){
        checkcodeseason();
      });

      function CopyData() {    
        var checkNewcostingExits = false;
        var kindOfCopy = vm.kindOfCopy.type;
        if(kindOfCopy == "costing"){
          $.ajax({
            type: "POST",
            url: "/index.cfm/costing/checkseasoncode",
            async: false,
            data:{
              'newseason'   : $("#newSeason").val() ? $("#newSeason").val():0,
              'newcode'     : vm.user.sameCode ? vm.user.sameCode:0
            },
            success: function( data ) {
                vm.isExist = data;
                if(data==true) {
                  vm.user.code_season = 'ok';                 
                  // vm.user.sameCode = '';                 
                }else{                    
                  vm.user.code_season = 'ok';
                  copyDataBlank();
                }
               $scope.$applyAsync();
            }
          });
        }else{
          copyDataBlank();
        }
      }

      function copyDataBlank(){
        var oldCode = vm.user.oCode;
        $.ajax({
          type: "POST",
          url: "/index.cfm/costing/CopyDataBlank",
          async: false,
          data:{
            'typeOfCopy': vm.kindOfCopy.type,
            'oseason'   : vm.user.oseason ? vm.user.oseason:0,
            'oCode'     : oldCode ? oldCode : "",
            'increase'  : vm.user.increase,
            'newSeason' : vm.user.newSeason,
            'newCode'  : vm.user.sameCode,
            'productType' : vm.user.productType ? vm.user.productType : ""
          },
          success: function( data ) {
              if(data.success){
                $('#copydata').modal('hide');
                 noticeSuccess(data.message);
                 vm.dtInstance1.reloadData();
                 vm.dtInstance2.reloadData();
                 $('#id_cost').val(0);}
              else{
                  noticeFailed(data.message);
              }
              refreshCopy();
              reloadOseason();
          }
        });
      }
      function refreshCopy(){
        vm.user = angular.copy(original);
        vm.kindOfCopy            = {type: 'type_product'};
        vm.oCodes = {};
        vm.isExist = false;
        vm.oProductTypeIsDisable = false;
        vm.user.increase      = 0;
        typeProductAction();
        $scope.userForm1.$setPristine();
        $scope.$applyAsync();
      }

     var fd = new FormData();
     $scope.uploadFile = function(files) {
          //Take the first selected file
          fd.append("image", files[0]);
      };

      function addRow() {
         $scope.userForm.$invalid=true;
        fd.append('cost_code'           ,  vm.user.cost_code);
        fd.append('id_cost'           ,  $('#id_cost').val());
        fd.append('des'                 , JSON.stringify(vm.newDes));

        fd.append('cost_season'         , (vm.user.cost_season          == null) ? "" : vm.user.cost_season);
        fd.append('cost_pl'             , (vm.user.cost_pl ? 1:0));
        fd.append('id_type_products'    , (vm.user. tp_code             == null) ? "" : vm.user.tp_code);
        fd.append('id_customer'         , (vm.user.customer             == null) ? "" : vm.user.customer);
        fd.append('cost_weight'         , (vm.user.cost_weight          == null) ? "" : vm.user.cost_weight);
        fd.append('cost_volume'         , (vm.user.cost_volume          == null) ? "" : vm.user.cost_volume);
        fd.append('idfactory'           , (vm.user.factory              == null) ? "" : vm.user.factory);

        $.ajax({
          type: "POST",
          url: "/index.cfm/costing/addNew",
          async: false,
          data: fd,
          processData: false,
          contentType: false,
          success: function( data ) {
            if(data.success)
            {
              $('#id_cost').val(0);
              noticeSuccess(data.message);
              vm.dtInstance1.reloadData();
              vm.dtInstance2.reloadData();
              window.location.href = "/index.cfm/cost.version?id_cost=" + data.id_cost;
            }
            else
            {
              noticeFailed(data.message);
            }
            $("addNew").modal('hide');

            fd = null;
            fd = new FormData();
          }
        });
      }

      function deleteCosting(id_cost) {
        var confirm = window.confirm("Do you want to delete this cost?");
        fd = new FormData();
        fd.append('id_cost',id_cost);
        if(confirm){
          $.ajax({
            type: "POST",
            url: "/index.cfm/costing/deletecosting",
            data: fd,
            async: false,
            processData: false,
            contentType: false,
            success: function( data ) {
              if(data.success)
              {
                noticeSuccess(data.message);
                vm.dtInstance1.reloadData();
                vm.dtInstance2.reloadData();
              }
              else
              {
                noticeFailed(data.message);
              }
            }
          });
        }
      }

      function showAddNew (argument) {
        // body...
          refresh();
          vm.isReadOnly = false;
          document.getElementById("titleID").innerHTML="Create";
          $('#btnRefresh').css('display','inline-block');
          $('#addNew').modal('show');
          $(document).ready(function(){
            $("#addNew").on('shown.bs.modal', function(){
            $(this).find('#cost_code').focus();
            });
          });
      }

      function showEditCosting(person){
        refresh();
        vm.isReadOnly = true;
        $("#id_cost").val(person.ID_COST);

        $.ajax({
          type: "POST",
          url: "/index.cfm/costing/getCostDes",
          async: false,
          data: {
            id_cost : person.ID_COST
          },
          success: function( datal ) {
            vm.newDes = datal;
          }
        });

        vm.user.cost_code   = person.COST_CODE;
        vm.user.cost_season = person.COST_SEASON;
        vm.user.cost_pl     = person.COST_PL == "YES"?true:false;
        vm.user.tp_code     = person.IDTYPE_OF_PRODUCT;
        vm.user.factory     = person.FACTORY;
        vm.user.customer    = person.IDCUSTOMER;
        vm.user.cost_weight = person.COST_WEIGHT;
        vm.user.cost_volume = person.COST_VOLUME;

        document.getElementById("titleID").innerHTML="Edit";
        $('#btnRefresh').css('display','inline-block');
        $('#addNew').modal('show');

        $(document).ready(function(){
          $("#addNew").on('shown.bs.modal', function(){
          $(this).find('#code').focus();
          });
        });
      }


      function doubleclickHandler(info) {
        window.location.href = "/index.cfm/cost.version?id_cost=" + info.ID_COST;
      }

      function gotoVersion(id_cost) {
        window.location.href = "/index.cfm/cost.version?id_cost=" + id_cost;
      }

      function createdRow(row, data, dataIndex,iDisplayIndexFull) {
        // Recompiling so we can bind Angular directive to the DT
        $('td', row).unbind('dblclick');
        $('td', row).bind('dblclick', function() {
            $scope.$apply(function() {
                vm.doubleclickHandler(data);
            });
        });

        $compile(angular.element(row).contents())($scope);
        return row;
       }

       function sketchDisplay(data, type, full, meta){
        return ' <img src="/includes/img/ao/' + data.COST_SKETCH + '" class="img-responsive" alt="' + data.COST_CODE + '" width="150"> ';
       }

       function actionsHtml(data, type, full, meta) {
          vm.persons[data.ID_COST] = data;
          return '<span class="txt-color-green btnedit" title="Edit" ng-click="showCase.showEditCosting(showCase.persons[' + data.ID_COST + '])">' +
                    '<i class="ace-icon bigger-130 fa fa-pencil"></i></span>'+
                  '<span class="txt-color-red btndelete" title="Delete costing" ng-click="showCase.deleteCosting(' + data.ID_COST + ')">' +
                    '<i class="ace-icon bigger-130 fa fa-trash-o"></i></span>';
      }
      function actionsHtmlDetail(data, type, full, meta){
          return '<span class="txt-color-green btngotoversion" title="Go to costing version" ng-click="showCase.gotoVersion(' + data.ID_COST + ')">' +
              '<i class="ace-icon bigger-130 fa fa-sign-out"></i></span>';
      }
      function actionsHtmlDetail2(data, type, full, meta){
          return '<span class="txt-color-green btngotoversion" title="Go to costing version" ng-click="showCase.gotoVersion(' + data.ID_COST + ')">' +
              '<i class="ace-icon bigger-130 fa fa-sign-out"></i></span>';
      }


      function refresh () {
          $('#id_cost').val(0);
          vm.newDes = vm.languages;
          vm.user= angular.copy(original);
          $scope.userForm.$setPristine();
      }

      //--------------------------------End Agent---------------------------------------

  };

})();