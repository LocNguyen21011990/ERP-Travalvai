(function() {
    var app = angular.module('price_list_factory_detail', ['datatables', 'ui.select2', 'datatables.light-columnfilter']).controller("BindAngularDirectiveCtrl", BindAngularDirectiveCtrl);

    function BindAngularDirectiveCtrl($scope, $filter, $http, $compile, DTOptionsBuilder, DTColumnBuilder) {
        var vm = this;
        vm.showFilterModal = showFilterModal;
        vm.searchCosting = searchCosting;
        vm.userInfo = {};
        vm.user = {};
        vm.dtInstance = {}
        vm.dtInstance_costing = {};
        vm.dtOptions_costing = [];
        vm.dtColumns_costing = [];
        vm.enableEditSell3 = enableEditSell3;
        vm.doneEditSell3 = doneEditSell3;
        vm.returnFilter = returnFilter;
        vm.addCostingVersion = addCostingVersion;
        vm.refreshEdit = refreshEdit;
        vm.metadata = -1;
        vm.PLF_Detail_Table = {};
        vm.deletePLF = deletePLF;
        vm.ResetPrice = ResetPrice;
        vm.backState = backState;
        id_plf = getQueryVariable('id');

        function getQueryVariable(variable) {
            var query = window.location.search.substring(1);
            var vars = query.split('&');
            for (var i = 0; i < vars.length; i++) {
                var pair = vars[i].split('=');
                if (decodeURIComponent(pair[0]) == variable) {
                    return decodeURIComponent(pair[1]);
                }
            }
        }

        $.ajax({
            async: false,
            type: 'GET',
            url: '/index.cfm/basicdata/getUserLevel',
            success: function(data) {
                vm.userInfo = data;
                //if it is factory admin
                if (vm.userInfo.TYPEUSER == 1) {
                    vm.isShowCreateBtn = true;
                } else {
                    vm.isShowCreateBtn = false;
                }
            }
        });

        $.ajax({
            async: false,
            type: 'GET',
            url: '/index.cfm/price_list_factory_detail/getSeason',
            success: function(data) {
                vm.old_seasons = data;
            }
        });

        $.ajax({
            type: "POST",
            url: "/index.cfm/price_list_factory/getPLF",
            async: false,
            data: {
                'id_price_list_factory': getQueryVariable('id')
            },
            success: function(data) {
                vm.user = angular.fromJson(data[0]);
                $.ajax({
                    async: false,
                    type: 'GET',
                    url: '/index.cfm/price_list_factory_detail/getCurrencyConvertById',
                    data: {
                        id_currency: vm.user.FTYCURRENCYID
                    },
                    success: function(data) {
                        vm.user.exRateUSDToFtyCurrency = $filter('number')(roundDecimalPlaces(data, 2), 2);
                        vm.user.calcuExRate = $filter('number')(roundDecimalPlaces(data / vm.user.CREATION_DATE, 2), 2);
                        vm.user.devidedCalcuExRate = roundDecimalPlaces(1 / data, 2);
                        vm.user.devidedExRate = roundDecimalPlaces(1 / vm.user.EX_RATE, 2);
                    }
                });
            }
        });



        vm.sell3 = [];
        vm.editing = false;

        vm.dtOptions_detail = DTOptionsBuilder.fromSource('/index.cfm/price_list_factory_detail/getPLF_detail?id=' + getQueryVariable('id'))
            .withPaginationType('full_numbers')
            .withLightColumnFilter({
                '0': {
                    type: 'text'
                },
                '1': {
                    type: 'text'
                },
                '2': {
                    type: 'text'
                },
                '3': {
                    type: 'text'
                },
                '4': {
                    type: 'text'
                },
                '6': {
                    type: 'text'
                },
                '8': {
                    type: 'text'
                },
                '10': {
                    type: 'text'
                }
            })
            .withOption('createdRow', createdRow)
            .withOption('select', { style: 'single' });

        vm.dtColumns_detail = [
            DTColumnBuilder.newColumn('COST_CODE').withTitle('CODE'),
            DTColumnBuilder.newColumn('CD_DESCRIPTION').withTitle('DESCRIPTION'),

            DTColumnBuilder.newColumn('CV_VERSION').withTitle('No.').withClass("text-center th-align-left"),
            DTColumnBuilder.newColumn('CVD_DESCRIPTION').withTitle('DESCRIPTION'),

            DTColumnBuilder.newColumn('FAC_COST').withTitle('COST').renderWith(formatNumber).withClass("text-right th-align-left"),
            DTColumnBuilder.newColumn('CURR_CODE_FAC').withTitle('CURRENCY'),

            DTColumnBuilder.newColumn('FTY_CURR').withTitle('SELL CALC').renderWith(formatNumber).withClass("text-right th-align-left"),
            DTColumnBuilder.newColumn('CURR_CODE_FAC').withTitle('CURRENCY'),

            DTColumnBuilder.newColumn('PL_CURR').withTitle('SELL CALC').renderWith(formatNumber).withClass("text-right th-align-left"),
            DTColumnBuilder.newColumn('CURR_CODE').withTitle('CURRENCY'),

            DTColumnBuilder.newColumn('PLFD_FTY_SELL_3').withTitle('SELL PRICE').renderWith(editsell3).withClass("text-right th-align-left").withOption('width', "9%"),
            DTColumnBuilder.newColumn('CURR_CODE').withTitle('CURRENCY'),
            DTColumnBuilder.newColumn(null).withTitle('ACTIONS').renderWith(actionsHtml).notSortable().withOption('width', "2%")
        ];

        function formatNumber(data, type, full, meta) {
            return $filter('number')(roundDecimalPlaces(data, 2), 2);
        }

        //remove action without factory admin
        if (vm.userInfo.TYPEUSER != 1) {
            vm.dtColumns_detail.splice(13, 1);
        }

        function deletePLF(plfid) {
            $.ajax({
                type: "POST",
                url: "/index.cfm/price_list_factory_detail/deletePLF",
                async: false,
                data: {
                    'id_plf': plfid
                },
                success: function(data) {
                    if (data.success) {
                        noticeSuccess(data.message);
                        vm.dtInstance.reloadData();
                    } else {
                        noticeFailed(data.message);
                    }
                }
            });
        }



        function actionsHtml(data, type, full, meta) {
            vm.PLF_Detail_Table[data.ID] = data;
            if (vm.userInfo.TYPEUSER == 1) {
                return '<span class="txt-color-red btndelete" title="Delete price list factory" ng-click="showCase.deletePLF(' + data.ID + ')">' +
                    '<i class="ace-icon bigger-130 fa fa-trash-o"></i></span>';
            } else {
                return "";
            }
        }

        function editsell3(data, type, full, meta) {
            var strStyle = '';
            if (full.PLFD_FTY_SELL_3 > full.PL_CURR) {
                strStyle = 'style="color: red;"';
            }
            return '<span ' + strStyle + ' ng-hide="showCase.editing && showCase.metadata == ' + meta.row + '" ng-click="showCase.enableEditSell3(' + meta.row + ',' + full.ID + ',' + full.PLFD_FTY_SELL_3 + ')">' + $filter('number')(data, 2) + '</span>' +
                '<input ng-show="showCase.editing && showCase.metadata == ' + meta.row + '" ng-enter="showCase.doneEditSell3(showCase.sell3[' + meta.row + '].ID,showCase.sell3[' + meta.row + '].PLFD_FTY_SELL_3)" autofocus ng-model="showCase.sell3[' + meta.row + '].PLFD_FTY_SELL_3"/>' +
                '<br/><span class="txt-color-green btnedit" title="Edit" ng-show="!(showCase.editing && showCase.metadata == ' + meta.row + ')" ng-click="showCase.enableEditSell3(' + meta.row + ',' + full.ID + ',' + full.PLFD_FTY_SELL_3 + ')"><i class="ace-icon bigger-130 fa fa-pencil"></i></span>' +
                '<span class="txt-color-red btnSave" ng-show="showCase.editing && showCase.metadata == ' + meta.row + '" ng-click="showCase.doneEditSell3(showCase.sell3[' + meta.row + '].ID,showCase.sell3[' + meta.row + '].PLFD_FTY_SELL_3)">' +
                '   <i class="ace-icon bigger-130 fa fa-floppy-o"></i>' +
                '</span>' +
                '<span class="txt-color-red btnSave" ng-show="showCase.editing && showCase.metadata == ' + meta.row + '" ng-click="showCase.refreshEdit()">' +
                '   <i class="ace-icon bigger-130 fa fa-times"></i>' +
                '</span>';
        }

        function enableEditSell3(metainfo, id, sell3value) {
            vm.editing = true;
            vm.metadata = metainfo;
        }

        function refreshEdit() {
            vm.editing = true;
            vm.metadata = -1;
        }

        function doneEditSell3(id, data) {
            vm.editing = false;
            vm.metadata = -1;
            $.ajax({
                type: "POST",
                url: "/index.cfm/price_list_factory_detail/updatePLFD_FTY_SELL_3",
                async: false,
                data: {
                    'id': id,
                    'sell3': Number(data)
                },
                success: function(data) {
                    if (data == true) {
                        vm.sell3 = [];
                        vm.dtInstance.reloadData();
                    } else {
                        alert('Something went wrong. Can not update data!');
                    }
                }
            });
        }


        function createdRow(row, data, dataIndex) {
            var newdata = {
                "ID": data.ID,
                "PLFD_FTY_SELL_3": $filter("number")(data.PLFD_FTY_SELL_3, 2).replace(/,/g, "")
            };
            vm.sell3.push(newdata);
            $compile(angular.element(row).contents())($scope);
        }

        function showFilterModal() {
            vm.user.typecopy = 0;

            $('#modalFilterArticle').modal('show');
            $(document).ready(function() {
                $("#modalFilterArticle").on('shown.bs.modal', function() {
                    $(this).find('#oseason').focus();
                });
            });
        }
        vm.selectallcv = selectallcv;
        vm.selectonebyonecv = selectonebyonecv;
        vm.isSelectAll = false;

        var titleHtml = '<input name="select_all" value="showCase.isSelectAll" id="select_all" type="checkbox" ng-click="showCase.selectallcv(showCase.isSelectAll)">';

        vm.dtOptions_costing = DTOptionsBuilder.fromSource('/index.cfm/costing/getCostingVerions?view=0')
            .withPaginationType('full_numbers')
            .withOption('createdRow', rowClick);
        vm.dtColumns_costing = [
            DTColumnBuilder.newColumn('id_cost').withTitle('ID'),
            DTColumnBuilder.newColumn('id_cost_version').withTitle('ID VERSION'),
            DTColumnBuilder.newColumn('cost_code').withTitle('CODE'),
            DTColumnBuilder.newColumn('cd_description').withTitle('DESCRIPTION'),
            DTColumnBuilder.newColumn('cost_season').withTitle('SEASON'),
            DTColumnBuilder.newColumn('cost_pl').withTitle('PRICE LIST'),
            DTColumnBuilder.newColumn('cv_version').withTitle('No.VERSION'),
            DTColumnBuilder.newColumn(null).withTitle(titleHtml).notSortable()
            .renderWith(function(data, type, full, meta) {
                vm.selected[full.id_cost_version] = false;
                return '<input type="checkbox" ng-model="showCase.selected[' + data.id_cost_version + ']" ng-click="showCase.toggleOne(showCase.selected)">';
            })
        ];

        function searchCosting() {
            $('#modalFilterArticle').modal('hide');
            $('#modalCostListing').modal('show');
            vm.isSelectAll = false;
            $('#select_all').prop('checked', vm.isSelectAll);
            $(document).ready(function() {
                vm.dtOptions_costing = DTOptionsBuilder.fromSource('/index.cfm/costing/getCostingVerions?view=1&oseason=' + $('#oseason').val() + "&ocode=" + $('#oCode').val())
                    .withPaginationType('full_numbers')
                    .withOption('createdRow', function(row, data, dataIndex) {
                        // Recompiling so we can bind Angular directive to the DT
                        $compile(angular.element(row).contents())($scope);
                    })
                    .withOption('headerCallback', function(header) {
                        if (!vm.headerCompiled) {
                            // Use this headerCompiled field to only compile header once
                            vm.headerCompiled = true;
                            $compile(angular.element(header).contents())($scope);
                        }
                    });
                vm.dtColumns_costing = [
                    DTColumnBuilder.newColumn('id_cost').withTitle('ID'),
                    DTColumnBuilder.newColumn('id_cost_version').withTitle('ID VERSION'),
                    DTColumnBuilder.newColumn('cost_code').withTitle('CODE'),
                    DTColumnBuilder.newColumn('cd_description').withTitle('DESCRIPTION'),
                    DTColumnBuilder.newColumn('cost_season').withTitle('SEASON'),
                    DTColumnBuilder.newColumn('cost_pl').withTitle('PRICE LIST'),
                    DTColumnBuilder.newColumn('cv_version').withTitle('No.VERSION'),
                    DTColumnBuilder.newColumn(null).withTitle(titleHtml).notSortable()
                    .renderWith(function(data, type, full, meta) {
                        return '<input type="checkbox" class="rowcheckbox" name="id_cost_version[]" value="' +
                            $('<div/>').text(full.id_cost_version).html() + '" ng-click="showCase.selectonebyonecv()">';
                    })
                ];
                vm.dtColumns_costing[0].visible = false;
                vm.dtColumns_costing[1].visible = false;
                vm.dtInstance_costing.reloadData();
            });
        }


        function selectallcv(isSelectAll) {
            vm.isSelectAll = !isSelectAll;
            $('.rowcheckbox').prop('checked', vm.isSelectAll);
        }

        function rowClick(row, data, dataIndex) {
            // Recompiling so we can bind Angular directive to the DT
            $compile(angular.element(row).contents())($scope);
        }

        function selectonebyonecv() {
            if (vm.isSelectAll == true) {
                vm.isSelectAll = !vm.isSelectAll;
                $('#select_all').prop('checked', vm.isSelectAll);
            }
        }

        function addCostingVersion() {
            var arr_CV = []
            $('.rowcheckbox').each(function() {
                if ($(this).prop('checked') == true) {
                    arr_CV.push($(this).val());
                }
            })
            if (arr_CV.length == 0) {
                alert("Nothing selected to insert !");
                return;
            }
            $.ajax({
                type: "POST",
                url: "/index.cfm/price_list_factory_detail/insertPLFDetail",
                async: false,
                data: {
                    'arr_cv': arr_CV,
                    'id_plf': getQueryVariable('id')
                },
                success: function(data) {
                    if (data.success == true) {
                        noticeSuccess(data.message);
                        vm.dtInstance.reloadData();
                    } else {
                        noticeSuccess(data.message);
                    }
                    $('#modalCostListing').modal('hide');
                }
            });
        }

        $("#oseason").change(function() {
            if (!$("#oseason").val()) {
                $("#oCode").attr("disabled", "disabled");
                vm.oCodes = [];
            } else {
                vm.oCodes = "";
                $("#oCode").removeAttr("disabled");
                var oseason = $("#oseason").val();
                $.ajax({
                    type: "POST",
                    url: "/index.cfm/costing/getCostingLst",
                    async: false,
                    data: {
                        'season': oseason,
                    },
                    success: function(data) {
                        vm.oCodes = data;
                        $("#sameCode").attr("disabled", "disabled");
                    }
                });
            }
        });

        $("#oCode").change(function() {});
    };

    function returnFilter() {
        $('#modalCostListing').modal('hide');
        $('#modalFilterArticle').modal('show');
    }

    app.directive('ngEnter', function() {
        return function(scope, element, attrs) {
            element.bind("keydown keypress", function(event) {
                if (event.which === 13) {
                    scope.$apply(function() {
                        scope.$eval(attrs.ngEnter);
                    });
                    event.preventDefault();
                }
            });
        };
    });

    function ResetPrice(vm) {
        var result = confirm('Do you want to reset Factory Sell Price?');
        if (result) {
            $.ajax({
                type: "POST",
                url: "/index.cfm/price_list_factory_detail/resetPrice",
                async: false,
                data: {
                    'id_plf': id_plf
                },
                success: function(data) {
                    if (data.success == true) {
                        noticeSuccess(data.message);
                    } else {
                        noticeSuccess(data.message);
                    }
                    vm.sell3 = [];
                    vm.dtInstance.reloadData();
                }
            });
        }
    };

    function backState() {
        history.back();
    }

})();