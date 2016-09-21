(function(){
  	angular.module('project', ['datatables', 'ui.select2']).controller("BindAngularDirectiveCtrl",BindAngularDirectiveCtrl)

  	function BindAngularDirectiveCtrl($scope ,$http, $filter ,$compile, DTOptionsBuilder, DTColumnBuilder, $window)
  	{
     	var vm = this;
      vm.regex               = "[a-z A-Z 0-9-\_\.]+";
      vm.message             = '';
      vm.addRow              = addRow;
      vm.addRowComment       = addRowComment;
      vm.editproject         = editproject;
      vm.editcomment         = editcomment;
      vm.deletecomment       = deletecomment;
      vm.persons             = {};
      vm.user                = {};
      vm.dtInstance          = {};
      vm.pddtInstance        = {};
      vm.idpro               = 0;
      vm.comment             = {};
      vm.user.groupWaitingFD = 0;
      vm.user.groupUrgent    = 0;
      vm.user.groupVUrgent   = 0;
      vm.user.groupSentTCom  = 0;
      vm.user.groupSentTCus  = 0;
      vm.user.groupSentTD    = 0;
      vm.user.groupWaitingFC = 0;
      var original = angular.copy(vm.comment);
      vm.comment.todaycomment = new Date($filter('date')(Date.now(),"yyyy/MM/dd "));
      vm.dtOptions = DTOptionsBuilder.fromSource('/index.cfm/project/getComment?idproject='+window.location.search.slice(4))
          .withPaginationType('full_numbers')
          .withOption('createdRow', createdRow)
          .withOption('select', { style: 'single' });

      vm.pddtOptions= DTOptionsBuilder.fromSource("/index.cfm/project/getProj_product?idproject="+window.location.search.slice(4))
          .withPaginationType('full_numbers')
          .withOption('createdRow', createdRow)
          .withOption('select', { style: 'single' });

      vm.dtColumns = [
            DTColumnBuilder.newColumn('DATE').withTitle('DATE')
          , DTColumnBuilder.newColumn('USER').withTitle('USER')
          , DTColumnBuilder.newColumn('COMMENT').withTitle('COMMENT')
      ];

      vm.pddtColumns = [
            DTColumnBuilder.newColumn('id_product').withTitle('PRODUCT')
          , DTColumnBuilder.newColumn('Garment_code').withTitle('GARMENT CODE')
          , DTColumnBuilder.newColumn('pr_version').withTitle('COMMENT')
          , DTColumnBuilder.newColumn('cost_code').withTitle('COST CODE')
          , DTColumnBuilder.newColumn('cv_version').withTitle('COST CODE VERS.')
          , DTColumnBuilder.newColumn('pr_description').withTitle('DESCRIPTION')
          , DTColumnBuilder.newColumn('pr_status_desc').withTitle('STATUS')
          , DTColumnBuilder.newColumn(null).withTitle('SKETCH').renderWith(sketchDisplay)
      ];


	  	$http.get("/index.cfm/basicdata/getcustomer").success(function(dataResponse){
        	vm.customers = dataResponse;
      });

    	$http.get("/index.cfm/project/getstatus").success(function(dataResponse){
      	vm.status = dataResponse;
    	});

    	$( "#customer" ).change(function() {
  		  	var idcus = $("#customer").val();
  		  	if(idcus > 0){
  			  	$.ajax({
  	             	type: "POST",
  	             	url: "/index.cfm/project/getzoneagent",
  	             	async: false,
  	             	data: {
  	                  	'idcus' : idcus
  	          		},
  	              	success: function( data ) {
  	                	if(data.success){
  	                  		vm.user.zone = data.name_zone;
  	                  		vm.user.agent = data.name_agent;
  	           	 		}
  	              	}
           	});
  		  	}else{
            vm.user.zone = "";
            vm.user.agent = "";
          }
  		});

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

      var queryString = window.location.search;
      if(queryString) editproject(getQueryVariable("id"));

      function editproject(id) {
        $.ajax({
            type: "POST",
            url: "/index.cfm/project/getprojectforid",
            async: false,
            data: {
                  'id_Project': id
            },
            success: function(data) {
                vm.user.display_format = data.id_display;
                vm.user.display        = "PJ-" +  data.id_display;
                vm.user.description    = data.pj_description;
                vm.user.customerID     = data.id_Customer;
                vm.user.date           = $filter('date')(new Date(data.pj_date),"MM/dd/yyyy");
                vm.user.statusID       = data.id_pj_Status;
                vm.user.zone           = data.zone;
                vm.user.agent          = data.agent;
                vm.user.z_des          = data.z_des;
                vm.user.ag_des         = data.ag_des;
                vm.user.groupWaitingFD = data.pj_act_1?"YES":"NO";
                vm.user.groupUrgent    = data.pj_act_2?"YES":"NO";
                vm.user.groupVUrgent   = data.pj_act_3?"YES":"NO";
                vm.user.groupSentTCom  = data.pj_act_4?"YES":"NO";
                vm.user.groupSentTCus  = data.pj_act_5?"YES":"NO";
                vm.user.groupSentTD    = data.pj_act_6?"YES":"NO";
                vm.user.groupWaitingFC = data.pj_act_7?"YES":"NO";
                vm.user.pj_act_8       = data.pj_act_8?"YES":"NO";
                vm.user.pj_act_9       = data.pj_act_9?"YES":"NO";
                vm.user.pj_act_10      = data.pj_act_10?"YES":"NO";
            }
        });
      }

      function sketchDisplay(data, type, full, meta){
        return ' <img src="/includes/img/ao/' + data.pr_sketch + '" class="img-responsive" alt="' + data.cost_code + '"> ';
      }

      function getComment(){
        var id = window.location.search.slice(4);

        $.ajax({
          type: "POST",
          url: "/index.cfm/project/getcomment?idproject="+id,
          async: false,
          success: function( data ) {
            if(data.success){
                 vm.comments = data.comments;
            }
            else
            {
                noticeFailed("Can not get Comments");
            }
            refresh();
          }
        });
      }

    	function addRow () {
      	$.ajax({
           	type: "POST",
           	url: "/index.cfm/project/addNew",
           	async: false,
           	data: {
                	'display'         : vm.user.display_format,
			            'description'     : vm.user.description,
                	'customer'	      : vm.user.customerID,
			            'date'            : $filter('date')(vm.user.date, "yyyy-MM-dd"),
                	'status'	        : vm.user.statusID,
                  'groupWaitingFD'  : vm.user.groupWaitingFD,
                  'groupUrgent'     : vm.user.groupUrgent,
                  'groupVUrgent'    : vm.user.groupVUrgent,
                  'groupSentTCom'   : vm.user.groupSentTCom,
                  'groupSentTCus'   : vm.user.groupSentTCus,
                  'groupSentTD'     : vm.user.groupSentTD,
                  'groupWaitingFC'  : vm.user.groupWaitingFC,
                	'id_Project':$('#id_Project').val()
        		},
            success: function( data ) {
            	if(data.success){
            		noticeSuccess(data.message);
                vm.idpro = data.projectId;
                window.location.href = "project/index";
         	 		}
              else
              {
                	noticeFailed("Please try again!");
              }
          	refresh();
          }
         });
    	}

      function addRowComment() {
        vm.idpro = $("#id_Project").val();
        if(vm.idpro != 0){
          $.ajax({
            type: "POST",
            url: "/index.cfm/project/addNewComment",
            async: false,
            data: {
                  'comment'    : vm.comment.commentContent,
                  'date'       : $filter('date')(Date.now(),"yyyy/MM/dd hh:mm:ss"),
                  'project'    : vm.idpro,
                  'id_Comment' : $('#id_Comment').val()
            },
            success: function( data ) {
              if(data.success){
                noticeSuccess(data.message);
              }
              else
              {
                  noticeFailed("Please try again!");
              }
              refresh();
            }
          });
        }else{
            noticeFailed('insert project before');
        }
      }

      function createdRow(row, data, dataIndex) {
        // Recompiling so we can bind Angular directive to the DT
        $compile(angular.element(row).contents())($scope);
      }


      function editcomment(person) {
        vm.user.commentContent=person.COMMENT;
        $('#id_Comment').val(person.ID);
        vm.idpro = person.PROJECTID;
      }

      function deletecomment(person) {
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
        });
      }

      function refresh () {
        $('#id_Comment').val(0);
        vm.comment = angular.copy(original);
        vm.comment.todaycomment = new Date($filter('date')(Date.now(),"yyyy/MM/dd"));
        $scope.userForm.$setPristine();
        vm.dtInstance.reloadData();
      }
  	};

})();
