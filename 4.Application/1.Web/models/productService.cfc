component extends="cborm.models.VirtualEntityService" singleton{
	property name='userService' 			inject='userService';
	/**
	* Constructor
	*/
	function init(){

		// init super class
		super.init( entityName="product" );

		// Use Query Caching
	    setUseQueryCaching( false );
	    // Query Cache Region
	    setQueryCacheRegion( "ormservice.product" );
	    // EventHandling
	    setEventHandling( true );

	    return this;
	}
	public function CostCodeCondition(){
		var result = "CUS%";
		return result;
	}
	public function getplz_id(numeric agentID){
		var result ="";
		var usertype = userService.getUserLevel();
		if (usertype != 4){
			var qPlz = QueryExecute("
				select *
				from price_list_zone
				where id_plz in(
					select id_plz
					from agent_price
					where id_agent = #agentID# and date(now()) between apl_date_i and apl_date_f
					group by id_plz)
				");
			result = qPlz;
		}
		return result;
	}

	public function getProject(numeric id_zone, numeric id_agent){
		var result = [];
		var check = QueryExecute("
			select *
			from project
			where project.id_customer in
				(	select id_customer
					from customer
					where id_agent = #id_agent# and id_zone = #id_zone#
					group by id_customer
				)
			");
		if(check.recordCount){
			result = queryToArray(check);
		}
		return result;
	}

	public function getcode_cost(plzid){
		var usertype = userService.getUserLevel();
		var result   = "";
		if(usertype != 4){
			var aCosting = [];
			var aPlzd 	 = [];
			var q_plfd = QueryExecute("
				select id_cost, id_cost_version
				from price_list_factory_detail
				where id_plf_det in
					(select id_plf_det
					from price_list_zone_details
					where id_plz = #plzid#)
			");
			if(q_plfd.recordCount){
				for(item2 in q_plfd){
					var t = structNew();
					t.id_cost = item2.id_cost;
					t.id_cost_version = item2.id_cost_version;
					arrayAppend(aPlzd, t);
					if( arrayFind(aCosting,t.id_cost) == 0){
						arrayAppend(aCosting,t.id_cost);
					}
				}
			}
			var lCostID = arrayLen(aCosting)? ArrayToList(aCosting, ",") : 0;
			result = QueryExecute("
				select *
				from costing
				where id_cost in (#lCostID#) and cost_code not like '#CostCodeCondition()#'
			");
		}
		return result;
	}

	public function getproducttype(numeric idcost){
		var idTypePr = QueryExecute("
				select costing.id_type_products
				from costing
				where id_cost = #idcost#
		");
		var result = QueryExecute("
			select *
			from type_of_products
			where id_type_products = #idTypePr.id_type_products#
		");
		return result;
	}

	public function getContract(numeric idcustomer){
		var result = QueryExecute("
			select id_contract, DATE_FORMAT(c_date_i,'%d-%m-%Y') as c_date_i, c_no_of_years, c_increase_year, id_Customer, id_agent, id_zone
			from contract
			where id_customer = #idcustomer#
			");
		return queryToArray(result);
	}

	public function getPrdTypeByDes(numeric id_type_products){
		var IdLangDefault = userService.get(SESSION.loggedInUserID).getlanguage().getid_language();
		var result = QueryExecute("
			select *
			from type_product_language tpl
				inner join type_of_products tpd
					on tpd.id_type_products = tpl.id_type
			where id_language = #IdLangDefault# and id_type = #id_type_products#
			");
		return result;
	}


	public function getcost_version(numeric id_cost){
		var IdLangDefault = userService.get(SESSION.loggedInUserID).getlanguage().getid_language();
		var checkDesExist = QueryExecute("
			select *
			From costing_version_description
			where id_cost_version in(
				select ct.id_cost_version
				from costing_versions ct
				where ct.id_cost = #id_cost#
				order by ct.id_cost_version )
			");
		if(!checkDesExist.recordCount){
			var result = QueryExecute("
			select ct.id_cost_version, ct.cv_version cvd_description
			from costing_versions ct
			where ct.id_cost = #id_cost#
			order by ct.id_cost_version
			");
		}else{
			var result = QueryExecute("
			select ct.id_cost_version, ct.cv_version, cvd.cvd_description
			from costing_versions ct
				inner join costing_version_description cvd
					on cvd.id_cost_version = ct.id_cost_version
			where ct.id_cost = #id_cost# and cvd.id_language = #IdLangDefault#
			order by ct.id_cost_version
			");
			if(!result.recordCount){
				result = QueryExecute("
				select ct.id_cost_version, ct.cv_version, cvd.cvd_description
				from costing_versions ct
					inner join costing_version_description cvd
						on cvd.id_cost_version = ct.id_cost_version
				where ct.id_cost = #id_cost# and cvd.id_language = 1
				order by ct.id_cost_version
				");
			}
		}
		return result;
	}


	public any function getProduct(numeric id) {
		var userLevel = userService.getUserLevel();
		var plzid = "";
		var cvList=[];
		var pattern_vars=[];
		var product = EntityLoadByPK("product",LSParseNumber(id));
		var project = isNull(product)?JavaCast("null", ""):product.getProject();
		var customer = isNull(project)?JavaCast("null", ""):project.getCustomer();
		var agent = isNull(customer)?JavaCast("null", ""):customer.getAgent();
		var zone = isNull(agent)?JavaCast("null", ""):agent.getZone();
		var plzd = isNull(product)?JavaCast("null", ""):product.getPrice_list_zone_detail();
		//get project
		var aProject = getProject(zone.getid_zone(), agent.getid_agent());
		var lstPj 	 = [];
		var lstPlz_dets = [];
		var aContract   = [];
		var id_contract = isNull(product.getcontract())?0:product.getcontract().getid_contract();
		var contract 	= getContract(customer.getid_customer());
		if(arrayLen(contract) gt 0){
			aContract = contract;
		}
		if(!isnull(aProject)) {
			for(item in aProject) {
				var str = {};
				var des = item.pj_description;
				var pj_description = len(des) gt 25 ? left(des,25)&'...' : des;
				str["id_Project"] = item.id_Project;
				str["pj_description"] = pj_description;
				arrayAppend(lstPj, str);
			}
		}
		//get price list
		var qPlz = getplz_id(agent.getid_agent());
		if(!isNull(qPlz)) {
			for(item in qPlz) {
				var str = {};
				str["id_plz"] = item.id_plz;
				str["des"] = item.plz_code&"_"&item.plz_description;
				arrayAppend(lstPlz_dets, str);
			}
		}
		//-----
		if(userLevel != 4){
			var fty_sell_4 		 = isNull(plzd)?"":plzd.getPlzd_Fty_Sell_4();
			var plzd_zone_sell_6 = isNull(plzd)?"":plzd.getPlzd_zone_sell_6();
			var plzd_pvpr_8 	 = isNull(plzd)?"":plzd.getPlzd_pvpr_8();
			var plz = QueryExecute("select id_plz
						from price_list_zone
						where id_plz in (
							select id_plz from price_list_zone_details where id_plz_det = #product.getPrice_list_zone_detail().getid_plz_det()#)");
			plzid = plz.id_plz;
		}
		if(not isNull(product.getCosting())){
			var cvs = getcost_version(product.getCosting().getId_Cost());
			if(cvs.recordCount) {
				for(item in cvs) {
					var newcv = {};
					newcv["id_cost_version"] = item.id_cost_version;
					newcv["cv_version"] = item.cvd_description;
					arrayAppend(cvList, newcv);
				}
			}
		}

		if(not isNull(product.getPattern())){
			var pvs = entityload("pattern_variantions",{pattern=product.getPattern()});
			for(pv in pvs){
				var newpv = {
					"id_pattern_var" = pv.getid_pattern_var(),
					"pv_code"	  = pv.getpv_code()
				};
				arrayAppend(pattern_vars,newpv);
			}
		}
		prd = {
			"id_product"       = product.getId_product(),
			"pr_version"       = val(product.getPr_version()),
			"pr_description"   = product.getPr_description(),
			"pr_section"       = product.getPr_section(),
			"pr_fty_sell_9"    = isNull(product.getPr_fty_sell_9())? 0 :val(product.getPr_fty_sell_9()),
			"pr_zone_sell_10"  = isNull(product.getPr_zone_sell_10())? 0 :val(product.getPr_zone_sell_10()),
			"pr_pvpr_11"       = isNull(product.getPr_PVPR_11()) ? 0 : val(product.getPr_PVPR_11()),
			"pr_club_12"       = isNull(product.getPr_Club_12())?0:val(product.getPr_Club_12()),
			"pr_web_13"        = isNull(product.getPr_Web_13())?0:val(product.getPr_Web_13()),
			"pr_date"          = dateformat(product.getPr_date(), "mm/dd/yyyy"),
			"pr_date_update"   = !isNull(product.getPr_date_update())?dateformat(product.getPr_date_update(), "mm/dd/yyyy"):dateformat(now(), "mm/dd/yyyy"),
			"pr_web"           = val(product.getPr_web()),
			// "pr_9_valid"       = product.getPr_9_valid(),
			// "pr_10_valid"      = product.getPr_10_valid(),
			// "pr_11_valid"      = product.getPr_11_valid(),
			"pr_sketch"        = product.getPr_sketch(),
			"pr_picture"       = product.getPr_picture(),
			"pr_stock"         = product.getPr_stock(),
			"plzd_zone_sell_6" = val(numberformat(plzd_zone_sell_6,"9.99")),
			"fty_sell_4"       = val(numberFormat(fty_sell_4,"9.99")),
			"plzd_pvpr_8"      = val(numberFormat(plzd_pvpr_8,"9.99")),
			"z_description"    = isNull(zone)?"":zone.getZ_description(),
			"ag_description"   = isNull(agent)?"":agent.getAg_description(),
			"cs_name"          = isNull(customer)?"":customer.getCs_name(),
			"factory"          = isNull(product.getFactory())?"":product.getFactory().getId_Factory(),
			"aProject"         = lstPj,
			"aPriceList"       = lstPlz_dets,
			"project"          = isNull(product.getProject())?"":product.getProject().getId_Project(),
			"pattern_var"      = isNull(product.getPattern_variantion())?"":product.getPattern_variantion().getId_pattern_var(),
			"pv_variation"	   = isNull(product.getPattern_variantion())?"":product.getPattern_variantion().getPv_code(),
			"sz"         	   = isNull(product.getSize())?"":product.getSize().getId_size(),
			"size_des"         = isNull(product.getSize())?"":product.getSize().getSz_description(),
			"product_status"   = isNull(product.getProduct_status())?"":product.getProduct_status().getId_pr_status(),
			"cost"             = isNull(product.getCosting())?"":product.getCosting().getId_Cost(),
			"cost_version"     = isNull(product.getCosting_versions())?"":product.getCosting_versions().getId_cost_version(),
			"pattern"          = isNull(product.getPattern())?"":product.getPattern().getId_Pattern(),
			"cvList" 		   = cvList,
			"pattern_vars"	   = pattern_vars,
			"id_plz"		   = plzid,
			"contract"		   = aContract,
			"id_contract"	   	   = id_contract,
			"plFactoryCus"	   = 0,
			"plZoneCus"   	   = 0,
			"plFinalCus"	   = 0,
		};
		return prd;
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

}