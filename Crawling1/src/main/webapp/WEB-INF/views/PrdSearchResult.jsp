<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 검색결과</title>
	<style type="text/css">
		.prdTitle{
			display: inline-block;
			width: 500px;
			white-space: nowrap;
			overflow: hidden;
			margin: 0;
			
		}
		table{
			border-collapse: collapse;

		}
		td, th{
			border-bottom: 1px solid black;
			padding: 3px 7px;
		}
		.prdArea{
			height: 700px;
			overflow: scroll;
			border: 2px solid black;
			padding: 3px;
			margin: 3px;
		}
	</style>



</head>
<body>
	<h1>PrdSearchResult.jsp</h1>
<div style="display: flex;">
	
	<div class="prdArea">
		<table>
			<thead>
				<tr>
					<th>쇼핑몰</th>
					<th>상품이름</th>
					<th>
						<select onchange="prdSort(this)" style="font-weight: bold; font-family: auto;">
							<option value="price_desc">상품가격↑</option>
							<option value="price_asc">상품가격↓</option>
						</select>
					</th>
				</tr>
			</thead>
			
			<tbody>
				<c:forEach items="${prdList_coopang }" var="prdInfo">
					<tr>
						<td>${prdInfo.prdSite }</td>
						<td>
							<a class="prdTitle" title="${prdInfo.prdName }" href="${prdInfo.prdUrl }">${prdInfo.prdName }</a>
						</td>
						<td class="prdPrice">${prdInfo.prdPrice }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	
	<div class="prdArea">
		<table>
			<thead>
				<tr>
					<th>쇼핑몰</th>
					<th>상품이름</th>
					<th>
					
					<select onchange="prdSort(this)" style="font-weight: bold; font-family: auto;">
						<option value="price_desc">상품가격↑</option>
						<option value="price_asc">상품가격↓</option>
					</select>
					</th>
					
				</tr>
			</thead>
			
			<tbody id="gmarket_tbody">
				<c:forEach items="${prdList_gmarket }" var="prdInfo">
					<tr>
						<td>${prdInfo.prdSite }</td>
						<td>
							<a class="prdTitle" title="${prdInfo.prdName }" href="${prdInfo.prdUrl }">${prdInfo.prdName }</a>
						</td>
						<td class="prdPrice">${prdInfo.prdPrice }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<div class="prdArea">
		<table>
			<thead>
				<tr>
					<th>쇼핑몰</th>
					<th>상품이름</th>
					<th>
					
					<select onchange="prdSort(this)" style="font-weight: bold; font-family: auto;">
						<option value="price_desc">상품가격↑</option>
						<option value="price_asc">상품가격↓</option>
					</select>
					</th>
					
				</tr>
			</thead>
			
			<tbody id="gmarket_tbody">
				<c:forEach items="${prdList_11st }" var="prdInfo">
					<tr>
						<td>${prdInfo.prdSite }</td>
						<td>
							<a class="prdTitle" title="${prdInfo.prdName }" href="${prdInfo.prdUrl }">${prdInfo.prdName }</a>
						</td>
						<td class="prdPrice">${prdInfo.prdPrice }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
</div>
	
</body>

<script>
	function prdSort(sortObj){
		console.log('정렬 - ' + sortObj.value)
		// let prdList = document.querySelectorAll('#gmarket_tbody>tr');
		// console.log(prdList);
		
		let tbody_tag = sortObj.parentElement.parentElement.parentElement.nextElementSibling;
		let prdList_arr = Array.from(tbody_tag.querySelectorAll('tr'));
		console.log(prdList_arr); // tbody > tr 상품목록
		
		let prdSort = [];
		for(let prd of prdList_arr){
			let prdPrice = Number(prd.querySelector('.prdPrice').innerText);

			let idx = -1;
			for(let sortIdx in prdSort){
				let sortPrice = Number(prdSort[sortIdx].querySelector('.prdPrice').innerText);
				let sortCheck = false;
				switch(sortObj.value){
				case "price_desc":
					sortCheck = prdPrice > sortPrice;
					break;
				case "price_asc":
					sortCheck = prdPrice < sortPrice;
					break;
				}
				if(sortCheck){
					idx = sortIdx;
					break;
				}

			}
			if(idx > -1){
				prdSort.splice(idx, 0, prd);
			}else{
				prdSort.push(prd);
			}

		}
		tbody_tag.innerHTML = "";

		for(let item of prdSort){
			tbody_tag.appendChild(item);
		}
	}
	
</script>









</html>