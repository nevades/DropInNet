<%-- 
    Document   : mis
    Created on : May 2, 2023, 3:22:49 PM
    Author     : Nevanjith
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Drop-In-Net</title>
        <%@include file="jspf/header.jspf" %>
        <style>
        </style>

    </head>
    <body>
        <style>
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
                <div class="pcoded-main-container" style="background-color: #CACFD2;">
                    <div class="pcoded-wrapper">
                        <%@include file="jspf/sidenav.jspf"%>
                        <div class="pcoded-content">
                            <div class="pcoded-inner-content">
                                <div class="main-body">
                                    <div class="page-wrapper">
                                        <div class="page-body">
                                            <div class="row">
                                                <div class="card " id="cardreport" tabindex="-1" style="margin: 10px;width: 1000px;">

                                                    <a  class="text-right" style="text-align: right;  margin-bottom:0px;">
                                                        <div class="" style="margin-left: 20px;">
                                                            <!--<button type="button" class="btn-close exit"  aria-label="Close"></button>-->
                                                        </div>
                                                    </a>
                                                    <div class="card-header">
                                                        <h5 class="card-title">Finance Report</h5>
                                                        <!--                <button type="button" class="btn-close exit"  aria-label="Close"></button>-->

                                                    </div>
                                                    <div class="card-body">

                                                        <ul class="nav nav-tabs " id="myTab1" role="tablist">
                                                            <li class="nav-item ">
                                                                <a class="nav-link active" id="home-tab1" data-toggle="tab" href="#home1" role="tab" aria-controls="home" aria-selected="true"><i class="fa fa-pencil"></i>Category Preview</a>
                                                            </li>
                                                            <li class="nav-item">
                                                                <a class="nav-link" id="profile-tab1" data-toggle="tab" href="#profile1" role="tab" aria-controls="profile" aria-selected="false"> <i class="fa fa-list-alt"></i>Department Preview</a>
                                                            </li>

                                                        </ul>
                                                        <br>
                                                        <div class="tab-content " id="myTabContent">
                                                            <div class="tab-pane fade show active" id="home1" role="tabpanel" aria-labelledby="home-tab1">
                                                                <div id="rtable" class="" style=" margin: 20px">
                                                                    <table class="table table-bordered table-striped" id="tbl">

                                                                        <thead>
                                                                            <tr>
                                                                                <th colspan="1"></th>
                                                                                <th colspan="1"></th>
                                                                                <th colspan="3" class="text-center">Monthly</th>
                                                                                <th colspan="3" class="text-center">Year to date</th>
                                                                                <th colspan="3" class="text-center">All</th>
                                                                            </tr>
                                                                            <tr>
                                                                                <th>Type</th>
                                                                                <th>Category</th>
                                                                                <th>Reported</th>
                                                                                <th>In-Progress</th>
                                                                                <th>Closed</th>
                                                                                <th>Reported</th>
                                                                                <th>In-Progress</th>
                                                                                <th>Closed</th>
                                                                                <th>Reported</th>
                                                                                <th>In-Progress</th>
                                                                                <th>Closed</th>
                                                                            </tr>
                                                                        </thead>

                                                                        <tbody id="tbl_body">

                                                                        </tbody>
                                                                        <tfoot>

                                                                        </tfoot>
                                                                    </table>
                                                                </div>

                                                            </div>

                                                            <div class="tab-pane fade" id="profile1" role="tabpanel" aria-labelledby="profile-tab1">
                                                                <div id="branchtable" class="" style=" margin: 20px">
                                                                    <table class="table table-bordered table-striped" id="tbl">

                                                                        <thead>
                                                                            <tr>
                                                                                <th colspan="1"></th>
                                                                                <th colspan="1"></th>
                                                                                <th colspan="3" class="text-center">Monthly</th>
                                                                                <th colspan="3" class="text-center">Year to date</th>
                                                                                <th colspan="3" class="text-center">All</th>
                                                                            </tr>
                                                                            <tr>
                                                                                <th>Department</th>
                                                                                <th>Category</th>
                                                                                <th>Reported</th>
                                                                                <th>In-Progress</th>
                                                                                <th>Closed</th>
                                                                                <th>Reported</th>
                                                                                <th>In-Progress</th>
                                                                                <th>Closed</th>
                                                                                <th>Reported</th>
                                                                                <th>In-Progress</th>
                                                                                <th>Closed</th>
                                                                            </tr>
                                                                        </thead>

                                                                        <tbody id="branchtable_body">

                                                                        </tbody>
                                                                        <tfoot id="branchtable_footer">

                                                                        </tfoot>
                                                                    </table>
                                                                </div>
                                                            </div>
                                                        </div>



                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-sm btn-primary" value="Print" onclick="PrintElem()">
                                                            <i class="bi bi-printer"></i>Print
                                                        </button>
                                                        <input type="button" id="btnExport" value="Download" class="btn btn-primary btn-sm " onclick="Export()">
                                                        <button type="button" class="btn btn-sm btn-danger" data-bs-dismiss="modal">Cancel</button>
                                                    </div>
                                                </div>
                                                <div class="col">
                                                    <div class="card" style="height: 200px; margin-top: 10px;">
                                                        <div style="height: 400px; width: 400px;">
                                                            <canvas id="myChart"></canvas>
                                                        </div>
                                                    </div>
                                                    <div class="card" style="height: auto; margin-top: 10px;">
                                                        <div style="height: 400px; width: 400px;">
                                                            <canvas id="myChart1"></canvas>                                                        
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div id="report_data" class="modal fade" tabindex="-1" role="dialog" style=" padding-right: 17px;"> 
                                                <div class="modal-dialog modal-lg " style="max-width: 1300px;">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">Finance Report</h5>
                                                            <div class="col-1">
                                                                <button type="button" class="close pull-right " data-dismiss="modal" aria-label="Close">
                                                                    <span aria-hidden="true">×</span>
                                                                </button> 
                                                            </div> 
                                                        </div>
                                                        <div class="modal-body">

                                                            <div id="rtable" class="card" style=" margin: 20px">
                                                                <div class="card-header">
                                                                    <table class="table table-bordered table-striped" id="tb2">

                                                                        <thead>

                                                                        <th style="display: none">ID</th>
                                                                        <th>Ticket Number</th>
                                                                        <th>Subject</th>                                   
                                                                        <th>Priority</th>
                                                                        <th>Reported by</th>
                                                                        <th>Assign</th>
                                                                        <th>Status</th>

                                                                        </thead>

                                                                        <tbody>

                                                                        </tbody>
                                                                        <tfoot>

                                                                        </tfoot>
                                                                    </table>
                                                                </div>
                                                            </div>

                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-sm btn-primary" value="Print" onclick="PrintElem()">
                                                                <i class="bi bi-printer"></i>Print
                                                            </button>
                                                            <input type="button" id="btnExport" value="Download" class="btn btn-primary btn-sm " onclick="Export()">
                                                            <button type="button" class="btn btn-sm btn-danger" data-bs-dismiss="modal">Cancel</button> 

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

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
                                                        </div>    
                                                        <div class="row">
                                                            <section class="work_skills card col-8" id="comment_card" style="margin-left: 10px ">

                                                                <br>

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

                                                            </section>
                                                            <section class="timeline_about card " style="margin: 0px 0 0 25px;width: 420px;">
                                                                <h1 class="heading">Tracking Details</h1>
                                                                <div class="ticketTracking" id="ticketTracking"></div>

                                                            </section>
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

        <%@include file="jspf/scripts.jspf"%>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script type="text/javascript" src="files/js/slimselect.js"></script>
        <script type="text/javascript" src="files/js/datatables.min.js"></script>
        <script type="text/javascript" src="files/js/sweetalert2.js"></script>
        <script type="text/javascript" src="files/js/func.js"></script>
        <script type="text/javascript" src="files/js/autoNumeric.js"></script>
        <script type="text/javascript" src="files/js/dataTables.responsive.min.js"></script>
        <script type="text/javascript" src="files/js/jquery.rowspanizer.js"></script>
        <script>
        </script>
        <script>
            fetch('mis/report').then((res) => res.json()).then((data) => {

                $('#tbl_body').html('');
                for (var i = 0; i < data.length; i++) {

                    let tr = document.createElement('tr');

                    $(tr).append('<td>' + data[i].ttype + '</td>');
                    $(tr).append('<td>' + data[i].cat + '</td>');
                    $(tr).append('<td class="text-right" frq="monthly" st="reportred" style="cursor:pointer">' + data[i].monthlyReported + '</td>');
                    $(tr).append('<td class="text-right" frq="monthly" st="in-progress" style="cursor:pointer">' + data[i].monthlyInProgress + '</td>');
                    $(tr).append('<td class="text-right" frq="monthly" st="closed" style="cursor:pointer">' + data[i].monthlyClosed + '</td>');
                    $(tr).append('<td class="text-right" frq="ytd" st="reportred" style="cursor:pointer">' + data[i].yearlyReported + '</td>');
                    $(tr).append('<td class="text-right" frq="ytd" st="in-progress" style="cursor:pointer">' + data[i].yearlyInProgress + '</td>');
                    $(tr).append('<td class="text-right" frq="ytd" st="closed" style="cursor:pointer">' + data[i].yearlyClosed + '</td>');
                    $(tr).append('<td class="text-right" frq="all" st="reportred" style="cursor:pointer">' + data[i].allReported + '</td>');
                    $(tr).append('<td class="text-right" frq="all" st="in-progress" style="cursor:pointer">' + data[i].allInProgress + '</td>');
                    $(tr).append('<td class="text-right" frq="all" st="closed" style="cursor:pointer">' + data[i].allClosed + '</td>');

                    $('#tbl_body').append(tr);

                    let ttype = data[i].ttype;
                    let category = data[i].cat;
                    $(tr).find('.text-right').click(function () {

                        $('#tb2 tbody').html('');
                        $('#tb2 tfoot').html('');

                        let frquency = $(this).attr('frq');
                        let status = $(this).attr('st');

                        fetch('mis/view-category-data', {
                            method: 'POST',
                            body: new URLSearchParams({type: ttype, category: category, frquency: frquency, status: status})
                        }).then((res) => res.json()).then((data) => {


                            for (var i = 0; i < data.length; i++) {
                                let tr = document.createElement('tr');
                                $(tr).append('<td style="display:none;" >' + data[i].id + '</td>');
                                $(tr).append('<td>' + data[i].code + '</td>');
                                $(tr).append('<td>' + data[i].subject + '</td>');
                                $(tr).append('<td>' + data[i].priority + '</td>');
                                $(tr).append('<td>' + data[i].entBy + '</td>');
                                $(tr).append('<td class="text-center">' + data[i].assignUser + '</td>');
                                $(tr).append('<td class="text-right">' + data[i].status + '</td>');

                                $('#tb2 tbody').append(tr);


                                $(tr).find('td').click(function () {
                                    let id = $(this).parent().find('td').eq(0).text();
//                                    alert(id);
                                    fetch('ticket/Data', {
                                        method: 'POST',
                                        body: new URLSearchParams({id: id})
                                    }).then((res) => res.json()).then((data) => {

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

                                        var tr1 = $('#tct_priority').html(data.priority);
                                        if ($(tr1).html() === ('Normal')) {
                                            $(tr1).html('<label class="" style="white-space: nowrap; color: #0ac282;">Normal</label>');
                                        } else if ($(tr1).html() === 'Urgent') {
                                            $(tr1).html('<label class="" style="white-space: nowrap; color: #fe5d70;">Urgent</label>');
                                        }
                                        $('#tct_description').html(data.description);
                                        $('.tct_id').html(data.id);


                                        var log = JSON.parse(data.ticketLog);

                                        $('#ticketTracking').html('');

                                        var timelineContainer = document.querySelector('#ticketTracking');
                                        timelineContainer.innerHTML = '';

                                        var dotColors = ['red', 'blue', 'green', 'yellow']; // Add more colors as needed
                                        var colorIndex = 0; // Initialize the color index

                                        log.forEach(function (item, index) {
                                            var tlItem = document.createElement('div');
                                            tlItem.classList.add('tl-item');

                                            var tlDot = document.createElement('div');
                                            tlDot.classList.add('tl-dot');

                                            colorIndex++;

                                            var tlTime = document.createElement('div');
                                            tlTime.classList.add('tl-time');

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

                                            tlContent.innerHTML = '<div><span class="tl-date text-muted mt-1">Step - </span>' + (index + 1).toString() + '</div>' +
                                                    '<div class="tl-date text-muted mt-1">Name - ' + item.user + '</div>' +
                                                    '<div class="tl-date text-muted mt-1">Date - ' + convertedTicketAge + '</div>' +
                                                    '<div class="tl-date text-muted mt-1" style="background: #e6f2ff;">Action - ' + item.action + '</div>';

                                            tlItem.appendChild(tlDot);
                                            tlItem.appendChild(tlContent);

                                            timelineContainer.appendChild(tlItem);
                                        });

                                        $('#show_ticket').modal('show');

                                    });
                                });

                            }


//                            $('#tb2').DataTable({
//                                "bLengthChange": false,
//                                "bPaginate": false,
//                                "bFilter": false,
//                            });

                            $('#report_data').modal('show');


                        });
                    });
                }

                $('#tbl_body').rowspanizer({
                    columns: [0],
                    vertical_align: 'middle'
                });

            });



            fetch('mis/branch-report').then((res) => res.json()).then((data) => {


                for (var i = 0; i < data.length; i++) {

                    let tr = document.createElement('tr');

                    $(tr).append('<td>' + data[i].branch + '</td>');
                    $(tr).append('<td>' + data[i].ttype + '</td>');
                    $(tr).append('<td class="text-right" frq="monthly" st="reportred" style="cursor:pointer">' + data[i].monthlyReported + '</td>');
                    $(tr).append('<td class="text-right" frq="monthly" st="in-progress" style="cursor:pointer">' + data[i].monthlyInProgress + '</td>');
                    $(tr).append('<td class="text-right" frq="monthly" st="closed" style="cursor:pointer">' + data[i].monthlyClosed + '</td>');
                    $(tr).append('<td class="text-right" frq="ytd" st="reportred" style="cursor:pointer">' + data[i].yearlyReported + '</td>');
                    $(tr).append('<td class="text-right" frq="ytd" st="in-progress" style="cursor:pointer">' + data[i].yearlyInProgress + '</td>');
                    $(tr).append('<td class="text-right" frq="ytd" st="closed" style="cursor:pointer">' + data[i].yearlyClosed + '</td>');
                    $(tr).append('<td class="text-right" frq="all" st="reportred" style="cursor:pointer">' + data[i].allReported + '</td>');
                    $(tr).append('<td class="text-right" frq="all" st="in-progress" style="cursor:pointer">' + data[i].allInProgress + '</td>');
                    $(tr).append('<td class="text-right" frq="all" st="closed" style="cursor:pointer">' + data[i].allClosed + '</td>');

                    if (data[i].branch === 'Total') {
                        $(tr).find('td').addClass('table-dark');
                        $('#branchtable_footer').append(tr);
                    } else {
                        $('#branchtable_body').append(tr);
                    }

                    let department = data[i].branch;
                    let category = data[i].ttype;

                    $(tr).find('.text-right').click(function () {

                        $('#tb2 tbody').html('');
                        $('#tb2 tfoot').html('');

                        let frquency = $(this).attr('frq');
                        let status = $(this).attr('st');

                        fetch('mis/view-data', {
                            method: 'POST',
                            body: new URLSearchParams({department: department, category: category, frquency: frquency, status: status})
                        }).then((res) => res.json()).then((data) => {


                            for (var i = 0; i < data.length; i++) {
                                let tr = document.createElement('tr');
                                $(tr).append('<td style="display:none;" >' + data[i].id + '</td>');
                                $(tr).append('<td>' + data[i].code + '</td>');
                                $(tr).append('<td>' + data[i].subject + '</td>');
                                $(tr).append('<td>' + data[i].priority + '</td>');
                                $(tr).append('<td>' + data[i].entBy + '</td>');
                                $(tr).append('<td class="text-center">' + data[i].assignUser + '</td>');
                                $(tr).append('<td class="text-right">' + data[i].status + '</td>');

                                $('#tb2 tbody').append(tr);


                                $(tr).find('td').click(function () {
                                    let id = $(this).parent().find('td').eq(0).text();
//                                    alert(id);
                                    fetch('ticket/Data', {
                                        method: 'POST',
                                        body: new URLSearchParams({id: id})
                                    }).then((res) => res.json()).then((data) => {

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

                                        var tr1 = $('#tct_priority').html(data.priority);
                                        if ($(tr1).html() === ('Normal')) {
                                            $(tr1).html('<label class="" style="white-space: nowrap; color: #0ac282;">Normal</label>');
                                        } else if ($(tr1).html() === 'Urgent') {
                                            $(tr1).html('<label class="" style="white-space: nowrap; color: #fe5d70;">Urgent</label>');
                                        }
                                        $('#tct_description').html(data.description);
                                        $('.tct_id').html(data.id);


                                        var log = JSON.parse(data.ticketLog);

                                        $('#ticketTracking').html('');

                                        var timelineContainer = document.querySelector('#ticketTracking');
                                        timelineContainer.innerHTML = '';

                                        var dotColors = ['red', 'blue', 'green', 'yellow']; // Add more colors as needed
                                        var colorIndex = 0; // Initialize the color index

                                        log.forEach(function (item, index) {
                                            var tlItem = document.createElement('div');
                                            tlItem.classList.add('tl-item');

                                            var tlDot = document.createElement('div');
                                            tlDot.classList.add('tl-dot');

                                            colorIndex++;

                                            var tlTime = document.createElement('div');
                                            tlTime.classList.add('tl-time');

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

                                            tlContent.innerHTML = '<div><span class="tl-date text-muted mt-1">Step - </span>' + (index + 1).toString() + '</div>' +
                                                    '<div class="tl-date text-muted mt-1">Name - ' + item.user + '</div>' +
                                                    '<div class="tl-date text-muted mt-1">Date - ' + convertedTicketAge + '</div>' +
                                                    '<div class="tl-date text-muted mt-1" style="background: #e6f2ff;">Action - ' + item.action + '</div>';

                                            tlItem.appendChild(tlDot);
                                            tlItem.appendChild(tlContent);

                                            timelineContainer.appendChild(tlItem);
                                        });

                                        $('#show_ticket').modal('show');

                                    });
                                });

                            }


//                            $('#tb2').DataTable({
//                                "bLengthChange": false,
//                                "bPaginate": false,
//                                "bFilter": false,
//                            });

                            $('#report_data').modal('show');


                        });
                    });

                }

                $('#branchtable_body').rowspanizer({
                    columns: [0],
                    vertical_align: 'middle'
                });

            });
