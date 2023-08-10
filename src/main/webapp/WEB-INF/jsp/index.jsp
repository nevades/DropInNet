<%-- 
    Document   : index
    Created on : Jan 14, 2023, 11:35:13 AM
    Author     : Thisara Dilshan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Fintrex - DropinNet </title>
        <%@include file="jspf/header.jspf" %>
    </head>
    <body>
        <style>
            body {
                margin: 0;
                padding: 0;
                overflow: hidden;
                background-color: #32312B;
            }

            .container {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                user-select: none;
            }

            .container .slide {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                width: 250px;
                height: 250px;
                border-radius: 50%;
                overflow: hidden;
                transition: all 300ms ease-in-out;
                z-index: -1;
                opacity: 0;
                background-color: #201F15;
            }

            .slide img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .slide.active {
                opacity: 1;
                z-index: 99;
                box-shadow: 0px 0px 105px -35px rgba(0, 0, 0, 0.75);
            }

            .slide.prev {
                z-index: 2;
                opacity: 0.25;
                transform: translate(-125%, -50%);
            }

            .slide.next {
                z-index: 2;
                opacity: 0.25;
                transform: translate(25%, -50%);
            }

            .container .button-container {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                width: 275px;
                z-index: 100;
            }

            .button-container .button {
                color: #fff;
                font-size: 32px;
                cursor: pointer;
                position: relative;
                opacity: 0.75;
                transition: all 300ms ease-in-out;
            }

            .button-container .button:hover {
                opacity: 1;
            }

            .button-container .button:before {
                content: "";
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%,-50%);
                width: 50px;
                height: 50px;
                background-color: rgba(0, 0, 0, 1);
                border-radius: 50%;
                z-index: -99;
            }

            .button-container .button:nth-child(1) {
                float: left;
            }

            .button-container .button:nth-child(2) {
                float: right;
            }
        </style>
        <%@include file="jspf/loader.jspf" %>
        <div id="pcoded" class="pcoded">
            <div class="pcoded-overlay-box"></div>
            <div class="pcoded-container navbar-wrapper">
                <%@include file="jspf/navbar.jspf" %>
                <div class="pcoded-main-container">
                    <div class="pcoded-wrapper">
                        <%@include file="jspf/sidenav.jspf" %>
                        <div class="pcoded-content">
                            <div class="pcoded-inner-content">
                                <div class="main-body">
                                    <div class="page-wrapper">
                                        <div class="page-body">
                                            <div class="container" style="margin-top: 250px;">
                                                <div class="slide active">
                                                    <img src="files/images/logo.png">
                                                </div>
                                                <div class="slide next"><h3 class="card-title">New Ticket</h3>
                                                    <div class="card-content " class="btn btn-primary" style="cursor: pointer; height: 92px; text-align: center">
                                                        <img id="new_ticket" src="./files/images/ticket.png" style="width: 150px">
                                                    </div>
                                                    <!--                                                    <img src="images/logo.png">-->
                                                </div>
                                                <div class="slide">
                                                    <img src="images/logo.png">
                                                </div>
                                                <div class="slide">
                                                    <img src="images/logo.png">
                                                </div>
                                                <div class="slide prev">
                                                    <img src="images/logo.png">
                                                </div>
                                                <div class="button-container">
                                                    <div class="button" id="left"><i class="fas fa-angle-left"></i></div>
                                                    <div class="button" id="right"><i class="fas fa-angle-right"></i></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="jspf/scripts.jspf" %>
        <script type="text/javascript" src="files/js/slimselect.js"></script>
        <script type="text/javascript" src="files/js/datatables.min.js"></script>
        <script type="text/javascript" src="files/js/sweetalert2.js"></script>
        <script type="text/javascript" src="files/js/func.js"></script>
        <script type="text/javascript" src="files/js/autoNumeric.js"></script>
        <script type="text/javascript" src="files/js/dataTables.responsive.min.js"></script>
        <script>
            const slider = document.querySelector('.container');
            const container = document.querySelectorAll('.slide');

            document.getElementById('left').addEventListener('click', function () {
                toPrevious();
            });

            document.getElementById('right').addEventListener('click', function () {
                toNext();
            });

            let current = 0;
            let prev = 4;
            let next = 1;

            const toPrevious = () => {
                console.log('prev');
                if (current > 0) {
                    toSlide(current - 1);
                } else {
                    toSlide(container.length - 1);
                }
            };

            const toNext = () => {
                if (current < 4) {
                    toSlide(current + 1);
                } else {
                    toSlide(0);
                }
            };

            const toSlide = (number) => {
                current = number;
                prev = current - 1;
                next = current + 1;

                for (let i = 0; i < container.length; i++) {
                    container[i].classList.remove('active');
                    container[i].classList.remove('prev');
                    container[i].classList.remove('next');
                }

                if (next == 5) {
                    next = 0;
                }

                if (prev == -1) {
                    prev = 4;
                }

                container[current].classList.add('active');
                container[prev].classList.add('prev');
                container[next].classList.add('next');
            };
        </script>
    </body>
</html>
