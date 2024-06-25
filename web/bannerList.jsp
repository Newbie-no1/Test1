<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html class="no-js" lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title> Shop</title>

        <link href="https://fonts.googleapis.com/css?family=Cairo:400,600,700&amp;display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Poppins:600&amp;display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Playfair+Display:400i,700i" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Ubuntu&amp;display=swap" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/css/animate.min.css">
        <link rel="stylesheet" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" href="assets/css/nice-select.css">
        <link rel="stylesheet" href="assets/css/slick.min.css">
        <!--<link rel="stylesheet" href="assets/css/style.css">-->
        <link rel="stylesheet" href="assets/css/main-color.css">

    </head>

    <body class="biolife-body">

        <nav class="navbar navbar-default">
            <div class="container">

                <!-- BRAND -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#alignment-example" aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span>
                    </button>
                    <a class="navbar-brand" href="HomePage">Online Shop</a>
                </div>
                <!-- COLLAPSIBLE NAVBAR -->
                <div class="collapse navbar-collapse" id="alignment-example">

                    <!-- Links -->
                    <ul class="nav navbar-nav">

                        <li>
                            <a style="text-decoration: none;" href="ManagerUser"> Manage User</a>
                        </li>


                        <li >
                            <a style="text-decoration: none;" href="ManagerProduct"> Manage Product</a>
                        </li>

                        <li>
                            <a style="text-decoration: none;" href="FeedbackList"> Manage Feedbacks </a>
                        </li>
                        <li >
                            <a style="text-decoration: none;" href="ManageBanner"> Manage Banner</a>
                        </li>
                        <li >
                            <a href="Logout" style="color: black;" class="login-link"><i class="fa fa-sign-out" style="font-size: 18px; margin-left: 10px;" aria-hidden="true"></i></a>
                        </li>
                    </ul>
                </div>

            </div>
        </nav>
        <!-- Main content -->
        <div id="main-content" class="main-content">
            <div class="container-fluid">

                <div class="row" >

                    <div class="col-md-12">
                        <h1 style="text-align: center;">Manager Banner</h1>
                        <form method="get" action="ManageBanner" class="row" style="width: 90%; padding: 15px; display: flex; justify-content: space-between">
                            <div class="col-md-4">
                                <label >Status:</label>
                                <div>
                                    <select  class="form-control" style="display: block;" name="status" onchange="this.form.submit()" >
                                        <option value="">All</option>
                                        <option value="1" ${param['status']=="1"?"selected":""} >Active </option>
                                        <option value="0" ${param['status']=="0"?"selected":""} >Inactive </option>
                                    </select>

                                </div>

                            </div>
                            <div class="col-md-4">
                                <label >Search:</label>
                                <div>
                                    <input type="hidden" name="index" value="1">
                                    <input type="text" style="width: 250px" placeholder="Search title or backlink" value="${param["search"]}" name="search" class="form-control">
                                </div>
                            </div>
                            <div class="col-md-4">

                                <input class="btn btn-primary" type="submit" value="Find" style="margin-top: 10px; ">
                            </div>


                        </form>

                        <table class="table" style="margin-top: 20px; margin-bottom: 20px;">
                            <thead >
                                <tr style="font-size: 20px;">
                                    <th scope="col">ID</th>
                                    <th scope="col">Title</th>
                                    <th scope="col">Image</th>
                                    <th scope="col">Backlink</th>
                                    <th scope="col">Status</th>
                                    <th scope="col">Create Date</th>

                                    <th scope="col" colspan="2" style="text-align: center">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="p" items="${bl}">
                                    <tr>
                                        <th scope="row">${p.getId()}</th>
                                        <td>${p.getTitle()}</td>
                                        <td>      
                                            <img style="width:150px;"src="img/${p.getImg()}">
                                        </td>
                                        <td>${p.getBackLink()}</td>
                                        <td>${p.isStatus()>=true?"Active":"Inactive"}</td>

                                        <td>${p.getCreated_on()}</td>


                                        <td ><a href="DeleteProduct?pid=${p.getId()}" class="btn- btn-danger  btn-lg" style="display: block;" > Delete</a></td>
                                        <td> <button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#myModal${p.getId()}">Edit</button></td>

                                    </tr>

                                </c:forEach>
                            </tbody>
                        </table>
                        <div style="display: flex; justify-content: center;">
                            <ul class="pagination" >
                                <li  class="page-item next"><a href="ManagerProduct?index=1&search=${param['search']}&status=${param['status']}"><i class="fa fa-angle-left" class="page-link" aria-hidden="true"></i></a></li>
                                        <c:forEach var = "i" begin = "1" end = "${numberPage}">
                                    <li class="${index==i?'page-item active':'page-item'}"><a href="ManagerProduct?index=${i}&search=${param['search']}&status=${param['status']}"   class="page-link">${i}</a></li>
                                    </c:forEach>
                                <li  class="page-item next"><a href="ManagerProduct?index=${numberPage}&search=${param['search']}&status=${param['status']}"><i class="fa fa-angle-right" class="page-link" aria-hidden="true"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Scroll Top Button -->
        <a class="btn-scroll-top"><i class="biolife-icon icon-left-arrow"></i></a>

        <script src="assets/js/jquery-3.4.1.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/jquery.countdown.min.js"></script>
        <script src="assets/js/jquery.nice-select.min.js"></script>
        <script src="assets/js/jquery.nicescroll.min.js"></script>
        <script src="assets/js/slick.min.js"></script>
        <script src="assets/js/biolife.framework.js"></script>
        <script src="assets/js/functions.js"></script> 
        <script>function displayImage(input) {
                                            var previewImage = document.getElementById("previewImage");
                                            var file = input.files[0];
                                            var reader = new FileReader();

                                            reader.onload = function (e) {
                                                previewImage.src = e.target.result;
                                                previewImage.style.display = "block";
                                            }

                                            reader.readAsDataURL(file);
                                        }

        </script>

    </body>

</html>