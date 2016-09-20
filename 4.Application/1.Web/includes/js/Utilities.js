var roundDecimalPlaces = function (value, places) {
     if (places <= 0)
         return value;
     if(value == 0) return value;

     //Positive number
     if (Math.abs(value) >= 1)
         return Number(value).toFixed(places);

     places = places - 1;

     var isNagative = value < 0;

     value = isNagative ? (value * -1) : value;

     var log10 = parseInt(Math.floor(Math.log10(value)));

     var exp = (Math.pow(10, log10));

     value /= exp;

     value = Number(value).toFixed(places);

     value = (value * exp).toPrecision(places + 1);

     value = isNagative ? (value * -1) : value;

     return value;
 	}
