<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

			<%@ include file="../include/header.jsp" %>

				<section>
					<div class="container">
						<div class="row">
							<!--lg에서 10그리드, xs에서 전체그리드-->
							<div class="col-lg-10 col-xs-12 board-table" id="reviewBoard">
								<section id="section">
									<h2 class="text-center border-bottom border-orange pb-3 mb-4">여러밥 후기</h2>
								</section>


								<!--form select를 가져온다 -->
								<form action="<c:url value='/review/reviewList' />">
									<div id="search-wrap">

										<select name="condition" class="form-select search-select">
											<option value="title" class="title" ${pc.paging.condition=='title' ? 'selected' : '' }>제목</option>
											<option value="content" ${pc.paging.condition=='content' ? 'selected' : '' }>내용</option>
											<option value="restaurant" ${pc.paging.condition=='restaurant' ? 'selected' : '' }>가게 이름</option>
											<option value="writer" ${pc.paging.condition=='writer' ? 'selected' : '' }>작성자</option>
											<option value="titleContent" ${pc.paging.condition=='titleContent' ? 'selected' : '' }>제목+내용
											</option>
										</select>
										<input type="text" name="keyword" class="form-control search-input" value="${pc.paging.keyword}"
											id="keywordInput">
										<button type="submit" class="btn btn-info search-btn" id="searchBtn">검색</button>

									</div>

								</form>

								<table class="table table-bordered table-hover" id="table">
									<thead>
										<tr>
											<th class="reviewNo">번호</th>
											<th id="board-title">제목</th>
											<th class="reviewWriter">작성자</th>
											<th>식당 이름</th>
											<th class="day">등록일</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="vo" items="${reviewList}">
											<tr>
												<td class="reviewNo">${vo.reviewNo}</td>
												<td id="review-title">
													<div class="text-truncate">
														<a
															href="${pageContext.request.contextPath}/review/content/${vo.reviewNo}?pageNum=${pc.paging.pageNum}&cpp=${pc.paging.cpp}&keyword=${pc.paging.keyword}&condition=${pc.paging.condition}">${vo.title}</a>
													</div>
												</td>
												<td class="reviewWriter">${vo.userNick}</td>
												<td>${vo.bplcNm}</td>
												<td class="day">
													<fmt:parseDate value="${vo.regDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" />
													<fmt:formatDate value="${parsedDateTime}" pattern="yy.MM.dd. HH:mm" />
												</td>
											</tr>
										</c:forEach>
									</tbody>

								</table>


								<!--페이지 네이션을 가져옴-->
								<form action="${pageContext.request.contextPath}/review/reviewList" name="pageForm">
									<nav aria-label="Page navigation example">
										<ul class="pagination justify-content-center">

											<!-- 이전 버튼 -->
											<c:if test="${pc.prev}">
												<li class="page-item">
													<a href="#" class="page-link" data-pagenum="${pc.beginPage-1}">이전</a>
												</li>
											</c:if>

											<!-- 페이지 버튼들 -->
											<c:forEach var="num" begin="${pc.beginPage}" end="${pc.endPage}">
												<li class="page-item ${pc.paging.pageNum == num ? 'active' : ''}">
													<a href="#" class="page-link" data-pagenum="${num}">${num}</a>
												</li>
											</c:forEach>

											<!-- 다음 버튼 -->
											<c:if test="${pc.next}">
												<li class="page-item">
													<a href="#" class="page-link" data-pagenum="${pc.endPage+1}">다음</a>
												</li>
											</c:if>
										</ul>
									</nav>

									<div class="text-center">
										<button type="button" class="btn btn-info" id="writeBtn"
											onclick="location.href='${pageContext.request.contextPath}/review/reviewRegist'">글쓰기</button>
									</div>

									<input type="hidden" name="pageNum" value="${pc.paging.pageNum}">
									<input type="hidden" name="cpp" value="${pc.paging.cpp}">
									<input type="hidden" name="keyword" value="${pc.paging.keyword}">
									<input type="hidden" name="condition" value="${pc.paging.condition}">

								</form>

							</div>
						</div>
					</div>
				</section>

				<%@ include file="../include/footer.jsp" %>

					<script>

						window.onload = function () {
							document.pageForm.addEventListener('click', e => {
								if (!e.target.matches('a')) {
									return;
								}
								e.preventDefault();
								const value = e.target.dataset.pagenum;

								document.pageForm.pageNum.value = value;
								document.pageForm.submit();
							});

						}
					</script>