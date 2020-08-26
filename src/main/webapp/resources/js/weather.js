function weather() {
var apiURI ="http://api.openweathermap.org/data/2.5/weather?id=1835848&APPID=32a5bf199bad7faca93091c36fbf5ce7";
$.ajax({
    url: apiURI,
    dataType: "json",
    type: "GET",
    async: "false",
    success: function(resp) {
        
        var temp = resp.main.temp- 273.15; //현재기온
        var weather = resp.weather[0].main; //날씨상태1
        var humidity = resp.main.humidity; //습도
        var type = resp.weather[0].description; //날씨상태2
        var city = resp.name; //도시이름
        var probability = resp.clouds.all; //강수확률
        var imgURL = "http://openweathermap.org/img/w/" + resp.weather[0].icon + ".png"; //이미지아이콘url
        
     

    	if(weather == "Clouds")
			type = "구름 낌";
		else if(weather == "Rain")
			type = "비";
		else if(weather == "Clear")
			type = "맑음";
		else if(weather == "Snow")
			type = "눈";
		else
			type = "흐림";

		$('.temp').append(temp.toFixed(1) + "°C"); //현재기온
		$('.weather').append(weather); //날씨상태1
		$('.type').append(type); //날씨상태2
		$('.humidity').append(humidity+ "%"); //습도
		$('.probability').append(probability +"%" );  //강수확률
		$('.city').append(city);  //도시  
		$('.weatherImg').attr("src", imgURL); //이미지        
    }
});
}
