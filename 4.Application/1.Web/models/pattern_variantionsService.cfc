component extends="cborm.models.VirtualEntityService" singleton{
	property name='userService' 			inject='userService';
	property name='patternsService'     	inject='patternsService';
	/**
	* Constructor
	*/
	function init(){
		// init super class
		super.init( entityName="pattern_variantions" );

		// Use Query Caching
	    setUseQueryCaching( false );
	    // Query Cache Region
	    setQueryCacheRegion( "ormservice.pattern_variantions" );
	    // EventHandling
	    setEventHandling( true );

	    return this;
	}

	function delPatternVari(numeric patternID, string varicode){
		var idvari = QueryExecute("select id_pattern_var from pattern_variantions WHERE pv_code = '#varicode#' ").id_pattern_var;
		QueryExecute("
						DELETE FROM pattern_var_des
   						WHERE id_pattern_var = #idvari#
					");
		QueryExecute("
						DELETE FROM pattern_variantions
   						WHERE id_pattern = #patternID# and pv_code = '#varicode#'
					");
		return "";
	}

	function getFullImage(numeric patternID, string varicode){
		var result = QueryExecute("
						SELECT * FROM pattern_variantions
   						WHERE id_pattern = #patternID# and pv_code = '#varicode#'
					");
		return result;
	}

	function getPatternVari(patternid, pvcode){
   		var result = QueryExecute("
   			select pvd.pv_description, pv.pv_code, pv.pv_parts, pv.pv_sketch, pvd.id_language
   			from pattern_variantions pv
   				join patterns
   					on patterns.id_pattern = pv.id_pattern
   				join pattern_var_des pvd
   					on pvd.id_pattern_var = pv.id_pattern_var
   			where patterns.id_pattern = #patternid# and pv_code = '#pvcode#'
   			");
   		return result;
   	}


}