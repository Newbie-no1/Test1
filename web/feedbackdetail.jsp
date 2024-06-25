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
        <c:if test="${param['index']==null }">   
            <c:set var = "index" scope = "page" value = "1"/>
        </c:if>
        <c:if test="${param['index']!=null}">
            <c:set var = "index" scope = "page" value = "${param['index']}"/>
        </c:if>
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
                <div class="row">
                    <div class="col-md-12">
                        <h1 style="text-align: center;">Feedback Details</h1>
                        <div  >
                            <div class="modal-dialog modal-dialog-centered" role="document">
                                
                                    <form action="FeedbackList">
                                            <input type="hidden" readonly="" name="action" value="edit">
                                            <div class="row">
                                                <div class="form-group  col-md-12">
                                                    <span class="thong-tin-thanh-toan">
                                                        
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="form-group col-md-6">
                                                    <label class="control-label">Fullname</label>
                                                    <input class="form-control" type="text" readonly="" value="${f.user.name}">
                                                    <input class="form-control" type="hidden" name="fid" readonly="" value="${f.feedback_id}">
                                                </div>
                                                <div class="form-group col-md-6">
                                                    <label for="exampleSelect1" class="control-label">Email</label>
                                                    <input class="form-control" type="text" id="stitle" value="${f.user.email}" readonly="">
                                                    <span id="invalid1" style="color: red;"> </span>

                                                </div>
                                                <div class="form-group col-md-6">
                                                    <label class="control-label">Phone</label>
                                                    <input class="form-control" type="text" readonly="" value="${f.user.phone}">
                                                </div>
                                                <div class="form-group col-md-6">
                                                    <label for="exampleSelect1" class="control-label">Rate Star</label>
                                                    <input class="form-control" type="text" value="${f.rated}" readonly="">
                                                    <span id="invalid1" style="color: red;"> </span>

                                                </div>
                                                <div class="form-group col-md-12">
                                                    <label class="control-label">Feedback</label>
                                                    <textarea readonly="" class="form-control" >${f.fb_content}</textarea>
                                                    <span id="invalid3" style="color: red;"> </span>
                                                </div><div class="form-group col-md-12" style="
                                                           text-align: center;
                                                           ">
                                                    <label class="control-label">Image</label>
                                                    <img src="${f.image}" alt="" width="150">
                                                    <span id="invalid3" style="color: red;"> </span>
                                                </div>

                                                <div class="form-group col-md-12" style="
                                                     text-align: center;
                                                     ">
                                                    <label class="control-label">Status</label><br>
                                                    <input  type="radio" name="status" required="" value="1" ${f.active?"checked":""}>Active
                                                    <input  type="radio" name="status" required="" value="0" ${f.active==false?"checked":""}> Inactive
                                                </div>

                                            </div>
                                            <br>
                                            <input class="btn btn-primary" type="submit" value="Save">
                                            <a class="btn btn-danger" data-dismiss="modal" href="FeedbackList">Cancel</a>
                                            <br>
                                        </form>

                                    
                                
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <!-- Scroll Top Button -->
        <a class="btn-scroll-top"><i class="biolife-icon icon-left-arrow"></i></a>
        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
        <script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.12.1/js/dataTables.bootstrap5.min.js"></script>
        <script>
            $(document).ready(function () {
                $("#slidetable").DataTable({bFilter: false, bInfo: false, paging: false});
            });
        </script>
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