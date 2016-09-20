<div ng-app="Formcontact">
    <!--- <div class="modal fade" id="modal_formcontact" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" > --->
    <div id="modal_formcontact" class="modal-dialog">
        <div  class="modal-content">
          	<div class="modal-header">
            	<button type="button" class="close" data-dismiss="modal">&times;</button>
            	<h4 class="modal-title" id="titlecontact">Create</h4>
          	</div>
          	<div class="modal-body">
                    <form class="form-horizontal" name="userFormContact" ng-submit="submitForm()" novalidate>
                        <input type="hidden" value="{{idContactEdit}}" id="contactcontactid">
        	      		<ul class="nav nav-tabs">
        				  	<li class="active"><a data-toggle="tab" href="#contactTab1">Main Information</a></li>
        				  	<li><a data-toggle="tab" href="#contactTab2">Shipping Address</a></li>
        				  	<li><a data-toggle="tab" id="myTab1_s2" href="#contactTab3">Person List</a></li>
        				</ul>
        				<div class="tab-content">

                            <!--------------------------------------- BEGIN CONTACT --------------------------------------->
        					  	<div id="contactTab1" class="tab-pane fade in active">
        							<input type='hidden' name="id_Contact" id="id_Contact" value="0">
                                    <input type='hidden' name="name_Contact" id="name_Contact" value="">

        							<div class="form-group"></div>
                                    <div class="form-group" ng-class="{'has-error':userFormContact.cn_name.$invalid && !userFormContact.cn_name.$pristine}">
                                        <label class="col-md-1 control-label text-left">Name</label>
                                        <label class="col-md-1 control-label text-left text-danger">*</label>
                                        <div class="col-md-10">
                                            <input class="form-control" placeholder="" type="text" name="cn_name" id="cn_name" ng-model="contact.cn_name" required>
                                            <p ng-show="userFormContact.cn_name.$error.required && !userFormContact.cn_name.$pristine" class="help-block">Name is required</p>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-1 control-label text-left">VAT code</label>
                                        <label class="col-md-1 control-label text-left text-danger">*</label>
                                        <div class="col-md-4"v>
                                            <input class="form-control" placeholder="" type="text" name="cts_vat_code" id="cts_vat_code" ng-model="contact.cts_vat_code" required>
                                        </div>

                                        <label class="col-md-1 control-label text-left">Type</label>
                                        <label class="col-md-1 control-label text-left text-danger">*</label>
                                        <div class="col-md-4">
                                            <select class="form-control" id="cts_type" name="cts_type" ng-model="contact.cts_type" ng-options="lang.id as lang.name for lang in typeOptions" required>
                                                <option value="">Choose</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group" >
                                        <label class="col-md-2 control-label text-left">Address 1</label>
                                        <div class="col-md-10">
                                            <input class="form-control" placeholder="" type="text" name="cts_address_1" id="cts_address_1" ng-model="contact.cts_address_1" >
                                        </div>
                                    </div>
                                    <div class="form-group" >
                                        <label class="col-md-2 control-label text-left">Address 2</label>
                                        <div class="col-md-10">
                                            <input class="form-control" placeholder="" type="text" name="cts_address_2" id="cts_address_2" ng-model="contact.cts_address_2" >
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-2 control-label text-left">Address 3</label>
                                        <div class="col-md-10">
                                            <input class="form-control" placeholder="" type="text" name="cts_address_3" id="cts_address_3" ng-model="contact.cts_address_3" >
                                        </div>
                                    </div>
                                    <div class="form-group" >
                                        <label class="col-md-2 control-label text-left">City</label>
                                        <div class="col-md-4" >
                                            <input class="form-control" placeholder="" type="text" name="cts_city" id="cts_city" ng-model="contact.cts_city" >
                                        </div>
                                        <label class="col-md-2 control-label text-left">Province</label>
                                        <div class="col-md-4" >
                                            <input class="form-control" placeholder="" type="text" name="cts_province" id="cts_province" ng-model="contact.cts_province" >
                                        </div>
                                    </div>
                                    <div class="form-group" >
                                        <label class="col-md-2 control-label text-left">Zip code</label>
                                        <div class="col-md-4" >
                                            <input class="form-control" placeholder="" type="text" name="cts_zip_code" id="cts_zip_code" ng-model="contact.cts_zip_code" >
                                        </div>
                                        <label class="col-md-2 control-label text-left">Country</label>
                                        <div class="col-md-4" >
                                            <input class="form-control" placeholder="" type="text" name="cts_country" id="cts_country" ng-model="contact.cts_country" >
                                        </div>
                                    </div>


                                    <div class="form-group">
                                        <label class="col-md-2 control-label text-left">Telephone</label>
                                        <div class="col-md-4" >
                                            <input class="form-control" placeholder="" type="text" name="cts_phone" id="cts_phone" ng-model="contact.cts_phone" >
                                        </div>
                                        <label class="col-md-2 control-label text-left">Email</label>
                                        <div class="col-md-4" >
                                            <input class="form-control" placeholder="" type="text" name="cts_email" id="cts_email" ng-model="contact.cts_email" ng-pattern="showCase.regex_email">
                                            <p ng-show="userFormContact.cts_email.$error.pattern  && !userFormContact.cts_email.$pristine" class="help-block">Email not valid</p>
                                        </div>
                                    </div>
                                    <div class="form-group" >
                                        <label class="col-md-2 control-label text-left">Notes</label>
                                        <div class="col-md-10">
                                            <textarea class="form-control" rows="5" placeholder="" type="text" name="cts_notes" id="cts_notes" ng-model="contact.cts_notes" ></textarea>
                                        </div>
                                    </div>
                                    <div class="form-group text-center">
                                        <div class="btn bg-color-blueDark txt-color-white" id="btnAddRowContact" ng-click="addRowContact()" ng-disabled="userFormContact.$invalid">
                                            <i class="fa fa-save"></i>
                                            &nbsp;Save
                                        </div>
                                        <div class="btn btn-default" id="btnRefreshContact" class="btnRefreshContact" ng-click="refreshContact()">
                                            <i class="fa fa-refresh" ></i>
                                            &nbsp;Refresh
                                        </div>
                                    </div>
        					  	</div>

        					  	<div id="contactTab2" class="tab-pane fade">
        					  		<div class="form-group"></div>
        							<div class="form-group" >
                                        <label class="col-md-3 control-label text-left">SH Name</label>
                                        <div class="col-md-3" >
                                            <input class="form-control" placeholder="" type="text" name="cts_sh_name" id="cts_sh_name" ng-model="contact.cts_sh_name" >
                                        </div>
                                        <label class="col-md-3 control-label text-left">SH Zip Code</label>
                                        <div class="col-md-3" >
                                            <input class="form-control" placeholder="" type="text" name="cts_sh_zip_code" id="cts_sh_zip_code" ng-model="contact.cts_sh_zip_code" >
                                        </div>
                                    </div>

                                    <div class="form-group" >
                                        <label class="col-md-3 control-label text-left">SH Address 1</label>
                                        <div class="col-md-9">
                                            <input class="form-control" placeholder="" type="text" name="cts_sh_address_1" id="cts_sh_address_1" ng-model="contact.cts_sh_address_1" >
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-3 control-label text-left">SH Address 2</label>
                                        <div class="col-md-9">
                                            <input class="form-control" placeholder="" type="text" name="cts_sh_address_2" id="cts_sh_address_2" ng-model="contact.cts_sh_address_2">
                                        </div>
                                    </div>
                                    <div class="form-group" >
                                        <label class="col-md-3 control-label text-left">SH Address 3</label>
                                        <div class="col-md-9">
                                            <input class="form-control" placeholder="" type="text" name="cts_sh_address_3" id="cts_sh_address_3" ng-model="contact.cts_sh_address_3">
                                        </div>
                                    </div>
                                    <div class="form-group" >
                                        <label class="col-md-3 control-label text-left">SH City</label>
                                        <div class="col-md-3" >
                                            <input class="form-control" placeholder="" type="text" name="cts_sh_city" id="cts_sh_city" ng-model="contact.cts_sh_city" >
                                        </div>
                                        <label class="col-md-3 control-label text-left">SH Province</label>
                                        <div class="col-md-3" >
                                            <input class="form-control" placeholder="" type="text" name="cts_sh_province" id="cts_sh_province" ng-model="contact.cts_sh_province" >
                                        </div>
                                    </div>
        							<div class="form-group text-center">
        								<div class="btn bg-color-blueDark txt-color-white" id="btnAddRowContact" ng-click="addRowContact()">
        									<i class="fa fa-save"></i>
        									&nbsp;Save
        								</div>
        								<div class="btn btn-default" id="btnRefreshContact" class="btnRefreshContact" ng-click="refreshContact()">
        									<i class="fa fa-refresh" ></i>
        									&nbsp;Refresh
        								</div>
        							</div>
        					  	</div>

                            <!----------------------------------------- END CONTACT --------------------------------------->

                            <!----------------------------------------- BEGIN PERSON -------------------------------------->
        				  	<div id="contactTab3" class="tab-pane fade">
        				    	<div class="row">
        							<div class="col-md-12" >
        								<fieldset style="display:table-cell;">
        									<div class="col-md-10"><legend class="fcollapsible">Person List</legend></div>
                                            <div class="btn col-md-2 bg-color-blueDark txt-color-white" id="btnAddRow" ng-click="showAddNewPerson()">
                                                <i class="fa fa-save"></i>&nbsp;Create
                                            </div>
                                            <div style="clear: both;"></div>
        									<div class="fcontent" style="overflow: auto;max-height: 500px;">
        										<table id="mytable-Per" class="table table-striped table-bordered" width="100%" datatable dt-options="dtOptionsPerson" dt-columns="dtColumnsPerson" dt-instance="dtInstancePerson">
                                                </table>
        									</div>
        								</fieldset>
        							</div>
        						</div>
        				  	</div>
                            <!------------------------------------------ END PERSON  -------------------------------------->
        				</div>
                    </form>

          	</div>
        </div>
    </div>
    <!--- </div> --->
    <div class="modal fade" id="addNewPersonForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
        <div class="modal-dialog" id="modalForm">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 id="title_Person" class="modal-title">Create</h4>
                </div>
                <div class="modal-body">
                    <div class="fcontent">
                        <form class="form-horizontal" name="userFormPerson" ng-submit="submitForm()" novalidate>
                            <input type='hidden' name="id_Person" id="id_Person" value="0">
                            <div class="form-group"></div>
                            <div class="form-group" ng-class="{'has-error':userFormPerson.name.$invalid && !userFormPerson.name.$pristine}">
                                <label class="col-md-1 control-label text-left">Name</label>
                                <label class="col-md-1 control-label text-left text-danger">*</label>
                                <div class="col-md-10">
                                    <input class="form-control" placeholder="" type="text" name="name" id="name" ng-model="user_person.name"  required>
                                    <p ng-show="userFormPerson.name.$error.required && !userFormPerson.name.$pristine" class="help-block">Name is required</p>
                                </div>
                            </div>

                            <div class="form-group" >
                                <label class="col-md-2 control-label text-left">Position</label>
                                <div class="col-md-10">
                                    <input class="form-control" placeholder="" type="text" name="pos" id="pos" ng-model="user_person.pos" >
                                </div>
                            </div>

                            <div class="form-group" >
                                <label class="col-md-2 control-label text-left">Telephone</label>
                                <div class="col-md-10">
                                    <input class="form-control" placeholder="" type="text" name="phone" id="phone" ng-model="user_person.phone">
                                </div>
                            </div>
                            <div id="telephoneper"></div>
                            <div class="form-group" >
                                <label class="col-md-2 control-label text-left">Email</label>
                                <div class="col-md-10">
                                    <input class="form-control" placeholder="" type="email" name="email_person" id="email_person" ng-model="user_person.email_person" >
                                </div>
                            </div>
                            <div id="emailper"></div>
                            <div class="form-group" >
                                <label class="col-md-2 control-label text-left">Birthday</label>
                                <div class="col-md-10">
                                    <input class="form-control col-md-12" placeholder="" type="date" name="bday" id="bday" ng-model="user_person.bday" >
                                </div>
                            </div>

                            <div class="form-group" >
                                <label class="col-md-2 control-label text-left">Notes</label>
                                <div class="col-md-10">
                                    <input class="form-control" placeholder="" type="text" name="note" id="note" ng-model="user_person.note" >
                                </div>
                            </div>

                            <div class="form-group text-center">
                                <div class="btn bg-color-blueDark txt-color-white" id="btnAddRowPerson" ng-click="addRowPerson()">
                                    <i class="fa fa-save"></i>
                                    &nbsp;Add/Update
                                </div>
                                <div class="btn btn-default" id="btnRefreshPerson" ng-click="refreshPerson()">
                                    <i class="fa fa-refresh"></i>
                                    &nbsp;Refresh
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="showDeletePerson" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
    	<div class="modal-dialog" id="modalForm">
    		<div class="modal-content">
    			<div class="modal-header alert-info">
    				<!--- <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">#getLabel('Close')#</span></button> --->
    				<h3 class="modal-title" id="myModalLabel">Are you sure you want to delete this item?</h3>
    			</div>
    			<div class="modal-footer">
    				<button type="button" class="btn btn-default" data-dismiss="modal">No</button>
    				<button type="submit" id="butsubmit" class="btn btn-info" ng-click="deleteUserPerson()">Yes</button>
    			</div>
    		</div>
    	</div>
    </div>
