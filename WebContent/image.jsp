<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%--<%@ taglib tagdir="/WEB-INF/tags" prefix="ps" %> --%>

<c:import url="header.jsp">
	<c:param name="title" value="PictureSquirell - View Image"></c:param>
</c:import>


<!-- Let's enclose all in sql transaction -->
<sql:transaction dataSource="jdbc/webshop">



	<!-- setting dataSource - not needed if we already set it up in sql transaction tag -->
	<%-- <sql:setDataSource var="ds" dataSource="jdbc/webshop" />--%>


	<!--querying  -->
	<sql:query sql="select * from images where id =?" var="results">
		<sql:param>${param.image}</sql:param>

	</sql:query>

	<div class="well">

		<%-- Get the row for this image --%>
		<c:set scope="page" var="image" value="${results.rows[0]}"></c:set>

		<c:set scope="page" var="imgname"
			value="${image.stem}.${image.image_extension}"></c:set>

		<c:set scope="page" var="average_ranking"
			value="${image.average_ranking}" />

		<%-- If the user has clicked to rate the image, do the rating --%>
		
		<c:if test='${param.action == "rate" }'>
		
			<c:set scope="page" var="newRating"
				value="${(image.average_ranking * image.rankings + param.rating)/(image.rankings + 1)}" />
				
		
				
			<c:set scope="page" var="average_ranking" value="${newRating}" />

			<sql:update sql="update images set average_ranking=? where id =?">
				<sql:param>${newRating}</sql:param>
				<sql:param>${param.image}</sql:param>
			</sql:update>


			<sql:update sql="update images set rankings=? where id =?">
				<sql:param>${image.rankings+1}</sql:param>
				<sql:param>${param.image}</sql:param>
			</sql:update>

		</c:if>
		<script>
		//JS inserted to debug
		//alert('Dakle average_ranking je:'+'${image.average_ranking}');
		//alert('Dakle image.rankings je:'+'${image.rankings}');
		//alert('Dakle param.rating je:'+'${param.rating}');
		//alert('Dakle image.rankings je:'+'${image.rankings}');
		//*'${image.rankings}'+'${param.rating}'/'${image.rankings}');
		
		</script>
		
		</sql:transaction>

<%--Show the title and the image --%>

<%-- Show the title, first letter capitalised --%>
	<H2>
		<c:out
			value="${fn:toUpperCase(fn:substring(image.stem, 0, 1))}${fn:toLowerCase(fn:substring(image.stem, 1, -1))}" />
	</H2>
	

<img src="${pageContext.request.contextPath}/pics/${imgname}" 	class="img-responsive " /> 
<%--<ps:image width="200" stem="${image.stem}" extension="${image.image_extension}"/>--%>

<hr>
<!-- output the rating form -->
<form action='<c:url value="/gallery"/>' method="post">
	<input type="hidden" name="action" value="rate" />
	 <input type="hidden" name="image" value="${image.id}" />

	<c:if test='${param.action == "rate" }'>
		<div class="alert alert-success alert-dismissable">
  		<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
  		<strong> Thank You!</strong>
		</div>
	</c:if>
	
	<c:if test='${param.action != "rate" }'>
	<p class="lead">Please rate the image!</p>
	</c:if>
	
	<div class="panel panel-primary">
		<div class="panel-heading">
			<strong>Rated: <fmt:formatNumber value="${average_ranking}" maxFractionDigits="1"/></strong>
		</div>
		<div class="panel-body">

		<input  type="radio" name="rating" value="5">5<br> <input
				type="radio" name="rating" value="4">4<br> <input
				type="radio" name="rating" value="3">3<br> <input
				type="radio" name="rating" value="2">2<br> <input
				type="radio" name="rating" value="1">1<br>
		</div>
	</div>
	<button type="submit" class="btn btn-primary">OK</button>


</form>







<!-- 
      <div class="starter-template">       
        <h1>Bootstrap starter template</h1>
        <p class="lead">Use this document as a way to quickly start any new project.<br> All you get is this text and a mostly barebones HTML document.</p>
      </div> -->



</div>
<c:import url="footer.jsp"></c:import>