//            $(document).on('click', '.row-id', function () {
//                let id = $(this).attr('idd');
//                alert(id);
//            });

            const ctx = document.getElementById('myChart');

            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['Delon', 'Nuwanthi', 'Shehan', 'Prashan', 'Amandi', 'Hiruni'],
                    datasets: [{
                            label: '# of Tickets Closed',
                            data: [12, 19, 20, 5, 9, 6],
                            borderWidth: 1
                        }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });

            const ctxs = document.getElementById('myChart1');

            new Chart(ctxs, {
                type: 'polarArea',
                data: {
                    labels: ['Delon', 'Nuwanthi', 'Shehan', 'Prashan', 'Amandi', 'Hiruni'],
                    datasets: [{
                            label: '# of Tickets Closed',
                            data: [12, 19, 20, 5, 9, 6],
                            borderWidth: 1
                        }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });


//            const config = {
//                type: 'polarArea',
//                data: data,
//                options: {}
//            };
//
//            const data = {
//                labels: [
//                    'Red',
//                    'Green',
//                    'Yellow',
//                    'Grey',
//                    'Blue'
//                ],
//                datasets: [{
//                        label: 'My First Dataset',
//                        data: [11, 16, 7, 3, 14],
//                        backgroundColor: [
//                            'rgb(255, 99, 132)',
//                            'rgb(75, 192, 192)',
//                            'rgb(255, 205, 86)',
//                            'rgb(201, 203, 207)',
//                            'rgb(54, 162, 235)'
//                        ]
//                    }]
//            };

        </script>

    </body>
</html>
