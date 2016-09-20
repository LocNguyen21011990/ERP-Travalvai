component extends="cborm.models.VirtualEntityService" singleton{
	property name='userService' 			inject='userService';
	/**
	* Constructor
	*/
	function init(){
		// init super class
		super.init( entityName="payment" );

		// Use Query Caching
	    setUseQueryCaching( false );
	    // Query Cache Region
	    setQueryCacheRegion( "ormservice.payment" );
	    // EventHandling
	    setEventHandling( true );

	    return this;
	}

	

}