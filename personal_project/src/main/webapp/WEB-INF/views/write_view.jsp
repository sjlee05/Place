<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=kfjywhorji&submodules=geocoder"></script>
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
</head>
<body>
	<div id="map" style="width:700px;height:300px;"></div>
	<form id="myForm">
	<div>
		<table>
			<thead>
				<tr>
					<td>분류</td>
				   <td>
				      <select name="cate">
				        <option value="한식" selected>한식</option>
				        <option value="중식">중식</option>
				        <option value="일식">일식</option>
				        <option value="양식">양식</option>
				        <option value="분식">분식</option>
				        <option value="패스트푸드">패스트푸드</option>
				      </select>
				   </td>
				</tr>
				<tr>
					<td>상호명</td>
					<td>
						<input type="text" name="title">
					</td>
				</tr>
				<tr>
					<td>내용</td>
					<td>
						<input type="text" name="content">
					</td>
				</tr>
				<tr>
					<td>첨부파일</td>
						<td class="uploadDiv">
							<input type="file" name="uploadFile" id="uploadFile" multiple>
						</td>
				</tr>
			</thead>
			<tbody id="mapList"></tbody>
		</table>
	</div>
	<div class="search">
		<input id="address" type="text" placeholder="검색할 주소">
		<input id="submit" type="button" value="주소검색">
	</div>
	<input type="button" id="btn" value="등록하기">
	</form>
</body>
<script>
	//지도를 그려주는 함수 실행
	selectMapList();
	
	//검색한 주소의 정보를 insertAddress 함수로 넘겨준다.
	function searchAddressToCoordinate(address) {
	    naver.maps.Service.geocode({
	        query: address
	    }, function(status, response) {
	        if (status === naver.maps.Service.Status.ERROR) {
	            return alert('Something Wrong!');
	        }
	        if (response.v2.meta.totalCount === 0) {
	            return alert('올바른 주소를 입력해주세요.');
	        }
	        var htmlAddresses = [],
	            item = response.v2.addresses[0],
	            point = new naver.maps.Point(item.x, item.y);
	        if (item.roadAddress) {
	            htmlAddresses.push('[도로명 주소] ' + item.roadAddress);
	        }
	        if (item.jibunAddress) {
	            htmlAddresses.push('[지번 주소] ' + item.jibunAddress);
	        }
	        if (item.englishAddress) {
	            htmlAddresses.push('[영문명 주소] ' + item.englishAddress);
	        }
	
	        insertAddress(item.roadAddress, item.x, item.y);
	        
	    });
	}
	
	// 주소 검색의 이벤트
	$('#address').on('keydown', function(e) {
	    var keyCode = e.which;
	    if (keyCode === 13) { // Enter Key
	        searchAddressToCoordinate($('#address').val());
	    }
	});
	$('#submit').on('click', function(e) {
	    e.preventDefault();
	    searchAddressToCoordinate($('#address').val());
	});

	
	    
	//검색정보를 테이블로 작성해주고, 지도에 마커를 찍어준다.
	function insertAddress(address, latitude, longitude) {
		var mapList = "";
		mapList += "<tr>"
		mapList += "	<td>주소</td>"
		mapList += "	<td>" + address + "</td>"
		mapList += "</tr>"
		mapList += "<tr>"
		mapList += "	<td>위도</td>"
		mapList += "	<td>" + latitude + "</td>"
		mapList += "</tr>"
		mapList += "<tr>"
		mapList += "	<td>경도</td>"
		mapList += "	<td>" + longitude + "</td>"
		mapList += "</tr>"
	
		$('#mapList').html(mapList);	
	
		var map = new naver.maps.Map('map', {
		    center: new naver.maps.LatLng(longitude, latitude),
		    zoom: 14
		});
	    var marker = new naver.maps.Marker({
	        map: map,
	        position: new naver.maps.LatLng(longitude, latitude),
	    });
	}
	
	//지도를 그려주는 함수
	function selectMapList() {
		
		var map = new naver.maps.Map('map', {
		    center: new naver.maps.LatLng(35.15626040, 129.05947417),
		    zoom: 16
		});
	}
	
	
	// 지도를 이동하게 해주는 함수
	function moveMap(len, lat) {
		var mapOptions = {
			    center: new naver.maps.LatLng(len, lat),
			    zoom: 15,
			    mapTypeControl: true
			};
	    var map = new naver.maps.Map('map', mapOptions);
	    var marker = new naver.maps.Marker({
	        position: new naver.maps.LatLng(len, lat),
	        map: map
	    });
	}

	// AJAX를 사용하여 폼 데이터를 제출하는 함수
	function submitFormWithMapData() {
		// 폼 데이터 가져오기
		var cate = $('select[name="cate"]').val();
		var title = $('input[name="title"]').val();
		var content = $('input[name="content"]').val();

		// 지도 데이터 가져오기
		var address = $('#address').val();
		var lat = parseFloat($('#mapList tr:nth-child(2) td:nth-child(2)').text());
		var lon = parseFloat($('#mapList tr:nth-child(3) td:nth-child(2)').text());
		
		// 파일 데이터 가져오기
		var fileInput = $('#uploadFile')[0];
		var file = fileInput.files[0]; // 첫 번째 파일만 가져오도록 합니다.
		
		  if (title.trim() === '' || content.trim() === '' || address.trim() === '') {
		        alert("제목, 내용, 주소를 모두 입력해주세요.");
		        return false;
		    } else if (isNaN(lat) || isNaN(lon)) {
		        alert("주소검색 버튼을 눌러 위도, 경도를 설정해주세요.");
		        return; // 폼 제출 방지
		    } else if (file == null) {
		        alert("파일을 등록해주세요.");
		        return; // 폼 제출 방지
		    }
		  
		
		// AJAX로 보낼 데이터 객체 생성
		var formData = new FormData();
		formData.append('cate', cate);
		formData.append('title', title);
		formData.append('content', content);
		formData.append('address', address);
		formData.append('lat', lat);
		formData.append('lon', lon);

		// 파일 데이터 추가
		formData.append('uploadFile', file);

		// AJAX POST 요청 수행
		$.ajax({
			type: 'POST',
			url: 'write', 
			data: formData,
			processData: false, // 필수: formData 사용 시, 데이터를 query string으로 변환하지 않도록 설정
			contentType: false, // 필수: formData 사용 시, 컨텐츠 타입 헤더를 설정하지 않도록 설정
			success: function(response) {
				// 서버로부터의 응답 처리
				alert("lon"+lon);
				alert("lat"+lat);
				alert('폼이 성공적으로 제출되었습니다!');
				location.href = "list";
			},
			error: function(error) {
				// 서버로부터의 에러 응답 처리
				alert('폼 제출 중 오류 발생: ' + error);
			}
		});
	}

	// "등록하기" 버튼에 클릭 이벤트를 바인딩하여 AJAX를 사용하여 폼을 제출합니다.
	$('#btn').on('click', function() {
		
		
		submitFormWithMapData();
	});
	
	

</script>
</html>