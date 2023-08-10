<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>Fintrex - Drop-In Net</title>
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,600" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="files/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="files/icon/feather/css/feather.css">
        <link rel="stylesheet" type="text/css" href="files/css/style_.css">
        <link rel="stylesheet" type="text/css" href="files/css/pages_.css">
        <link rel="stylesheet" type="text/css" href="files/css/waves.min.css">
        <meta name="keywords" content="fintrex,fintrexfinance,finance,cms">
        <meta name="author" content="fintrexIT">
        <link rel="icon" href="files/images/favicon.ico" type="images/x-icon">
    </head>
    <body class="" style="background-color: #42a5f5;">
        <%@include file="jspf/loader.jspf" %>
        <section class="login-block">

            <div class="container-fluid">
                <div class="row">
                    <div class="col-sm-12">
                        <form class="md-float-material form-material">
                            <div class="text-center">
                                <img src="files/images/fintrex-din-purple.png" width="300" alt="logo.png">
                            </div>
                            <div class="auth-box card">
                                <div class="card-block">

                                    <div class="row m-b-20">
                                        <div class="col-md-12">
                                            <h3 class="text-center text-danger">**UAT**</h3>
                                            <h3 class="text-center txt-primary">Sign In</h3>
                                        </div>
                                    </div>

                                    <p class="text-muted text-center p-b-5">Sign in with your Computer Login</p>
                                    <div id="altarea"></div>
                                    <div class="form-group form-primary">
                                        <input type="text" id="username" name="user-name" class="form-control" required="">
                                        <span class="form-bar"></span>
                                        <label class="float-label">Username</label>
                                    </div>
                                    <div class="form-group form-primary">
                                        <input type="password" id="password" name="password" class="form-control" required="">
                                        <span class="form-bar"></span>
                                        <label class="float-label">Password</label>
                                    </div>

                                    <div class="row m-t-30">
                                        <div class="col-md-12">
                                            <button type="button" id="loginbtn" class="btn btn-primary btn-md btn-block waves-effect text-center m-b-20">LOGIN</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

        </section>
        <script type="text/javascript" src="files/jquery/js/jquery.min.js"></script>
        <script type="text/javascript" src="files/js/popper.min.js"></script>
        <script type="text/javascript" src="files/bootstrap/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="files/js/jquery.slimscroll.js"></script>
        <script src="files/js/waves.min.js" defer=""></script>
        <script src="files/js/common-pages.js" defer=""></script>
        <script>

            function loadDiv(card) {
                var $this = $(card);
                $this.addClass("div-load");
                $this.append('<div class="div-loader"><i class="loader2"></div>');
            }

            function finishLoadDiv(card) {
                var $this = $(card);
                $this.children(".div-loader").remove();
                $this.removeClass("div-load");
            }

            $('#loginbtn').click(function () {

                if ($(this).text() !== 'LOGIN') {
                    return;
                }

                $('#altarea').html('');
                loadDiv($('#card-block').parents('.card-block'));
                $(this).html('<i class="feather icon-radio rotate-refresh"></i>');
                $.post('login', {username: $('#username').val(), password: $('#password').val()}, function (data) {
                    // var data = JSON.parse(res);
                    if (data === "ok") {
                        window.location.href = '/dropinnet/';
                    } else if (data === "locked") {
                        var alttemp = '<div class="alert alert-danger alert-dismissible">' +
                                '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>' +
                                '<strong></strong> Your Account is Locked !, Please Contact IT Department' +
                                '</div>';
                        $('#altarea').append(alttemp);
                    } else {
                        var alttemp = '<div class="alert alert-danger alert-dismissible">' +
                                '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>' +
                                '<strong>Error!</strong> Invalid Username or Password' +
                                '</div>';
                        $('#altarea').append(alttemp);
                    }
                    $('#loginbtn').html('LOGIN');
                }).fail(function () {
                    var alttemp = '<div class="alert alert-danger alert-dismissible">' +
                            '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>' +
                            '<strong>Error!</strong> Someting Went Wrong !' +
                            '</div>';
                    $('#altarea').append(alttemp);
                });
            });

            $('#password').on('keypress', function (e) {
                if (e.which === 13) {
                    $('#loginbtn').click();
                }
            });
        </script>
    </body>
</html>
