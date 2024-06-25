<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> <%-- Import thư viện JSTL để định dạng ngày tháng --%>

<!DOCTYPE html>
<html class="no-js" lang="en">

    <head>    
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Blog List</title>

        <!-- Import các thư viện và file CSS cần thiết -->
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

        <!-- Thiết lập style cho carousel -->
        <style>
            .carousel-inner > .item > img,
            .carousel-inner > .item > a > img {
                width: 100%;
                margin: auto;
            }
        </style>

    </head>

    <body class="biolife-body">

        <!-- Include header -->
        <jsp:include page="header.jsp"/>

        <!-- Phần nội dung trang -->
        <div class="container" style="display: flex; flex-direction: column; align-items: center;padding: 20px">

            <!-- Tiêu đề của blog -->
            <h1 style="color: black; font-weight: 600;text-align: center; color: black ">${b.getBlogTitle()}</h1>  

            <!-- Hiển thị category và số lượt xem -->
            <p style="padding: 20px; text-align: center;">Category: ${b.getBlogCategoryObject().getName()} <span style="margin-left: 20px">&#128065; ${b.getViewCount()} </span></p>  

            <div style="display: flex;">

                <!-- Hình ảnh bên trái -->
                <img src="${b.getImg1()}" style="width: 40%; flex-shrink: 0; margin-right: 1rem;" />

                <!-- Phần nội dung bên phải -->
                <div style="display: flex; flex-direction: column; align-items: flex-start; border: 1px solid; border-radius: 5px; padding: 10px; width: 60%;">
                    <div style="padding: 20px; width: 100%;">
                        Posted date: <fmt:formatDate pattern="dd-MM-yyyy" value="${b.getCreateDate()}" />
                    </div>
                    <p style="padding: 20px; padding-bottom: 0;">${b.getIntroduction()}</p>
                    <!-- Hiển thị nội dung của blog -->
                    <p style="padding: 20px; padding-bottom: 0;">${b.getBody()}</p>
                    <p style="padding: 20px; padding-bottom: 0;">${b.getConclusion()}</p>
                    <p style="padding: 20px; padding-bottom: 0; align-self: flex-end; color: blueviolet;">
                        <strong>${b.getAuthor()}</strong>
                    </p>
                </div>
            </div>





        </div>

        <!-- Include footer -->
        <jsp:include page="footer.jsp"/>

        <!-- Scroll Top Button -->
        <a class="btn-scroll-top"><i class="biolife-icon icon-left-arrow"></i></a>

        <!-- Import các thư viện và file JavaScript cần thiết -->
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
