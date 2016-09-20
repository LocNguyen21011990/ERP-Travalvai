component output="false" displayname=""  {
	property name='userService' 			inject='userService';
	property name='orderService' 			inject='orderService';

	function getOrders(){
		var rs = [];
		rs = orderService.getOrders();
		event.renderData(type = "json", data = rs);
	}

	function getUserLevel() {
		event.renderData(type = "json", data = userService.getUserLevel()); 
	}

	function getOrderById(event,prc,rc){
		var rs = {};
		rs = orderService.getOrderById(rc.orderId);
		event.renderData(type = "json", data = rs);
	}

	function getOrderDetails(event,prc,rc){
		var rs = {};
		rs = orderService.getOrderDetails(rc.orderId);
		event.renderData(type = "json", data = rs);
	}

	function addNewOrder(event, rc, prc){
		if(event.GETHTTPMETHOD() == "POST"){
			if(rc.id_order_temp == 0){


			}
		}
	}
}