<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=kfjywhorji"></script>
</head>
<body>
    <div id="map" style="width:100%;height:100vh;margin:0 auto;"></div>

<script>
	var HOME_PATH = window.HOME_PATH || '.';
	
	
	map = new naver.maps.Map('map', {
	    center: new naver.maps.LatLng(${dto.lon}, ${dto.lat}),
	    zoom: 15
	});
	
	
	var place = new naver.maps.LatLng(${dto.lon}, ${dto.lat});
// 	var jooyeokHouse = new naver.maps.LatLng(36.32611, 127.41263);
	
	
	var markers = [];
	var infowindows = [];
	
	markers.push(new naver.maps.Marker({
	    map: map,
	    position: place
	}));
	
	infowindows.push(new naver.maps.InfoWindow({
	    content: [
	        '<div class="iw_inner">',
	        '   <h3>${dto.title}</h3>',
	        '   <h3>${dto.content}</h3>',
	        '</div>'
	    ].join('')
	}));


	for(let i=0; i<markers.length; i++){
	    naver.maps.Event.addListener(markers[i], "click", function(e) {
	        if (infowindows[i].getMap()) {
	            infowindows[i].close();
	        } else {
	            infowindows[i].open(map, markers[i]);
	        }
	    });
	}

	infowindows[0].open(map, markers[0]);
	</script>
</body>
<table>
	      <tr>
			<td>
				<a href="modify_view?pno=${dto.pno}">수정</a>
				<a href="delete?pno=${dto.pno}">삭제</a>
			</td>
		</tr>
</table>
</html>