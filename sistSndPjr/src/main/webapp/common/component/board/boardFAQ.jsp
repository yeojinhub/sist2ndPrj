<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../../jsp/external_file.jsp" />

<style>
</style>
<script>

</script>
<div>
	<div style="position: relative;">
		<h3 class="section-title">공지사항</h3>
		<hr class="line_gray">
		<div class="search-box">
			<select>
				<option>제목</option>
			</select> <input type="text" />
			<button class="btn btn-confirm">검색</button>
		</div>

		<div class="accordion" id="accordionExample" style="width: 960px;">
			<div class="accordion-item" style="text-align: center;">
				<h2 class="accordion-header">
					<button class="accordion-button" type="button"
						data-bs-toggle="collapse" data-bs-target="#collapseOne"
						aria-expanded="true" aria-controls="collapseOne">전기/수소차
						충전소 정보 제공 안내</button>
				</h2>
				<div id="collapseOne" class="accordion-collapse collapse show"
					data-bs-parent="#accordionExample">
					<div class="accordion-body">
						<strong>*한국환경공단 전기자동차 충전소 정보 등 활용</strong> 전기 충전소는 공공데이터 연계로 3~4분
						정도 지연이 있으며, 갱신 주기는 5분입니다. 수소 충전소는 정보 확인 시 지연 시간 없이 제공하고 있습니다.
					</div>
				</div>
			</div>
			<div class="accordion-item">
				<h2 class="accordion-header">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse" data-bs-target="#collapseTwo"
						aria-expanded="false" aria-controls="collapseTwo">
						Accordion Item #2</button>
				</h2>
				<div id="collapseTwo" class="accordion-collapse collapse"
					data-bs-parent="#accordionExample">
					<div class="accordion-body">
						<strong>This is the second item's accordion body.</strong> It is
						hidden by default, until the collapse plugin adds the appropriate
						classes that we use to style each element. These classes control
						the overall appearance, as well as the showing and hiding via CSS
						transitions. You can modify any of this with custom CSS or
						overriding our default variables. It's also worth noting that just
						about any HTML can go within the
						<code>.accordion-body</code>
						, though the transition does limit overflow.
					</div>
				</div>
			</div>
			<div class="accordion-item">
				<h2 class="accordion-header">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse" data-bs-target="#collapseThree"
						aria-expanded="false" aria-controls="collapseThree">
						Accordion Item #3</button>
				</h2>
				<div id="collapseThree" class="accordion-collapse collapse"
					data-bs-parent="#accordionExample">
					<div class="accordion-body">
						<strong>This is the third item's accordion body.</strong> It is
						hidden by default, until the collapse plugin adds the appropriate
						classes that we use to style each element. These classes control
						the overall appearance, as well as the showing and hiding via CSS
						transitions. You can modify any of this with custom CSS or
						overriding our default variables. It's also worth noting that just
						about any HTML can go within the
						<code>.accordion-body</code>
						, though the transition does limit overflow.
					</div>
				</div>
			</div>
		</div>

	</div>
</div>