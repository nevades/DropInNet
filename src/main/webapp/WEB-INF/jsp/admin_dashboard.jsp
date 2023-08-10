<%-- 
    Document   : admin_dashboard
    Created on : Mar 14, 2023, 4:51:01 PM
    Author     : Akash
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
            /*            * {
                            box-sizing: border-box;
            
                        }*/
            .pcoded .pcoded-inner-content {
                padding: 20px;
            }
            .zoom {
                padding-top: 10px;
                transition: transform .2s;
                margin: 0 auto;
                box-sizing: border-box;
                box-shadow: 0 0 5px 0 rgba(43, 43, 43, .1), 0 11px 6px -7px rgba(43, 43, 43, .1);

            }

            .zoom:hover {
                -ms-transform: scale(0.3); /* IE 9 */
                -webkit-transform: scale(0.3); /* Safari 3-8 */
                transform: scale(1.1);
                box-shadow: 0 4px 15px 0 rgba(65, 132, 234, 0.75);
            }
            .dataTable tr {
                padding-top: 10px;
                transition: transform .5s;
                margin: 0 auto;
                box-sizing: border-box;
                /*box-shadow: 0 0 5px 0 rgba(43, 43, 43, .1), 0 11px 6px -7px rgba(43, 43, 43, .1);*/

            }

            .dataTable tr:hover {
                -ms-transform: scale(0.1); /* IE 9 */
                -webkit-transform: scale(0.1); /* Safari 3-8 */
                transform: scale(0.99);
                /*box-shadow: 0 4px 15px 0 rgba(65, 132, 234, 0.75);*/
            }

            .box {
                height: 60px;


                background-image: linear-gradient(
                    to right,
                    transparent 5%,
                    rgba(255,255,255,0.5) 50%,
                    transparent 66%
                    );
                background-size:2000% 20%;
                animation: shine 4s infinite;
            }

            @keyframes shine {
                0% {
                    background-position: right;
                }
                /*100% {
                  background-position: left; it's the default value, no need to define it
                }*/
            }

            .row{
                margin-right: -10px;
                margin-left: -10px;
            }
        </style>
        <style>

            /*            .modal:nth-of-type(even) {
                            z-index: 1052 !important;
                        }
                        .modal-backdrop.show:nth-of-type(even) {
                            z-index: 1051 !important;
                        }
                        .dataTable.table td {
                            padding: 0.3rem !important;
                        }
                        .modal-lg {
                            max-width: 98% !important;
                        }
                        .table.table-sm td, .table.table-sm th {
                            padding: .2rem 0.2rem;
                        }
            
                        .modal-mxl{
                            max-width:50% !important;
                        }
                        .modal {
                            overflow-y:auto;
                        }
                        #searchBox{
                            width: 200px !important;
                        }
                        .form-control-xs{
                            height: 25px;
                        }*/



            /*
            */
            #all_tickets .dataTable {
                border-spacing: 0.55rem 0.55rem !important;
            }

            #all_tickets .dataTable .dropdown {
                display: inline-block;
            }

            #all_tickets .dataTable td,
            #all_tickets .dataTable th {
                vertical-align: middle;
                margin-bottom: 10px;
                border: none;
                background:  #fff;
            }


            #all_tickets .dataTable   {

                border-top-left-radius: 10px;
                border-top-right-radius:  10px;
                border: none;
                background:  #f2f4f5;
            }

            #all_tickets .dataTable td:first-child {
                border-top-left-radius: 10px;
                border-bottom-left-radius: 10px;

            }

            #all_tickets .dataTable td:last-child {
                border-top-right-radius: 10px;
                border-bottom-right-radius: 10px;
            }

            #all_tickets .dataTable td   {
                background: #ffffff;
                cursor: pointer;

            }

            #all_tickets .dataTable  td:nth-child(2){
                border-top-left-radius: 10px;
                border-bottom-left-radius: 10px;

            }

            #all_tickets .dataTable th:first-child   {
                border-top-left-radius: 10px;
                border-bottom-left-radius: 10px;
            }

            #all_tickets .dataTable th:last-child {
                border-top-right-radius: 10px;
                border-bottom-right-radius: 10px;
            }

            #all_tickets table.dataTable.dtr-inline.collapsed
            > tbody
            > tr[role="row"]
            > td:first-child:before,
            table.dataTable.dtr-inline.collapsed
            > tbody
            > tr[role="row"]
            > th:first-child:before {
                top: 28px;
                left: 14px;
                border: none;
                box-shadow: none;
            }

            #all_tickets table.dataTable.dtr-inline.collapsed > tbody > tr[role="row"] > td:first-child,
            #all_tickets table.dataTable.dtr-inline.collapsed > tbody > tr[role="row"] > th:first-child {
                padding-left: 48px;
            }

            #all_tickets table.dataTable > tbody > tr.child ul.dtr-details {
                width: 100%;
            }

            #all_tickets table.dataTable > tbody > tr.child span.dtr-title {
                min-width: 50%;
            }

            #all_tickets table.dataTable.dtr-inline.collapsed > tbody > tr > td.child,
            #all_tickets table.dataTable.dtr-inline.collapsed > tbody > tr > th.child,
            #all_tickets table.dataTable.dtr-inline.collapsed > tbody > tr > td.dataTables_empty {
                padding: 0.75rem 1rem 0.125rem;
            }

            #all_tickets div.dataTables_wrapper div.dataTables_length label,
            #all_tickets div.dataTables_wrapper div.dataTables_filter label {
                margin-bottom: 0;
            }
            .single-table{

                padding:10px;
            }

            @media (max-width: 767px) {
                div.dataTables_wrapper div.dataTables_paginate ul.pagination {
                    -ms-flex-pack: center !important;
                    justify-content: center !important;
                    margin-top: 1rem;
                }
            }

            /*            .dataTable th {
                            display: none;
                        }*/

            .dataTable td:first-child   {
                display: none;
            }
            .card-dashboard:hover{
                transform: scale(1.02);
                box-shadow: 0 20px 30px rgba(62, 173, 230,.30), 0 4px 8px rgba(62, 173, 230,.06);
                cursor: pointer;
            }
            .card-dashboard.selected{
                background-color: #71b2eb;
            }

            :root {
                --shadow-white: white;
                --shadow-gray: #c8d0e7;
                --bg-gray: #fff;
                --text-purple: #4b7acc;
            }

            .tabs {
                width: 100%;

            }

            .tabs .tabs--nav {
                position: relative;
                display: inline-flex;
                align-items: center;
                padding: 8px;
            }

            .tabs .tabs--nav span {
                padding:  8px;
                display: block;
                transition-delay: 0s;
                transition-duration: 0.5s;
                border-radius: 0.20rem;
                cursor: pointer;
                background: #fff;
            }

            .tabs .tabs--nav span.wait-animation {
                pointer-events: none;
            }

            .tabs .tabs--nav span:not(:first-of-type):not(:last-of-type) {
                margin: 0 10px;
            }

            .tabs .tabs--nav span.active {
                color: var(--text-purple);
                transition-delay: 0.25s;
                transition-duration: 0.5s;


            }

            .tabs .tabs--nav span:not(.active):hover {
                box-shadow: inset 0.15em 0.15em 0.15em var(--shadow-white),
                    inset -0.15em -0.15em 0.15em var(--shadow-gray),
                    0.3rem 0.3rem 0.6rem var(--shadow-gray),
                    -0.3rem -0rem 0.6rem var(--shadow-white);
                box-shadow: inset 0.1rem 0.1rem 0.3rem var(--shadow-gray),
                    inset -0.2rem -0.2rem 0.5rem var(--shadow-white);
            }

            .tabs .tabs--nav .tabs--fx {
                position: absolute;
                box-shadow: inset 0.2rem 0.2rem 0.5rem var(--shadow-gray),
                    inset -0.2rem -0.2rem 0.5rem var(--shadow-white);
                box-shadow: inset 0.10em 0.10em 0.10em var(--shadow-white),
                    inset -0.10em -0.10em 0.10em var(--shadow-gray),
                    0.2rem 0.2rem 0.3rem var(--shadow-gray),
                    -0.2rem -0rem 0.2rem var(--shadow-white);
                border-radius: 0.25rem;
                opacity: 0;
            }


            .tabs .tabs--content h2 {
                color: var(--text-purple);
            }

            .font{
                color: #828282;
            }


            .swal2-container {
                z-index: 1000000;
            }
            .modal {
                z-index: 10000;
            }
            #tct_detail td, #tct_detail .table.table-sm th {
                padding: 10px 0px 10px 10px !important;
            }
            .badge {
                font-size: 75%;
                padding: 4px 7px;
                margin-right: 5px;
                font-weight: 400;
            }
            .badge-purple {
                background: #6f42c1;
            }
            .modal-lg {
                max-width: 1200px;
            }
            .new-label-box {
                margin-top: -6px !important;
                width: 11%;
                font-size: 14px;
                text-align: left;
            }
            .new-label{
                margin-top: 0px !important;
                /*width: 11%;*/
                font-size: 12px;
                text-align: left;
            }

            #comment_modal {
                z-index: 1000000;
            }

            .rate {
                float: left;
                height: 46px;
                padding: 0 10px;
            }
            .rate:not(:checked) > input {
                position:absolute;
                top:-9999px;
            }
            .rate:not(:checked) > label {
                float:right;
                width:1em;
                overflow:hidden;
                white-space:nowrap;
                cursor:pointer;
                font-size:30px;
                color:#ccc;
            }
            .rate:not(:checked) > label:before {
                content: '★ ';
            }
            .rate > input:checked ~ label {
                color: #ffc700;
            }
            .rate:not(:checked) ,
            .rate:not(:checked) ~ label {
                color: #deb217;
            }
            .rate > input:checked ,
            .rate > input:checked  ~ label,
            .rate > input:checked ,
            .rate > input:checked  ~ label,
            .rate > input:checked ~ label {
                color: #c59b08;
            }

            .date{
                font-size: 12px
            }
            .comment-text{
                font-size: 13px
            }
            .fs-12{
                font-size: 13px
            }
            .shadow-none{
                box-shadow: none
            }
            .name{
                color: #007bff
            }
            .cursor:hover{
                color: blue
            }
            .cursor{
                cursor: pointer
            }
            .textarea{
                resize: none
            }
            .second{
                width: 100%;
                background-color: white;
                border-radius: 4px;
                box-shadow: 2px 2px 1px #aaaaaa;
            }
            /*css table*/

            :root {
                /* =====>>  Font Color  <<===== */
                --f1-color: #fff;
                --f2-color: #000;
                --f3-color: rgba(0, 0, 0, 0.8);
                --f4-color: rgba(0, 0, 0, 0.6);
                --f5-color: #0099cc;
                --f6-color: #88cee6;

                /* =====>>  Background Color  <<===== */
                --bg1-color: #fff;
                --bg2-color: #000;
                --bg3-color: #33ccff;
                --bg4-color: #33cc33;
                --bg5-color: #0099cc;
                --bg6-color: rgba(0, 0, 0, 0.4);
                --bg7-color: rgba(0, 0, 0, 0.2);
                --glass-bg: linear-gradient(
                    to right bottom,
                    rgba(255, 255, 255, 0.5),
                    rgba(255, 255, 255, 0.3)
                    );
                --C-lg-bg: linear-gradient(45deg, #ff3399, #ff9933);

                /* ===== =====>>  Font Size  <<===== =====  */
                --xxxl-fs: 2.2rem;
                --xxl-fs: 1.8rem;
                --xl-fs: 1.6rem;
                --l-fs: 1.4rem;
                --m-fs: 1.2rem;
                --s-fs: 1.1rem;
                --xs-fs: 1rem;

                /* =====>>  Margin  <<===== */
                --m-2-5: 2.5rem;
                --m-1-8: 1.8rem;
                --m-1-5: 1.5rem;
                --m-0-6: 0.6rem;
                --m-0-5: 0.5rem;
                --m-0-3: 0.3rem;

                /* =====>>  Padding  <<===== */
                --p-2-5: 2.5rem;
                --p-1-5: 1.5rem;
                --p-1-0: 1rem;
                --p-0-8: 0.8rem;
                --p-0-5: 0.5rem;
                --p-0-4: 0.4rem;
                --p-0-3: 0.3rem;
            }

            /* ===== =====>>  Body Css  <<===== =====  */
            #myTabContent {
                display: block;
                /*                justify-content: center;*/
                min-height: 100vh;
                background-color: lavender;
                background: url(files/images/bg.jpg);
            }

            /* ===== =====>>  Body Main-Background Css  <<===== =====  */
            .main_bg {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: url(files/images/bg.jpg);
                background-position: left;
                z-index: -1;
                filter: blur(10px);
            }

            /* ===== =====>>  Main-Container Css  <<===== =====  */
            .container1 {
                position: relative;
                /*display: grid;*/
                backdrop-filter: blur(3rem);
                grid-template-columns: 2fr 1fr;
                grid-template-areas:
                    "header header"
                    "userProfile userDetails"
                    "work_skills timeline_about"
                    "work_skills timeline_about";
                width: 100%;
                height: auto;
                border-radius: 10px;
                background: url(files/images/bg.jpg);
                /*background: lavender;*/
                padding: 10px;
                box-shadow: 0 0 5px rgba(255, 255, 255, 0.5), 0 0 25px rgba(0, 0, 0, 0.08);
            }

            /* ===== =====>>  Container Cards Grid-Area Css Start  <<===== =====  */
            header {
                grid-area: header;
            }

            .userProfile {
                grid-area: userProfile;
            }

            .work_skills {
                grid-area: work_skills;
            }

            /*            .userDetails {
                            grid-area: userDetails;
                        }*/

            .timeline_about {
                grid-area: timeline_about;
            }

            /* ===== =====>>  Container Cards Css  <<===== =====  */
            .container1 .card {
                background: var(--glass-bg);
                border-radius: 0.5rem;
                /*border-radius: 20px;*/
                box-shadow: 0 0 25px rgba(0, 0, 0, 0.05);
                padding: 20px;
                /*margin: 20px;*/
            }

            /* ===== =====>>  Container Header/Navbar Css  <<===== =====  */
            .container1 header {
                padding: 0 var(--p-2-5);
            }

            .container1 header .brandLogo {
                /*display: flex;*/
                /*                align-items: center;*/
            }

            .container1 header .brandLogo figure img {
                width: 3.5rem;
                height: 3.5rem;
            }

            .container1 header .brandLogo span {
                font-size: var(--xl-fs);
                font-weight: 700;
                margin-left: var(--m-0-5);
            }

            /* ===== =====>>  User Main-Profile Css Start  <<===== ===== */
            .container1 .userProfile {
                position: relative;
                display: flex;
                /*                justify-content: center;
                                align-items: center;*/
                padding: 0;
                background: none;
                backdrop-filter: none;
                box-shadow: none;
            }

            .container1 .userProfile .profile figure img {
                width: 18rem;
                height: 18rem;
                border-radius: 50%;
            }

            /* ===== =====>>  Work & Skills Css Start  <<===== ===== */
            .container1 .work_skills {
                padding: var(--p-1-5);
            }

            .work_skills .work .heading,
            .timeline_about .heading,
            .work_skills .skills .heading {
                position: relative;
                font-size: var(--xs-fs);
                color: rgba(0, 0, 0, 0.6);
                text-transform: uppercase;
                margin-bottom: var(--m-1-5);
            }

            .work_skills .work .heading::before,
            .work_skills .skills .heading::before ,
            .timeline_about .heading::before {
                content: "";
                position: absolute;
                bottom: 0;
                right: 0;
                height: 0.1rem;
                width: 84%;
                background: var(--bg6-color);
            }

            .work_skills .work .primary,
            .work_skills .work .secondary {
                position: relative;
            }

            .work_skills .work .primary h1,
            .work_skills .work .secondary h1 {
                font-size: var(--l-fs);
                color: var(--f3-color);
                margin-bottom: var(--m-0-6);
            }

            .work_skills .work .primary span,
            .work_skills .work .secondary span {
                position: absolute;
                top: 0;
                right: 3rem;
                font-weight: 700;
                font-size: var(--s-fs);
                color: var(--f5-color);
                background: #e6f2ff;
                padding: var(--p-0-4) var(--p-1-0);
                border-radius: 0.4rem;
            }

            .work_skills .work .primary p,
            .work_skills .work .secondary p {
                margin-bottom: var(--m-1-8);
                font-size: var(--m-fs);
                color: rgba(0, 0, 0, 0.6);
                line-height: 1.6rem;
            }

            /* =====>>  Skills Bars Css  <<===== */
            .work_skills .skills ul li {
                position: relative;
                font-size: var(--m-fs);
                line-height: 1.8rem;
                margin: var(--m-0-5);
                color: var(--f2-color);
                font-weight: 500;
            }

            .work_skills .skills ul li::before {
                content: "";
                position: absolute;
                top: 0;
                bottom: 0;
                right: 0;
                margin: auto;
                height: 0.2rem;
                background: var(--bg3-color);
                animation: skills 8s linear infinite;
                animation-delay: calc(-2s * var(--i));
            }

            @keyframes skills {
                0% {
                    width: 50%;
                    filter: hue-rotate(180deg);
                }

                50% {
                    width: 0;
                }

                100% {
                    width: 50%;
                    filter: hue-rotate(0);
                }
            }

            /* ===== =====>>  User Details Css Start  <<===== ===== */
            .userDetails {
                position: relative;
                padding: var(--p-1-5) var(--p-2-5);
            }

            .userDetails .userName h1 {
                font-size: var(--xxxl-fs);
            }

            .userDetails .userName .map {
                position: absolute;
                top: 2.5rem;
                left: 18.5rem;
                display: flex;
                /*justify-content: center;*/
                /*align-items: center;*/
            }

            .userDetails .userName .map .ri {
                margin-right: var(--m-0-3);
                font-size: var(--m-fs);
            }

            .userDetails .userName .map span {
                font-size: var(--s-fs);
                color: var(--f3-color);
                font-weight: 700;
            }

            .userDetails .userName p {
                font-size: var(--m-fs);
                font-weight: 700;
                color: var(--f5-color);
                margin-bottom: var(--m-1-8);
            }

            .userDetails .rank {
                position: relative;
                margin-bottom: var(--m-1-8);
            }

            .userDetails .rank .heading {
                font-size: var(--xs-fs);
                color: var(--f4-color);
                text-transform: uppercase;
                margin-bottom: var(--m-0-6);
            }

            .userDetails .rank span {
                font-size: var(--xxl-fs);
                font-weight: 700;
            }

            .userDetails .rank .rating {
                position: absolute;
                top: 2.7rem;
                left: 3.5rem;
            }

            .userDetails .rank .rating .rate {
                color: var(--f5-color);
                font-size: var(--l-fs);
            }

            .userDetails .rank .rating .underrate {
                color: var(--f6-color);
            }

            .userDetails .btns ul,
            .userDetails .btns ul li {
                display: flex;
                /*align-items: center;*/
            }

            .userDetails .btns ul li {
                margin-right: var(--m-2-5);
                border-radius: 0.5rem;
            }

            .userDetails .btns ul li .ri {
                margin-right: var(--m-0-5);
                font-size: var(--xl-fs);
            }

            .userDetails .btns ul li a {
                font-size: var(--l-fs);
                color: var(--f2-color);
                font-weight: 500;
            }

            .userDetails .btns ul .active {
                background: #e6f2ff;
                padding: var(--p-0-5) var(--p-1-5);
            }

            .userDetails .btns ul .active a,
            .userDetails .btns ul .active .ri {
                color: var(--f5-color);
            }

            /* ===== =====>>  Timeline & About Css Start  <<===== ===== */
            .timeline_about {
                padding: 10px;
            }

            .timeline_about .tabs ul {
                position: relative;
                display: flex;
                /*align-items: center;*/
                margin-bottom: var(--m-2-5);
            }

            .timeline_about .tabs ul::before {
                content: "";
                position: absolute;
                bottom: 0;
                right: 0;
                width: 100%;
                height: 1px;
                background: var(--bg7-color);
            }

            .timeline_about .tabs ul li {
                position: relative;
                display: flex;
                /*align-items: center;*/
                margin-right: var(--m-2-5);
                padding-bottom: var(--p-0-8);
                cursor: pointer;
            }

            .timeline_about .tabs ul li span {
                font-size: var(--l-fs);
                font-weight: 500;
            }

            .timeline_about .tabs ul li .ri {
                margin-right: var(--m-0-5);
            }

            .timeline_about .tabs ul .active::before {
                content: "";
                position: absolute;
                bottom: 0;
                width: 100%;
                height: 2px;
                background: var(--bg5-color);
            }

            .timeline_about .contact_info .heading,
            .timeline_about .basic_info .heading {
                font-size: var(--xs-fs);
                color: var(--f4-color);
                text-transform: uppercase;
                margin-bottom: var(--m-1-5);
            }

            .timeline_about .contact_info ul,
            .timeline_about .basic_info ul {
                margin-bottom: var(--m-1-5);
            }

            .timeline_about .contact_info ul li,
            .timeline_about .basic_info ul li {
                display: flex;
                margin: var(--m-0-5) 0;
            }

            .timeline_about .contact_info ul li h1,
            .timeline_about .basic_info ul li h1 {
                font-weight: 500;
                font-size: var(--m-fs);
                min-width: 12rem;
            }

            .timeline_about .contact_info ul li span,
            .timeline_about .basic_info ul li span {
                font-size: var(--m-fs);
            }

            .timeline_about .contact_info ul .phone span,
            .timeline_about .contact_info ul .email span,
            .timeline_about .contact_info ul .site span {
                color: var(--f5-color);
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


                                            <div class="row" style="margin-left: 10px;">

                                                <div class="col-md-auto" style="width: 14%">
                                                    <div class="card  radiodiv card-dashboard zoom selected"  id="queued_card" style="" selected>
                                                        <div class="row ">
                                                            <div class="col-12" style="text-align: center">
                                                                <span style="font-size: 13px;font-weight: 600;color: #4e597d"><i class="fa fa-money fa-flip" style="color:#4e597d;--fa-animation-duration: 3s;"> </i> Queued Tickets</span>
                                                            </div>
                                                        </div>    
                                                        <div class="row">

                                                            <div class="col-12" style="text-align: center;">
                                                                <h2 style=" font-size: 20px;font-weight: 600; color: #4e597d;background-color: #f0f0f0 "><span id="queued_card_all"></span></h2> 
                                                            </div>
                                                        </div>    
                                                        <table style="height: 25px">
                                                            <tbody><tr>
                                                                    <td style="text-align: center">
                                                                        <p style="font-size: 11px;color: #4e597d;">   
                                                                            <i class="fa fa-windows" style="color: #6666ff "></i><i class="fa fa-caret-right     "></i>  <span id="queued_card_ap" style=" font-weight: 600 ">0</span> 
                                                                        </p>
                                                                    </td>
                                                                    <td style="text-align: center">
                                                                        <p style="font-size: 11px;color: #4e597d;">   
                                                                            <i class="fa fa-desktop" style="color: #6666ff"></i><i class="fa fa-caret-right      "></i>   <span id="queued_card_hw" style=" font-weight: 600 ">0</span> 
                                                                        </p>
                                                                    </td>
                                                                    <td style="text-align: center">
                                                                        <p style="font-size: 11px;color: #4e597d;">   
                                                                            <i class="fa fa-user-plus " style="color: #9999ff"></i> <i class="fa fa-caret-right      "></i> <span id="queued_card_hr" style="font-weight: 600 ">0</span> 
                                                                        </p>
                                                                    </td>
                                                                </tr>
                                                            </tbody></table>
                                                    </div>
                                                </div>

                                                <div class="col-md-auto " style="width: 14%">
                                                    <div class="card radiodiv card-dashboard zoom"  id="inprogress_card">
                                                        <div class="row">
                                                            <div class="col-12" style="text-align: center">
                                                                <span style="font-size: 13px;font-weight: 600;color: #4e597d"><i style="color:#4e597d;  --fa-bounce-start-scale-x: 1; --fa-bounce-start-scale-y: 1; --fa-bounce-jump-scale-x: 1; --fa-bounce-jump-scale-y: 1; --fa-bounce-land-scale-x: 1; --fa-bounce-land-scale-y: 1; --fa-bounce-rebound: 0;--fa-animation-duration: 3s; " class="fa fa-first-order fa-bounce"></i> In Progress Tickets</span>
                                                            </div>
                                                        </div>    
                                                        <div class="row">

                                                            <div class="col-12" style="text-align: center;">
                                                                <h2 style=" font-size: 20px;font-weight: 600; color: #4e597d;background-color: #f0f0f0 "><span id="inprogress_card_all">0</span></h2> 
                                                            </div>
                                                        </div>    
                                                        <table style="height: 25px">
                                                            <tbody><tr>
                                                                    <td style="text-align: center">
                                                                        <p style="font-size: 11px;color: #4e597d;">   
                                                                            <i class="fa fa-windows     " style="color: #6666ff "></i>   <i class="fa fa-caret-right     "></i>  <span id="inprogress_card_ap" style=" font-weight: 600 ">0</span> 
                                                                        </p>
                                                                    </td>
                                                                    <td style="text-align: center">
                                                                        <p style="font-size: 11px;color: #4e597d;">   
                                                                            <i class="fa fa-desktop " style="color: #6666ff"></i>   <i class="fa fa-caret-right      "></i>   <span id="inprogress_card_hw" style=" font-weight: 600 ">0</span> 
                                                                        </p>
                                                                    </td>
                                                                    <td style="text-align: center">
                                                                        <p style="font-size: 11px;color: #4e597d;">   
                                                                            <i class="fa fa-user-plus" style="color: #9999ff"></i> <i class="fa fa-caret-right      "></i> <span id="inprogress_card_hr" style="font-weight: 600 ">0</span> 
                                                                        </p>
                                                                    </td>
                                                                </tr>
                                                            </tbody></table>
                                                    </div>
                                                </div>
                                                <div class="col-md-auto " style="width: 14%">
                                                    <div class="card radiodiv card-dashboard zoom"  id="development_card">
                                                        <div class="row">
                                                            <div class="col-12" style="text-align: center">
                                                                <span style="font-size: 13px;font-weight: 600;color: #4e597d"><i style="color:#4e597d;  --fa-bounce-start-scale-x: 1; --fa-bounce-start-scale-y: 1; --fa-bounce-jump-scale-x: 1; --fa-bounce-jump-scale-y: 1; --fa-bounce-land-scale-x: 1; --fa-bounce-land-scale-y: 1; --fa-bounce-rebound: 0;--fa-animation-duration: 3s; " class="fa fa-wrench fa-bounce"></i>Development Pending</span>
                                                            </div>
                                                        </div>    
                                                        <div class="row">

                                                            <div class="col-12" style="text-align: center;">
                                                                <h2 style=" font-size: 20px;font-weight: 600; color: #4e597d;background-color: #f0f0f0 "><span id="development_card_all">0</span></h2> 
                                                            </div>
                                                        </div>    
                                                        <table style="height: 25px">
                                                            <tr>
                                                                <td style="text-align: center" id="development_card" class="card-dashboard">
                                                                    <p style="font-size: 11px;color: #4e597d;"  >   
                                                                        <span class="" style="color: #6666ff; font-weight: 600 ">Core </span>   <i class="fa fa-caret-right     "   ></i>  <span   id="development_card_core" style=" font-weight: 600 ">0</span> 
                                                                    </p>
                                                                </td>

                                                                <td style="text-align: center" id="intl_development_card" class="card-dashboard">
                                                                    <p style="font-size: 11px;color: #4e597d;"  >   
                                                                        <span class="" style="color: #6666ff; font-weight: 600 ">Internal </span> <i class="fa fa-caret-right      "   ></i> <span   id="development_card_intnl"style="font-weight: 600 " >0</span> 
                                                                    </p>
                                                                </td>
                                                            <a href="dashboard.jsp"></a>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </div>

                                                <div class="col-md-auto " style="width: 14%">
                                                    <div class="card radiodiv card-dashboard zoom"  id="finish_card">
                                                        <div class="row">
                                                            <div class="col-12" style="text-align: center">
                                                                <span style="font-size: 13px;font-weight: 600;color: #4e597d"><i  class="fa fa-check-circle fa-flip" style="color:#4e597d;--fa-animation-duration: 3s;--fa-flip-x: 1; --fa-flip-y: 0; "></i> Finished Tickets</span>

                                                            </div>
                                                        </div>    
                                                        <div class="row">
                                                            <div class="col-12" style="text-align: center;">
                                                                <h2 style=" font-size: 20px;font-weight: 600; color: #5f6f96;background-color: #f0f0f0"><span id="finish_card_all">0</span></h2>
                                                            </div>
                                                        </div>    
                                                        <table style="height: 25px">
                                                            <tbody><tr>
                                                                    <td style="text-align: center">
                                                                        <p style="font-size: 11px;color: #4e597d;">   
                                                                            <i class="fa fa-windows     " style="color: #6666ff "></i>   <i class="fa fa-caret-right     "></i>  <span id="finish_card_ap" style=" font-weight: 600 ">0</span> 
                                                                        </p>
                                                                    </td>
                                                                    <td style="text-align: center">
                                                                        <p style="font-size: 11px;color: #4e597d;">   
                                                                            <i class="fa fa-desktop " style="color: #6666ff"></i>   <i class="fa fa-caret-right      "></i>   <span id="finish_card_hw" style=" font-weight: 600 ">0</span> 
                                                                        </p>
                                                                    </td>
                                                                    <td style="text-align: center">
                                                                        <p style="font-size: 11px;color: #4e597d;">   
                                                                            <i class="fa fa-user-plus" style="color: #9999ff"></i> <i class="fa fa-caret-right      "></i> <span id="finish_card_hr" style="font-weight: 600 ">0</span> 
                                                                        </p>
                                                                    </td>
                                                                </tr>
                                                            </tbody></table>
                                                    </div>
                                                </div>

                                                <div class="col-md-auto " style="width: 14%">
                                                    <div class="card radiodiv card-dashboard zoom"  id="closed_card">
                                                        <div class="row">
                                                            <div class="col-12" style="text-align: center">
                                                                <span style="font-size: 13px;font-weight: 600;color: #4e597d"><i style="color:#4e597d " class="fa fa-close fa-beat-fade" style="--fa-beat-fade-opacity: 0.1; --fa-beat-fade-scale: 1.25;--fa-animation-duration: 3s;" ></i> Closed Tickets</span>

                                                            </div>
                                                        </div>    
                                                        <div class="row">
                                                            <div class="col-12" style="text-align: center;">
                                                                <h2 style=" font-size: 20px;font-weight: 600; color: #5f6f96;background-color: #f0f0f0"><span id="closed_card_all">0</span></h2>
                                                            </div>
                                                        </div>    
                                                        <table style="height: 25px">
                                                            <tbody><tr>
                                                                    <td style="text-align: center">
                                                                        <p style="font-size: 11px;color: #4e597d;">   
                                                                            <i class="fa fa-windows     " style="color: #6666ff "></i>   <i class="fa fa-caret-right     "></i>  <span id="closed_card_ap" style=" font-weight: 600 ">0</span> 
                                                                        </p>
                                                                    </td>
                                                                    <td style="text-align: center">
                                                                        <p style="font-size: 11px;color: #4e597d;">   
                                                                            <i class="fa fa-desktop" style="color: #6666ff"></i>   <i class="fa fa-caret-right      "></i>   <span id="closed_card_hw" style=" font-weight: 600 ">0</span> 
                                                                        </p>
                                                                    </td>
                                                                    <td style="text-align: center">
                                                                        <p style="font-size: 11px;color: #4e597d;">   
                                                                            <i class="fa fa-user-plus" style="color: #9999ff"></i> <i class="fa fa-caret-right      "></i> <span id="closed_card_hr" style="font-weight: 600 "></span> 
                                                                        </p>
                                                                    </td>
                                                                </tr>
                                                            </tbody></table>
                                                    </div>
                                                </div>


                                                <div class="col-md-auto " style="width: 14%">
                                                    <div class="card radiodiv card-dashboard zoom"  id="mytickets_card">
                                                        <div class="row">
                                                            <div class="col-12" style="text-align: center">
                                                                <span style="font-size: 13px;font-weight: 600;color: #4e597d"><i style="color:#4e597d " class="fa fa-user-circle fa-shake"></i>  My Tickets</span>
                                                            </div>
                                                        </div>    
                                                        <div class="row">
                                                            <div class="col-12" style="text-align: center;">
                                                                <h2 style=" font-size: 20px;font-weight: 600; color: #5f6f96;background-color: #f0f0f0"><span id="mytickets_card_all">0</span></h2>
                                                            </div>
                                                        </div>    
                                                        <table style="height: 25px">
                                                            <tbody><tr>
                                                                    <td style="text-align: center">
                                                                        <p style="font-size: 11px;color: #4e597d;">   
                                                                            <i class="fa fa-windows     " style="color: #6666ff "></i>   <i class="fa fa-caret-right     "></i>  <span id="mytickets_card_ap" style=" font-weight: 600 ">0</span> 
                                                                        </p>
                                                                    </td>
                                                                    <td style="text-align: center">
                                                                        <p style="font-size: 11px;color: #4e597d;">   
                                                                            <i class="fa fa-desktop" style="color: #6666ff"></i>   <i class="fa fa-caret-right      "></i>   <span id="mytickets_card_hw" style=" font-weight: 600 ">0</span> 
                                                                        </p>
                                                                    </td>
                                                                    <td style="text-align: center">                                           
                                                                    </td>
                                                                </tr>
                                                            </tbody></table>
                                                    </div>
                                                </div>

                                                <div class="col-md-auto " style="width: 14%">
                                                    <div class="card radiodiv card-dashboard zoom"  id="assigned_card">
                                                        <div class="row">
                                                            <div class="col-12" style="text-align: center">
                                                                <span style="font-size: 13px;font-weight: 600;color: #4e597d"><i style="color:#4e597d " class="fa fa-user-plus fa-spin "></i> Assigned Tickets</span>
                                                            </div>
                                                        </div>    
                                                        <div class="row">
                                                            <div class="col-12" style="text-align: center;">
                                                                <h2 style="font-size: 20px; font-weight: 600;  color: #5f6f96;background-color: #f0f0f0"> <span id="assigned_card_all">0</span></h2>                                    
                                                            </div>
                                                        </div>    
                                                        <table style="height: 25px">
                                                            <tbody><tr>
                                                                    <td style="text-align: center">
                                                                        <p style="font-size: 11px;color: #4e597d;">   
                                                                            <i class="fa fa-windows     " style="color: #6666ff "></i>   <i class="fa fa-caret-right     "></i>  <span id="assigned_card_ap" style=" font-weight: 600 ">0</span> 
                                                                        </p>
                                                                    </td>
                                                                    <td style="text-align: center">
                                                                        <p style="font-size: 11px;color: #4e597d;">   
                                                                            <i class="fa fa-desktop " style="color: #6666ff"></i>   <i class="fa fa-caret-right      "></i>   <span id="assigned_card_hw" style=" font-weight: 600 ">0</span> 
                                                                        </p>
                                                                    </td>
                                                                    <td style="text-align: center">
                                                                        <p style="font-size: 11px;color: #4e597d;">   
                                                                            <i class="fa fa-desktop " style="color: #6666ff"></i>   <i class="fa fa-caret-right      "></i>   <span id="assigned_card_hr" style=" font-weight: 600 ">0</span> 
                                                                        </p>
                                                                    </td>
                                                                   
                                                                </tr>
                                                            </tbody></table>
                                                    </div>
                                                </div>                      
                                            </div>

                                            <br>

                                            <div id="ticket" class="" style="">

                                                <div class="card" id="admincard" style="padding:20px">
                                                    <ul class="nav nav-tabs md-tabs" role="tablist">
                                                        <%
                                                            if(session.getAttribute("type").toString().equals("2")){
                                                        %>
                                                        <li class="nav-item">
                                                            <a class="nav-link active show" data-toggle="tab" id="application" role="tab" aria-selected="true"><i class="fa fa-windows"></i> Application</a>
                                                            <div class="slide"></div>
                                                        </li>

                                                        <% }else if(session.getAttribute("type").toString().equals("3")){%> 
                                                        <li class="nav-item">
                                                            <a class="nav-link active show" data-toggle="tab" id="hardware" role="tab" aria-selected="false"><i class="fa fa-desktop"></i> Hardware <span></span><span style="font-size: 11px;color: #f55656;height: 5px"><i class="fa fa-eye " aria-hidden="true"> <span id="newTicket_hw" style=" font-weight: 600 ">0</span></i> </span></a>
                                                            <div class="slide"></div>
                                                        </li>
                                                      
                                                        <%}%>
                                                        <li class="nav-item">
                                                            <a class="nav-link recruitment" data-toggle="tab" id="recruitment" role="tab" aria-selected="false"><i class="fa-sharp fa-solid fa-file-circle-plus"></i> Recruitment</a>
                                                            <div class="slide"></div>
                                                        </li>

                                                        <li class="nav-item">
                                                            <a class="nav-link" data-toggle="tab" id="incident" role="tab" aria-selected="false"><i class="fa fa-users"></i> Incident</a>
                                                            <div class="slide"></div>
                                                        </li>

                                                    </ul>

                                                    <div class="table-responsive" id="application_div" style="overflow-x: hidden; margin-top: 20px">
                                                        <div id="deltable1_wrapper" class="dataTables_wrapper dt-bootstrap4 no-footer">
                                                            <div class="row">
                                                                <div class="col-xs-12 col-sm-12">
                                                                    <table class="table table-hover table-bordered table-sm dataTable no-footer" id="all_tickets" style="font-size: 14px;" role="grid">
                                                                        <thead style="font-size: 16px; text-align: center;">
                                                                            <tr role="row">
                                                                                <th class="sorting_disabled" rowspan="1" colspan="1">1</th>
                                                                                <th class="sorting_disabled" rowspan="1" colspan="1">2</th>
                                                                                <th class="sorting_disabled" rowspan="1" colspan="1">3</th>
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody>

                                                                        </tbody>
                                                                    </table>

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
                    </div>
                </div>
            </div>
        </div>

        <div style="display: none" id="ticketTemplate">
            <div class="row" style="margin-right: -100px" >
                <div class="btn_application_unassigne" data-toggle="modal" style="width: 18%;padding: 10px 0 0 20px">
                    <span></span><span class=" priority"></span> <br>   
                    <img src="files/images/user.png" style=" width:50px; border-radius: 50%; box-shadow: 0 5px 10px 0 rgba(43, 43, 43, .2);border: 2px solid #fff;">
                    <span style="height:15px;font-size:11px"></span>  
                    <i style="font-size: 12px;color: #828282;" class="fa fa-building"> 
                        <span id="department">IT</span></i>
                </div>
                <div class="col-6">
                    <h5 style="color: #3976b6"></h5>
                    <span class="col-2" style="font-size: 12px;color: #828282"></span>|<span class="col-2" ><span style="font-size: 12px;color: #828282">Category - </span> <span class="category"  style="font-size: 14px;" ></span></span>| <span class="col-2" style="font-size: 11px;color: #f55656;height: 5px">
                        <!--<i class="fa fa-eye "></i>--><span>Seen By :- </span>
                        <span class="seenby">No one</span> </span>
                    <div class="description" style="font-size: 12px; overflow-wrap:break-word;"></div>
                    <div class="infor text-danger" style="overflow-wrap:break-word;"></div>
                </div>
                <div class="col-3" >
                    <span id="last_status" ></span>
                    <span id="approve_type"></span>
                </div>
            </div>
        </div>

        <div class="odd" style="display: none" id="ticketTemplate2">
            <div class="row" style="margin-right: -100px" >
                <span class="btn_recruitments_unassigne" data-toggle="modal" style="width: 2%;"></span>
                <span class="btn_recruitments_unassigne" data-toggle="modal" style="width: 18%;"><span class="no">REQ0000000492</span><br><span class="new">New Recruitment</span></span>
                <span class="btn_recruitments_unassigne" data-toggle="modal" style="width: 60%;"><span class="text-uppercase fname" style="font-weight: 600;height: 5px;font-size:16px;color: #3976b6"> fname </span> <br> 
                    <span style="font-size: 11px;color: black;height: 5px">NIC </span><span style="font-size: 11px;color: #828282;height: 5px" class="nic">  </span>| <span style="font-size: 11px;color: black;height: 5px">EPF </span><span style="font-size: 11px;color: #828282;height: 5px" class="epf">EPF 1</span>  | 
                    <span style="font-size: 11px;color: #828282;height: 5px" class="designation"> Assistant Manager - Micro Leasing &amp; Credit</span> |<span style="font-size: 11px;color: #828282;height: 5px" class="dep"> Kandy </span>| <i class="fa  fa-map-marker"></i> <span style="font-size: 11px;color: #828282;height: 5px" class="location">Negombo</span> </span>
                <span class="btn_recruitments_unassigne" data-toggle="modal"><span style="font-size: 12px;color: #828282" class="entBy"> Nevanjith De Silva </span><br><i class="fa fa-clock ">  <span class="entOn" style="font-size: 12px;color: #828282">2023-05-17 11:04:18 AM </span></i></span>
            </div>
        </div>
        <!--<div id="show_ticket" class="" tabindex="-1" role="dialog" >-->
        <!--modal fade-->
        <div id="show_ticket" class="modal fade" tabindex="-1" role="dialog" style=" padding-right: 17px;">
            <div class="modal-dialog modal-lg" style="max-width: 1400px;">
                <div class="container1 modal-content">
                    <div class="modal-header">                   
                        <div class="col-7 ">
                            <h5 class="ticket_code" style="font-weight: bold;">#AP00000-00</h5>
                        </div>                    

                        <div class="col-2">
                            <span class="badge bg-info" id="reOpenLbl"></span><br><span id="reOpenDate"></span>
                        </div> 
                        <div class="col-2">
                            <span class="badge bg-secondary" id="last_update_confirm_lbl">SEEN by <span id="last_seen"></span></span>
                        </div> 
                        <div class="col-1">
                            <button type="button" class="close pull-right " data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button> 
                        </div> 
                    </div>

                    <span class="main_bg"></span>

                    <div class="form-group " id="normal_card" >

                        <div class="card col-12">
                            <div class="row">
                                <table class="table-bordered" style="width: 100%;" id="tct_datatable">
                                    <tbody>
                                        <tr style="background-color: aliceblue" class="text-center">
                                            <td style="width: 17%"><label class="ticket_code"  style="font-size: 14px;height: 40px "></label> <br>
                                                <span id="tct_status" >UnAssign</span>  <br>  
                                            </td>
                                            <td style="padding-left: 10px"><label id="tct_subject" style="height: 8px;font-size: 22px;font-weight: 600;color: #3d3e3e"></label>
                                                <label style="font-size: 10px;height: 8px"> </label><hr style="height: 1px">
                                                <label style="font-size: 12px; color:  #4e4e4e;font-weight: 500 " id="tct_description"></label>
                                            </td>
                                        </tr>
                                    </tbody>                                                
                                </table>
                            </div>
                            <div class="row">
                                <table class="table table-sm table-bordered" style="background-color: #f8f8f8;margin-bottom: 0rem;" id="tct_detail">
                                    <tbody>
                                        <tr >
                                            <td><label style="font-size: 11px;font-weight: 500;color: #4e4e4e;height: 5px">Category <i class="fa fa-navicon"></i></label> <br>   <label id="tct_category"></label>   
                                                <div id="change_category_div" style="display: none">
                                                    <div class="row">
                                                        <div class="col-10">
                                                            <select id="select_category">

                                                            </select> 

                                                        </div>

                                                        <div class="col-2" style="margin-top: 6px">
                                                            <a href="" id="update_edit_btn" class="   mb-3" data-toggle="modal" data-target="#update_modal"><i class="fa fa-check-circle" style="color: #23a343; "></i></a>
                                                            <a href="" class="  mb-3" id="close_edit_btn" data-toggle="modal" data-target="#update_modal"><i class="fa fa-close" style="color:red"></i></a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <label style="font-size: 10px;font-weight: 500;color: #4e4e4e;height: 5px">Priority <i class="fa fa-warning"></i></label> <br> 
                                                <h6 id="id_modal_text" hidden="">7340</h6><label style="font-size: 14px;" id="tct_priority" ></label>
                                            </td>
                                            <td><label style="font-size: 11px;font-weight: 500;color: #4e4e4e;height: 5px">Reporter <i class="fa fa-user"></i></label> <br>  <label id="tct_reporter">Dulmani Chandima</label></td>
                                            <td><label style="font-size: 11px;font-weight: 500;color: #4e4e4e;height: 5px">Branch/Department <i class="fa fa-map-marker"></i></label> <br>     <label id="tct_branch">Risk &amp; Compliance</label></td>
                                            <td class="assignee_name"><label style="font-size: 11px;font-weight: 500;color: #4e4e4e;height: 5px">Assignee <i class="fa fa-user-secret"></i></label> <br>  <label id="tct_assigned"> </label></td>
                                            <td class="assignee_date" style="width:12%"><label style="font-size: 11px;font-weight: 500;color: #4e4e4e;height: 5px">Reported Date <i class="fa fa-calendar"></i></label> <br>   <label style="font-size: 12px" id="reported_date"></label> </td>
                                        </tr>

                                        <tr class="2_row" style="display: none">
                                            <td style="width:15%"><label style="font-size: 11px;font-weight: 500;color: #4e4e4e;height: 5px">Job Type <i class="fa fa-suitcase"></i></label> <br>   <label id="closed_job_type_lbl">Bug-Defect</label></td>
                                            <td style="width:15%"><label style="font-size: 11px;font-weight: 500;color: #4e4e4e;height: 5px">Feed Back <i class="fa fa-feed"></i></label> <br>   <label id="closed_rating_lbl">  <div class=" ratebar" style="display: none">
                                                        <div class="rate">
                                                            <input type="radio" id="star5" name="rate" value="5" disabled/>
                                                            <label for="star5" title="text">5 stars</label>
                                                            <input type="radio" id="star4" name="rate" value="4" disabled/>
                                                            <label for="star4" title="text">4 stars</label>
                                                            <input type="radio" id="star3" name="rate" value="3" disabled/>
                                                            <label for="star3" title="text">3 stars</label>
                                                            <input type="radio" id="star2" name="rate" value="2" disabled/>
                                                            <label for="star2" title="text">2 stars</label>
                                                            <input type="radio" id="star1" name="rate" value="1" disabled/>
                                                            <label for="star1" title="text">1 star</label>
                                                        </div>
                                                    </div> </label></td>
                                            <td style="width:15%">  <label style="font-size: 11px;font-weight: 500;color: #4e4e4e;height: 5px">Assignee <i class="fa fa-user-secret"></i></label>  <br>  <label id="closed_assigned_lbl">Akash</label></td>
                                            <td style="width:10%"><label style="font-size: 11px;font-weight: 500;color: #4e4e4e;height: 5px">Assigned Date <i class="fa fa-calendar"></i></label> <br>   <label style="font-size: 12px" id="closed_assigned_date_lbl">2023-04-26 09:43:42 AM</label></td>
                                            <td style="width:12%"><label style="font-size: 11px;font-weight: 500;color: #4e4e4e;height: 5px">Closed Date <i class="fa fa-calendar"></i></label> <br>   <label style="font-size: 12px" id="closed_closed_date_lbl">2023-04-26 09:46:07 AM</label></td>
                                        </tr>
                                    </tbody>                                                
                                </table>
                            </div>
                        </div>    

                        <div class=" card col-12" id="assignee_card" >
                            <div class="">
                                <div class="row ">
                                    <div class="col-topic-start" ></div>
                                    <div class="col-1 tct_id" style="display: none" ></div>
                                    <div class="col-5">
                                        <select id="select_status" >
                                            <option value="3">IN PROGRESS</option>
                                            <option value="2">FINISH</option>
                                            <option value="6">DEVELOPMENT PENDING</option>
                                        </select>
                                    </div>
                                    <div class="col-5">
                                        <select id="select_job_type" >

                                        </select>
                                    </div>
                                    <div class="col-2" id="btn_div" style="padding-left: 20px;">
                                        <button type="button" id="save_btn" style="align-items: center; display: block;" class="btn btn-sm btn-success display"><i class="fa fa-save"></i> Assign</button>
                                        <!--<button type="button" id="update_btn" style="align-items: center;display: none" class="btn btn-sm btn-success mb-3 display"><i class="fa fa-save"></i>Update</button>-->
                                    </div> 

                                </div>
                            </div>
                        </div>
                    </div>    

                    <div class="row">
                        <section class="work_skills card col-8" id="comment_card" style="margin-left: 10px ">
                            <ul class="nav nav-tabs " id="myTab_1" role="tablist">
                                <li class="nav-item ">
                                    <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home_1" role="tab" aria-controls="home" aria-selected="true"><i class="fa fa-pencil"></i>Comments</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile_1" role="tab" aria-controls="profile" aria-selected="false"> <i class="fa fa-list-alt"></i> Ticket Log</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="profile-tab_12" data-toggle="tab" href="#profile_12" role="tab" aria-controls="profile_12" aria-selected="false"> <i class="fa fa-paperclip "></i> Attachments</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="profile-tab_3" data-toggle="tab" href="#profile_3" role="tab" aria-controls="profile_2" aria-selected="false"> <i class="fa fa-group "></i> Assigners</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="profile-tab_14" data-toggle="tab" href="#profile_14" role="tab" aria-controls="profile_14" aria-selected="false"> <i class="fa fa-wrench "></i> Modifications</a>
                                </li>
                            </ul>
                            <br>
                            <div class="tab-content " id="myTabContent">
                                <div class="tab-pane fade show active" id="home_1" role="tabpanel" aria-labelledby="home-tab">
                                    <div class="row">
                                        <div class="col-3">
                                            <select id="suggestion_comment_id" class="form-control" style="display: none;">
                                                <option value="x"> -- Select Here -- </option>
                                                <option value="Approved">Approved</option>

                                            </select>
                                        </div>
                                        <div class="col-2">
                                            <button type="button" class="btn btn-facebook btn-sm pull-right" id="suggetion_btn" style="display: none;"><i class="fa fa-save"></i>  Submit</button>
                                        </div>

                                    </div>
                                    <br>
                                    <div class="container">
                                        <div class="d-flex  row">
                                            <div class="col-md-12">
                                                <div class="d-flex flex-column comment-section" >

                                                    <div class="container justify-content-center border-left border-right"  id="commentcard">

                                                    </div>

                                                </div>

                                            </div>
                                        </div>
                                        <br>
                                        <div class="bg-light p-2">
                                            <div class="d-flex flex-row align-items-start"><img class="rounded-circle" src="files/images/user.png" width="40"><textarea class="form-control ml-1 shadow-none textarea" id="newComment" placeholder="Add your comments here"></textarea></div>
                                            <div class="mt-2 text-right"><button class="btn btn-primary btn-sm shadow-none" type="button" id="comment_btn">Post comment</button></div>
                                        </div>
                                    </div>
                                </div>
                                <!--</div>-->
                                <!--                                        </div>
                                                                    </div>-->
                                <div class="tab-pane   fade" id="profile_1" role="tabpanel" aria-labelledby="profile-tab">
                                    <div class="row">
                                        <div class="col-md-12   ">
                                            <div class="single-table" style="height: 300px; overflow: auto">
                                                <table class="table text-center table-sm table-bordered" id="log_table">
                                                    <thead class="  table-bordered" style="background-color: #dcecf6;font-size: 15px" id="head">
                                                        <tr>
                                                            <th scope="col" style="width: 10%">No</th>
                                                            <th scope="col" style="width: 40%">Date/Time</th>
                                                            <th scope="col" style="width: 30%">Status</th>
                                                            <th scope="col" style="width: 20%">Enter By</th>

                                                        </tr>
                                                    </thead>
                                                    <tbody id="logbody" style="background-color: #f0f0f0;font-size: 10px">

                                                    </tbody>
                                                </table>    

                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane   fade" id="profile_12" role="tabpanel" aria-labelledby="profile-tab">
                                    <div class="row">
                                        <div class="col-6" style="height: 250px; overflow: auto">
                                            <ol id="modal_image_div"><li><a href="Get_Image_1?i_name=007340_1&amp;type=.doc" target="_blank"> <i class="fa  fa-file-image-o ">.doc - Dulmani Chandima (2022-11-21 | 14:49:21 PM  )</i></a></li><li><a href="Get_Image_1?i_name=007340_2&amp;type=.xlsx" target="_blank"> <i class="fa  fa-file-image-o ">.xlsx - Dulmani Chandima (2022-11-21 | 14:49:21 PM  )</i></a></li></ol>
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="row">
                                        <div id="fileList_2"></div>
                                        <div class="col-topic-start"></div>
                                        <label class=" col-form-label new-label-box" style="width: 20%">Attachments</label>
                                        <div class="col-8">
                                            <div class="col-sm-12 col-form-label input-images_2" id="upload_document_div_2">
                                                <div class="jquery-image-uploader"><input type="file" id="image_upload_2" name="images" multiple="multiple"><div class="uploaded"></div><div class="upload-text"><i class="material-icons"></i><span>(6 Files only)</span></div></div></div>                
                                        </div>
                                        <div class="col-1">
                                            <button type="button" id="upload_new_attachment" style="align-items: center" class="btn btn-sm btn-success mb-3"><i class="fa fa-upload"></i> Upload</button>
                                        </div>
                                    </div>  
                                </div>
                                <div class=" tab-pane fade" id="profile_3" role="tabpanel" aria-labelledby="profile-tab">
                                    <div class="row">  
                                        <div class="col-5">
                                            <select  id="select_sub_status">
                                                <option value="1">FEEDBACK PENDING</option>    
                                                <option value="2">APPROVAL PENDING</option>    
                                            </select>                                                             
                                        </div>                                                                                                 
                                        <div class="col-5">
                                            <select class="form-control-xs" id="users" tabindex="-1 " multiple>
                                            </select>
                                        </div>                                                                                                 
                                        <div class="col-2">
                                            <button type="button" class="btn btn-google-plus btn-sm " id="ticket_assign_btn"><i class="fa fa-user-plus"></i> Confirm</button>
                                        </div>                                                                                                 
                                    </div> 
                                </div>
                                <div class="tab-pane   fade" id="profile_14" role="tabpanel" aria-labelledby="profile-tab">
                                    <div class="row">
                                        <div class="col-4">
                                            <select class="form-control form-control-xs" id="select_mod_sub_status" onchange=" on_change_modification_status()">
                                                <option value="0"> -- select sub status --</option>                                                        
                                                <option value="48">MODIFICATION PENDING</option>                
                                            </select>                                                             
                                        </div>            
                                        <div class="col-8">
                                            <button type="button" class="btn btn-google-plus btn-sm pull-right" id="confirm_sow_modal_btn" data-toggle="modal" data-target="#confirm_sow_modal"><i class="fa fa-upload"></i> Upload SOW Document</button>
                                        </div>
                                    </div>
                                    <br>
                                    <div class="row">
                                        <div class="col-4">
                                            <div id="modification_div">    
                                                <table class="table table-sm">
                                                    <tbody id="sow_tbody">
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </section>
                        <section class="timeline_about card " style="margin: 0px 0 0 25px;width: 420px;">
                            <h1 class="heading">Tracking Details</h1>
                            <div class="ticketTracking" id="ticketTracking"></div>

                        </section>
                    </div>  

                </div>
            </div>
        </div>

        <div id="reqruitment_modal" class="modal fade" tabindex="-1" role="dialog" style=" padding-right: 17px;">
            <div class="modal-dialog modal-lg" style="max-width: 1400px;">
                <div class="modal-content">
                    <div class="modal-header">                   
                        <div class="col-10 ">
                            <h5> Recruitment Details - <span class="  new-label-box"  name="hr_recruitment_no" id="hr_recruitment_no"></span> </h5>
                        </div>                    
                        <div class="col-1 ">
                        </div> 
                        <div class="col-1">
                            <button type="button" class="close pull-right " data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button> 
                        </div> 
                    </div>
                    <div class="modal-body" style="background-color: #f8f8f8">
                        <!--                        <div class="row">
                                                    <div class="col-12">
                                                        <div class=" row form-group  ">
                                                            <div class="col-12">-->

                        <header class="timeline_about card" style=" padding:20px" >
                            <!--<section class="userDetails card" style=" padding:20px">-->
                            <h1 class="heading">Ticket Details</h1>

                            <div class="card-body" >
                                <div class="col-6">
                                    <div class=" row form-group  row-up-1">
                                        <div class="col-topic-start"></div>
                                        <label class=" col-form-label new-label-box" style="width:10px"><span id="recruitment_type_badge" >New Recruitment</span></label>
                                    </div>

                                </div>
                                <div class="col-12 row">
                                    <div class="form-group col-sm-12 col-xl-12 p-l-0 p-r-0 row">
                                        <label class="col-sm-2 col-form-label" style="margin: 0px -59px 0 12px">Full Name <span class="text-danger">*</span></label>
                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" readonly="" id="hr_full_name_input" autocomplete="off" style="width: 104%">
                                        </div>
                                    </div>
                                </div>

                                <div class="col-12 row">
                                    <div class="col-6">
                                        <div class="form-group col-sm-12 col-xl-12 p-l-0 p-r-0 row">
                                            <label class="col-sm-3 col-form-label">Calling Name <span class="text-danger">*</span></label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" readonly="" id="hr_call_name_input" autocomplete="off">
                                            </div>
                                        </div>
                                        <div class="form-group col-sm-12 col-xl-12 p-l-0 p-r-0 row">
                                            <label class="col-sm-3 col-form-label">EPF <span class="text-danger">*</span></label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" readonly="" id="hr_emp_epf_input" autocomplete="off">
                                            </div>
                                        </div>
                                        <div class="form-group col-sm-12 col-xl-12 p-l-0 p-r-0 row">
                                            <label class="col-sm-3 col-form-label">Join Date <span class="text-danger">*</span></label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" readonly="" id="hr_join_date_input" autocomplete="off">
                                            </div>
                                        </div>
                                        <div class="form-group col-sm-12 col-xl-12 p-l-0 p-r-0 row">
                                            <label class="col-sm-3 col-form-label">Phone No <span class="text-danger">*</span></label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" readonly="" id="hr_pno_input" autocomplete="off">
                                            </div>
                                        </div>
                                        <div class="form-group col-sm-12 col-xl-12 p-l-0 p-r-0 row">
                                            <label class="col-sm-3 col-form-label">NIC <span class="text-danger">*</span></label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" readonly="" id="hr_emp_nic_input" autocomplete="off">
                                            </div>
                                        </div>
                                        <div class="form-group col-sm-12 col-xl-12 p-l-0 p-r-0 row">
                                            <label class="col-sm-3 col-form-label">Address <span class="text-danger">*</span></label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" readonly="" id="hr_address_input" autocomplete="off">
                                            </div>
                                        </div>

                                        <div id="admin_req_div" class="row form-group" style="display: none; padding-left: 8px;">
                                            <label class=" col-form-label new-label-box" style="width: 20%">Control</label>
                                            <div class="col-7" style="width: 70%">
                                                <select id="admin_req_val" class="form-control form-control-xs col-8">
                                                    <option value="0"> -- Select Action -- </option>

                                                    <option value="1">   Release Asset Verification     </option>

                                                </select>
                                            </div>

                                        </div>

                                    </div>   
                                    <div class="col-6">

                                        <div class="form-group col-sm-12 col-xl-12 p-l-0 p-r-0 row">
                                            <label class="col-sm-3 col-form-label">Designation <span class="text-danger">*</span></label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" readonly="" id="hr_emp_select_designation" autocomplete="off">
                                            </div>
                                        </div>
                                        <div class="form-group col-sm-12 col-xl-12 p-l-0 p-r-0 row">
                                            <label class="col-sm-3 col-form-label">Gender <span class="text-danger">*</span></label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" readonly="" id="hr_emp_select_gender" autocomplete="off">
                                            </div>
                                        </div>
                                        <div class="form-group col-sm-12 col-xl-12 p-l-0 p-r-0 row">
                                            <label class="col-sm-3 col-form-label">Department <span class="text-danger">*</span></label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" readonly="" id="hr_emp_select_department" autocomplete="off">
                                            </div>
                                        </div>
                                        <div class="form-group col-sm-12 col-xl-12 p-l-0 p-r-0 row">
                                            <label class="col-sm-3 col-form-label">Location <span class="text-danger">*</span></label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" readonly="" id="hr_emp_select_location" autocomplete="off">
                                            </div>
                                        </div>
                                        <div class="form-group col-sm-12 col-xl-12 p-l-0 p-r-0 row">
                                            <label class="col-sm-3 col-form-label">Description <span class="text-danger">*</span></label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" readonly="" id="hr_emp_txt_area" autocomplete="off">
                                            </div>
                                        </div>
                                        <div class="form-group col-sm-12 col-xl-12 p-l-0 p-r-0 row">
                                            <label class="col-sm-3 col-form-label">Last Date <span class="text-danger">*</span></label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" readonly="" id="hr_emp_lstDate" autocomplete="off">
                                            </div>
                                        </div>

                                    </div> 
                                </div> 

                                <div class="col-6">
                                    <div class=" row form-group row-up-1">
                                        <div class="col-topic-start"></div>      
                                        <h6 id="system_accress" class="text-danger"></h6>

                                    </div>
                                </div> 

                            </div>
                            <br>
                            <hr>
                            <div id="new_recruitment_div" style="display: block; padding:20px">
                                <div class="row">
                                    <div class="col-6">
                                        <h6>Asset List</h6>
                                        <table class="table table-sm table-bordered" style="  overflow: auto">
                                            <thead>
                                                <tr><th hidden="">Name</th>
                                                    <th>Name</th>
                                                    <th>Request</th>
                                                    <th>Action</th>
                                                </tr></thead>
                                            <tbody style="font-size: 10px" id="asset_list_body">

                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="col-6">
                                        <h6>System List</h6>
                                        <table class="table table-sm table-bordered" style="  overflow: auto">
                                            <thead>
                                                <tr><th hidden="">Name</th>
                                                    <th>Name</th>
                                                    <th>Request</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody style="font-size: 10px" id="system_list_body">
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-12">
                                        <div class=" row form-group row-up-1">
                                            <div class="col-topic-start"></div>
                                            <label class=" col-form-label new-label-box" style="width: 25%">PC User Name</label>
                                            <div class="col-15" style="width: 50%">
                                                <input class="form-control form-control-xs" id="pc_username_input">
                                            </div>
                                        </div>
                                        <div class=" row form-group row-up-1">
                                            <div class="col-topic-start"></div>
                                            <label class=" col-form-label new-label-box" style="width: 25%">User Email</label>
                                            <div class="col-15" style="width: 50%">
                                                <input class="form-control form-control-xs" id="email_input">
                                            </div>
                                        </div>
                                        <div class=" row form-group row-up-1">
                                            <div class="col-topic-start"></div>
                                            <label class=" col-form-label new-label-box" style="width: 25%">System User Name</label>
                                            <div class="col-15" style="width: 50%">
                                                <input class="form-control form-control-xs" id="system_username_input">
                                            </div>
                                        </div>

                                        <div class="col-15 pull-right">
                                            <button type="button" id="user_update_btn" style="align-items: center; background-color: rgb(43, 139, 203); color: rgb(255, 255, 255); display: block;" class="btn btn-sm mb-3"><i class="fa fa-save"></i> Update</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="transfer_promotion_div" style="display: none">
                                <div class=" row form-group row-up-1">
                                    <div class="col-topic-start"></div>
                                    <label class=" col-form-label new-label-box" style="width: 20%">New Designation</label>
                                    <div class="col-15" style="width: 50%">
                                        <input readonly="" class="form-control form-control-xs" id="transfer_promotion_desig_lbl">
                                    </div>
                                </div>
                                <div class=" row form-group row-up-1">
                                    <div class="col-topic-start"></div>
                                    <label class=" col-form-label new-label-box" style="width: 20%">New Department</label>
                                    <div class="col-15" style="width: 50%">
                                        <input readonly="" class="form-control form-control-xs" id="transfer_promotion_department_lbl">
                                    </div>
                                </div>
                                <div class=" row form-group row-up-1">
                                    <div class="col-topic-start"></div>
                                    <label class=" col-form-label new-label-box" style="width: 20%">New Branch</label>
                                    <div class="col-15" style="width: 50%">
                                        <input readonly="" class="form-control form-control-xs" id="transfer_promotion_branch_lbl">
                                    </div>
                                </div>
                            </div>
                        </header>


                        <div class="col-12 row">

                            <!-- ===== ===== Work & Skills Section ===== ===== -->
                            <section class="work_skills card col-8" style="padding: 10px">

                                <!-- ===== ===== Work Contaienr ===== ===== -->
                                <div class="col-12 work" >
                                    <h1 class="heading">Other Details</h1>

                                    <ul class="nav nav-tabs " id="myTab1" role="tablist">
                                        <li class="nav-item ">
                                            <a class="nav-link active" id="home-tab1" data-toggle="tab" href="#home1" role="tab" aria-controls="home" aria-selected="true"><i class="fa fa-pencil"></i>Comments</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" id="profile-tab1" data-toggle="tab" href="#profile1" role="tab" aria-controls="profile" aria-selected="false"> <i class="fa fa-list-alt"></i> Ticket Log</a>
                                        </li>

                                    </ul>
                                    <br>
                                    <div class="tab-content " id="myTabContent">
                                        <div class="tab-pane fade show active" id="home1" role="tabpanel" aria-labelledby="home-tab1">
                                            <div class="row">
                                                <div class="col-3">
                                                    <select id="suggestion_comment_id" class="form-control" style="display: none;">
                                                        <option value="x"> -- Select Here -- </option>
                                                        <option value="Approved">Approved</option>

                                                    </select>
                                                </div>
                                                <div class="col-2">
                                                    <button type="button" class="btn btn-facebook btn-sm pull-right" id="suggetion_btn" style="display: none;"><i class="fa fa-save"></i>  Submit</button>
                                                </div>

                                            </div>
                                            <br>
                                            <div class="container">
                                                <div class="d-flex  row">
                                                    <div class="col-md-12">
                                                        <div class="d-flex flex-column comment-section" >

                                                            <div class="container justify-content-center border-left border-right"  id="commentcard">

                                                            </div>

                                                        </div>

                                                    </div>
                                                </div>
                                                <br>
                                                <div class="bg-light p-2">
                                                    <div class="d-flex flex-row align-items-start"><img class="rounded-circle" src="files/images/user.png" width="40"><textarea class="form-control ml-1 shadow-none textarea" id="newComment" placeholder="Add your comments here"></textarea></div>
                                                    <div class="mt-2 text-right"><button class="btn btn-primary btn-sm shadow-none" type="button" id="comment_btn">Post comment</button></div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="tab-pane fade" id="profile1" role="tabpanel" aria-labelledby="profile-tab1">
                                            <div class="row">
                                                <div class="col-md-12   ">
                                                    <div class="single-table" style="height: 300px; overflow: auto">
                                                        <table class="table text-center table-sm table-bordered" id="log_table">
                                                            <thead class="  table-bordered" style="background-color: #dcecf6;font-size: 15px" id="head">
                                                                <tr>
                                                                    <th scope="col" style="width: 10%">No</th>
                                                                    <th scope="col" style="width: 40%">Date/Time</th>
                                                                    <th scope="col" style="width: 30%">Status</th>
                                                                    <th scope="col" style="width: 20%">Enter By</th>

                                                                </tr>
                                                            </thead>
                                                            <tbody id="logbody" style="background-color: #f0f0f0;font-size: 10px">

                                                            </tbody>
                                                        </table>    

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </section>

                            <!-- ===== ===== Timeline & About Sections ===== ===== -->
                            <section class="timeline_about card" style=" margin: 0 0 0 29px;width: 420px;">
                                <h1 class="heading">Tracking Details</h1>
                                <div class="ticketTracking"></div>

                            </section>
                        </div>


                    </div>

                    <div class="modal-footer">
                        <button type="button" id="user_save_btn" style="align-items: center; display: block;" class="btn btn-sm btn-success mb-3"><i class="fa fa-save"></i> Submit</button>
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

        </script>
        <script>


            document.addEventListener('DOMContentLoaded', function () {
                const cards = document.querySelectorAll('.card-dashboard');

                cards.forEach(card => {
                    card.addEventListener('click', function () {
                        // Remove the 'selected' class from all cards
                        cards.forEach(card => {
                            card.classList.remove('selected');
                        });

                        // Add the 'selected' class to the clicked card
                        this.classList.add('selected');
                    });
                });
            });

            document.getElementById("queued_card").setAttribute("selected", "");

            function clearForm() {
                $('#show_ticket').find('input[type!=search]').val('');
                $('#show_ticket').find('select').each(function () {
                    if ($(this).data('select')) {
                        if ($(this).data('select').ajax) {
                            $(this).data('select').data.data = [];
                        }
                        $(this).data('select').set('');
                    }
                });
            }
            loadCount();
            //                setInterval(function () {
            //                    loadCount();
            ////                    dtable.ajax.reload(null, false);
            //                }, 10 * 1000);
            //
            //                setInterval(function () {
            //
            //                }, 500);

            var job_type = new SlimSelect({
                select: '#select_job_type',
                ajax: function (search, callback) {
                    fetch('ticket/search-job-type', {
                        method: 'POST',
                        body: new URLSearchParams({search: search || ''})
                    }).then(res => res.json()).then((data) => {
                        callback(data);
                    });
                },
                allowDeselect: false,
                deselectLabel: '<span class="red">✖</span>',
                showSearch: true
            });
            $('#select_job_type').data('select', job_type);

            var ticketType;
            var sessionType = "<%= session.getAttribute("type") %>";

            if (sessionType === "2") {
                ticketType = '1';
            } else if (sessionType === "3") {
                ticketType = '2';
            }
            $("#application").click(function () {

                ticketType = '1';
                dtable.ajax.reload();
            });
            $("#hardware").click(function () {
                ticketType = '2';
                dtable.ajax.reload();
            });
            $(".recruitment").click(function () {
                ticketType = '3';
                dtable.ajax.reload();
            });
            //            $(".recruitment").click(function () {
            //                ticketType = '5';
            //                dtable.ajax.reload();
            //            });
            $("#incident").click(function () {
                ticketType = '4';
                dtable.ajax.reload();
            });

            var status = '5';


            $("#queued_card").click(function () {
                status = '5';
                dtable.ajax.reload();
            });
            $("#closed_card").click(function () {
                dtable.ajax.reload();
                status = '4';
                dtable.ajax.reload();
            });
            $("#inprogress_card").click(function () {
                status = '3';
                dtable.ajax.reload();
            });
            $("#finish_card").click(function () {
                status = '2';
                dtable.ajax.reload();
            });

            $("#mytickets_card").click(function () {
                status = '8';
                dtable.ajax.reload();
            });


            $("#assigned_card").click(function () {
                status = '7';
                dtable.ajax.reload();
            });

            let stts = new SlimSelect({
                select: '#select_status'

            });


            $.fn.dataTable.ext.errMode = 'none';
            var dtable = $('#all_tickets').DataTable({
                "aLengthMenu": [[5, 10, 25, -1], [5, 10, 25, "All"]],
                "pageLength": 0,
                "ordering": true,
                "autoWidth": false,
                "processing": true,
                "serverSide": true,
                "order": [[0, "desc"]],
                "searchHighlight": true,
                "searchDelay": 350,
                "ajax": {
                    "url": "ticket/all",
                    "contentType": "application/json",
                    "type": "POST",
                    "data": function (d) {
                        d.data = JSON.stringify({
                            ticketType: ticketType,
                            status: status
                        });
                        return JSON.stringify(d);
                        console.log(data);
                    },
                    error: function (xhr, error, code) {
                        console.log(xhr);
                        console.log(code);
                    }
                },

                "columns": [
                    {"data": "id", className: "text-right", "visible": false},
                    {"data": "code", "visible": false},
                    {"data": "ticketType", "visible": false},
                    {"data": "category", "visible": false},
                    {"data": "priority", "visible": false},
                    {"data": "subject", "visible": false},
                    {"data": "description", "visible": false},
                    {"data": "timeOfIncident", "visible": false},
                    {"data": "entBy", "visible": false},
                    {"data": "behalf", "visible": false},
                    {"data": "entOn", "visible": false},
                    {"data": "status", "visible": false},
                    //                        {"data": "assignedTo", "visible": false},
                    {"data": "seenBy"}

                ],

                "language": {
                    'loadingRecords': '&nbsp;',
                    'processing': '<div class="loader2"></div>'
                },
                "createdRow": function (row, data) {

                    if ((data.ticketType === 'Recruitment') | (data.ticketType === 'Transfer/Promotion') | (data.ticketType === 'Termination')) {
                        let temp2 = document.getElementById("ticketTemplate2").cloneNode(true);
                        let spn = document.createElement('span');
                        setTableStatus(spn, dtable.costomPriority);

                        $(temp2).find('.no').html(data.code);
                        $(temp2).find('.entBy').html(data.entBy);
                        $(temp2).find('.entOn').html(data.entOn);
                        var tr = $(temp2).find('.new').html(data.priority);
                        if ($(tr).html() === ('Termination')) {
                            $(tr).html('<span class="badge badge-warning">Termination</span>');
                        } else if ($(tr).html() === 'Recruitment') {
                            $(tr).html('<span class="badge badge-danger" style="white-space: nowrap">Recruitment</span>');
                        } else if ($(tr).html() === 'Transfer/Promotion') {
                            $(tr).html('<span class="badge badge-info" style="white-space: nowrap">Transfer/Promotion</span>');
                        }

                        if (data.recData) {
                            let rec = JSON.parse(data.recData);
                            for (var i = 0; i < rec.length; i++) {
                                $(temp2).find('.nic').html(rec[i].nic);
                                $(temp2).find('.epf').html(rec[i].epf);
                                $(temp2).find('.designation').html(rec[i].designation);
                                $(temp2).find('.fname').html(rec[i].fname);
                                $(temp2).find('.dep').html(rec[i].branch);
                                $(temp2).find('.location').html(rec[i].location);
                            }
                        }
                        if (data.terData) {
                            let ter = JSON.parse(data.terData);
                            for (var i = 0; i < ter.length; i++) {
                                $(temp2).find('.nic').html(ter[i].nic);
                                $(temp2).find('.epf').html(ter[i].epf);
                                $(temp2).find('.fname').html(ter[i].fullname);
                                $(temp2).find('.dep').html(ter[i].dep);
                                $(temp2).find('.designation').html(ter[i].designation);
                                $(temp2).find('.location').html(ter[i].location);
                            }
                        }
                        if (data.tpData) {
                            let tp = JSON.parse(data.tpData);
                            for (var i = 0; i < tp.length; i++) {
                                $(temp2).find('.nic').html(tp[i].nic);
                                $(temp2).find('.epf').html(tp[i].epf);
                                $(temp2).find('.fname').html(tp[i].fullname);
                                $(temp2).find('.dep').html(tp[i].dep);
                                $(temp2).find('.designation').html(tp[i].designation);
                                $(temp2).find('.location').html(tp[i].location);
                            }
                        }

                        let td = document.createElement('td');
                        $(td).append($(temp2).html());
                        $(row).append(td);
                    } else {
                        let temp = document.getElementById("ticketTemplate").cloneNode(true);


                        let spn = document.createElement('span');
                        setTableStatus(spn, dtable.costomPriority);

                        $(temp).find('h5').html(data.subject);
                        $(temp).find('span').eq(2).html(data['entBy']);
                        $(temp).find('span').eq(0).html(data.code);
                        $(temp).find('span').eq(4).html(data.entOn);
                        $(temp).find('.category').html(data.category);
                        $(temp).find('.description').html(data.description);

                        if (data.assigneeType) {
                            let ticketAssignee = JSON.parse(data.assigneeType);

                            for (var j = 0; j < ticketAssignee.length; j++) {

                                var typ = $(temp).find('#approve_type').html(ticketAssignee[j].type);

                                if ($(typ).html() === '1') {
                                    $(typ).html('<span class="badge badge-purple" style="white-space: nowrap">FEEDBACK PENDING (Assigned to ' + ticketAssignee[j].user + ') </span>');
                                } else if ($(typ).html() === '2') {
                                    $(typ).html('<span class="badge badge-purple" style="white-space: nowrap">APPROVAL PENDING (Assigned to ' + ticketAssignee[j].user + ') </span>');
                                }
                            }
                        }
                        if (data.seenBy) {
                            let seenby = JSON.parse(data.seenBy);
                            $(temp).find('.seenby').text(seenby.user + ' - ' + seenby.date).addClass('font');
                        }

                        var sts = $(temp).find('#last_status').html(data.status);
                        if ($(sts).html() === ('3')) {
                            $(sts).html('<label class="badge label-info" style="white-space: nowrap">In Progress</label>');
                        } else if ($(sts).html() === '4') {
                            $(sts).html('<label class="badge label-danger" style="white-space: nowrap">Closed</label>');
                        } else if ($(sts).html() === '2') {
                            $(sts).html('<label class="badge " style="white-space: nowrap; background:#5ba9fd">Finished</label>');
                        } else if ($(sts).html() === '5') {
                            $(sts).html('<label class="badge label-success" style="white-space: nowrap">Queued</label>');
                        }

                        var tr1 = $(temp).find('.priority').html(data.priority);

                        if ($(tr1).html() === ('Normal')) {
                            $(tr1).html('<label class="label label-success" style="white-space: nowrap">Normal</label>');
                        } else if ($(tr1).html() === 'Urgent') {
                            $(tr1).html('<label class="label label-danger" style="white-space: nowrap">Urgent</label>');
                        } else if ($(tr1).html() === ('Termination')) {
                            $(tr1).html('<span class="badge badge-warning">Termination</span>');
                        } else if ($(tr1).html() === 'Recruitment') {
                            $(tr1).html('<span class="badge badge-danger" style="white-space: nowrap">Recruitment</span>');
                        } else if ($(tr1).html() === 'Transfer/Promotion') {
                            $(tr1).html('<span class="badge badge-info" style="white-space: nowrap">Transfer/Promotion</span>');
                        }

                        let td = document.createElement('td');
                        $(td).append($(temp).html());
                        $(row).append(td);
                    }

                    $(row).on('click', function () {
                        var idd = data.id;
                        let tr = $(this).parents('tr').first();
                        $('#reqruitment_modal').data('id', idd);
                        $('#show_ticket').data('id', idd);
                        Swal.fire({
                            text: "Are you want to see the ticket ?",
                            icon: 'warning',
                            showCancelButton: true,
                            confirmButtonColor: '#3085d6',
                            cancelButtonColor: '#d33',
                            confirmButtonText: 'Yes, Continue!',
                            showLoaderOnConfirm: true,
                            searchHighlight: true,
                            preConfirm: () =>
                            {
                                return fetch('ticket/Data', {
                                    method: 'POST',
                                    body: new URLSearchParams({id: idd})

                                }).then(response => {
                                    if (!response.ok) {
                                        throw new Error(response.statusText);
                                    }
                                    return response.json();
                                }).catch(error => {
                                    Swal.showValidationMessage('Request failed:' + error);
                                });
                            },
                            allowOutsideClick: () => !Swal.isLoading()

                        }).then((result) => {
                            if (result.value) {
                                clearForm();
                                $("#change_category_div").hide();
                                let data = result.value;
                                let ticketLog = JSON.parse(data.ticketLog);
                                let lastSeen = JSON.parse(data.lastSeen);
                                if (data.assigneeDetail) {
                                    let assignee = JSON.parse(data.assigneeDetail);
                                    $('#tct_assigned').text(assignee.user);
                                }
                                //                        $('#tct_assigned').text(assignee.user);


                                if (data.rate) {
                                    //$(document).find('#star' + data.rate).click();
                                    $(document).find('#star' + data.rate).prop('checked', true);
                                }

                                if (data.comments) {
                                    let comment = JSON.parse(data.comments);
                                    $('#commentcard').html('');
                                    for (var i = 0; i < comment.length; i++) {

                                        var temp = ' <div class="d-flex" >'
                                                + ' <div class="d-flex py-2 col-12">'
                                                + '<div class="d-flex justify-content-between py-1  col-12" >'
                                                + ' <div class="second py-2 px-2" >'
                                                + '<div class="d-flex flex-row user-info"><img class="rounded-circle" src="files/images/user.png" width="40">'
                                                + '<div class="d-flex flex-column justify-content-start ml-2"><span class="d-block font-weight-bold name" id="commentUser">' + comment[i].user + '</span><span class="date text-black-50" id="commentDate">' + comment[i].date + '</span></div>'
                                                + '</div>'
                                                + '<div class="mt-2">'
                                                + '<p class="comment-text" id="commentText">' + comment[i].comment + '</p>'
                                                + '</div></div></div></div></div>'


                                        $('#commentcard').append(temp);
                                    }
                                }
                                var sts = $('#tct_status').text(data.status);
                                if ($(sts).html() === ('3')) {
                                    $("#assignee_card,.assignee_name,#profile-tab,#profile-tab_12,#profile-tab_3,#user_update_btn,#user_save_btn").show();
                                    $(".assignee_date,.2_row,.ratebar").hide();
                                    $(sts).html('<label class="badge label-info" style="white-space: nowrap">In Progress</label>');
                                } else if ($(sts).html() === '4') {
                                    $(sts).html('<label class="badge label-danger" style="white-space: nowrap">Closed</label>');
                                    $("#profile-tab_12,#profile-tab_3,#assignee_card,.assignee_name,#user_update_btn,#user_save_btn").hide();
                                    $(".assignee_date,.2_row,.ratebar").show();
                                } else if ($(sts).html() === '2') {
                                    $(".assignee_date,.2_row").show();
                                    $(".assignee_name,#assignee_card,#profile-tab_3,#profile-tab_12,.ratebar,#user_update_btn").hide();
                                    $(sts).html('<label class="badge " style="white-space: nowrap; background:#5ba9fd">Finished</label>');
                                } else if ($(sts).html() === '5') {
                                    $("#assignee_card,.assignee_name,#profile-tab,#profile-tab_12,#profile-tab_3,#user_update_btn,#user_save_btn").show();
                                    $(".assignee_date,.2_row,.ratebar").hide();
                                    $(sts).html('<label class="badge label-success" style="white-space: nowrap">Queued</label>');
                                } else if ($(sts).html() === '6') {
                                    $("#assignee_card,.assignee_name,#profile-tab,#profile-tab_12,#profile-tab_3,#user_update_btn,#user_save_btn").show();
                                    $(".assignee_date,.2_row,.ratebar").hide();
                                    $(sts).html('<label class="badge label-success" style="white-space: nowrap">Development Pending</label>');
                                }

                                $('#last_seen').text(lastSeen.user);
                                $(tr).find('.seenby').text(data.user + ' - ' + data.date);
                                $('#log_table tbody').html('');
                                for (var i = 0; i < ticketLog.length; i++) {
                                    let tr = document.createElement('tr');
                                    $(tr).append('<td>' + ticketLog[i].id + '</td>');
                                    $(tr).append('<td>' + ticketLog[i].data + '</td>');
                                    $(tr).append('<td>' + ticketLog[i].action + '</td>');
                                    $(tr).append('<td>' + ticketLog[i].user + '</td>');
                                    $('#log_table tbody').append(tr);
                                }

                                let access = JSON.parse(data.checked);
                                $('#asset_list_body').html('');
                                $('#system_list_body').html('');
                                for (var a = 0; a < access.length; a++) {
                                    let tr = document.createElement('tr');
                                    $(tr).append('<td>' + access[a].name + '</td>');
                                    $(tr).append('<td><i class="fa ' + access[a].hr + '"></i></td>');
                                    $(tr).append('<td><input type="checkbox" ' + (access[a].it === 'YES' ? 'checked' : '') + ' value="' + access[a].id + '" ></td>');
                                    if (access[a].type === 'asset') {
                                        $('#asset_list_body').append(tr);
                                    } else {
                                        $('#system_list_body').append(tr);
                                    }
                                }

                                $('.ticket_code').html(data.code);
                                $('#tct_subject').html(data.subject);
                                $('#tct_reporter').html(data.reporter);
                                $('#closed_job_type_lbl').html(data.jobType);
                                $('#closed_assigned_date_lbl').html(data.assigneeDate);
                                $('#reported_date').html(data.entOn);

                                if (data.closed) {
                                    var closed = JSON.parse(data.closed);
                                    for (var c = 0; c < closed.length; c++) {
                                        if (closed[c].act === 'Re-Open by User') {
                                            $('#reOpenLbl').html(closed[c].act);
                                            //                                        $('#reOpenDate').html(closed[c].user);
                                        } else {
                                            $('#closed_closed_date_lbl').html(closed[c].date);
                                            $('#closed_assigned_lbl').html(closed[c].user);
                                        }
                                    }
                                }


                                stts.set();
                                $('#name').val(data.name);
                                $('#username').val(data.username);
                                if (data.jobType) {
                                    job_type.setData([{value: data.jobTypeId, text: data.jobType}]);
                                    job_type.set(data.jobTypeId);
                                }

                                if (data.assignee) {
                                    let a = JSON.parse(data.assignee);
                                    let  ary = [];
                                    let  arySelect = [];
                                    for (var i = 0; i < a.length; i++) {
                                        ary.push({value: a[i].id, text: a[i].name});
                                        arySelect.push(a[i].id);
                                    }
                                    users.setData(ary);
                                    users.set(arySelect);
                                }


                                $('#tct_category').html(data.category);
                                var tr = $('#recruitment_type_badge').html(data.priority);
                                if ($(tr).html() === ('Termination')) {
                                    $(tr).html('<span class="badge badge-warning">Termination</span>');
                                } else if ($(tr).html() === 'Recruitment') {
                                    $(tr).html('<span class="badge badge-danger" style="white-space: nowrap">Recruitment</span>');
                                } else if ($(tr).html() === 'Transfer/Promotion') {
                                    $(tr).html('<span class="badge badge-info" style="white-space: nowrap">Transfer/Promotion</span>');
                                }
                                var tr1 = $('#tct_priority').html(data.priority);
                                if ($(tr1).html() === ('Normal')) {
                                    $(tr1).html('<label class="" style="white-space: nowrap; color: #0ac282;">Normal</label>');
                                } else if ($(tr1).html() === 'Urgent') {
                                    $(tr1).html('<label class="" style="white-space: nowrap; color: #fe5d70;">Urgent</label>');
                                }
                                $('#tct_description').html(data.description);
                                $('.tct_id').html(data.id);
                                dtable.ajax.reload();
                                if (data.ticketType === 'Recruitment') {
                                    $('#new_recruitment_div').show();
                                    $('#transfer_promotion_div').hide();
                                } else if (data.ticketType === 'Termination') {
                                    $('#new_recruitment_div,#transfer_promotion_div').hide();
                                } else if (data.ticketType === 'Transfer/Promotion') {
                                    $('#new_recruitment_div').hide();
                                    $('#transfer_promotion_div').show();
                                }

                                if (data.recData) {
                                    let records = JSON.parse(data.recData);
                                    for (var i = 0; i < records.length; i++) {
                                        var rec = records[i];
                                        console.log(rec.fname);
                                        $('#hr_full_name_input').val(rec.fname);
                                        $('#hr_call_name_input').val(rec.name);
                                        $('#hr_emp_epf_input').val(rec.epf);
                                        $('#hr_join_date_input').val(rec.join_date);
                                        $('#hr_pno_input').val(rec.phone);
                                        $('#hr_emp_nic_input').val(rec.nic);
                                        $('#hr_address_input').val(rec.add);
                                        $('#hr_emp_select_designation').val(rec.designation);
                                        $('#hr_emp_select_gender').val(rec.gender);
                                        $('#hr_emp_select_department').val(rec.branch);
                                        $('#hr_emp_select_location').val(rec.location);
                                        $('#hr_emp_txt_area').val(rec.description);
                                    }
                                }
                                if (data.terData) {
                                    let termination = JSON.parse(data.terData);
                                    for (var i = 0; i < termination.length; i++) {
                                        var ter = termination[i];
                                        $('#hr_full_name_input').val(ter.fullname);
                                        $('#hr_emp_lstDate').val(ter.lastdate);
                                        $('#hr_emp_epf_input').val(ter.epf);
                                        $('#hr_join_date_input').val(ter.join_date);
                                        $('#hr_pno_input').val(ter.phone);
                                        $('#hr_emp_nic_input').val(ter.nic);
                                        $('#hr_address_input').val(ter.address);
                                        $('#hr_emp_select_designation').val(ter.designation);
                                        $('#hr_emp_select_gender').val(ter.gender);
                                        $('#hr_emp_select_department').val(ter.dep);
                                        $('#hr_emp_select_location').val(ter.location);
                                        $('#hr_emp_txt_area').val(ter.description);
                                    }
                                }
                                if (data.tpData) {
                                    let trans = JSON.parse(data.tpData);
                                    for (var i = 0; i < trans.length; i++) {
                                        var tp = trans[i];
                                        $('#hr_full_name_input').val(tp.fullname);
                                        $('#hr_emp_lstDate').val(tp.lastdate);
                                        $('#hr_emp_epf_input').val(tp.epf);
                                        $('#hr_join_date_input').val(tp.join_date);
                                        $('#hr_pno_input').val(tp.phone);
                                        $('#hr_emp_nic_input').val(tp.nic);
                                        $('#hr_address_input').val(tp.address);
                                        $('#hr_emp_select_designation').val(tp.designation);
                                        $('#hr_emp_select_gender').val(tp.gender);
                                        $('#hr_emp_select_department').val(tp.dep);
                                        $('#hr_emp_select_location').val(tp.location);
                                        $('#hr_emp_txt_area').val(tp.description);
                                        $('#transfer_promotion_desig_lbl').val(tp.newdesi);
                                        $('#transfer_promotion_department_lbl').val(tp.newdep);
                                        $('#transfer_promotion_branch_lbl').val(tp.newbra);
                                    }
                                }
                                var log = JSON.parse(data.ticketLog);
                                $('#recruitment_logbody').html('');
                                for (var i = 0; i < log.length; i++) {
                                    let tr = document.createElement('tr');
                                    $(tr).append('<td>' + log[i].id + '</td>');
                                    $(tr).append('<td>' + log[i].user + '</td>');
                                    $(tr).append('<td>' + log[i].action + '</td>');
                                    $(tr).append('<td>' + log[i].data + '</td>');
                                    $('#recruitment_logbody').append(tr);
                                }

                                $('#ticketTracking').html('');

                                // Get the timeline container element
                                var timelineContainer = document.querySelector('#ticketTracking');
                                timelineContainer.innerHTML = '';

                                // Define an array of colors for tlDot elements
                                var dotColors = ['red', 'blue', 'green', 'yellow']; // Add more colors as needed
                                var colorIndex = 0; // Initialize the color index

                                // Loop through the timeline data and create the timeline items dynamically
                                log.forEach(function (item, index) {
                                    // Create a new timeline item
                                    var tlItem = document.createElement('div');
                                    tlItem.classList.add('tl-item');

                                    // Create the timeline dot element
                                    var tlDot = document.createElement('div');
                                    tlDot.classList.add('tl-dot');

                                    //                    tlDot.style.backgroundColor = dotColors[colorIndex % dotColors.length]; // Assign the color dynamically

                                    // Update the color index
                                    colorIndex++;

                                    // Create the timeline time element
                                    var tlTime = document.createElement('div');
                                    tlTime.classList.add('tl-time');

                                    // Create the timeline content
                                    var tlContent = document.createElement('div');
                                    tlContent.classList.add('tl-content');

                                    var ticketAge = item.age;


                                    function convertTicketAge(ticketAge) {
                                        var parts = ticketAge.split(':');
                                        var days = parseInt(parts[0]);
                                        var hours = parseInt(parts[1]);
                                        var minutes = parseInt(parts[2]);
                                        var seconds = parseInt(parts[3]);

                                        var result = days + ' days ' + hours + ' hours ' + minutes + ' minutes ' + seconds + ' seconds';

                                        return result;
                                    }

                                    var convertedTicketAge = convertTicketAge(ticketAge);

                                    // Set the content of the timeline item
                                    tlContent.innerHTML = '<div><span class="tl-date text-muted mt-1">Step - </span>' + (index + 1).toString() + '</div>' +
                                            '<div class="tl-date text-muted mt-1">Name - ' + item.user + '</div>' +
                                            '<div class="tl-date text-muted mt-1">Date - ' + convertedTicketAge + '</div>' +
                                            '<div class="tl-date text-muted mt-1" style="background: #e6f2ff;">Action - ' + item.action + '</div>';


                                    // Append the dot and content to the timeline item
                                    tlItem.appendChild(tlDot);
                                    tlItem.appendChild(tlContent);

                                    // Append the timeline item to the timeline container
                                    timelineContainer.appendChild(tlItem);
                                });


                                $('#hr_recruitment_no').text(data.code);
                                if (data.ticketType === 'Recruitment') {
                                    $('#reqruitment_modal').modal('show');
                                } else if (data.ticketType === 'Termination') {
                                    $('#reqruitment_modal').modal('show');
                                } else if (data.ticketType === 'Transfer/Promotion') {
                                    $('#reqruitment_modal').modal('show');
                                } else {
                                    $('#show_ticket').modal('show');
                                }
                            }
                        });
                    }
                    );
                }
            });

            // var selectedTicketId = 0;

            //reqruitment user save button
            $(document).on('click', '#user_save_btn', function () {
                var idd = $('#reqruitment_modal').data('id');

                Swal.fire({
                    title: 'Are you sure?',
                    text: "Ticket Will be Closed!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, Proceed!',
                    showLoaderOnConfirm: true,
                    preConfirm: () => {
                        return fetch('ticket/closed-ticket', {
                            method: 'POST',
                            body: new URLSearchParams({
                                tctId: idd,
                            })
                        }).then(response => {
                            if (!response.ok) {
                                throw new Error(response.statusText);
                            }
                            return response.json();
                        }).catch(error => {
                            Swal.showValidationMessage('Request failed:' + error);
                        });
                    },
                    allowOutsideClick: () => !Swal.isLoading()
                }).then((result) => {
                    if (result.value) {
                        if (result.value.status !== 200) {
                            Swal.fire('Error!', result.value.msg, 'error');
                            clearForm();
                        } else {
                            Swal.fire('Sucessfull!', 'Type has been Changed !', 'success');
                            loadCount();
                            dtable.ajax.reload();
                            clearForm();

                        }
                    }
                });
            });

            // reqruitment user update
            $('#user_update_btn').click(function () {
                var idd = $('#reqruitment_modal').data('id');
                function saveSelectedCheckboxes() {
                    var checkboxes = document.querySelectorAll('input[type="checkbox"]');
                    var selectedCheckboxes = [];

                    checkboxes.forEach(function (checkbox) {
                        if (checkbox.checked) {
                            selectedCheckboxes.push(checkbox.value);
                        }
                    });

                    console.log(selectedCheckboxes);
                    return selectedCheckboxes;
                }

                var selectedCheckboxes = saveSelectedCheckboxes();

                $.post('ticket/Update_new_reqruitment', {
                    assetlist: JSON.stringify(selectedCheckboxes),
                    ticketId: idd,
                    pc_username_input: $('#pc_username_input').val(),
                    email_input: $('#email_input').val(),
                    system_username_input: $('#system_username_input').val()
                }, function (resp) {
                    if (resp == "ok") {
                        Swal.fire({
                            icon: 'success',
                            showConfirmButton: false,
                            timer: 1000
                        }).then(function () {
                        });
                    } else {
                        Swal.fire("success!", "ok");
                    }
                });
            });


            //ticket catogory change button
            $(document).on('click', '#update_edit_btn', function () {
                var idd = $('#show_ticket').data('id');

                Swal.fire({
                    title: 'Are you sure?',
                    text: "This Type Will be Change!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, Proceed!',
                    showLoaderOnConfirm: true,
                    preConfirm: () => {
                        return fetch('ticket/change_category', {
                            method: 'POST',
                            body: new URLSearchParams({
                                tctId: idd,
                                type: document.getElementById('select_category').value
                            })
                        }).then(response => {
                            if (!response.ok) {
                                throw new Error(response.statusText);
                            }
                            return response.json();
                        }).catch(error => {
                            Swal.showValidationMessage('Request failed:' + error);
                        });
                    },
                    allowOutsideClick: () => !Swal.isLoading()
                }).then((result) => {
                    if (result.value) {
                        if (result.value.status !== 200) {
                            Swal.fire('Error!', result.value.msg, 'error');
                            clearForm();
                        } else {
                            $("#change_category_div").hide();
                            Swal.fire('Sucessfull!', 'Type has been Changed !', 'success');
                            document.getElementById("tct_category").innerText = $("#select_category option:selected").text();
                            dtable.ajax.reload();
                            loadCount();
                            clearForm();

                        }
                    }
                });
            });


            $(document).on('click', '#close_edit_btn', function () {

                $("#change_category_div").hide();
            });


            $(document).on('click', '#tct_category', function () {
                $("#change_category_div").show();

                var job_sub_type = new SlimSelect({
                    select: '#select_category',
                    ajax: function (search, callback) {
                        fetch('ticket/get-app', {
                            method: 'POST',
                            body: new URLSearchParams({
                                search: search || '',
                                //                            category: data.ticketType
                            })
                        }).then(res => res.json()).then((data) => {
                            callback(data);
                        });
                    },
                    allowDeselect: false,
                    deselectLabel: '<span class="red">✖</span>',
                    showSearch: false
                });
                //            job_sub_type.set(data.category);
            });

            var select_sub_status = new SlimSelect({
                select: '#select_sub_status'
            })
            var users = new SlimSelect({
                select: '#users',
                placeholder: "Select a User",
                searchHighlight: true,

                ajax: function (search, callback) {
                    fetch('user/search-users', {
                        method: 'POST',
                        body: new URLSearchParams({search: search || ''})
                    }).then(res => res.json()).then((data) => {
                        callback(data);
                    });
                },
                allowDeselect: true,
                deselectLabel: '<span class="red">✖</span>'
            });
            $('#users').data('select', users);

            //        $(document).ready(function () {
            //            $('#log_table').DataTable({
            //                "aLengthMenu": [[5, 10, 25, -1], [5, 10, 25, "All"]],
            //            });
            //
            //        });

            $(document).on('click', '#ticket_assign_btn', function () {
                Swal.fire({
                    title: 'Are you sure?',
                    //                    text: "This Ticket Will be Closed!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, Proceed!',
                    showLoaderOnConfirm: true,
                    preConfirm: () => {
                        return fetch('ticket/assign', {
                            method: 'POST',
                            body: new URLSearchParams({
                                type: document.getElementById('select_sub_status').value,
                                user: JSON.stringify(users.selected()),
                                ticketId: $('#show_ticket').data('id')})
                        }).then(response => {
                            if (!response.ok) {
                                throw new Error(response.statusText);
                            }
                            return response.json();
                        }).catch(error => {
                            Swal.showValidationMessage('Request failed:' + error);
                        });
                    },
                    allowOutsideClick: () => !Swal.isLoading()

                }).then((result) => {
                    if (result.value) {
                        if (result.value.status !== 200) {
                            Swal.fire('Error!', result.value.msg, 'error');
                        } else {
                            Swal.fire('Successfull!', 'Ticket has been Assign !', 'success');
                            dtable.ajax.reload();
                            loadCount();

                        }
                    }
                });

            });

            $(document).on('click', '#save_btn', function () {
                Swal.fire({
                    title: 'Are you sure?',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, Proceed!',
                    showLoaderOnConfirm: true,
                    preConfirm: () => {
                        return fetch('ticket/status-ticket', {
                            method: 'POST',
                            body: new URLSearchParams({
                                status: document.getElementById('select_status').value,
                                type: document.getElementById('select_job_type').value,
                                ticketId: $('#show_ticket').data('id')})
                        }).then(response => {
                            if (!response.ok) {
                                throw new Error(response.statusText);
                            }
                            return response.json();
                        }).catch(error => {
                            Swal.showValidationMessage('Request failed:' + error);
                        });
                    },
                    allowOutsideClick: () => !Swal.isLoading()

                }).then((result) => {
                    if (result.value) {
                        if (result.value.status !== 200) {
                            Swal.fire('Error!', result.value.msg, 'error');
                        } else {
                            Swal.fire('Successfull!', 'success');
                            dtable.ajax.reload();
                            loadCount();

                        }
                    }
                });
            });

            //save comment 
            $('#comment_btn').click(function () {
                Swal.fire({
                    title: 'Are you sure?',
                    text: "This Comment Will Be Sent!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, Proceed!',
                    showLoaderOnConfirm: true,
                    preConfirm: () => {
                        return fetch('ticket/save-comment-text', {
                            method: 'POST',
                            body: new URLSearchParams({
                                ticketId: $('#show_ticket').data('id'),
                                comment: document.getElementById('newComment').value
                            })
                        }).then(response => {
                            if (!response.ok) {
                                throw new Error(response.statusText);
                            }

                            return response.json();
                        }).catch(error => {
                            Swal.showValidationMessage('Request failed:' + error);
                        });
                    },
                    allowOutsideClick: () => !Swal.isLoading()

                }).then((result) => {
                    if (result.value) {
                        if (result.value.status !== 200) {
                            Swal.fire('Error!', result.value.msg, 'error');
                        } else {
                            Swal.fire('Successfull!', 'Comment has been sent!', 'success');
                        }
                    }
                });
            });



            function loadCount() {
                fetch('ticket/count').then((res) => res.json()).then((data) => {
                    //                    console.log(data);
                    for (let i = 0; i < data.length; i++) {
                        if (data[i].id === 5) {
                            $('#queued_card_all').html(data[i].tot);
                            let sub = JSON.parse(data[i].sub);
                            for (var j = 0; j < sub.length; j++) {
                                if (sub[j].type === 'Application Issues') {
                                    $('#queued_card_ap').html(sub[j].cnt);
                                } else if (sub[j].type === 'Modifications') {
                                    $('#queued_card_hw').html(sub[j].cnt);
                                } else if (sub[j].type === 'User Access') {
                                    $('#queued_card_hr').html(sub[j].cnt);
                                }
                            }
                        } else if (data[i].id === 3) {
                            $('#inprogress_card_all').html(data[i].tot);
                            let sub = JSON.parse(data[i].sub);
                            for (var j = 0; j < sub.length; j++) {
                                if (sub[j].type === 'Application Issues') {
                                    $('#inprogress_card_ap').html(sub[j].cnt);
                                } else if (sub[j].type === 'Modifications') {
                                    $('#inprogress_card_hw').html(sub[j].cnt);
                                } else if (sub[j].type === 'User Access') {
                                    $('#inprogress_card_hr').html(sub[j].cnt);
                                }
                            }
                        } else if (data[i].id === 2) {
                            $('#finish_card_all').html(data[i].tot);
                            let sub = JSON.parse(data[i].sub);
                            for (var j = 0; j < sub.length; j++) {
                                if (sub[j].type === 'Application Issues') {
                                    $('#finish_card_ap').html(sub[j].cnt);
                                } else if (sub[j].type === 'Modifications') {
                                    $('#finish_card_hw').html(sub[j].cnt);
                                } else if (sub[j].type === 'User Access') {
                                    $('#finish_card_hr').html(sub[j].cnt);
                                }
                            }
                        } else if (data[i].id === 4) {
                            $('#closed_card_all').html(data[i].tot);
                            let sub = JSON.parse(data[i].sub);
                            for (var j = 0; j < sub.length; j++) {
                                if (sub[j].type === 'Application Issues') {
                                    $('#closed_card_ap').html(sub[j].cnt);
                                } else if (sub[j].type === 'Modifications') {
                                    $('#closed_card_hw').html(sub[j].cnt);
                                } else if (sub[j].type === 'User Access') {
                                    $('#closed_card_hr').html(sub[j].cnt);
                                }
                            }
                        } else if (data[i].id === 11) {
                            $('#assigned_card_all').html(data[i].tot);
                            if (data[i].sub) {
                                let sub = JSON.parse(data[i].sub);

                                for (var j = 0; j < sub.length; j++) {
                                    if (sub[j].type === 'Application Issues') {
                                        $('#assigned_card_ap').html(sub[j].cnt);
                                    } else if (sub[j].type === 'Modifications') {
                                        $('#assigned_card_hw').html(sub[j].cnt);
                                    } else if (sub[j].type === 'User Access') {
                                        $('#assigned_card_hr').html(sub[j].cnt);
                                    }
                                }
                            }
                        } else if (data[i].id === 12) {
                            $('#mytickets_card_all').html(data[i].tot);
                            if (data[i].sub) {
                                let sub = JSON.parse(data[i].sub);

                                for (var j = 0; j < sub.length; j++) {
                                    if (sub[j].type === 'Application Issues') {
                                        $('#mytickets_card_ap').html(sub[j].cnt);
                                    } else if (sub[j].type === 'Modifications') {
                                        $('#mytickets_card_hw').html(sub[j].cnt);
                                    } else if (sub[j].type === 'User Access') {
                                        $('#mytickets_card_hr').html(sub[j].cnt);
                                    }
                                }
                            }
                        } else if (data[i].id === 13) {
//                            $('#mytickets_card_all').html(data[i].tot);
                            if (data[i].sub) {
                                let sub = JSON.parse(data[i].sub);

                                for (var j = 0; j < sub.length; j++) {
                                    if (sub[j].type === 'Application Issues') {
                                        $('#newTicket_ap').html(sub[j].cnt);
                                    } else if (sub[j].type === 'Modifications') {
                                        $('#newTicket_hw').html(sub[j].cnt);
                                    } else if (sub[j].type === 'User Access') {
                                        $('#mytickets_card_hr').html(sub[j].cnt);
                                    }
                                }
                            }
                        }

                    }

                });
            }
            //                $.get('ticket/count', {}, function (res) {
            //                    let data = JSON.parse(res);
            //
            //                });


        </script>
    </body>
</html>
