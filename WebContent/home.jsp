<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>


<c:import url="header.jsp">
<c:param name="title" value ="PictureSquirell"></c:param>
</c:import>

<!-- setting dataSource -->
<sql:setDataSource var ="ds"  dataSource ="jdbc/webshop" />

<!--querying  -->
<sql:query dataSource="${ds}" sql="select * from images limit 10" var="results" />
<div class="well">

<table class ="table">

	<c:set var="tablewidth" value="8"/>

	<c:forEach var ="image" items="${results.rows}" varStatus="row">
	
	<!-- see if index of the image is equal to 8 - just making a grid of 8 by n images -->
	<c:if test="${row.index % tablewidth == 0 }">
		<tr>
	</c:if>
            
    <c:set scope="page" var="imgname" value="${image.stem}.${image.image_extension}"></c:set>
      
      <td>
      <!-- c:url adds path to context root & and handles history if there are no cookies (jsession) -->
     <a href=" <c:url value="/gallery?action=image&image=${image.id}"/>">
      
      <img src="${pageContext.request.contextPath}/pics/${imgname}" class="img-responsive"class="img-thumbnail img-responsive"/> </td>           
      
      <c:if test="${row.index +1 % tablewidth == 0 }">
		</tr>
	  </c:if>
      
      
      
</c:forEach>
      
      <!-- 
      <div class="starter-template">       
        <h1>Bootstrap starter template</h1>
        <p class="lead">Use this document as a way to quickly start any new project.<br> All you get is this text and a mostly barebones HTML document.</p>
      </div> -->

</table>

</div>
<c:import url="footer.jsp"></c:import>