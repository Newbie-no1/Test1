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

    <!-- Thiết lập style cho trang blog -->
    <style>
        .blog-container {
            padding: 20px;
            max-width: 1200px; /* Mở rộng chiều rộng */
            margin: auto;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }

        .blog-title {
            color: #333;
            font-weight: 600;
            text-align: center;
            margin-bottom: 20px;
        }

        .blog-meta {
            text-align: center;
            padding: 10px 0;
            font-size: 16px;
            color: #777;
        }

        .blog-meta span {
            margin-left: 20px;
        }

        .blog-image {
            width: 100%;
            height: auto;
            display: block;
            margin: 20px 0;
            border-radius: 10px;
        }

        .blog-content {
            padding: 20px;
            border-top: 1px solid #eee;
        }

        .blog-content p {
            line-height: 1.6;
            margin-bottom: 20px;
        }

        .blog-author {
            text-align: right;
            color: blueviolet;
            font-weight: bold;
        }

        .posted-date {
            text-align: center;
            padding: 10px 0;
            color: #777;
        }
    </style>
</head>

<body class="biolife-body">

    <!-- Include header -->
    <jsp:include page="header.jsp" />

    <!-- Phần nội dung trang -->
    <div class="blog-container">
        <!-- Tiêu đề của blog -->
        <h1 class="blog-title">${b.getBlogTitle()}</h1>

        <!-- Hiển thị category và số lượt xem -->
        <p class="blog-meta">Category: ${b.getBlogCategoryObject().getName()} <span>&#128065; ${b.getViewCount()}</span></p>

        <!-- Hình ảnh nằm trên cùng -->
        <img src="${b.getImg1()}" alt="${b.getBlogTitle()}" class="blog-image" />

        <!-- Phần nội dung bên dưới -->
        <div class="blog-content">
            <!-- Ngày đăng -->
            <div class="posted-date">
                Posted date: <fmt:formatDate pattern="dd-MM-yyyy" value="${b.getCreateDate()}" />
            </div>

            <!-- Nội dung blog -->
            <p>${b.getIntroduction()}</p>
            <p>${b.getBody()}</p>
            <p>${b.getConclusion()}</p>
            <p class="blog-author">${b.getAuthor()}</p>
        </div>
    </div>

    <!-- Include footer -->
    <jsp:include page="footer.jsp" />

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
