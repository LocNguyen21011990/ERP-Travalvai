(function(){
  angular.module('price.List.zone', ['datatables', 'ui.select2', 'datatables.light-columnfilter']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  function BindAngularDirectiveCtrl($scope ,$filter,$http ,$compile, DTOptionsBuilder, DTColumnBuilder, $window, $q)
  {
     var vm                       = this;
     vm.message                   = '';
     vm.addRow                    = addRow;
     vm.refresh                   = refresh;
     vm.showAddNew                = showAddNew;
     vm.clickItem                 = clickItem;
     vm.showCopyData              = showCopyData;
     vm.CopyData                  = CopyData;
     vm.deletePLZ                 = deletePLZ;
     vm.PLZ_Table                 = [];
     vm.agents                    = [];
     vm.plzs                      = [];
     vm.formLoad                  = formLoad;
     vm.isFirstload               = true;
     vm.currency_freight          = "";
     vm.currency_freight_copy    = "";
     vm.dtInstance                = {};
     vm.persons                   = {};
     vm.user                      = {};
     vm.regex                     = "[a-z A-Z 0-9-\_\.]+";
     vm.regexNumber               = /^[0-9]+([\.][0-9]+)?$/;

     vm.changeSourceSeasonAddNew  = changeSourceSeasonAddNew;
     vm.changePLC                 = changePLC;
     vm.calculateExRate           = calculateExRate;
     vm.changeManualExRate        = changeManualExRate;
     vm.getftycurrency            = getftycurrency;

     $.ajax({
      async: false,
      type: 'GET',
      url: '/index.cfm/basicdata/getUserLevel',
      success: function(data) {
           //callback
             vm.userInfo = data;
             if( vm.userInfo.TYPEUSER == 3){
                userForm.$invalid = true;
                $("#btnAddNew").hide();
                $("#btnCopyData").hide();
              }
              else{
                userForm.$invalid = true;
                // vm.dtColumns_detail.splice(0,18);
                sumColumnFilter = {};
              }
        }
    });

    $("#sourceplz").change(function(){
      var idplz = $(this).val();
      if(idplz != "") {
        $("#sourceCurrency").text(vm.PLZ_Table[idplz].PLCURRENCY);
      }
      else {
        $("#sourceCurrency").text("");
      }
    });

    function roundDecimalPlaces(value, places) {
      if (places <= 0)
          return value;
      //Positive number
      if (Math.abs(value) >= 1)
          return Number(value).toFixed(places);
      places         = places - 1;
      var isNagative = value < 0;
      value          = isNagative ? (value * -1) : value;
      var log10      = parseInt(Math.floor(Math.log10(value)));
      var exp        = (Math.pow(10, log10));
      value         /= exp;
      value          = Number(value).toFixed(places);
      value          = (value * exp).toPrecision(places + 1);
      value          = isNagative ? (value * -1) : value;
      return value;
    }

    function changeManualExRate(){
      if(vm.user.ex_rate === undefined || vm.user.ex_rate == 0 || vm.user.ex_rate == "") {
        vm.user.convertplz_ex_rate = "";
        return "";
      }
      else{
        vm.user.convertplz_ex_rate = roundDecimalPlaces(1/vm.user.ex_rate,2);
      }
    }


    function calculateExRate(){
      if(vm.currency_convert.cc_value === undefined || vm.user.plfEx_Rate === undefined) {
        return "";
      }
      else{
        var c_ex_rate = vm.user.plfEx_Rate/vm.currency_convert.cc_value;
        c_ex_rate = roundDecimalPlaces(c_ex_rate,2);
        vm.user.plz_ex_rate = c_ex_rate;
        vm.user.ex_rate = c_ex_rate;

        vm.user.convertCc_ex_rate = roundDecimalPlaces(1/c_ex_rate,2);
        vm.user.convertplz_ex_rate =roundDecimalPlaces(1/c_ex_rate,2);
      }
    }

    function formLoad(){
      if(vm.isFirstload){
        $http.get("/index.cfm/basicdata/getlanguage").success(function(dataResponse){
          vm.languages = dataResponse;
        });

        $http.get("/index.cfm/basicdata/getcurrency").success(function(dataResponse){
          vm.currencylist = dataResponse;
        });
        $.ajax({
          async: false,
          type: 'GET',
          url: '/index.cfm/price_list_factory/getNewSeason',
          success: function(data) {
            vm.newseasons = data.arrnewseason;
          }
        });
        vm.isFirstload = false;
      }
    }


      vm.arrPlist = [];

    function changeSourceSeasonAddNew() {
      $.ajax({
          async: false,
          type: 'POST',
          data: {
            'season': $('#add_sourceseason').val()
          },
          url: '/index.cfm/price_list_zone/getPLFactoryBySeason',
          success: function(data) {
             vm.plfs = data.arrPlist;
          }
      });
    }

    var original  = angular.copy(vm.user);

    vm.dtOptions  = DTOptionsBuilder.fromFnPromise(function() {
                      var defer = $q.defer();
                      $http.get('/index.cfm/price_list_zone/getprice_list_zones').then(function(result) {
                          defer.resolve(result.data);
                          vm.plzs = result.data;
                      });
                      return defer.promise;
                    })
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
                      },
                      '13' : {
                          type : 'text'
                      },
                      '14' : {
                          type : 'text'
                      }
                    })
                  .withPaginationType('full_numbers')
                  .withOption('createdRow', createdRow);

     vm.dtColumns  = [
          DTColumnBuilder.newColumn('CODE').withTitle('CODE'),
          DTColumnBuilder.newColumn('DESCRIPTION').withTitle('DESCRIPTION'),
          DTColumnBuilder.newColumn('SEASON').withTitle('SEASON'),
          DTColumnBuilder.newColumn('PLF_CODE').withTitle('PRICE LIST FACTORY').withClass("needcolspan2"),
          DTColumnBuilder.newColumn('PLF_CURR').withTitle(''),
          DTColumnBuilder.newColumn('PLCURRENCY').withTitle('P.L. CURRENCY'),
          DTColumnBuilder.newColumn('EX_RATE').withTitle('EX. RATE').renderWith(formatNumber).withClass("text-right"),
          DTColumnBuilder.newColumn('DATE').withTitle('DATE'),
          DTColumnBuilder.newColumn('UPDATE').withTitle('UPDATE'),
          DTColumnBuilder.newColumn('CORRECTION').withTitle('CORRECTION').renderWith(formatNumber).withClass("text-right"),
          DTColumnBuilder.newColumn('COMMISSION').withTitle('COMMISSION').renderWith(formatNumber).withClass("text-right"),
          DTColumnBuilder.newColumn('FREIGHT').withTitle('FREIGHT').renderWith(formatNumber).withClass("text-right"),
          DTColumnBuilder.newColumn('TAXES').withTitle('TAXES').renderWith(formatNumber).withClass("text-right"),
          DTColumnBuilder.newColumn('MARGIN').withTitle('MARGIN').renderWith(formatNumber).withClass("text-right"),
          DTColumnBuilder.newColumn('LANGUAGE').withTitle('LANGUAGE'),
          DTColumnBuilder.newColumn(null).renderWith(actionsHtml).withOption('width',"2%")
        ];

        function formatNumber(data, type, full, meta){
          if(data < 1) return roundDecimalPlaces(data,2);
          return $filter("number")(roundDecimalPlaces(data, 2),2);
        }

      (function () {
        $(document).ready(function() {
          $('#datatable_fixed_column_1').find('th').each(function() {
            if($(this).is(':empty')) {
              $(this).remove();
            }
            if($(this).hasClass('need2col')) {
              $(this).attr("colspan", "2");
            }
            if($(this).hasClass('need3col')) {
              $(this).attr("colspan", "3");
            }
          });
        })
      })();

      //remove action without factory admin
      if( (vm.userInfo.TYPEUSER == 3) || (vm.userInfo.TYPEUSER == 4)){
        vm.dtColumns.splice(15,1);
      }

      function actionsHtml(data, type, full, meta) {
        vm.PLZ_Table[data.ID] = data;
        if( (vm.userInfo.TYPEUSER == 1) || (vm.userInfo.TYPEUSER == 2)){
          return '<span class="txt-color-red btndelete" title="Delete price list zone" ng-click="showCase.deletePLZ(' + data.ID + ')">' +
                  '<i class="ace-icon bigger-130 fa fa-trash-o"></i></span>';
        }else{
          return "";
        }
      }

      function deletePLZ(plzid){
        $.ajax({
             type: "POST",
             url: "/index.cfm/price_list_zone/deletePLZ",
             async: false,
             data: {
                  'id_plz' :  plzid
            },
            success: function( data ) {
              if(data.success){
                  noticeSuccess(data.message);
                  vm.dtInstance.reloadData();
              }else{
                  noticeFailed(data.message);
              }
            }
        });
      }

    function clickItem(param) {
      var path = '/index.cfm/basicdata.price_list_zone_detail?id='+ param;
      $window.location.href = path;
    }

    function showAddNew() {
      // body...
        refresh();
        vm.formLoad();
        document.getElementById("titleID").innerHTML="Create";
        $(".highlight").removeClass("highlight");
        $('#btnRefresh').css('display','inline-block');
        $('#close').css('display','block');

        $('#addNew').modal('show');
        $(document).ready(function(){
          $("#addNew").on('shown.bs.modal', function(){
          $(this).find('#code').focus();
          });
        });
    }

    function showCopyData(){
        vm.formLoad();
        vm.user.typecopy = 0;
        $('#copydata').modal('show');
        $(document).ready(function(){
          $("#copydata").on('shown.bs.modal', function(){
            $(this).find('#season').focus();
          });
        });
    }

    function CopyData() {
        $.ajax({
          type: "POST",
          url: "/index.cfm/price_list_zone/CopyData",
          async: false,
          data:{
              'code'        : vm.user.code
            , 'description' : vm.user.description
            , 'season'      : vm.user.season
            , 'sourceplz'   : vm.user.sourceplz
            , 'currency'    : vm.user.currency
            , 'ex_rate'     : vm.user.ex_rate
            , 'correction'  : vm.user.correction
            , 'commission'  : vm.user.commission
            , 'freight'     : vm.user.freight
            , 'taxes'       : vm.user.taxes
            , 'margin'      : vm.user.margin
            , 'language'    : vm.user.language
          },
          success: function( data ) {
            if(data.success == true) {
              noticeSuccess(data.message);
            }
            else {
              noticeFailed(data.message);
            }
            vm.dtInstance.reloadData();
            $('#copydata').modal('hide');
          }
        });
    }

    function addRow() {
        $.ajax({
             type: "POST",
             url: "/index.cfm/price_list_zone/addNew",
             async: false,
             data: {
                  'code'        : vm.user.code
                , 'description' : vm.user.description
                , 'season'      : vm.user.season
                , 'plf'         : vm.user.plf
                , 'currency'    : vm.user.currency
                , 'ex_rate'     : vm.user.ex_rate
                , 'correction'  : vm.user.correction
                , 'commission'  : vm.user.commission
                , 'freight'     : vm.user.freight
                , 'taxes'       : vm.user.taxes
                , 'margin'      : vm.user.margin
                , 'language'    : vm.user.language
                , 'id_plz'      : $("#id_plz").val()
            },
            success: function( data ) {
              if(data.success)
              {
                noticeSuccess(data.message);
                window.location.href= '/index.cfm/basicdata.price_list_zone_detail?id='+ data.plzid;
               }
               else
               {
                  noticeFailed(data.message);
                  refresh();
               }
            }
         });
    }

    // $('#addNew').on('show.bs.modal', function () {
    //   vm.formLoad();
    // });

    // $('#copydata').on('show.bs.modal', function () {
    //   vm.formLoad();
    // });

    function createdRow(row, data, dataIndex) {
      $('td', row).unbind('dblclick');
      $('td', row).bind('dblclick', function() {
          $scope.$apply(function() {
              vm.clickItem(data.ID);
          });
      });
      // Recompiling so we can bind Angular directive to the DT
      $compile(angular.element(row).contents())($scope);
    }

      function refresh () {
        $('#id_plz').val(0);
        vm.currency_convert = {};
        vm.plfs=[];
        vm.user= angular.copy(original);
        $scope.userForm.$setPristine();
      }

    function changePLC() {
      $.ajax({
        async:false,
        type: 'POST',
        url: '/index.cfm/price_list_zone/getCurr_convert',
        data: {currency : vm.user.currency},
        success: function(data){
          vm.currency_convert      = data.currency_convert;
          var plzcurrencytext      = $("#currency option:selected").text();
          vm.currency_freight      = plzcurrencytext;
          vm.currency_freight_copy = plzcurrencytext;
          vm.user.plzcurrencytext  = plzcurrencytext;
          vm.calculateExRate();
        }
        });
    }

    function getftycurrency() {
      if(vm.user.plf != undefined && vm.user.plf != ""){
        $.ajax({
          async:false,
          type: 'POST',
          url: '/index.cfm/price_list_zone/getftycurrency',
          data: {
            'plf_id' : vm.user.plf
          },
          success: function(data){
            if(data.success) {
              vm.user.ftycurrency = data.currency;
              vm.user.plfEx_Rate = data.plf_ex_rate;
              vm.user.plzCurrencyID = data.curID;
              vm.calculateExRate();
            }
            else {
              noticeFailed(data.message);
            }
          }
        });
      }
    }
  };

})();
