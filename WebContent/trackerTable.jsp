<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false"%>
<body>
    <div class="row">
        <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
                <div class="x_title">
                    <script>
                        $(document).ready(function() {
                            $("button").click(function() {
                                $("#selectedTrackerTable").toggle(200);
                            });
                        });
                    </script>
                    </head>
                    <body>
                        <button type="button" class="btn btn-info"
                            style="background-color: rgba(52, 73, 94, 0.94)">
                            Blogs from Selected Tracker <span class="fa fa-chevron-down"></span>
                        </button>
                        <div class="clearfix"></div>
                </div>
                <div class="x_content" id="demo">
                    <p class="text-muted font-13 m-b-30"></p>
                    <div class="table-responsive">
                        <table id="selectedTrackerTable">
                            <tbody>
                                <c:set var="i" value="0" />
                                <c:set var="eo" value="1" />
                                <c:forEach items="${allSepSites}" var="s1" begin="${i}">
                                    <c:if test="${eo==1 || eo%2 ==1 }">
                                        <tr class="odd pointer">
                                            <c:forEach items="${allSepSites}" var="s1" begin="${i}"
                                                end="${i+4}">
                                                <td class="a-center ">${s1.siteName}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp</td>
                                            </c:forEach>
                                        </tr>
                                        <c:set var="i" value="${i+5}" />
                                    </c:if>
                                    <c:if test="${eo%2 ==0}">
                                        <tr class="even pointer">
                                            <c:forEach items="${allSepSites}" var="s1" begin="${i}"
                                                end="${i+4}">
                                                <td class="a-center ">${s1.siteName}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp</td>
                                            </c:forEach>
                                        </tr>
                                        <c:set var="i" value="${i+5}" />
                                    </c:if>
                                    <c:set var="eo" value="${eo+2}" />
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</body>
</html>