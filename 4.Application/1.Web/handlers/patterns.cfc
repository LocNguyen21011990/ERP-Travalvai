component output="false" displayname=""  {
	property name='groupOfProductService' 	inject="entityService:group_of_products";
	property name='factoryService' 			inject="entityService:factory";
	property name='languagesService' 		inject="entityService:Languages";
	property name='patternsService'     	inject='patternsService';
	property name='patternsPartService'     inject='pattern_partService';
	property name='patternDesService' 		inject="entityService:pattern_description";
	property name='patternVariDesService' 	inject="entityService:pattern_var_des";
	property name='patternNoteService' 		inject="entityService:pattern_notes";
	property name='patternVariService' 		inject="pattern_variantionsService";
	property name='userService' 			inject='userService';

	public function init(){
		return this;
	}
	public function getPatternList(event, rc, prc){
		var userLevel = userService.getUserLevel();
		if(userLevel != 4){
			var factory = factoryService.get(id=userService.getFactoryID());
			var patterns = [];
			var patternsList = EntityLoad('patterns',{factory=factory},"id_pattern desc");
			for(item in patternsList) {
			   var sPattern        = {};
			   var aPnotes = patternsService.getFullNotes(item.getid_pattern());
			   sPattern.idPattern  = item.getid_pattern();
			   sPattern.code       = item.getpt_code();
			   sPattern.createDate = dateformat(item.getpt_date(), "dd-mm-yyyy");
			   sPattern.updateDate = dateformat(item.getpt_update(), "dd-mm-yyyy");
			   sPattern.notes      = item.getpt_notes();
			   sPattern.sketch     = "<img src=#getImage("/includes/img/ao/#item.getpt_Sketch()#",300,168,'scaleToFit')#/>";
			   sPattern.groupProductName 	= patternsService.getGroupProduct(item.getid_pattern()).gp_code;
			   sPattern.groupProductID 		= patternsService.getGroupProduct(item.getid_pattern()).id_group_products;
			   sPattern.description 		= patternsService.getPatternDesByLangCurrent(item.getid_pattern());
			   sPattern.notes 				= arrayLen(aPnotes)?aPnotes[1].notes:"";
			   ArrayAppend(patterns,sPattern);
			}
			event.renderData(type="json",data=patterns);
		}else{
			event.renderData(type="json",data={});
		}
	}

	public function getPatternID(event, rc, prc) {
		if(structKeyExists(URL, "id")){
			var userLevel = userService.getUserLevel();
			if(userLevel != 4){
				var pattern = EntityLoadByPK('patterns', URL.id);
				var full_lang = EntityLoad('pattern_description', {pattern = pattern});
				var gProductListDes = {};
				var languages = entityload("languages");
				for(lang in languages){
					gProductListDes[lang.getId_language()] = lang;
				}
				var ldes = gProductListDes;
			   	for(page in full_lang){
					ldes[page.getLanguage().getId_language()]["description"] = page.getpd_description();
				}
				var full_language = SerializeJson(ldes);
				event.renderData(type="json",data={
												 'code':pattern.getpt_code()
												,'id':pattern.getid_pattern()
												,'groupID':pattern.getgroup_of_product().getid_group_products()
												,'craeateDate':DateFormat(pattern.getpt_date(),'dd/mm/yyyy')
												,'updateDate':DateFormat(pattern.getpt_update(),'dd/mm/yyyy')
												// ,'patternnode':pattern.getpt_notes()
												,'full_language':full_language
												,'sketch'	: "#getImage("/includes/img/ao/#pattern.getpt_Sketch()#",600,300,'scaleToFit')#"
												,'parts'	: "#getImage("/includes/img/ao/#pattern.getpt_parts()#",600,300,'scaleToFit')#"
											});
			}else{
				event.renderData(type="json",data={});
			}
		}else{
			event.renderData(type="json",data={});
		}
	}

	public function editPatternPart(event, rc, prc){
		if(structKeyExists(URL, "id")){
			var userLevel = userService.getUserLevel();
			if(userLevel != 4){
				var pattern = EntityLoadByPK('patterns', URL.id);
				var full_lang = EntityLoad('pattern_part', {pattern = pattern, pp_code = rc.ppcode});
				var gProductListDes = {};
				var languages = entityload("languages");
				for(lang in languages){
					gProductListDes[lang.getId_language()] = lang;
				}
				var ldes = gProductListDes;
			   	for(page in full_lang){
					ldes[page.getLanguage().getId_language()]["description"] = page.getpp_description();
				}
				var full_language = SerializeJson(ldes);
				event.renderData(type="json",data={
												'full_language_part':full_language
												,'ppcode': full_lang[1].getpp_code()
												});
			}else{
				event.renderData(type="json",data={});
			}
		}else{
			event.renderData(type="json",data={});
		}
	}

	public function editPatternVari(event, rc, prc){
		if(structKeyExists(URL, "id")){
			var userLevel = userService.getUserLevel();
			if(userLevel != 4){
				var full_lang = patternVariService.getPatternVari(URL.id, rc.pv_code);
				var gProductListDes = {};
				var languages = QueryExecute("select * from languages");
				for(lang in languages){
					gProductListDes[lang.Id_language] = lang;
				}
				var ldes = gProductListDes;
			   	for(page in full_lang){
					ldes[page.Id_language]["description"] = page.pv_description;
				}
				var full_language = SerializeJson(ldes);
				event.renderData(type="json",data={
												'full_language_part':full_language
												,'pvcode': full_lang.pv_code
												,'parts' : full_lang.pv_parts
												,'pv_sketch' : "#getImage("/includes/img/ao/#full_lang.pv_sketch#",600,300,'scaleToFit')#"
												});
			}else{
				event.renderData(type="json",data={});
			}
		}else{
			event.renderData(type="json",data={});
		}
	}

	public function getPatternPart(event, rc, prc) {
		if(structKeyExists(URL, "id")){
			var IdLangDefault = userService.get(SESSION.loggedInUserID).getlanguage().getid_language();
			var userLevel = userService.getUserLevel();
			if(userLevel != 4){
				var pattern = EntityLoadByPK('patterns', URL.id);
				var full_lang = EntityLoad('pattern_part', {pattern = pattern, language = EntityLoadByPK('languages', IdLangDefault)});
				var list = [];
				for(item in full_lang){
					var str = {};
					str["id"] = item.getid_pattern_part();
					str["code"] = item.getpp_code();
					str["des"] = item.getpp_description();
					arrayAppend(list, str);
				}
				event.renderData(type="json",data=list);
			}
			else{
				event.renderData(type="json",data={});
			}
		}else{
			event.renderData(type="json",data={});
		}
	}

	public function getPatternNotes(event, rc, prc){
		if(structKeyExists(URL, "id")){
			var userLevel = userService.getUserLevel();
			if(userLevel != 4){
				var pattern = patternsService.findwhere({id_pattern=URL.id});
				var ptnotes = patternsService.getFullNotes(pattern.getid_pattern());
				for(item in ptnotes){
					item.createDate = item.createDate & '<br>' & item.user;
				}
				event.renderData(type="json",data=ptnotes);
			}else{
				event.renderData(type="json",data={});
			}
		}else{
			event.renderData(type="json",data={});
		}
	}
	public function addNewNote(event, rc, prc){
		var userLevel = userService.getUserLevel();
		if(event.GETHTTPMETHOD() == "POST" and userLevel != 4 and rc.idpattern neq 0){
			var createdDate = DateFormat(now(),'dd/mm/yyyy');
			var user_created = userService.getLoggedInUser().getid_user();
			var pattern = EntityLoadByPK('patterns', rc.idpattern);
			var pnote 	= patternNoteService.new({
					pn_note 	: rc.patternnode
					,pn_date	: createdDate
					,pattern 	: pattern
					,user_created : user_created
			});
			var result = patternNoteService.save(pnote);
			if(result)
				event.renderData(type="json",data={ 'success' : true , 'message' : 'Add new pattern notes successfully!' });
			else
				event.renderData(type="json",data={ 'success' : false , 'message' : 'Add new pattern notes failed !' });
		}else{
			event.renderData(type="json",data={ 'success' : false , 'message' : 'Access denied !' });
		}
	}

	public function addNewPattern(event, rc, prc) {
		var userLevel = userService.getUserLevel();
		if(event.GETHTTPMETHOD() == "POST" and userLevel != 4){
			if(rc.id_pattern == 0){
				var user_created = userService.getLoggedInUser().getid_user();
				var factory = factoryService.get(id=userService.getFactoryID());
				var createdDate = DateFormat(now(),'dd/mm/yyyy');
				var newPattern 	= patternsService.new({
						pt_code				:UCase(rc.code)
						,group_of_product 	:groupOfProductService.get(rc.groupProduct)
						,pt_date 			:createdDate
						,pt_update 			:createdDate
						,user_created 		:user_created
						,user_updated 		:user_created
						,factory 			: factory
					});
				if(structKeyExists(rc,'sketch')){
					if(rc.sketch neq ''){
						var fileName = GenerateRandomString();
						var fileExtension = (rc.sketchName.split("/"));
						switch(fileExtension[2]){
				            case 'jpeg' :
				                var imageType	= 'jpg';
				            default:
				                var imageType	= fileExtension[2];
				            break;
				        }
						var fc1 = fileupload("#expandpath('/includes/img/ao/#GenerateRandomString()#.#imageType#')#", "#sketch#" ,"","makeunique");
						newPattern.setpt_Sketch(fc1.serverfile);
					}
				}
				if(structKeyExists(rc,'parts')){
					if(rc.parts neq ''){
						var fileName = GenerateRandomString();
						var fileExtension = (rc.partsName.split("/"));
						switch(fileExtension[2]){
				            case 'jpeg' :
				                var imageType	= 'jpg';
				            default:
				                var imageType	= fileExtension[2];
				            break;
				        }
						var fc2 = fileupload("#expandpath('/includes/img/ao/#GenerateRandomString()#.#imageType#')#", "#parts#" ,"","makeunique");
						newPattern.setpt_Parts(fc2.serverfile);
					}
				}
				var result = patternsService.save(newPattern);
				var dataDes = deserializeJSON(rc.des);
				for(item in dataDes){
					var pDescription = "";
					if(structKeyExists(item, "description")){
						pDescription = item.description;
					}
					var language = languagesService.get( item.id_language);
					var pdes = patternDesService.new({
							   pd_description  	: pDescription
							 , created         	: createdDate
							 , updated         	: createdDate
							 , user_created    	: user_created
							 , user_updated    	: user_created
							 , pattern 			: newPattern
							 , language        	: language
						});
					patternDesService.save(pdes);
				}
				var pnote 	= patternNoteService.new({
							pn_note 	: rc.patternnode
							,pn_date	: createdDate
							,pattern 	: newPattern
							,user_created : user_created
					});
				patternNoteService.save(pnote);
				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Add new pattern successfully' , 'typeId' : newPattern.getid_pattern(), 'typecode' : newPattern.getpt_code()});
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Add new pattern failed !' });
			}else{
				//edit pattern
				var updateDate = DateFormat(now(),'dd/mm/yyyy');
				var factory = factoryService.get(userService.getFactoryID());
				var pattern = patternsService.get(rc.id_pattern);
				pattern.setpt_code(UCase(rc.code));
				pattern.setgroup_of_product(groupOfProductService.get(rc.groupProduct));
				pattern.setpt_update(updateDate);
				pattern.setuser_updated(userService.get(SESSION.loggedInUserID));
				pattern.setfactory(factory);
				if(structKeyExists(rc,'sketch')){
					if(rc.sketch neq ''){
						var oldImagesSketch = expandpath('/includes/img/ao/')&pattern.getpt_sketch();
						if(FileExists(oldImagesSketch)){
							FileDelete(oldImagesSketch);
						}
						var fileExtension1 = (rc.sketchName.split("/"));
						switch(fileExtension1[2]){
				            case 'jpeg' :
				                var imageType	= 'jpg';
				            default:
				                var imageType	= fileExtension1[2];
				            break;
				        }
						var fc1 = fileupload("#expandpath('/includes/img/ao/#GenerateRandomString()#.#imageType#')#", "#sketch#" ,"","makeunique");
						pattern.setpt_Sketch(fc1.serverfile);
					}
				}
				if(structKeyExists(rc,'parts')){
					if(rc.parts neq ''){
						var oldImagesParts = expandpath('/includes/img/ao/')&pattern.getpt_sketch();
						if(fileExists(oldImagesParts)){
							FileDelete(oldImagesParts);
						}
						var fileExtension = (rc.partsName.split("/"));
						switch(fileExtension[2]){
				            case 'jpeg' :
				                var imageType	= 'jpg';
				            default:
				                var imageType	= fileExtension[2];
				            break;
				        }
						var fc2 = fileupload("#expandpath('/includes/img/ao/#GenerateRandomString()#.#imageType#')#", "#parts#" ,"","makeunique");
						pattern.setpt_Parts(fc2.serverfile);
					}
				}
				var result = patternsService.save(pattern);
				var dataDes = deserializeJSON(rc.des);
				for(item in dataDes){
					var pDescription = "";
					var language = languagesService.get(dataDes[item].id_language);
					if(structKeyExists(dataDes[item], "description")){
						pDescription = dataDes[item].description;
					}
					var pdes = !isNull(patternDesService.findwhere({pattern=pattern, language=language}))?patternDesService.findwhere({pattern=pattern, language=language}):patternDesService.new();
					pdes.setpd_description(pDescription);
					pdes.setupdated(updateDate);
					pdes.setuser_updated(userService.get(SESSION.loggedInUserID));
					pdes.setpattern(pattern);
					patternDesService.save(pdes);
				}
				if(rc.patternnode neq ""){
					var pnote 	= patternNoteService.new({
						pn_note 	: rc.patternnode
						,pn_date	: updateDate
						,pattern 	: pattern
						,user_created : userService.get(SESSION.loggedInUserID)
					});
					patternNoteService.save(pnote);
				}

				if(result)
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Edit pattern successfully' , 'typeId' : pattern.getid_pattern(), 'typecode' : pattern.getpt_code()});
				else
					event.renderData(type="json",data={ 'success' : false , 'message' : 'Edit pattern failed !' });
			}
		}else{
			event.renderData(type="json",data={ 'success' : false , 'message' : 'Access denied !' });
		}
	}

	public function addNewPatternPart(event, rc, prc){
		if(structKeyExists(URL, "id")){
			var userLevel = userService.getUserLevel();
			if(event.GETHTTPMETHOD() == "POST" and userLevel != 4){
				if(rc.pp_code == ""){
					var updateDate = DateFormat(now(),'dd/mm/yyyy');
					var pattern = patternsService.findwhere({id_pattern=URL.id});
					var dataDes = deserializeJSON(rc.des);
					//set pattern_part
					for(item in dataDes){
						var pDescription = "";
						if(structKeyExists(item, "description")){
							pDescription = item.description;
						}
						var language = languagesService.get( item.id_language);
						var pdes = patternsPartService.new({
								   pp_code 			: UCase(rc.partcode)
								 , pp_description  	: pDescription
								 , pattern 			: pattern
								 , language        	: language
							});
						patternsPartService.save(pdes);
					}
					//update pattern table
					pattern.setpt_update(updateDate);
					pattern.setuser_updated(userService.get(SESSION.loggedInUserID));
					patternsService.save(pattern);

					event.renderData(type="json",data={ 'success' : true , 'message' : 'Add new pattern part successfully!' });
				}else{
					var updateDate = DateFormat(now(),'dd/mm/yyyy');
					var pattern = patternsService.findwhere({id_pattern=URL.id});
					var patternPart = patternsPartService.findAllWhere({pattern=pattern, pp_code=rc.pp_code});
					var dataDes = deserializeJSON(rc.des);
					for(item in dataDes){
						var pDescription = "";
						var language = languagesService.get(dataDes[item].id_language);
						if(structKeyExists(dataDes[item], "description")){
							pDescription = dataDes[item].description;
						}
						var pdes = !isNull(patternsPartService.findAllWhere({pattern=pattern, language=language, pp_code=rc.pp_code}))?patternsPartService.findAllWhere({pattern=pattern, language=language, pp_code=rc.pp_code}):patternsPartService.new();
						pdes[1].setPp_description(pDescription);
						patternsPartService.save(pdes[1]);
					}
					//update pattern table
					pattern.setpt_update(updateDate);
					pattern.setuser_updated(userService.get(SESSION.loggedInUserID));
					patternsService.save(pattern);
					event.renderData(type="json",data={ 'success' : true , 'message' : 'Edit pattern part successfully!' });
				}
			}else{
				event.renderData(type="json",data={});
			}
		}else{
			event.renderData(type="json",data={});
		}
	}

	public function getPatternVari(event, rc, prc) {
		if(structKeyExists(URL, "id")){
			var userLevel = userService.getUserLevel();
			if(userLevel != 4){
				var patternVari = patternsService.getPatternVari(URL.id);
				var list = [];
				for(item in patternVari){
					var str = {};
					str["id"] 	= item.id_pattern_var;
					str["code"] = item.pv_code;
					str["des"] 	= item.pv_description;
					str["parts"]  = item.pv_parts;
					str["sketch"] = "<img src=#getImage("/includes/img/ao/#item.pv_sketch#",130,170,'scaletofit')#/>";
					arrayAppend(list, str);
				}
				event.renderData(type="json",data=list);
			}
			else{
				event.renderData(type="json",data={});
			}
		}else{
			event.renderData(type="json",data={});
		}
	}

	public function delPatternPart(event, rc, prc){
		var userLevel = userService.getUserLevel();
		if(event.GETHTTPMETHOD() == "POST" and userLevel != 4)
		{
			patternsPartService.delPatternPart(rc.id_pattern, rc.pp_code);
			event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete Pattern Part successfully' });
		}
	}
	public function deletePatternVari(event, rc, prc){
		var userLevel = userService.getUserLevel();

		if(event.GETHTTPMETHOD() == "POST" and userLevel != 4)
		{
			var fullImage = patternVariService.getFullImage(rc.id_pattern, rc.pv_code);
			for(item in fullImage){
				var oldImagesSketch = expandpath('/includes/img/ao/')&item.pv_sketch;
				if(FileExists(oldImagesSketch)){
					FileDelete(oldImagesSketch);
				}
			}
			try {
				patternVariService.delPatternVari(rc.id_pattern, rc.pv_code);
				event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete Pattern Vari successfully' });
			}
			catch(any e) {
				event.renderData(type="json",data={ 'success' : false , 'message' : 'This pattern vari is using for product. If you want to delete this patter vari, please delete product first!' });
			}

		}
	}

	public function addNewPatternVari(event, rc, prc){
		if(structKeyExists(URL, "id")){
			var userLevel = userService.getUserLevel();
			if(event.GETHTTPMETHOD() == "POST" and userLevel != 4){
				if(rc.pv_code_temp == ""){
					var updateDate = DateFormat(now(),'dd/mm/yyyy');
					var pattern = patternsService.findwhere({id_pattern=URL.id});
					var dataDes = deserializeJSON(rc.des);
					//set pattern_vari
					var patternVari = patternVariService.new({
								   pv_code 			: UCase(rc.varicode)
								 , pv_parts 		: UCase(rc.varipart)
								 , pattern			: pattern
								});
					if(structKeyExists(rc,'varisketch')){
						if(rc.varisketch neq ''){
							var fileName = GenerateRandomString();
							var fileExtension = (rc.variSketchName.split("/"));
							switch(fileExtension[2]){
					            case 'jpeg' :
					                var imageType	= 'jpg';
					            default:
					                var imageType	= fileExtension[2];
					            break;
					        }
							var fc2 = fileupload("#expandpath('/includes/img/ao/#GenerateRandomString()#.#imageType#')#", "#varisketch#" ,"","makeunique");
							patternVari.setpv_sketch(fc2.serverfile);
						}
					}
					var result = patternVariService.save(patternVari);
					//set pattern_var_des
					for(item in dataDes){
						var pDescription = "";
						if(structKeyExists(item, "description")){
							pDescription = item.description;
						}
						var language = languagesService.get( item.id_language);
						var pvdes = patternVariDesService.new({
								pv_description 		: pDescription
								,pattern_variantion : patternVari
								,language 			: language
							});
						patternVariDesService.save(pvdes);
					}
					//update pattern table
					pattern.setpt_update(updateDate);
					pattern.setuser_updated(userService.get(SESSION.loggedInUserID));
					patternsService.save(pattern);
					if(result){
						event.renderData(type="json",data={ 'success' : true , 'message' : 'Add new pattern vari successfully!' });
					}else{
						event.renderData(type="json",data={ 'success' : false , 'message' : 'Add new pattern vari failed !' });
					}
				}else{
					var updateDate = DateFormat(now(),'dd/mm/yyyy');
					var pattern = patternsService.findwhere({id_pattern=URL.id});
					var patternVari = patternVariService.findAllWhere({pattern=pattern, pv_code=rc.pv_code_temp});

					var pdes = !isNull(patternVariService.findAllWhere({pattern=pattern, pv_code=rc.pv_code_temp}))?patternVariService.findAllWhere({pattern=pattern, pv_code=rc.pv_code_temp}):patternVariService.new();
					if(structKeyExists(rc, "varipart")){
						pdes[1].setpv_parts(UCase(rc.varipart));
					}

					if(structKeyExists(rc,'varisketch')){
						if(rc.varisketch neq ''){
							var fileName = GenerateRandomString();
							var oldImagesSketch = expandpath('/includes/img/ao/')&patternVari[1].getpv_sketch();
							if(fileExists(oldImagesSketch)){
								FileDelete(oldImagesSketch);
							}
							var fileExtension = (rc.variSketchName.split("/"));
							switch(fileExtension[2]){
					            case 'jpeg' :
					                var imageType	= 'jpg';
					            default:
					                var imageType	= fileExtension[2];
					            break;
					        }
							var fc2 = fileupload("#expandpath('/includes/img/ao/#GenerateRandomString()#.#imageType#')#", "#varisketch#" ,"","makeunique");
							pdes[1].setpv_sketch(fc2.serverfile);
						}
					}

					var result = patternVariService.save(pdes[1]);

					var dataDes = deserializeJSON(rc.des);
					for(item in dataDes){
						var pDescription = "";
						var language = languagesService.get(dataDes[item].id_language);
						if(structKeyExists(dataDes[item], "description")){
							pDescription = dataDes[item].description;
						}
						var pdes = !isNull(patternVariDesService.findwhere({pattern_variantion=patternVari[1], language=language}))?patternVariDesService.findwhere({pattern_variantion=patternVari[1], language=language}):patternVariDesService.new();
						pdes.setpv_description(pDescription);
						patternVariDesService.save(pdes);

					}
					//update pattern table
					pattern.setpt_update(updateDate);
					pattern.setuser_updated(userService.get(SESSION.loggedInUserID));
					patternsService.save(pattern);
					if(result){
						event.renderData(type="json",data={ 'success' : true , 'message' : 'Edit pattern vari successfully!' });
					}else{
						event.renderData(type="json",data={ 'success' : false , 'message' : 'Edit pattern vari failed !' });
					}

				}
			}else{
				event.renderData(type="json",data={});
			}
		}else{
			event.renderData(type="json",data={});
		}
	}

	function getlanguage(event,prc,rc)
	{
		var listLang = QueryExecute("select * from languages")
		event.renderData(type="json",data=queryToArray(listLang));
	}
	private function queryToArray(required query inQuery) {
        result = arrayNew(1);
        for(row in inQuery) {
            item = {};
            for(col in queryColumnArray(inQuery)) {
                item[col] = row[col];
            }
            arrayAppend(result, item);
        }
        return result;
   	}

   	function getGroupOfProduct(event,prc,rc)
	{
		event.renderData(type="json",data=queryToArray(patternsService.getFullGP()));
	}

	function deletePattern(event,rc,prc)
	{
		var userLevel = userService.getUserLevel();
		if(event.GETHTTPMETHOD() == "POST" and userLevel != 4)
		{
			var getCurr = patternsService.get(rc.id_pattern);
			patternsService.deleteFKPattern(rc.id_pattern);
			var oldImagesSketch = expandpath('/includes/img/ao/')&getCurr.getpt_sketch();
			if(FileExists(oldImagesSketch)){
				FileDelete(oldImagesSketch);
			}
			var oldImagesParts = expandpath('/includes/img/ao/')&getCurr.getpt_parts();
			if(FileExists(oldImagesParts)){
				FileDelete(oldImagesParts);
			}
			patternsService.delete(getCurr,true);
			event.renderData(type="json",data={ 'success' : true , 'message' : 'Delete Pattern successfully' });
		}
	}

	function checkExistCode(event,rc,prc){
		if(event.GETHTTPMETHOD() == "POST")
		{
			if(rc.id==0){
				var factory = factoryService.get(id=userService.getFactoryID());
				var result = entityload("patterns",{pt_code=UCase(rc.code),factory=factory},true);
				event.renderData(type="json",data={ 'success' : !isNull(result),"pCode": rc.code });
			}else{
				var factory = factoryService.get(id=userService.getFactoryID());
				var listItem = entityload("patterns",{pt_code=UCase(rc.code),factory=factory});
				for(item in listItem){
					if(item.getId_pattern() != rc.id)
					{
						return event.renderData(type="json",data={ 'success' : true,"pCode": rc.code });
					}
				}
				event.renderData(type="json",data={ 'success' : false,"pCode": rc.code });
			}
		}
	}
	function checkExistPartCode(event,rc,prc){
		if(event.GETHTTPMETHOD() == "POST"){
			if(rc.id_pattern neq 0 and rc.pp_code eq ""){
				var pattern = patternsService.get(rc.id_pattern);
				var listItem = entityload("pattern_part",{pp_code=UCase(rc.part_code),pattern=pattern});
				if(arrayLen(listItem) gt 0)
				{
					return event.renderData(type="json",data={ 'exist' : true});
				}else{
					event.renderData(type="json",data={ 'exist' : false});
				}
			}else{
				event.renderData(type="json",data={ 'exist' : false});
			}
		}
	}
	function checkExistVariCode(event,rc,prc){
		if(event.GETHTTPMETHOD() == "POST"){
			if(rc.id_pattern neq 0 and rc.pv_code_temp eq ""){
				var pattern = patternsService.get(rc.id_pattern);
				var listItem = entityload("pattern_variantions",{pv_code=UCase(rc.pv_code),pattern=pattern});
				if(arrayLen(listItem) gt 0)
				{
					return event.renderData(type="json",data={ 'exist' : true});
				}else{
					event.renderData(type="json",data={ 'exist' : false});
				}
			}else{
				event.renderData(type="json",data={ 'exist' : false});
			}
		}
	}

	public string function GenerateRandomString(){
		var chars="0123456789abcdefghiklmnopqrstuvwxyz";
		var strLength = 30;
		var randout="";
		for( var i=1; i<=strLength; i=i+1){
			var rnum=ceiling(rand() * len(chars));
			if(rnum eq 0){
				rnum="1";
			}
			randout=randout & mid(chars, rnum, 1);
		}
		return  randout
	}


}