</div>
<script src="/includes/js/jquery.dataTables.min.js"></script>
<script src="/includes/js/angular-datatables.min.js"></script>
<script src="/includes/js/jquery-ui.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $('#bday').datepicker({dateFormat: 'yy-mm-dd'});
        var isValidEmail = true;
        var isValidPhone = true;
        $('#email_person').keypress(function(){
            var emil=$('#email_person').val();
            var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
            if(!regex.test(emil)){
                isValidEmail = false;
                if($('#emailper').empty()){
                    $('#btnAddRowPerson').attr('disabled','disabled');
                    $('#emailper').append('<div class="form-group">\
                                        <label class="col-md-2 control-label text-left"></label>\
                                            <div class="col-md-10" style="color: red">Email not valid</div>\
                                    </div>');
                }
            }else{
                $('#emailper').empty();
                isValidEmail = true;
                if(isValidEmail == true && isValidPhone == true){
                    $('#btnAddRowPerson').removeAttr('disabled');
                }
            }
        });
        $('#email_person').blur(function(){
            if($('#email_person').val() == ""){
                $('#emailper').empty();
                isValidEmail = true;
                if(isValidEmail == true && isValidPhone == true){
                    $('#btnAddRowPerson').removeAttr('disabled');
                }
            }
        });
        var regex_ph = new RegExp('^[0-9]*$');
        $('#phone').on('paste copy cut keyup keydown',function(){
            var emil=$('#phone').val();

            if(!regex_ph.test(emil)){
                if($('#telephoneper').empty()){
                    isValidPhone = false;
                    $('#btnAddRowPerson').attr('disabled','disabled');
                    $('#telephoneper').append('<div class="form-group">\
                                        <label class="col-md-2 control-label text-left"></label>\
                                            <div class="col-md-10" style="color: red">Telephone not valid</div>\
                                    </div>');
                }
            }else{
                $('#telephoneper').empty();
                isValidPhone = true;
                if(isValidEmail == true && isValidPhone == true){
                    $('#btnAddRowPerson').removeAttr('disabled');
                }
            }
        });
    });
</script>