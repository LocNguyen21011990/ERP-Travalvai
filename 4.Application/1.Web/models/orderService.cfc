/**
* A ColdBox Enabled virtual entity service
*/
component extends="cborm.models.VirtualEntityService" singleton{
	property name='userService' 			inject='userService';
	property name='numberService' 			inject='numberHelper';
	/**
	* Constructor
	*/
	function init(){
	    // init super class
		super.init( entityName="orders" );

		// Use Query Caching
	    setUseQueryCaching( false );
	    // Query Cache Region
	    setQueryCacheRegion( "ormservice.orders" );
	    // EventHandling
	    setEventHandling( true );
	    return this;
	}

	function getOrders() {
		var orders = entityLoad("orders");
		var arrOrders = [];
		var userLevel = userService.getUserLevel();
		for(ord in orders) {
			var zoneId = isnull(ord.getcustomer()) ? "" : isnull(ord.getcustomer().getzone()) ? "" : ord.getcustomer().getzone().getid_zone();
			var agentId = isnull(ord.getcustomer()) ? "" : isnull(ord.getcustomer().getagent()) ? "" : ord.getcustomer().getagent().getid_agent();
			if(userLevel == 1) {
				arrOrders = createListOrders(arrOrders, ord, userLevel);
			}
			else if(userLevel == 2) {
				if(zoneId == ord.getcustomer().getzone().getid_zone()) {
					arrOrders = createListOrders(arrOrders, ord, userLevel);
				}
			}
			else if(userLevel == 3) {
				if(zoneId == ord.getcustomer().getzone().getid_zone() && agentId == ord.getcustomer().getagent().getid_agent()) {
					arrOrders = createListOrders(arrOrders, ord, userLevel);
				}
			}
		}
		return arrOrders;
	}

	private array function createListOrders(array arrOrd, any ord, string userLevel) {
		var strOrd = {};
		strOrd["userLevel"] = userLevel;
		strOrd["id_order"] = ord.getid_order();
		strOrd["id_customer"] = isnull(ord.getcustomer()) ? "" : ord.getcustomer().getid_customer();
		strOrd["cs_name"] 		= isnull(ord.getcustomer()) ? "" : ord.getcustomer().getcs_name();
		strOrd["ag_description"] = isnull(ord.getcustomer()) ? "" : isnull(ord.getcustomer().getagent()) ? "" : ord.getcustomer().getagent().getag_description();
		strOrd["z_description"] = isnull(ord.getcustomer()) ? "" : isnull(ord.getcustomer().getzone()) ? "" : ord.getcustomer().getzone().getz_description();
		strOrd["ord_description"] = ord.getord_description();
		strOrd["pm_description"] = isnull(ord.getpayment()) ? "" : ord.getpayment().getpay_description();
		strOrd["ot_description"] = isnull(ord.getorder_type()) ? "" : ord.getorder_type().getot_description();
		strOrd["oc_description"] = isnull(ord.getorder_condition()) ? "" : ord.getorder_condition().getoc_description();
		strOrd["os_description"] = isnull(ord.getorder_status()) ? "" : ord.getorder_status().getos_description();
		strOrd["ord_fty_confirm"] = dateFormat(ord.getord_fty_confirm(), "dd/mm/yyyy");
		strOrd["ord_zone_confirm"] = dateFormat(ord.getord_zone_confirm(), "dd/mm/yyyy");
		strOrd["ord_date"] = dateFormat(ord.getord_date(), "dd/mm/yyyy");
		strOrd["ord_fty_del_date"] = dateFormat(ord.getord_fty_del_date(), "dd/mm/yyyy");
		strOrd["ord_zone_del_date"] = dateFormat(ord.getord_zone_del_date(), "dd/mm/yyyy");
		strOrd["ord_ag_del_date"] = dateFormat(ord.getord_ag_del_date(), "dd/mm/yyyy");
		strOrd["ord_units"] = ord.getord_units();
		strOrd["ord_fty_delivered"] = ord.getord_fty_delivered();
		strOrd["ord_zone_delivered"] = ord.getord_zone_delivered();
		strOrd["ord_ag_delivered"] = ord.getord_ag_delivered();
		strOrd["calc_1"] = ord.getord_units() - ord.getord_fty_delivered();
		strOrd["calc_2"] = ord.getord_fty_delivered() - ord.getord_zone_delivered();
		strOrd["calc_3"] = ord.getord_zone_delivered() - ord.getord_ag_delivered();
		strOrd["ord_fty_value"] = ord.getord_fty_value();
		strOrd["ord_zone_value"] = ord.getord_zone_value();
		strOrd["ord_ag_value"] = ord.getord_ag_value();
		strOrd["ord_plf"] = ord.getprice_list_factory().getcurrency().getcurr_code();
		strOrd["ord_plz"] = ord.getprice_list_zone().getcurrency().getcurr_code();
		var calc_4 = ord.getord_ag_value()  *  ord.getord_discount_1() / 100;
		strOrd["ord_discount_1"] = ord.getord_discount_1();
		strOrd["calc_4"] = calc_4;
		strOrd["ord_ag_value_dsc1"] = ord.getord_ag_value() - calc_4;
		strOrd["ord_discount_2"] = ord.getord_discount_2();
		var calc_6 = (ord.getord_ag_value() - calc_4) * ord.getord_discount_2() / 100;
		strOrd["calc_6"] = calc_6;
		strOrd["ord_ag_value_dsc2"] = ord.getord_ag_value() - calc_4 - calc_6;
		arrayAppend(arrOrd, strOrd);
		return arrOrd;
	}

	function getOrderById(string Id) {
		var orders = entityLoad("orders", {id_order: Id});
		var arrOrders = [];
		var userLevel = userService.getUserLevel();
		for(ord in orders) {
			var zoneId = isnull(ord.getcustomer()) ? "" : isnull(ord.getcustomer().getzone()) ? "" : ord.getcustomer().getzone().getid_zone();
			var agentId = isnull(ord.getcustomer()) ? "" : isnull(ord.getcustomer().getagent()) ? "" : ord.getcustomer().getagent().getid_agent();
			if(userLevel == 1) {
				arrOrders = createListOrders(arrOrders, ord, userLevel);
			}
			else if(userLevel == 2) {
				if(zoneId == ord.getcustomer().getzone().getid_zone()) {
					arrOrders = createListOrders(arrOrders, ord, userLevel);
				}
			}
			else if(userLevel == 3) {
				if(zoneId == ord.getcustomer().getzone().getid_zone() && agentId == ord.getcustomer().getagent().getid_agent()) {
					arrOrders = createListOrders(arrOrders, ord, userLevel);
				}
			}
		}
		return arrOrders[1];	
	}

	function getOrderDetails(string orderId) {
		var orderDetails = entityLoad("order_details", {order: entityLoad("orders", {id_order: orderId}, true)});
		var arrDets = [];
		var userLevel = userService.getUserLevel();
		for(det in orderDetails) {
			var str = {};
			str["userLevel"] = userLevel;
			str["id_order_det"] = det.getid_order_det();
			str["garment"] = det.getproduct().getproject().getid_project() & "-" & det.getproduct().getpattern().getid_pattern() & "-" & det.getproduct().getpattern_variantion().getid_pattern_var();
			str["pr_version"] = det.getproduct().getpr_version();
			str["cost_code"] = det.getproduct().getcosting().getcost_code();
			str["cv_version"] = det.getproduct().getcosting_versions().getcv_version();
			str["pr_description"] = det.getproduct().getpr_description();
			str["sz_description"] = det.getproduct().getsize().getsz_description();
			str["ordd_cg_name"] = det.getordd_cg_name();
			str["ordd_name"] = det.getordd_name();
			str["ordd_number"] = det.getordd_number();
			str["ordd_size"] = det.getsize_details().getszd_size();
			str["ordd_qtty"] = det.getordd_qtty();
			str["ordd_del_fty"] = det.getordd_del_fty();
			str["ordd_del_zone"] = det.getordd_del_zone();
			str["ordd_del_ag"] = det.getordd_del_ag();

			str["plfd_fty_sell_3"] = numberService.roundDecimalPlaces(det.getproduct().getprice_list_zone_detail().getprice_list_factory_detail().getplfd_fty_sell_3(),2);
			str["plzd_zone_sell_6"] = numberService.roundDecimalPlaces(det.getproduct().getprice_list_zone_detail().getplzd_Zone_Sell_6(),2);
			str["plzd_pvpr_8"] = numberService.roundDecimalPlaces(det.getproduct().getprice_list_zone_detail().getplzd_PVPR_8(),2);
			str["pr_fty_sell_9"] = numberService.roundDecimalPlaces(det.getproduct().getpr_fty_sell_9(),2);
			str["pr_zone_sell_10"] = numberService.roundDecimalPlaces(det.getproduct().getpr_zone_sell_10(),2);
			str["pr_pvpr_11"] = numberService.roundDecimalPlaces(det.getproduct().getpr_PVPR_11(),2);
			str["ordd_fty_pr"] = numberService.roundDecimalPlaces(det.getordd_fty_pr(),2);
			str["ordd_zone_pr"] = numberService.roundDecimalPlaces(det.getordd_zone_pr(),2);
			str["ordd_ag_pr"] = numberService.roundDecimalPlaces(det.getordd_ag_pr(),2);

			var ord_fty_tot = 0;
			var ord_zone_tot = 0;
			var ord_ag_tot = 0;

			if(str.ordd_fty_pr > 0) {
				ord_fty_tot = str.ordd_fty_pr * str.ordd_qtty;
			}
			else {
				if(str.pr_fty_sell_9 > 0) {
					ord_fty_tot = str.pr_fty_sell_9 * str.ordd_qtty;
				}
				else {
					if(str.plfd_fty_sell_3 > 0) {
						ord_fty_tot = str.plfd_fty_sell_3 * str.ordd_qtty;
					}
				}
			}
			str["ord_fty_tot"] = numberService.roundDecimalPlaces(ord_fty_tot,2);

			if(str.ordd_zone_pr > 0) {
				ord_zone_tot = str.ordd_zone_pr * str.ordd_qtty;
			}
			else {
				if(str.pr_zone_sell_10 > 0) {
					ord_zone_tot = str.pr_zone_sell_10 * str.ordd_qtty;
				}
				else {
					if(str.plzd_zone_sell_6 > 0) {
						ord_zone_tot = str.plzd_zone_sell_6 * str.ordd_qtty;
					}
				}
			}
			str["ord_zone_tot"] =  numberService.roundDecimalPlaces(ord_zone_tot,2);

			if(str.ordd_ag_pr > 0) {
				ord_ag_tot = str.ordd_ag_pr * str.ordd_qtty;
			}
			else {
				if(str.pr_pvpr_11 > 0) {
					ord_ag_tot = str.pr_pvpr_11 * str.ordd_qtty;
				}
				else {
					if(str.plzd_pvpr_8 > 0) {
						ord_ag_tot = str.plzd_pvpr_8 * str.ordd_qtty;
					}
				}
			}
			str["ord_ag_tot"] =  numberService.roundDecimalPlaces(ord_ag_tot,2);
			str["ord_plf"] = det.getorder().getprice_list_factory().getcurrency().getcurr_code(); 
			str["ord_plz"] = det.getorder().getprice_list_zone().getcurrency().getcurr_code(); 
			str["ordd_rcv_zone"] = isnull(det.getordd_rcv_zone()) ? 0 : det.getordd_rcv_zone();
			str["ordd_rcv_ag"] = isnull(det.getordd_rcv_ag()) ? 0 : det.getordd_rcv_ag();
			str["ordd_rcv_cs"] = isnull(det.getordd_rcv_cs()) ? 0 : det.getordd_rcv_cs();
			str["ordd_rcv_pr"] = isnull(det.getordd_rcv_pr()) ? 0 : det.getordd_rcv_pr();
			arrayAppend(arrDets, str);
		}
		return arrDets;
	}

	function getOrderTypes() {
		var arrOrdType = [];
		var ordTypes = entityLoad("order_type");
		for(item in ordTypes) {
			var str = {};
			str["id_order_type"] = item.getid_order_type();
			str["ot_description"] = item.getot_description();
			arrayAppend(arrOrdType, str);
		}
		return arrOrdType;
	}

	function getOrderConditions() {
		var arrOrdCondition = [];
		var ordConditions = entityLoad("order_condition");
		for(item in ordConditions) {
			var str = {};
			str["id_order_condition"] = item.getid_order_condition();
			str["oc_description"] = item.getoc_description();
			arrayAppend(arrOrdCondition, str);
		}
		return arrOrdCondition;
	}

	function getOrderStatus() {
		var arrOrdStatus = [];
		var ordStatus = entityLoad("order_status");
		for(item in ordStatus) {
			var str = {};
			str["id_order_status"] = item.getid_order_status();
			str["os_description"] = item.getos_description();
			arrayAppend(arrOrdStatus, str);
		}
		return arrOrdStatus;
	}

	function getPayments() {
		var arrPayments = [];
		var payments = entityLoad("order_status");
		for(item in payments) {
			var str = {};
			str["id_payment"] = item.getid_payment();
			str["pay_code"] = item.getpay_code();			
			str["pay_description"] = item.getpay_description();
			str["pay_dp"] = item.getpay_dp();			
			str["pay_delivery"] = item.getpay_delivery();	
			str["pay_30_days"] = item.getpay_30_days();	
			str["pay_60_days"] = item.getpay_60_days();	
			str["pay_other"] = item.getpay_other();		
			str["pay_day"] = item.getpay_day();		
			arrayAppend(arrPayments, str);
		}
		return arrPayments;
	}

	function getCustomerByAgent(string agentId) {
		var agent = entityLoad("agent", {id_Agent: agentId}, true);
		var customers = entityLoad("customer", {agent: agent});
		var arrCus = [];
		for(item in customers) {
			var str = {};
			str["id_customer"] = item.getId_customer();
			str["cs_name"] = item.getcs_name();
			str["id_agent"] = item.getagent().getid_agent();
			str["id_zone"] = item.getzone().getid_zone();
			str["type_of_customer"] = item.gettype_of_customer().getid_type_customer();
			str["id_contract"] = item.contract().getid_contact();
			arrayAppend(arrCus, str);
		}
		return arrCus;
	}

}
