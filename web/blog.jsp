<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> <%-- Import thư viện JSTL để định dạng dd/MM/yyyy --%>
<!DOCTYPE html>
<html class="no-js" lang="en">
    <head>    
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Blog List</title>

        <!-- Import các file CSS cần thiết -->
        <link href="https://fonts.googleapis.com/css?family=Cairo:400,600,700&amp;display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Poppins:600&amp;display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Playfair+Display:400i,700i" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Ubuntu&amp;display=swap" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/animate.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/nice-select.css">
        <link rel="stylesheet" type="text/css" href="assets/css/slick.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link rel="stylesheet" type="text/css" href="assets/css/main-color.css">

        <!-- Import các file JavaScript cần thiết -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <style>
            .carousel-inner > .item > img,
            .carousel-inner > .item > a > img {
                width: 100%;
                margin: auto;
            }
            .input{
                width: 16rem;
                height: 4rem;
            }
        </style>
    </head>
    <body class="biolife-body">
        <!-- Đặt giá trị cho biến index nếu không có -->
        <c:if test="${param['index']==null }">   
            <c:set var = "index" scope = "page" value = "1"/>
        </c:if>
        <!-- Lấy giá trị của biến index nếu có -->
        <c:if test="${param['index']!=null}">
            <c:set var = "index" scope = "page" value = "${param['index']}"/>
        </c:if>

        <!-- Include header -->
        <jsp:include page="header.jsp"/>

        <!-- Nếu tài khoản có vai trò là 2, hiển thị nút Manage Blog -->



        <div class="container">


            <!-- Tiêu đề của trang -->
            <h1 style="color: black; font-weight: 600;text-align: center; font-family: cursive; color: #7fff00 ">Blogs List</h1>

            <div id="main-content" class="main-content">
                <!-- Block 03: Product Tab -->
                <div class="product-tab z-index-20 sm-margin-top-33px xs-margin-top-30px">
                    <!-- Form tìm kiếm và lọc dữ liệu -->
                    <form style="display: flex; justify-content: space-evenly; " method="get" action="BlogList">
                        <!-- Lọc theo danh mục -->
                        <div style="display: flex; justify-content: space-evenly; width: 20%;align-items: center;">
                            <p style="display: inline-block; width: 70px;">Category:</p>
                            <select onchange="this.form.submit()" style="display: inline-block; width: 200px;" class="form-select" name="cateId">
                                <option value="">All</option>
                                <c:forEach var="c" items="${bcl}">
                                    <option value="${c.id}">${c.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Ô tìm kiếm -->
                        <div  style="display: flex; justify-content: space-evenly; width: 20%;align-items: center;">
                            <div>Search: </div>
                            <input onblur="this.form.submit()"   style="display: inline-block; width: 250px;" type="text" value="${param["name"]}" name="name"  class="form-control">
                        </div>

                        <!-- Sắp xếp -->
                        <div  style="display: flex; justify-content: space-evenly; width: 20%;align-items: center;">
                            <span>Sortby: </span>
                            <select onchange="this.form.submit()" class="form-select" name="sort">
                                <option value="order by b.blog_title asc">Title A-Z</option>   
                                <option value="order by b.[create_date] desc">Newest</option>
                            </select>
                        </div>
                    </form>

                    <!-- Hiển thị danh sách blog -->
                    <div class="biolife-tab biolife-tab-contain sm-margin-top-34px">
                        <div class="tab-head tab-head__icon-top-layout icon-top-layout">
                            <div class="container">
                                <div class="row" style="margin-bottom: 50px;">
                                    <ul class="products-list" style="list-style: none; padding: 0;">

                                        <!-- Duyệt qua từng blog và hiển thị thông tin -->
                                        <c:forEach var="p" items="${blist}">
                                            <li class="product-item col-lg-4 col-md-6 col-xs-12" style="min-height: 350px; margin-bottom: 30px;">
                                                <div class="contain-product layout-default">
                                                    <div class="product-thumb">

                                                        <!-- Link đến trang chi tiết của blog -->
                                                        <a href="BlogDetail?bid=${p.getId()}" class="link-to-product" style="display: block; width: 100%; height: auto;">
                                                            <img src="${p.getBanner()}" alt="img" style="display: block; margin: 0 auto; width: 300px; height: 200px;">
                                                        </a>
                                                    </div>
                                                    <div class="info text-center">

                                                        <!-- Tiêu đề và ngày đăng của blog -->
                                                        <h4 class="product-title" style="margin-top: 21px;"><a style="color: black; font-size: 21px;" href="BlogDetail?bid=${p.getId()}" class="pr-name">${p.getBlogTitle()}</a></h4>
                                                        <div class="price">

                                                            <!-- Ngày đăng được định dạng sang dd/MM/yyyy -->
                                                            <ins><span class="price-amount" style="color: black; font-weight: 100; font-size: 15px;">
                                                                    Posted date: <fmt:formatDate pattern="dd-MM-yyyy" value="${p.getCreateDate()}"/> <span style="margin-left: 10px">&#128065;${p.getViewCount()}</span>
                                                                </span></ins>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>


                    <!-- Phân trang -->
                    <nav style="margin-left: 42%" aria-label="Page navigation example">
                        <ul class="pagination">
                            <li class="page-item"><a class="page-link" href="BlogList?cateId=${param["cateId"]}&name=${param["name"]}&index=1">First Page</a></li>
                                <c:forEach var="i"  begin="1" end="${numberPage}" step="1">
                                <li class="page-item  ${index==i?"active":""}"><a class="page-link" href="BlogList?cateId=${param["cateId"]}&name=${param["name"]}&index=${i}">${i}</a></li>
                                </c:forEach>
                            <li class="page-item"><a class="page-link" href="BlogList?cateId=${param["cateId"]}&name=${param["name"]}&index=${numberPage}">Last Page</a></li>
                        </ul>
                    </nav>

                </div>
            </div>
        </div>

        <!-- Include footer -->
        <jsp:include page="footer.jsp"/>

        <!-- Scroll Top Button -->
        <a class="btn-scroll-top"><i class="biolife-icon icon-left-arrow"></i></a>

        <!-- Import các file JavaScript cần thiết -->
        <script src="assets/js/jquery-3.4.1.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/jquery.countdown.min.js"></script>
        <script src="assets/js/jquery.nice-select.min.js"></script>
        <script src="assets/js/jquery.nicescroll.min.js"></script>
        <script src="assets/js/slick.min.js"></script>
        <script src="assets/js/biolife.framework.js"></script>
        <script src="assets/js/functions.js"></script>
    </body>
</html>
