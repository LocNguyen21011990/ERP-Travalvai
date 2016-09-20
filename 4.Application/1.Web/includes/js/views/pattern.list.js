(function(){
  var myapp = angular.module('pattern.list', ['datatables', 'datatables.light-columnfilter', 'ui.select2']);
  myapp.controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  function BindAngularDirectiveCtrl($scope , $http ,$compile, DTOptionsBuilder, DTColumnBuilder)
  {
    var vm                = this;
    vm.message            = '';
     vm.addRow            = addRow;
     vm.refresh           = refresh;
     vm.refreshPart       = refreshPart;
     vm.refreshVari       = refreshVari;
     vm.addPatternPart    = addPatternPart;
     vm.addPatternVari    = addPatternVari;
     vm.editPatternVari   = editPatternVari;
     vm.editPatternPart   = editPatternPart;
     vm.dtInstance        = {};
     vm.dtInstance2       = {};
     vm.dtInstance3       = {};
     vm.dtInstance4       = {};
     vm.showAddNew        = showAddNew; 
     vm.refreshLanguage   = refreshLanguage;
     vm.persons           = {};
     vm.user              = {};
     vm.user.craeateDate  = $.datepicker.formatDate('dd/mm/yy', new Date());
     vm.user.updateDate   = $.datepicker.formatDate('dd/mm/yy', new Date());
     vm.dataDesDefine     = {};
     vm.newDes            = {};
     vm.dataDes           = {};
     vm.dataDesPart       = {};
     vm.dataDesVari       = {};
     vm.regex             = "[a-z A-Z 0-9-\_\.]+";
     vm.regexPartVari     = "[a-z A-Z 0-9-\_\,]+";
     vm.isReadonly        = false;
     vm.patternPart       = {};
     vm.patternVari       = {};
     vm.deletePatternVari = deletePatternVari;
     vm.deletePatternPart = deletePatternPart;     
     var original         = angular.copy(vm.user);
     var originalDesVari  = angular.copy(vm.dataDesVari);


    vm.patterns = [];
     //table notes
    vm.dtOptions2  = DTOptionsBuilder.fromSource('/index.cfm/patterns.getPatternNotes'+ window.location.search)
                    .withOption('createdRow', createdRow)
                    .withOption('order', [1, 'desc'])
                    .withOption('searching', false)
                    .withOption('paging', false);
    vm.dtColumns2  = [
        DTColumnBuilder.newColumn('createDate').withTitle('Date'),
        DTColumnBuilder.newColumn('id').withTitle(''),
        DTColumnBuilder.newColumn('notes').withTitle('Notes').withOption('width',"80%"),
    ]; 
    vm.dtColumns2[1].visible = false; 

    //table part
    vm.dtOptions3  = DTOptionsBuilder.fromSource('/index.cfm/patterns.getPatternPart'+ window.location.search)
      .withPaginationType('full_numbers')
      .withOption('createdRow', createdRow)
      .withOption('order', [0, 'desc'])
      .withOption('searching', false)
      .withOption('paging', false);;
    vm.dtColumns3  = [
          DTColumnBuilder.newColumn('id').withTitle('ID'),
          DTColumnBuilder.newColumn('code').withTitle('CODE').withOption('width',"10%"),
          DTColumnBuilder.newColumn('des').withTitle('DESCRIPTION').withOption('width',"86%"),
          DTColumnBuilder.newColumn(null).renderWith(actionsHtmlPart).notSortable().withOption('width',"2%")
        ];
    vm.dtColumns3[0].visible = false; 

    //table vari
    vm.dtOptions4  = DTOptionsBuilder.fromSource('/index.cfm/patterns.getPatternVari'+ window.location.search)
      .withPaginationType('full_numbers')
      .withOption('createdRow', createdRow)
      .withOption('order', [0, 'desc'])
      .withOption('searching', false)
      .withOption('paging', false);;
    vm.dtColumns4  = [
          DTColumnBuilder.newColumn('id').withTitle('ID'),
          DTColumnBuilder.newColumn('code').withTitle('VAR. Code').withOption('width',"10%"),
          DTColumnBuilder.newColumn('des').withTitle('Description').withOption('width',"10%"),
          DTColumnBuilder.newColumn('parts').withTitle('Parts').withOption('width',"18%"),
          DTColumnBuilder.newColumn('sketch').withTitle('Sketch').withOption('width',"40%"),
          DTColumnBuilder.newColumn(null).renderWith(actionsHtmlVari).notSortable().withOption('width',"2%")
        ];
    vm.dtColumns4[0].visible = false; 
    //get group product
    $http.get("/index.cfm/patterns/getGroupOfProduct").success(function(dataResponse){
      vm.groupProduct = dataResponse;
    });
    //get multi lang
    $.ajax({
        async: false,
        type: 'POST',
        url: '/index.cfm/patterns/getLanguage',
        success: function(data) {
        //callback
          vm.dataDesPart = data.slice(); 
          vm.dataDesDefine  = data.slice();       
          vm.dataDesVari  = data.slice();       
        }
      }); 
    
     if(getQueryVariable('id')){
        $('#pattern_part').css("display", "inline-block");
        $('#pattern_vari').css("display", "inline-block");
        $('#divImgParts').css("display", "inline-block");
        $('#divImgSketch').css("display", "inline-block"); 
        $('#divImgVari').css("display", "none");
         
        //get pattern base on id_pattern      
        $.ajax({
            async: false,
            type: 'POST',
            url: '/index.cfm/patterns/getPatternID'+window.location.search,
          success: function(data) {
            vm.user = data;
            vm.dataDes = angular.fromJson(data.full_language);
            sketchPath = data.sketch;
            $('#imgSketch').attr('src',sketchPath);
            $('#imgSketch').parent().attr('href',sketchPath);

            partsPath = data.parts;
            $('#imgParts').attr('src',partsPath);
            $('#imgParts').parent().attr('href',partsPath);            

            if(data.hasOwnProperty('id')){
              $('#id_pattern').val(data.id);
            }else{
              $('#id_pattern').val(0);
            }
            $('#btnCreateNotes').removeAttr("disabled");
          }
        }); 
     }else{
        $('#pattern_part').css("display", "none");
        $('#pattern_vari').css("display", "none");
        $('#divImgParts').css("display", "none");
        $('#divImgSketch').css("display", "none");
       

        $.ajax({
          async: false,
          type: 'POST',
          url: '/index.cfm/patterns/getLanguage',
          success: function(data) {
          //callback
            vm.newDes = data.slice();
            vm.dataDes = data.slice();       
          }
        });      
     }
    
    function showAddNew () {
      // body...
      if(vm.user.patternnode != ""){
        $.ajax({
               type: "POST",
               url: "/index.cfm/patterns/addNewNote",
               async: false,
               data: {'patternnode' : vm.user.patternnode,
                      'idpattern' : $('#id_pattern').val(),
            },
            success: function( data ) {
                if(data.success)
                {
                    noticeSuccess(data.message);
                    vm.user.patternnode = '';
                    vm.dtInstance2.reloadData();
                    $('#patternnode').val("");
                }else{
                    noticeFailed("Please insert contents to add notes");
                    $('#patternnode').focus();
                }
            }
        });
      }else{
         noticeFailed("Please insert contents to add notes");
         $('#patternnode').focus();
      }
    }    
    

     function getQueryVariable(variable) {
        var query = window.location.search.substring(1);
        var vars = query.split("&");
        for (var i=0;i<vars.length;i++) {
          var pair = vars[i].split("=");
          if (pair[0] == variable) {
            return pair[1];
          }
        } 
    }

  
  function addPatternPart(){
   var flag2 = false;
   var pp_code = $("#pp_code").val();
      $.ajax({
             type: "POST",
             url: "/index.cfm/patterns/checkExistPartCode",
             async: false,
             data: {
                'pattern_code' : vm.user.code,
                'id_pattern' : $("#id_pattern").val(),
                'part_code' : vm.user.partcode,
                'pp_code' : pp_code
            },
            success: function( data ) {
                flag2 = data.exist;
                if(flag2 == false){
                  $.ajax({
                       type: "POST",
                       url: '/index.cfm/patterns/addNewPatternPart'+window.location.search,
                       async: false,
                       data: {
                          'des' : JSON.stringify(vm.dataDesPart)
                          ,'partcode'  : (vm.user.partcode == null) ? "" : (vm.user.partcode)    
                          ,'pp_code' : pp_code                     
                       },
                    success: function( idata ) {
                      if(idata.success){                        
                        noticeSuccess(idata.message);
                      }else{
                        noticeFailed(idata.message);
                      }
                      refreshPart(); 
                      $('#partcode').removeAttr('readonly', true); 
                      $("#pp_code").val("");
                      vm.dtInstance3.reloadData();                    
                    }
                });
              }else{               
                // $scope.partForm.partcode.$invalid=true;
                // $scope.partForm.$invalid=true;
                $(".noti_code").remove();
                $("#partcode").after('<p class="help-block noti_code"><font color="red">Code is exist in systems!</p>');
                $("#partcode").focus();
              }
            }
      });
  }
  var fd2 = new FormData(); 
  $scope.uploadVariSketch = function(files) {
    //Take the first selected file
    fd2.append("varisketch", files[0]);
    vm.user.varisketch = files[0].type;
  };

  function addPatternVari(){
    $scope.variForm.$invalid = true;
    var pv_code_temp = $("#pv_code_temp").val();
    fd2.append('des'                 , JSON.stringify(vm.dataDesVari));
    fd2.append('varicode'            , (vm.user.varicode == null) ? "" : (vm.user.varicode));
    fd2.append('pv_code_temp'        , pv_code_temp);
    fd2.append('varipart'            , (vm.user.varipart == null) ? "" : vm.user.varipart);
    fd2.append('variSketchName'      , (vm.user.varisketch== null) ? "" : vm.user.varisketch);
   var flag2 = false;   
      $.ajax({
             type: "POST",
             url: "/index.cfm/patterns/checkExistVariCode",
             async: false,
             data: {
                'id_pattern'    : $("#id_pattern").val(),
                'pv_code_temp'  : $("#pv_code_temp").val(),
                'pv_code'    : vm.user.varicode
            },
            success: function( data ) {
                flag2 = data.exist;
                if(flag2 == false){
                  $.ajax({
                       type: "POST",
                       url: '/index.cfm/patterns/addNewPatternVari'+window.location.search,
                       async: false,
                       processData: false,
                       contentType: false,
                       data: fd2,
                    success: function( idata ) {
                      if(idata.success){                        
                        noticeSuccess(idata.message);
                      }else{
                        noticeFailed(idata.message);
                      }
                      resetFormd2();
                      refreshVari();
                      $('#varicode').removeAttr('readonly', true); 
                      $("#pv_code_temp").val('');
                      vm.dtInstance4.reloadData();
                      $('#divImgVari').addClass('hidden');
                    }
                  });
                }else{
                  vm.user.varipart = null;
                  vm.dataDesVari = vm.dataDesDefine;
                  resetFormd2();            
                  $scope.variForm.$invalid=true;
                  $("#varicode").after('<p class="help-block noti_code"><font color="red">Code is exist in systems!</p>');
                  $("#varisketch").val('');
                  $("#varicode").focus();
                }
              }
      });
  }
  function resetFormd2(){
    fd2.delete('des');
    fd2.delete('varicode');
    fd2.delete('pv_code_temp');
    fd2.delete('varipart');
    fd2.delete('variSketchName');
    fd2.delete('varisketch');
  }
  var fd = new FormData();
  $scope.uploadSketch = function(files) {
      //Take the first selected file
      fd.append("sketch", files[0]);
      vm.user.sketch = files[0].type;
  };
  $scope.uploadParts = function(files) {
    //Take the first selected file
    fd.append("parts", files[0]);
    vm.user.parts = files[0].type;
  };

  function addRow() {
     $scope.userForm.$invalid=true;     
      fd.append('code'                , (vm.user.code == null) ? "" : vm.user.code);
      fd.append('des'                 , JSON.stringify(vm.dataDes));
      fd.append('sketchName'         , (vm.user.sketch == null) ? "" : vm.user.sketch);
      fd.append('partsName'          , (vm.user.parts == null) ? "" : vm.user.parts);
      fd.append('id_pattern'          , $('#id_pattern').val());
      fd.append('groupProduct'        , $('#groupProduct').val());
      fd.append('patternnode'         , $('#patternnode').val());
      var flag = false;
      $.ajax({
             type: "POST",
             url: "/index.cfm/patterns/checkExistCode",
             async: false,
             data: {
                'code' : vm.user.code,
                'id' : $("#id_pattern").val()
            },
            success: function( data ) {
                flag = data.success;
                if(!flag){
                  $.ajax({
                       type: "POST",
                       url: "/index.cfm/patterns/addNewPattern",
                       async: false,
                       processData: false,
                       contentType: false,
                       data: fd
                    ,
                    success: function( idata ) {
                      if(idata.success){
                        noticeSuccess(idata.message);
                        resetFormd();                        
                        window.location.href = "/index.cfm/patterns.index";
                      }else{
                        noticeFailed(idata.message);
                      }
                      refresh();
                    }
                });
              }else{  
                resetFormd();             
                $scope.userForm.code.$invalid=true;
                $scope.userForm.$invalid=true;                 
                $("#code").after('<p class="help-block noti_code"><font color="red">Code is exist in systems!</p>');
                refresh();
              }
            }
      });
    }

  function resetFormd(){
    vm.user.sketch = '';
    vm.user.parts = '';
    fd.delete('code');
    fd.delete('des');
    fd.delete('sketchName');
    fd.delete('partsName');
    fd.delete('id_pattern');
    fd.delete('groupProduct');
    fd.delete('patternnode');
    fd.delete('groupProduct');
    fd.delete('sketch');
    fd.delete('parts');
  }
  function edit(person) {   
    refresh();
    $('#addNew').modal('show');
    $('#btnRefresh').css('display','none');
      //highlight row being edit
    $(".highlight").removeClass("highlight");
    $("#mytable td").filter(function() { return $.text([this]) == person.CODE; })
      .parent()
      .addClass("highlight");
    vm.user.code        = person.CODE;
    vm.user.patternnode = person.patterncode;
    vm.newDes = angular.fromJson(person.FULL_LANGUAGE);

    $('#id_pattern').val(person.ID);
    document.getElementById("titleID").innerHTML="Edit";
  }
	function refreshLanguage() {
		$('#id_cv').val(0);
		vm.des= angular.copy(originalLanguage);
		$scope.languageForm.$setPristine();
	}

  function refresh () {
      $('#id_pattern').val(0);
      $(".noti_code").remove();
      vm.user= angular.copy(original);
      $scope.userForm.$setPristine();
      $('#code').val('');
      $('.pdescription').val('');
      $('#sketch').val('');      
      $('#parts').val('');      
  }

  function refreshPart(){
    $(".noti_code").remove();
    $('#partcode').val('');
    $('.partDescription').val('');
    $scope.partForm.$setPristine();
    vm.dataDesPart = vm.dataDesDefine;
    $("#partcode").focus();    
  }

  function refreshVari(){
    $( '#fd2' ).each(function(){
        this.reset();
    });
    $(".noti_code").remove();
    $("#varisketch").val('');
    vm.user.varipart = null;
    vm.user.varicode = null;
    vm.dataDesVari = vm.dataDesDefine;
    $('.variDescription').val('');
    vm.user.varisketch = "";
    $scope.variForm.$setPristine();
    $("#varicode").focus();    
  }

  function editPatternPart(array){
       $('.noti_code').remove();
      $.ajax({
             type: "POST",
             url: "/index.cfm/patterns/editPatternPart"+window.location.search,
             async: false,
             data: {
                  'ppid' : array.id
                , 'ppcode' : array.code
            },
            success: function( data ) {
              vm.dataDesPart = angular.fromJson(data.full_language_part);
              vm.user.partcode = data.ppcode;
              $("#pp_code").val(data.ppcode);
              $('#partcode').prop('readonly', true);
            }
      });
  }

  function editPatternVari(array){
      $('.noti_code').remove();
      $('#divImgVari').removeClass('hidden');
      $.ajax({
             type: "POST",
             url: "/index.cfm/patterns/editPatternVari"+window.location.search,
             async: false,
             data: {
                  'pvid' : array.id
                , 'pv_code' : array.code
            },
            success: function( data ) {
              vm.dataDesVari = angular.fromJson(data.full_language_part);
              vm.user.varicode = data.pvcode;
              vm.user.varipart = data.parts;
              $("#pv_code_temp").val(data.pvcode);
              $('#varicode').prop('readonly', true);
              ///image vari
              $('#divImgVari').css("display", "inline-block");
              VariSketchPath = data.pv_sketch;
              $('#imgVari').attr('src',VariSketchPath);
              $('#imgVari').parent().attr('href',VariSketchPath);
            }
      });
  }

  function deletePatternPart(array){
    $.ajax({
         type: "POST",
         url: "/index.cfm/patterns/delPatternPart"+window.location.search,
         async: false,
         data: {
              'id_pattern' :  $('#id_pattern').val()
            , 'pp_code' : array.code
        },
        success: function( data ) {
          if(data.success){
              noticeSuccess(data.message);
              vm.dtInstance3.reloadData();
          }else{
              noticeFailed("Can not delete this pattern part");
          }
        }
    });
  }

  function deletePatternVari(array){
    $.ajax({
         type: "POST",
         url: "/index.cfm/patterns/deletePatternVari"+window.location.search,
         async: false,
         data: {
              'id_pattern' :  $('#id_pattern').val()
            , 'pv_code' : array.code
        },
        success: function( data ) {
          if(data.success){
              noticeSuccess(data.message);
              vm.dtInstance4.reloadData();
          }else{
              noticeFailed(data.message);
          }
        }
    });
  }


  function actionsHtmlPart(data, type, full, meta) {
      vm.patternPart[data.id] = data;
      return '<span class="txt-color-green btnedit" title="Edit" ng-click="showCase.editPatternPart(showCase.patternPart[' + data.id + '])">' +
                '<i class="ace-icon bigger-130 fa fa-pencil"></i></span></a>' + 
              '<span class="txt-color-red btndelete" title="Delete pattern part" ng-click="showCase.deletePatternPart(showCase.patternPart[' + data.id + '])">' +
                '<i class="ace-icon bigger-130 fa fa-trash-o"></i></span>';
  }

  function actionsHtmlVari(data, type, full, meta) {
      vm.patternVari[data.id] = data;
      return '<span class="txt-color-green btnedit" title="Edit" ng-click="showCase.editPatternVari(showCase.patternVari[' + data.id + '])">' +
                '<i class="ace-icon bigger-130 fa fa-pencil"></i></span></a>' + 
              '<span class="txt-color-red btndelete" title="Delete pattern vari" ng-click="showCase.deletePatternVari(showCase.patternVari[' + data.id + '])">' +
                '<i class="ace-icon bigger-130 fa fa-trash-o"></i></span>';
  }


  function createdRow(row, data, dataIndex,iDisplayIndexFull) {
      // Recompiling so we can bind Angular directive to the DT
      $compile(angular.element(row).contents())($scope);
        return row;
  };

	

    };

})();
