<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Fintrex - DropinNet </title>
        <%@include file="jspf/header.jspf" %>
    </head>
    <body>
        <style>
            .hidden {
                display: none;
            }

            .tooltip {
                position: relative;
                display: inline-block;
                border-bottom: 1px dotted black;
            }

            .tooltip .tooltiptext {
                visibility: hidden;
                width: 120px;
                background-color: black;
                color: #fff;
                text-align: center;
                border-radius: 6px;
                padding: 5px 0;
                position: absolute;
                z-index: 1;
                bottom: 150%;
                left: 50%;
                margin-left: -60px;
            }

            .tooltip .tooltiptext::after {
                content: "";
                position: absolute;
                top: 100%;
                left: 50%;
                margin-left: -5px;
                border-width: 5px;
                border-style: solid;
                border-color: black transparent transparent transparent;
            }

            .tooltip:hover .tooltiptext {
                visibility: visible;
            }

            .switch {
                position: relative;
                display: inline-block;
                width: 60px;
                height: 21px;
            }

            .switch input {
                opacity: 0;
                width: 0;
                height: 0;
            }

            .slider {
                position: absolute;
                cursor: pointer;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: #ccc;
                -webkit-transition: .4s;
                transition: .4s;
            }

            .slider:before {
                position: absolute;
                content: "";
                height: 13px;
                width: 13px;
                left: 4px;
                bottom: 4px;
                background-color: white;
                -webkit-transition: .4s;
                transition: .4s;
            }

            input:checked + .slider {
                background-color: #2196F3;
            }

            input:focus + .slider {
                box-shadow: 0 0 1px #2196F3;
            }

            input:checked + .slider:before {
                -webkit-transform: translateX(26px);
                -ms-transform: translateX(26px);
                transform: translateX(26px);
            }

            .slider.round {
                border-radius: 34px;
            }

            .slider.round:before {
                border-radius: 50%;
            }

            .pcoded-inner-content {
                /*background-image: url("./files/images/Background.jpg");*/
                background-color: rgb(93, 109, 126);
                /*background-color: rgb(93, 109, 126);*/
                /*                background-color: -moz-linear-gradient(90deg, rgba(64,131,187,1) 0%, rgba(96,142,205,1) 50%);
                                background-color: -webkit-linear-gradient(90deg, rgba(64,131,187,1) 0%, rgba(96,142,205,1) 50%);
                                background-color: linear-gradient(90deg, rgba(64,131,187,1) 0%, rgba(96,142,205,1) 50%);
                                filter: progid:DXImageTransform.Microsoft.gradient(startColorstr="#4083bb",endColorstr="#608ecd",GradientType=1);*/
            }
            .pcoded-main-container {
                background: rgb(93, 109, 126);
                /*                                background: -moz-linear-gradient(90deg, rgba(64,131,187,1) 0%, rgba(96,142,205,1) 50%);
                                                background: -webkit-linear-gradient(90deg, rgba(64,131,187,1) 0%, rgba(96,142,205,1) 50%);
                                                background: linear-gradient(90deg, rgba(64,131,187,1) 0%, rgba(96,142,205,1) 50%);
                                                filter: progid:DXImageTransform.Microsoft.gradient(startColorstr="#4083bb",endColorstr="#608ecd",GradientType=1);*/
            }

            .data-card{
                width: 170px;
                margin-left: 5px;
            }

            .count-count{
                margin-top: -2px;
                margin-left: 120px;
                width: 50px;
            }

            @media screen and (max-width: 768px) {

                .img-fluid {
                    max-width: 40%;
                }
                .data-card {
                    margin-bottom: 10px;
                }
                .dashcontainer {
                    margin-left: 18px;
                }
            }

            @media screen and (min-width: 768px) and (max-width: 1024px) {

                .data-card{
                    width: 170px;
                    margin-bottom :10px;
                }
                .img-fluid {
                    max-width: 20%;
                    height: auto;
                }
                .dashcontainer {
                    margin-left: 20px;
                }
            }

            .dashcard .card-title {
                font-size: 15px;
                text-align: center;
            }


            @media screen and (min-width: 768px) and (max-width: 1366px)  {
                .dashcard .card-title {
                    font-size: 12px;
                    text-align: center;
                }

                .data-card {
                    width: 150px;
                }

                .count-count {
                    margin-left: 100px;
                }

                .count-count-assign {
                    margin-left: 100px;
                    margin-top: 20px;
                }

                .count-count-all {
                    margin-left: 100px;
                    margin-top: 2px;
                }

                .leftfix {
                    margin-right: -130px;
                }

                .autofx {
                    width: auto;
                }
            }

            span.grey {
                background: #666;
                border-radius: 0.8em;
                -moz-border-radius: 0.8em;
                -webkit-border-radius: 0.8em;
                color: #fff;
                display: inline-block;
                font-weight: bold;
                line-height: 1.6em;
                margin-right: 15px;
                /*text-align: center;*/
                width: 1.6em;
            }

            <%
                                                   if(session.getAttribute("type").toString().equals("1") | session.getAttribute("type").toString().equals("2")){
            %>
            .dashcontainer {
                max-width: 1400px;
                padding: 0;
                /*margin-left: 145px;*/
                border-radius: 25px;
            }

            <%
                }
            %>

            .container{
                max-width:900px;
            }
            .inbox_people {
                background: #fff;
                float: left;
                overflow: hidden;
                width: 30%;
                border-right: 1px solid #ddd;
            }

            .inbox_msg {
                border: 1px solid #ddd;
                clear: both;
                overflow: hidden;
            }

            .top_spac {
                margin: 20px 0 0;
            }

            .recent_heading {
                float: left;
                width: 40%;
            }

            .srch_bar {
                display: inline-block;
                text-align: right;
                width: 60%;

            }

            .headind_srch {
                padding: 10px 29px 10px 20px;
                overflow: hidden;
                border-bottom: 1px solid #c4c4c4;
            }

            .recent_heading h4 {
                color: #0465ac;
                font-size: 16px;
                margin: auto;
                line-height: 29px;
            }

            .srch_bar input {
                outline: none;
                border: 1px solid #cdcdcd;
                border-width: 0 0 1px 0;
                width: 80%;
                padding: 2px 0 4px 6px;
                background: none;
            }

            .srch_bar .input-group-addon button {
                background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
                border: medium none;
                padding: 0;
                color: #707070;
                font-size: 18px;
            }

            .srch_bar .input-group-addon {
                margin: 0 0 0 -27px;
            }

            .chat_ib h5 {
                font-size: 15px;
                color: #464646;
                margin: 0 0 8px 0;
            }

            .chat_ib h5 span {
                font-size: 13px;
                float: right;
            }

            .chat_ib p {
                font-size: 12px;
                color: #989898;
                margin: auto;
                display: inline-block;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .chat_img {
                float: left;
                width: 11%;
            }

            .chat_img img {
                width: 100%
            }

            .chat_ib {
                float: left;
                padding: 0 0 0 15px;
                width: 88%;
            }

            .chat_people {
                overflow: hidden;
                clear: both;
            }

            .chat_list {
                border-bottom: 1px solid #ddd;
                margin: 0;
                padding: 18px 16px 10px;
            }

            .inbox_chat {
                height: 550px;
                overflow-y: scroll;
            }

            .active_chat {
                background: #e8f6ff;
            }

            .incoming_msg_img {
                display: inline-block;
                width: 6%;
            }

            .incoming_msg_img img {
                width: 100%;
            }

            .received_msg {
                display: inline-block;
                padding: 0 0 0 10px;
                vertical-align: top;
                width: 92%;
            }

            .received_withd_msg p {
                background: #ebebeb none repeat scroll 0 0;
                border-radius: 0 15px 15px 15px;
                color: #646464;
                font-size: 14px;
                margin: 0;
                padding: 5px 10px 5px 12px;
                width: 100%;
            }

            .time_date {
                color: #747474;
                display: block;
                font-size: 12px;
                margin: 8px 0 0;
            }

            .mesgs{
                float: left;
                padding: 30px 15px 0 25px;
                width:70%;
            }

            .sent_msg p {
                background:#0465ac;
                border-radius: 12px 15px 15px 0;
                font-size: 14px;
                margin: 0;
                color: #fff;
                padding: 5px 10px 5px 12px;
                width: 100%;
            }

            .outgoing_msg {
                overflow: hidden;
                margin: 26px 0 26px;

            }

            .sent_msg {
                float: right;
                width: 80%;
            }

            .input_msg_write input {
                background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
                border: medium none;
                color: #4c4c4c;
                font-size: 15px;
                min-height: 48px;
                width: 100%;
                outline:none;
            }

            .type_msg {
                border-top: 1px solid #c4c4c4;
                position: relative;
            }

            .msg_send_btn {
                background: #05728f none repeat scroll 0 0;
                border:none;
                border-radius: 50%;
                color: #fff;
                cursor: pointer;
                font-size: 15px;
                height: 33px;
                position: absolute;
                right: 0;
                top: 11px;
                width: 33px;
            }

            .messaging {
                padding: 0 0 50px 0;
            }

            .msg_history {
                height: 516px;
                overflow-y: auto;
            }

            label.bold{
                font-weight:bold;
            }

            .submit-button {
                display: inline-flex; /* Display as inline-flex to adjust size */
                align-items: center; /* Center content vertically */
                justify-content: center; /* Center content horizontally */
                background-color: #4CAF50; /* Green background color */
                color: white; /* Text color */
                border: none; /* Remove border */
                padding: 8px 16px; /* Adjust padding for smaller size */
                font-size: 14px; /* Decrease font size */
                border-radius: 4px; /* Add border radius */
                cursor: pointer; /* Add cursor style */
                transition: background-color 0.3s ease; /* Add transition effect */
            }

            .submit-button:hover {
                background-color: #45a049; /* Darker green on hover */
            }

            .submit-button i {
                margin-right: 6px; /* Add some space between icon and text */
            }
            .highlight {
                background: green;
            }

            .hidden {
                display: none;
            }

            .table{
                height: 10%;
            }

            .cover {
                width: 100%;
                padding: 0px 30px;
                position: relative;
                margin-top: 10px;
            }
            .left {
                position: absolute;
                left: 0;
                top: 50%;
                transform: translateY(-50%);
            }
            .right {
                position: absolute;
                right: 0;
                top: 50%;
                transform: translateY(-50%);
            }
            .scroll-images {
                width: 100%;
                height: auto;
                display: flex;
                flex-wrap: nowrap;
                overflow-x: auto;
                overflow-y: hidden;
                scroll-behavior: smooth;
                -webkit-overflow-scrolling: touch;
            }
            .child img {
                width: 100%;
                object-fit: cover;
                object-position: center;
            }
            .scroll-images::-webkit-scrollbar {
                width: 5px;
                height: 8px;
                background-color: #aaa;
            }

            .scroll-images::-webkit-scrollbar-thumb {
                background-color: #565C5F;
                margin-top: 1000px;
            }

            .child {

                margin: 20px;
                display: flex;
                flex-direction: column;
                padding: 0px 10px 30px 10px;
                background: var(--white);
                border-radius: 12px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 15%);
                scroll-snap-align: start;
                transition: all 0.2s;
                min-width: 250px;
                height: 120px;
                overflow: hidden;
            }
            .card-dashboard:hover{
                transform: scale(1.02);
                box-shadow: 0 20px 30px rgba(62, 173, 230,.30), 0 4px 8px rgba(62, 173, 230,.06);
                cursor: pointer;
            }
            .dashcard.selected{
                background-color: #9A9E9F;
            }
            .dashcard.hover{
                -ms-transform: scale(0.3); /* IE 9 */
                -webkit-transform: scale(0.3); /* Safari 3-8 */
                transform: scale(0.9);
                box-shadow: 0 4px 15px 0 rgba(65, 132, 234, 0.75);
            }

            :root {
                --red: #ef233c;
                --darkred: #c00424;
                --platinum: #e5e5e5;
                --black: #2b2d42;
                --white: #fff;
                --thumb: #edf2f4;
                --blue: #288AB2;
            }

            .dashcontainer {
                max-width: 1400px;

                margin-left:auto;
                border-radius: 25px;

            }

            h2 {
                font-size: 32px;
                margin-bottom: 1em;
            }

            .cards {
                display: flex;
                padding: 25px 0px;
                list-style: none;
                overflow-x: scroll;
                scroll-snap-type: x mandatory;
            }

            .dashcard {
                display: flex;
                flex-direction: column;
                flex: 0 0 100%;
                padding: 20px 0px 20px;
                background: var(--white);
                border-radius: 12px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 15%);
                scroll-snap-align: start;
                transition: all 0.2s;
                padding-top: 10px;
                transition: transform .2s;
                margin: 0 auto;
                box-sizing: border-box;
                box-shadow: 0 0 5px 0 rgba(43, 43, 43, .1), 0 11px 6px -7px rgba(43, 43, 43, .1);
            }

            .dashcard:not(:last-child) {
                margin-right: 20px;
            }

            .dashcard:hover {
                -ms-transform: scale(0.3); /* IE 9 */
                -webkit-transform: scale(0.3); /* Safari 3-8 */
                transform: scale(0.9);
                box-shadow: 0 4px 15px 0 rgba(65, 132, 234, 0.75);
            }

            .dashcard .card-content {
                margin: 10px 0 0 0;
            }

            .dashcard .card-link-wrapper {
                margin-top: auto;
            }

            .dashcard .card-link {
                display: inline-block;
                text-decoration: none;
                color: white;
                background: var(--red);
                padding: 6px 12px;
                border-radius: 8px;
                transition: background 0.2s;
            }

            .dashcard:hover .card-link {
                background: var(--darkred);
            }

            .cards::-webkit-scrollbar {
                height: 12px;
            }

            .cards::-webkit-scrollbar-thumb,
            .cards::-webkit-scrollbar-track {
                border-radius: 92px;
            }

            .cards::-webkit-scrollbar-thumb {
                background: var(--blue);
            }

            .cards::-webkit-scrollbar-track {
                background: var(--thumb);
            }

            @media (min-width: 500px) {
                .dashcard {
                    flex-basis: calc(100% - 20px);
                }

                .dashcard:not(:last-child) {
                    margin-right: 20px;
                }
            }

            @media (min-width: 700px) {
                .dashcard {
                    flex-basis: calc(calc(100% / 3) - 30px);
                }

                .dashcard:not(:last-child) {
                    margin-right: 30px;
                }
            }

            @media (min-width: 1100px) {
                .dashcard {
                    flex-basis: calc(20% - 40px);
                }

                .dashcard:not(:last-child) {
                    margin-right: 40px;
                }
            }
            .card {
                min-width: auto;
            }

            .page-footer {
                position: fixed;
                right: 0;
                bottom: 50px;
                display: flex;
                align-items: center;
                padding: 5px;
                z-index: 1;
            }

            .page-footer a {
                display: flex;
                margin-left: 4px;
            }

            div.card {
                box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            }
            .swal2-container {
                z-index: 1000000;
            }
            .modal {
                z-index: 10000;
            }
        </style>
        <style>
            @media screen and (max-width: 1024px) {
                html {
                    font-size: 9px;
                }
            }

            @media screen and (max-width: 900px) {
                html {
                    font-size: 8px;
                }
            }

            @media screen and (max-width: 768px) {
                html {
                    font-size: 10px;
                }

                /* ===== =====>>  Container Css Start  <<===== ===== */
                .container1 {
                    grid-template-columns: 1fr;
                    grid-template-areas:
                        "header"
                        "userProfile"
                        "userDetails"
                        "work_skills"
                        "timeline_about";
                    overflow-x: hidden;
                    overflow-y: inherit;
                    padding: 0;
                    width: 90%;
                    height: 100%;
                    box-shadow: none;
                }

                /* ===== =====>>  Container Card Css Start  <<===== ===== */
                .container1 .card {
                    backdrop-filter: none;
                }

                .userDetails {
                    margin-bottom: 3rem;
                }

                .container1::before,
                .container1::after {
                    display: none;
                }

                /* ===== =====>>  Header/Navbar Css Start  <<===== ===== */
                .container1 header {
                    padding: 2.5rem;
                }
            }

            @media screen and (max-width: 500px) {
                .container1 {
                    width: 100%;
                    overflow: initial;
                }
            }

            @media screen and (max-width: 350px) {
                .main_bg {
                    animation: none;
                }
            }

            * {
                padding: 0;
                margin: 0;
                font-size: 14px;
                list-style: none;
                text-decoration: none;
            }

            /* ===== =====>>  Body Font Size  <<===== =====  */
            /*            html {
                            font-size: 10px;
                        }*/

            /* ===== =====>> Css Variables  <<===== =====  */
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
                padding: var(--p-1-5);
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
                backdrop-filter: blur(3rem);
                border-radius: 0.5rem;
                /*border-radius: 20px;*/
                box-shadow: 0 0 25px rgba(0, 0, 0, 0.05);
                padding: var(--p-1-5);
                margin: 20px;
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
                padding: var(--p-2-5);
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
            .col-form-label {
                padding-top: 0rem;

            }

            @media (min-width:992px) {
                .page-container {
                    max-width: 1140px;
                    margin: 0 auto
                }

                .page-sidenav {
                    display: block !important
                }
            }

            .padding {
                padding: 2rem
            }

            .w-32 {
                width: 32px !important;
                height: 32px !important;
                font-size: .85em
            }

            .tl-item .avatar {
                z-index: 2
            }

            .circle {
                border-radius: 500px
            }

            .gd-warning {
                color: #fff;
                border: none;
                background: #f4c414 linear-gradient(45deg, #f4c414, #f45414)
            }

            .timeline {
                position: relative;
                border-color: rgba(160, 175, 185, .15);
                padding: 0;
                margin: 0
            }

            .p-4 {
                padding: 1.5rem !important
            }

            .block,
            .card {
                /*                background: #fff;
                                border-width: 0;
                                border-radius: .25rem;
                                box-shadow: 0 1px 3px rgba(0, 0, 0, .05);
                                margin-bottom: 1.5rem*/
            }

            .mb-4,
            .my-4 {
                margin-bottom: 1.5rem !important
            }

            .tl-item {
                border-radius: 3px;
                position: relative;
                display: -ms-flexbox;
                display: flex
            }

            .tl-item>* {
                padding: 10px
            }

            .tl-item .avatar {
                z-index: 2
            }

            .tl-item:last-child .tl-dot:after {
                display: none
            }

            .tl-item.active .tl-dot:before {
                border-color: #448bff;
                box-shadow: 0 0 0 4px rgba(68, 139, 255, .2)
            }

            .tl-item:last-child .tl-dot:after {
                display: none
            }

            .tl-item.active .tl-dot:before {
                border-color: #448bff;
                box-shadow: 0 0 0 4px rgba(68, 139, 255, .2)
            }

            .tl-dot {
                position: relative;
                border-color: rgba(160, 175, 185, .15)
            }

            .tl-dot:after,
            .tl-dot:before {
                content: '';
                position: absolute;
                border-color: inherit;
                border-width: 2px;
                border-style: solid;
                border-radius: 50%;
                width: 10px;
                height: 10px;
                top: 15px;
                left: 50%;
                transform: translateX(-50%)
            }

            .tl-dot:after {
                width: 0;
                height: auto;
                top: 25px;
                bottom: -15px;
                border-right-width: 0;
                border-top-width: 0;
                border-bottom-width: 0;
                border-radius: 0
            }

            tl-item.active .tl-dot:before {
                border-color: #448bff;
                box-shadow: 0 0 0 4px rgba(68, 139, 255, .2)
            }

            .tl-dot {
                position: relative;
                border-color: rgba(160, 175, 185, .5)
            }

            .tl-dot:after,
            .tl-dot:before {
                content: '';
                position: absolute;
                border-color: inherit;
                border-width: 2px;
                border-style: solid;
                border-radius: 50%;
                width: 10px;
                height: 10px;
                top: 15px;
                left: 50%;
                transform: translateX(-50%)
            }

            .tl-dot:after {
                width: 0;
                height: auto;
                top: 25px;
                bottom: -15px;
                border-right-width: 0;
                border-top-width: 0;
                border-bottom-width: 0;
                border-radius: 0
            }

            .tl-content p:last-child {
                margin-bottom: 0
            }

            .tl-date {
                font-size: .85em;
                margin-top: 2px;
                min-width: 300px;
                max-width: 100px
            }

            .avatar {
                position: relative;
                line-height: 1;
                border-radius: 500px;
                white-space: nowrap;
                font-weight: 700;
                border-radius: 100%;
                display: -ms-flexbox;
                display: flex;
                -ms-flex-pack: center;
                justify-content: center;
                -ms-flex-align: center;
                align-items: center;
                -ms-flex-negative: 0;
                flex-shrink: 0;
                border-radius: 500px;
                box-shadow: 0 5px 10px 0 rgba(50, 50, 50, .15)
            }

            .b-warning {
                border-color: #f4c414!important;
            }

            .b-primary {
                border-color: #448bff!important;
            }

            .b-danger {
                border-color: #f54394!important;
            }
            .b-susscess {
                border-color: #198754!important;
            }
            .b-common {
                border-color: #541474!important;
            }
            .timeline-image {
                width: 40px; /* Adjust the width as per your requirement */
                height: 40px; /* Adjust the height as per your requirement */
                border-radius: 50%; /* Make the image round */
                object-fit: cover; /* Ensure the image covers the entire space */
            }

            /* CSS Styles */
            .tl-dot {
                position: relative;
            }

            .tl-time {
                position: absolute;
                top: 20%;
                right: 93%;
                transform: translateY(-50%);
                font-size: 11px;
                font-weight: 600;
                background-color: #84649c;
                width: 55px;
                color: white;
                border-radius: 24px;
                padding-left: 2px;
                padding-right: 2px;
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
            .rate:not(:checked) > label:hover,
            .rate:not(:checked) > label:hover ~ label {
                color: #deb217;
            }
            .rate > input:checked + label:hover,
            .rate > input:checked + label:hover ~ label,
            .rate > input:checked ~ label:hover,
            .rate > input:checked ~ label:hover ~ label,
            .rate > label:hover ~ input:checked ~ label {
                color: #c59b08;
            }
        </style>

        <%@include file="jspf/loader.jspf" %>
        <div id="pcoded" class="pcoded">
            <div class="pcoded-overlay-box"></div>
            <div class="pcoded-container navbar-wrapper">
                <%@include file="jspf/navbar.jspf" %>
                <div class="pcoded-main-container">
                    <div class="pcoded-wrapper">
                        <%@include file="jspf/sidenav.jspf"%>
                        <div class="pcoded-content">
                            <div class="pcoded-inner-content">
                                <div class="main-body">
                                    <div class="page-wrapper">
                                        <div class="page-body">
                                            <div class="dashcontainer">
                                                <div class="row" style="margin-left: -98px;">
                                                    <div class="data-card col-md-auto">
                                                        <li class="card dashcard">
                                                            <div>
                                                                <h3 style="font-weight: bold;" class="card-title">New Ticket</h3>
                                                                <div class="card-content " class="btn btn-primary" style="cursor: pointer; height: 92px; text-align: center">
                                                                    <img id="new_ticket" src="./files/images/ticket.png" style="margin-top:10px; width: 110px">
                                                                </div>
                                                            </div>
                                                        </li>
                                                    </div>

                                                    <div class="vl" style="border-left: 10px solid whitesmoke;"></div>

                                                    <div class="data-card col-md-auto" id="all_tickets1" style="margin-left: 0px;">
                                                        <li class="card dashcard">
                                                            <div>
                                                                <h3 style="font-weight: bold;" class="card-title">All Tickets</h3>
                                                                <!--                                                                <div class="count-count count-count-all">
                                                                                                                                    <span class="grey" style="font-weight: bold;" id="all_tickets_card">0</span>
                                                                                                                                </div>-->
                                                                <!--<span class="label labelr other"><span class="" style="font-weight: bold;" id="all_tickets_card">0</span></span>-->
                                                                <!--<p class="text-light bg-default" style="text-align: center; margin-top: 3px;"><span style="font-weight: bold; color: black; font-size: 16px;" id="all_tickets_card">0</span></p>-->
                                                                <p class="text-light bg-default" style="text-align: center; margin-top: 3px;"><span style="font-weight: bold; color: black; font-size: 59px;" id="all_tickets_card">0</span></p>
                                                                <!--                                                                <div class="card-content " class="btn btn-primary" style="  cursor: pointer; height: 65px; text-align: center">
                                                                                                                                    <img src="./files/images/all_tickets.gif" style="width: 70px" id="add_modal_btn">
                                                                                                                                </div>-->
                                                            </div>
                                                        </li>
                                                    </div>

                                                    <div class="data-card col-md-auto" id="queued" style="margin-left: -10px;">
                                                        <li class="card dashcard">
                                                            <div>
                                                                <h3 style="font-weight: bold;" class="card-title">Queued Tickets</h3>
                                                                <!--<p class="text-light bg-default" style="text-align: center; margin-top: 3px;"><span class="" style="font-weight: bold; color: black;  font-size: 16px;" id="queued_card_all">0</span></p>-->
                                                                <p class="text-light bg-default" style="text-align: center; margin-top: 3px;"><span class="" style="font-weight: bold; color: black;  font-size: 59px;" id="queued_card_all">0</span></p>

                                                                <!--<p class="text-light bg-dark" style="text-align: center; margin-top: 3px;"><span class="" style="font-weight: bold;" id="queued_card_all">0</span></p>-->
                                                                <!--                                                                <div class="card-content " class="btn btn-primary" style="  cursor: pointer; height: 65px; text-align: center">
                                                                                                                                    <img src="./files/images/process.gif" style="width: 70px " id="add_modal_btn">
                                                                                                                                                                                                        <div class="count-count">
                                                                                                                                                                                                        <span class="grey" style="font-weight: bold;" id="queued_card_all">0</span>
                                                                                                                                                                                                        </div>
                                                                                                                                </div>-->
                                                            </div>
                                                        </li>
                                                    </div> 


                                                    <div class="data-card col-md-auto" id="approval" style="margin-left: -10px;">
                                                        <li class="card dashcard">
                                                            <div>
                                                                <h3 style="font-weight: bold;" class="card-title">Approval Pending</h3>
                                                                <!--<p class="text-light bg-default" style="text-align: center; margin-top: 3px;"><span class="" style="font-weight: bold; color: black;  font-size: 16px;" id="approval_card_all">0</span></p>-->
                                                                <p class="text-light bg-default" style="text-align: center; margin-top: 3px;"><span class="" style="font-weight: bold; color: black;  font-size: 59px;" id="approval_card_all">0</span></p>
                                                                <!--                                                                <div class="card-content " class="btn btn-primary" style="  cursor: pointer; height: 65px; text-align: center">
                                                                                                                                    <img src="./files/images/curriculum-vitae-unscreen.gif" style="width: 80px " id="add_modal_btn">
                                                                                                                                                                                                        <div class="count-count">
                                                                                                                                                                                                        <span class="grey" style="font-weight: bold;" id="approval_card_all">0</span>
                                                                                                                                                                                                        </div>
                                                                                                                                </div>-->
                                                            </div>
                                                        </li>
                                                    </div> 


                                                    <%
                                                   if(session.getAttribute("type").toString().equals("5")){
                                                    %>
                                                    <div class="data-card col-md-auto" id="recruitment" style="margin-left: -10px;">
                                                        <li class="card dashcard">
                                                            <div>
                                                                <h3 style="font-weight: bold;" class="card-title">Recruitments</h3>
                                                                <p class="text-light bg-default" style="text-align: center; margin-top: 3px;"><span class="" style="font-weight: bold; color: black;  font-size: 59px;" id="recruitment_card_all">0</span></p>
                                                                <!--                                                                <div class="card-content " class="btn btn-primary" style="  cursor: pointer; height: 65px; text-align: center">
                                                                                                                                    <img src="./files/images/recruitment.png" style="width: 60px " id="add_modal_btn">
                                                                                                                                                                                                        <div class="count-count">
                                                                                                                                                                                                        <span class="grey" style="font-weight: bold;" id="recruitment_card_all">0</span>
                                                                                                                                                                                                        </div>
                                                                                                                                </div>-->
                                                            </div>
                                                        </li>
                                                    </div> 
                                                    <%
                                                        }
                                                    %>

                                                    <div class="data-card col-md-auto" id="in_progress" style="margin-left: -10px;">
                                                        <li class="card dashcard">
                                                            <div>
                                                                <h3 style="font-weight: bold;" class="card-title">IN Progress</h3>
                                                                <!--<p class="text-light bg-default" style="text-align: center; margin-top: 3px;"><span class="" style="font-weight: bold; color: black;  font-size: 16px;" id="inprogress_card_all">0</span></p>-->
                                                                <p class="text-light bg-default" style="text-align: center; margin-top: 3px;"><span class="" style="font-weight: bold; color: black;  font-size: 59px;" id="inprogress_card_all">0</span></p>
                                                                <!--                                                                <div class="card-content " class="btn btn-primary"  style=" cursor: pointer; height: 65px; text-align: center">
                                                                                                                                    <img src="./files/images/settings.gif" style="width: 70px "  id="add_modal_btn">
                                                                                                                                                                                                        <div class="count-count">
                                                                                                                                                                                                        <span class="grey" style="font-weight: bold;" id="inprogress_card_all">0</span>
                                                                                                                                                                                                        </div>
                                                                                                                                </div>-->
                                                            </div>
                                                        </li>
                                                    </div>
                                                    <br>
                                                    <div class="data-card col-md-auto" id="assigned_ticket" style="margin-left: -10px;">
                                                        <li class="card dashcard">
                                                            <div>
                                                                <h3 style="font-weight: bold;" class="card-title">Assigned</h3>
                                                                <!--<p class="text-light bg-default" style="text-align: center; margin-top: 3px;"><span class="" style="font-weight: bold; color: black;  font-size: 16px;" id="assigned_card_all">0</span></p>-->
                                                                <p class="text-light bg-default" style="text-align: center; margin-top: 3px;"><span class="" style="font-weight: bold; color: black;  font-size: 59px;" id="assigned_card_all">0</span></p>
                                                                <!--                                                                <div class="card-content" class="btn btn-primary" style="cursor: pointer; height: 65px; text-align: center">
                                                                                                                                    <img src="./files/images/recruitment-unscreen.gif" style="width: 80px;"  id="add_modal_btn">
                                                                                                                                    <img src="./files/images/candidate-unscreen.gif" style="width: 85px;"  id="add_modal_btn">
                                                                                                                                                                                                        <div class="count-count count-count-assign" style="margin-top: 20px;">
                                                                                                                                                                                                        <span class="grey" style="font-weight: bold;" id="assigned_card_all">0</span>
                                                                                                                                                                                                        </div>
                                                                                                                                </div>-->
                                                            </div>
                                                        </li>
                                                    </div>

                                                    <div class="data-card col-md-auto" id="finished_tickets" style="margin-left: -10px;">
                                                        <li class="card dashcard">
                                                            <div>
                                                                <h3 style="font-weight: bold;" class="card-title">Finished Tickets</h3>
                                                                <!--<p class="text-light bg-default" style="text-align: center; margin-top: 3px;"><span class="" style="font-weight: bold; color: black;  font-size: 16px;" id="finished_card_all">0</span></p>-->
                                                                <p class="text-light bg-default" style="text-align: center; margin-top: 3px;"><span class="" style="font-weight: bold; color: black;  font-size: 59px;" id="finished_card_all">0</span></p>
                                                                <!--                                                                <div class="card-content " class="btn btn-primary" style=" cursor: pointer; height: 65px; text-align: center">
                                                                                                                                    <img src="./files/images/check.gif" style="width: 70px "  id="add_modal_btn">
                                                                                                                                                                                                        <div class="count-count">
                                                                                                                                                                                                        <span class="grey" style="font-weight: bold;" id="finished_card_all">0</span>
                                                                                                                                                                                                        </div>
                                                                                                                                </div>-->
                                                            </div>
                                                        </li>
                                                    </div>

                                                    <div class="data-card col-md-auto" id="closed_tickets" style="margin-left: -10px;">
                                                        <li class="card dashcard">
                                                            <div>
                                                                <h3 style="font-weight: bold;" class="card-title">Closed Tickets</h3>
                                                                <!--<p class="text-light bg-default" style="text-align: center; margin-top: 3px;"><span class="" style="font-weight: bold; color: black;  font-size: 16px;" id="closed_card_all">0</span></p>-->
                                                                <p class="text-light bg-default" style="text-align: center; margin-top: 3px;"><span class="" style="font-weight: bold; color: black;  font-size: 59px;" id="closed_card_all">0</span></p>
                                                                <!--                                                                <div class="card-content " class="btn btn-primary" style=" cursor: pointer; height: 65px; text-align: center">
                                                                                                                                    <img src="./files/images/closed-unscreen.gif" style="width: 90px; margin-top:  -10px;"  id="add_modal_btn">  
                                                                                                                                                                                                        <div class="count-count">
                                                                                                                                                                                                        <span class="grey" style="font-weight: bold;" id="closed_card_all">0</span>
                                                                                                                                                                                                        </div>
                                                                                                                                </div>-->
                                                            </div>
                                                        </li>
                                                    </div>
                                                    <div class="data-card col-md-auto" id="department_tickets" style="margin-left: -10px;">
                                                        <li class="card dashcard">
                                                            <div>
                                                                <h3 style="font-weight: bold;" class="card-title">My Department</h3>
                                                                <!--<p class="text-light bg-default" style="text-align: center; margin-top: 3px;"><span class="" style="font-weight: bold; color: black;  font-size: 16px;" id="closed_card_all">0</span></p>-->
                                                                <p class="text-light bg-default" style="text-align: center; margin-top: 3px;"><span class="" style="font-weight: bold; color: black;  font-size: 59px;" id="department_card_all">0</span></p>
                                                                <!--                                                                <div class="card-content " class="btn btn-primary" style=" cursor: pointer; height: 65px; text-align: center">
                                                                                                                                    <img src="./files/images/closed-unscreen.gif" style="width: 90px; margin-top:  -10px;"  id="add_modal_btn">  
                                                                                                                                                                                                        <div class="count-count">
                                                                                                                                                                                                        <span class="grey" style="font-weight: bold;" id="closed_card_all">0</span>
                                                                                                                                                                                                        </div>
                                                                                                                                </div>-->
                                                            </div>
                                                        </li>
                                                    </div>
                                                </div>
                                            </div>

                                            <div id="editcard" class="modal fade" tabindex="-1" role="dialog" style=" padding-right: 17px;">
                                                <div class="modal-dialog modal-lg " style="max-width: 1300px;">
                                                    <div class="container1" id="admincardmodal" style="width: 1300px;height: auto; margin-top: 90px;">
                                                        <div class="modal-header">
                                                            <div class="col-12  pull-right">
                                                                <div class="row">
                                                                    <h3>Ticket Details</h3>
                                                                    <button type="button" class="close" style="margin-left: 1050px;" data-dismiss="modal" aria-label="Close">
                                                                        <span aria-hidden="true">×</span>
                                                                    </button> 
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <ul class="nav nav-tabs" id="myTab_1" role="tablist" style="margin-top: 10px;">
                                                            <li class="nav-item ">
                                                                <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home_1" role="tab" aria-controls="home" aria-selected="true"><i class="fa fa-list"></i> Ticket Details</a>
                                                            </li>
                                                            <li class="nav-item">
                                                                <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile_1" role="tab" aria-controls="profile" aria-selected="false"> <i class="fa fa-list-alt"></i> Ticket Log</a>
                                                            </li>
                                                            <li class="nav-item">
                                                                <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile_2" role="tab" aria-controls="profile" aria-selected="false"> <i class="fa fa-comment"></i> Comments</a>
                                                            </li>

                                                        </ul>
                                                        <div class="tab-content " id="myTabContent">
                                                            <div class="tab-pane fade show active" id="home_1" style="margin-top: 10px;" role="tabpanel" aria-labelledby="home-tab">

                                                                <!-- ===== ===== Body Main-Background ===== ===== -->
                                                                <span class="main_bg"></span>

                                                                <header class="userDetails card" >
                                                                    <div class="col-12" style="margin-left: 20px;">

                                                                        <div class="row form-group row-up-1" id="editrow" style="display: none">
                                                                            <div class="col-2">
                                                                                <button  type="button" class="btn btn-danger" id="rate-btn" style="width:100%"><i class="fa fa-close"></i> Close </button>
                                                                            </div>
                                                                            <div class="col-2">
                                                                                <button  type="button" class="btn btn-success" id="re-open-btn" style="width:100%" data-dismiss="modal" aria-label="Close"><i class="fa fa-folder-open"></i> Re-Open</button>
                                                                            </div>
                                                                        </div>

                                                                        <div class=" row form-group row-up-1">
                                                                            <span id="newstatus"></span><span id="newpriority" style="margin-left: 5px;"></span>
                                                                        </div>
                                                                        <div class=" row form-group row-up-1">
                                                                            <label class=" col-form-label new-label-box" style="width: 20%">Ticket Number</label>
                                                                            <div class="col-15" style="width: 75%">
                                                                                <label class="new-label" style="width: 100%" >: <span id="ticketid"></span></label>
                                                                            </div>
                                                                        </div>
                                                                        <br>
                                                                        <div class=" row form-group row-up">
                                                                            <div class="col-topic-start"></div>
                                                                            <label class=" col-form-label new-label-box" style="width: 20%">Subject<span class="text-danger">*</span></label>
                                                                            <div class="col-15 " style="width: 75%">
                                                                                <input type="text" onkeyup="this.value = this.value.toUpperCase();" max="100" class="form-control form-control-xs" autocomplete="off" id="subject" readonly>
                                                                            </div>
                                                                        </div>
                                                                        <br>
                                                                        <div class=" row form-group row-up-1">
                                                                            <div class="col-topic-start"></div>
                                                                            <label class=" col-form-label new-label-box" style="width: 20%">User Assign<span class="text-danger">*</span></label>
                                                                            <div class="col-15" style="width: 75%">
                                                                                <select style="width: 100%" class="form-control-xs" id="users_assign" tabindex="-1" multiple></select>
                                                                            </div>
                                                                        </div>
                                                                        <br>
                                                                        <button style="width: 10%;margin-right: 43px;" type="button" class="btn btn-google-plus btn-sm pull-right" id="ticket_assign_btn"><i class="fa fa-user-plus"></i> Confirm</button>
                                                                    </div>
                                                                    <div class="row col-12">

                                                                        <div class="col-6">


                                                                        </div>
                                                                    </div>

                                                                </header>

                                                                <div class="col-12 row">

                                                                    <!-- ===== ===== Work & Skills Section ===== ===== -->
                                                                    <section class="work_skills card" style="width: 800px">

                                                                        <!-- ===== ===== Work Contaienr ===== ===== -->
                                                                        <div class="col-12 work" style="margin-left: 10px;">
                                                                            <h1 class="heading">Ticket Details</h1>
                                                                            <div class=" row form-group row-up-1">
                                                                                <span class="col-topic-start" style="width: 5%; font-size: 14px">01 </span>
                                                                                <label class=" col-form-label new-label-box" style="width: 26%"> Ticket Type</label>
                                                                                <div class="col-7" style="width: 70%">
                                                                                    <input type="text" class="form-control form-control-xs" autocomplete="off" id="ttype" readonly="">
                                                                                </div>
                                                                            </div>
                                                                            <div class=" row form-group row-up-1">
                                                                                <span class="col-topic-start" style="width: 5%; font-size: 14px">02 </span>
                                                                                <label class=" col-form-label new-label-box" style="width: 26%"> Description</label>
                                                                                <div class="col-7" style="width: 70%">
                                                                                    <textarea class="form-control" rows="8" name="description" id="desc" readonly=""></textarea>
                                                                                </div>
                                                                            </div>
                                                                            <div class=" row form-group row-up-1">
                                                                                <span class="col-topic-start" style="width: 5%; font-size: 14px">03 </span>
                                                                                <label class=" col-form-label new-label-box" style="width: 26%"> Date</label>
                                                                                <div class="col-7" style="width: 70%">
                                                                                    <input type="text" class="form-control form-control-xs" autocomplete="off" id="date" readonly="">
                                                                                </div>
                                                                            </div>
                                                                            <div class=" row form-group row-up-1">
                                                                                <span class="col-topic-start" style="width: 5%; font-size: 14px">04 </span>
                                                                                <label class=" col-form-label new-label-box" style="width: 26%"> Ticket Category</label>
                                                                                <div class="col-7" style="width: 70%">
                                                                                    <input type="text" class="form-control form-control-xs" autocomplete="off" id="category" readonly="">
                                                                                </div>
                                                                            </div>

                                                                        </div>
                                                                    </section>
                                                                    <!-- ===== ===== Timeline & About Sections ===== ===== -->
                                                                    <section class="timeline_about card" style=" margin: 20px 0 0 0px;width: 398px;">
                                                                        <h1 class="heading">Tracking Details</h1>
                                                                        <div class="ticketTracking"></div>

                                                                    </section>
                                                                </div>
                                                            </div>

                                                            <div class="tab-pane   fade" id="profile_1" role="tabpanel" aria-labelledby="profile-tab">
                                                                <div class="row">
                                                                    <div class="card col-md-10">
                                                                        <div class="modal-header">
                                                                            <h3>Ticket Log</h3>
                                                                        </div>
                                                                        <div class="single-table" style="height: 350px; overflow: auto">
                                                                            <table class="table text-center  table-hover" id="lod_table">
                                                                                <thead class="" style="background-color: #dcecf6;font-size: 15px" id="head">
                                                                                    <tr>
                                                                                        <th scope="col" style="width: 5%">No</th>
                                                                                        <th scope="col" style="width: 15%">Enter By</th>
                                                                                        <th scope="col" style="width: 20%">Status</th>
                                                                                        <th scope="col" style="width: 30%">Date/Time</th>
                                                                                    </tr>
                                                                                </thead>
                                                                                <tbody></tbody>
                                                                            </table>
                                                                        </div>

                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="tab-pane fade" id="profile_2" role="tabpanel" aria-labelledby="profile-tab">

                                                                <div class="col-4 pull-left">
                                                                    <div class="row" style="margin-top: 10px;">
                                                                        <div class="col-8">
                                                                            <select id="suggestion_comment_id" class="">
                                                                                <option value="x"> -- Select Here -- </option>
                                                                                <option value="Approved">Approved</option>
                                                                            </select>
                                                                        </div>
                                                                        <div class="col-2">
                                                                            <button id="suggetion_btn" style="" type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#add_modal"><i class="fa fa-check-square-o"></i>Add Comment</button>
                                                                        </div>

                                                                    </div>
                                                                    <div class="card" style="margin-top: 15px; width: 600px;">
                                                                        <div class="tab-pane fade show active" id="home_1" role="tabpanel" aria-labelledby="home-tab">
                                                                            <div class="row">
                                                                                <div class="col-3">
                                                                                    <select id="suggestion_comment_id" class="form-control" style="display: none;">
                                                                                        <option value="x"> -- Select Here -- </option>
                                                                                        <option value="Approved">Approved</option>

                                                                                    </select>
                                                                                </div>
                                                                                <div class="col-2">
                                                                                    <button type="button" class="btn btn-facebook btn-sm pull-right" id="suggetion_btn" style="display: none;"><i class="fa fa-save" aria-hidden="true"></i>  Submit</button>
                                                                                </div>

                                                                            </div>
                                                                            <br>
                                                                            <div class="container">
                                                                                <div class="d-flex  row">
                                                                                    <div class="col-md-12">
                                                                                        <div class="d-flex flex-column comment-section">

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
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>

                                        </div>
                                        <input type="text" id="status" value="pending" disabled hidden>

                                        <!--</center>-->
                                    </div>

                                    <div id="datatable" class="col-lg-10 offset-lg-1 col-xl-12 offset-xl-0 col-12" style="margin-top: 20px;">
                                        <div class="card">
                                            <div class="card-header">
                                                <div class="row">
                                                    <h6 style="margin-left: 10px;">All Tickets</h6>
                                                    <h6 style="margin-left: 10px; margin-left: 1190px;"><b>Filter :</b></h6>
                                                    <div style="margin-top: -12px;">
                                                        <select class="form-control-sm pull-right" style="width: 150px;" id="time_table">
                                                            <option value="1">All</option>
                                                            <option value="2">Today</option>
                                                            <option value="4">This Week</option>
                                                            <option value="3">This Month</option>
                                                            <option value="5">This Year</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="card-header-right">
                                                    <ul class="list-unstyled card-option" style="margin-left: 2px;">
                                                        <li><i class="feather icon-maximize full-card"></i></li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <div class="card-block p-b-0">
                                                <div class="table-responsive">
                                                    <table class="table table-hover table-bordered m-b-0" id="tbll">
                                                        <thead>
                                                            <tr>
                                                                <th>ID</th>
                                                                <th>Ticket ID</th>
                                                                <th>Ticket Type</th>
                                                                <th>Priority level</th>
                                                                <th>Subject</th>
                                                                <th>Description</th>
                                                                <th>Mod by</th>
                                                                <th>Mod Date/Time</th>
                                                                <th style="width:1px;">Status</th>
                                                                <th style="width:1px;">Action</th>
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

        <div class="modal fade" id="ticket_type_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <!--<div class="modal-dialog modal-dialog-centered modal-lg" role="document">-->
            <div class="card" style="width: auto; height: auto; margin: 30px; margin-top: 40px;">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">Please Select Ticket Type</h5>
                    <span class="close" onClick="window.location.reload();">&times;</span>
                </div>
                <div class="modal-body" style="background-color: #f8f8f8">
                    <div class="" style="margin-left: 10px">
                        <div class="">
                            <div class="col-12 row form-group  row-up-1">
                                <div class="col-3">
                                    <label class=" col-form-label new-label-box" style="margin-top: -10px">Ticket  Type<span class="text-danger">*</span></label>
                                </div>
                                <div class="col-8" style="width: 80%">
                                    <select style="margin-top: -18px" id="type">
                                    </select>
                                </div>
                            </div>
                            <div id="application_type" style="display: none">
                                <div class="col-12 row form-group  row-up-1">
                                    <div class="col-topic-start"></div>
                                    <label class="col-3 col-form-label new-label-box" style="margin-top: -10px" for="radio1">Issue</label>
                                    <div class="col-8" style="width: 30%">
                                        <!--<input class="checkbox" type="radio" name="option" id="radio1" value="1">-->
                                        <label class="switch" style="width: 48px;">
                                            <input class="checkbox" name="option" id="radio1" value="1" type="checkbox">
                                            <span class="slider round"></span>
                                        </label>
                                    </div>

                                </div>
                                <div class="col-12 row form-group  row-up-1">
                                    <div class="col-topic-start"></div>
                                    <label class="col-3 col-form-label new-label-box" style="margin-top: -10px" for="radio2">Modification</label>
                                    <div class="col-8" style="width: 30%">
                                        <!--<input class="checkbox" type="radio" name="option" id="radio2" value="2">-->
                                        <label class="switch" style="width: 48px;">
                                            <input type="checkbox" class="checkbox" name="option" id="radio2" value="2">
                                            <span class="slider round"></span>
                                        </label>
                                    </div>
                                </div>
                                <div class="col-12 row form-group  row-up-1">
                                    <div class="col-topic-start"></div>
                                    <label class="col-3 col-form-label new-label-box" style="margin-top: -10px" for="radio5">Other</label>
                                    <div class="col-8" style="width: 30%">
                                        <!--<input class="checkbox" type="radio" name="option" id="radio2" value="2">-->
                                        <label class="switch" style="width: 48px;">
                                            <input type="checkbox" class="checkbox" name="option" id="radio5" value="5">
                                            <span class="slider round"></span>
                                        </label>
                                    </div>
                                </div>
                                <div class="col-12 row form-group  row-up-1">
                                    <div class="col-topic-start"></div>
                                    <label class="col-3 col-form-label new-label-box" style="margin-top: -10px" for="radio4">User Access</label>
                                    <div class="col-8" style="width: 30%">
                                        <!--<input class="checkbox" type="radio" name="option" id="radio2" value="2">-->
                                        <label class="switch" style="width: 48px;">
                                            <input type="checkbox" class="checkbox" name="option" id="radio4" value="4">
                                            <span class="slider round"></span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div id="hardware_type" style="display: none">
                                <div class="col-12 row form-group  row-up-1">
                                    <div class="col-topic-start"></div>
                                    <label class="col-3 col-form-label new-label-box" style="margin-top: -10px" for="radio8">Issues</label>
                                    <div class="col-8" style="width: 30%">
                                        <!--<input class="checkbox" type="radio" name="option" id="radio1" value="1">-->
                                        <label class="switch" style="width: 48px;">
                                            <input class="checkbox" name="option" id="radio8" value="8" type="checkbox">
                                            <span class="slider round"></span>
                                        </label>
                                    </div>
                                </div>
                                <div class="col-12 row form-group  row-up-1">
                                    <div class="col-topic-start"></div>
                                    <label class="col-3 col-form-label new-label-box" style="margin-top: -10px" for="radio3">Requirements</label>
                                    <div class="col-8" style="width: 30%">
                                        <!--<input class="checkbox" type="radio" name="option" id="radio2" value="3">-->
                                        <label class="switch" style="width: 48px;">
                                            <input class="checkbox" name="option" id="radio3" value="3" type="checkbox">
                                            <span class="slider round"></span>
                                        </label>
                                    </div>
                                </div>
                                <div class="col-12 row form-group  row-up-1">
                                    <div class="col-topic-start"></div>
                                    <label class="col-3 col-form-label new-label-box" style="margin-top: -10px" for="radio6">Reset/Unlock</label>
                                    <div class="col-8" style="width: 30%">
                                        <!--<input class="checkbox" type="radio" name="option" id="radio2" value="3">-->
                                        <label class="switch" style="width: 48px;">
                                            <input class="checkbox" name="option" id="radio6" value="6" type="checkbox">
                                            <span class="slider round"></span>
                                        </label>
                                    </div>
                                </div>
                                <div class="col-12 row form-group  row-up-1">
                                    <div class="col-topic-start"></div>
                                    <label class="col-3 col-form-label new-label-box" style="margin-top: -10px" for="radio7">Access Requests</label>
                                    <div class="col-8" style="width: 30%">
                                        <!--<input class="checkbox" type="radio" name="option" id="radio2" value="3">-->
                                        <label class="switch" style="width: 48px;">
                                            <input class="checkbox" name="option" id="radio7" value="7" type="checkbox">
                                            <span class="slider round"></span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div id="incident_type" style="display: none">
                                <div class="col-12 row form-group  row-up-1">
                                    <div class="col-topic-start"></div>
                                    <label class="col-3 col-form-label new-label-box" style="margin-top: -10px" for="radio1">Issues</label>
                                    <div class="col-8" style="width: 30%">
                                        <!--<input class="checkbox" type="radio" name="option" id="radio1" value="1">-->
                                        <label class="switch" style="width: 48px;">
                                            <input class="checkbox" name="option" id="radio9" value="1" type="checkbox">
                                            <span class="slider round"></span>
                                        </label>
                                    </div>
                                </div>

                            </div>
                            <!--                            <div class="col-3">
                                                            <button type="button" class="btn btn-success" data-dismiss="modal" id="ticket_type_btn"><i class="fa fa-save"></i>Save</button>
                                                        </div>-->
                        </div>
                    </div>
                    <div id="ticket" style="display: none;">

                        <div class="card autofx" id="admincard" style="width: auto; height: auto; margin: 30px; padding: 40px 0px 0px 0px;margin-top: 40px;">

                            <div class="card-block p-b-0">
                                <div class="pull-left" id="admincard" style="width: 600px; padding: 5px; margin-top: -50px;">
                                    <h5 class="card-title" id="label_type"></h5>
                                    <div class="tab-content card-block">

                                        <div id="recruitment_div" style="display: none;">
                                            <br>
                                            <div class=" row form-group  row-up-1">
                                                <div class="col-topic-start"></div>
                                                <label class=" col-form-label new-label-box" style="width: 20%">Full Name</label>
                                                <div class="col-15 " style="width: 75%">
                                                    <input name="hr_full_name_input" id="hr_full_name_input" type="text" class="form-control  form-control-xs">
                                                </div>
                                            </div>
                                            <div class=" row form-group  row-up-1">
                                                <div class="col-topic-start"></div>
                                                <label class=" col-form-label new-label-box" style="width: 20%">Calling Name</label>
                                                <div class="col-15 " style="width: 75%">
                                                    <input name="hr_call_name_input" id="hr_call_name_input" type="text" class="form-control  form-control-xs">
                                                </div>
                                            </div>
                                            <div class=" row form-group row-up-1">
                                                <div class="col-topic-start"></div>
                                                <label class=" col-form-label new-label-box" style="width: 20%">EPF</label>
                                                <div class="col-15" style="width: 25%">
                                                    <input name="hr_emp_epf_input" maxlength="5" id="hr_emp_epf_input" type="number" class="form-control form-control-xs ">
                                                </div>
                                            </div>
                                            <div class=" row form-group row-up-1">
                                                <div class="col-topic-start"></div>
                                                <label class=" col-form-label new-label-box" style="width: 20%">Join Date</label>
                                                <div class="col-15" style="width: 25%">
                                                    <input name="hr_join_date_input" id="hr_join_date_input" type="date" class="form-control form-control-xs ">
                                                </div>
                                            </div>
                                            <div class=" row form-group row-up-1">
                                                <div class="col-topic-start"></div>
                                                <label class=" col-form-label new-label-box" style="width: 20%">Address</label>
                                                <div class="col-15" style="width: 75%">
                                                    <input name="hr_address_input" id="hr_address_input" type="text" class="form-control form-control-xs ">
                                                </div>
                                            </div>
                                            <div class=" row form-group row-up-1">
                                                <div class="col-topic-start"></div>
                                                <label class=" col-form-label new-label-box" style="width: 20%">Phone Number</label>
                                                <div class="col-15" style="width: 25%">
                                                    <input name="hr_pno_input" id="hr_pno_input" maxlength="10" type="number" class="form-control form-control-xs ">
                                                </div>
                                            </div>
                                            <div class=" row form-group row-up-1">
                                                <div class="col-topic-start"></div>
                                                <label class=" col-form-label new-label-box" style="width: 20%">NIC</label>
                                                <div class="col-15" style="width: 25%">
                                                    <input name="hr_emp_nic_input" id="hr_emp_nic_input" type="text" class="form-control form-control-xs ">
                                                </div>
                                            </div>
                                            <div class=" row form-group row-up-1">
                                                <div class="col-topic-start"></div>
                                                <label class=" col-form-label new-label-box" style="width: 20%">Department</label>
                                                <div class="col-15" style="width: 50%">

                                                    <select id="hr_emp_select_department">
                                                    </select>                                        
                                                </div>
                                            </div>

                                            <div class=" row form-group row-up-1">
                                                <div class="col-topic-start"></div>
                                                <label class=" col-form-label new-label-box" style="width: 20%">Designation</label>
                                                <div class="col-15" style="width: 50%">

                                                    <select id="hr_emp_select_designation">
                                                    </select>                                        
                                                </div>
                                            </div>
                                            <div class=" row form-group row-up-1">
                                                <div class="col-topic-start"></div>
                                                <label class=" col-form-label new-label-box" style="width: 20%">Gender</label>
                                                <div class="col-15" style="width: 50%">

                                                    <select id="hr_emp_select_gender">
                                                        <option value="Male">Male</option>
                                                        <option value="Female">Female</option>
                                                    </select>                                        
                                                </div>
                                            </div>
                                            <div class=" row form-group row-up-1">
                                                <div class="col-topic-start"></div>
                                                <label class=" col-form-label new-label-box" style="width: 20%">Location</label>
                                                <div class="col-15" style="width: 50%">
                                                    <select id="hr_emp_select_location">
                                                    </select>                                        
                                                </div>
                                            </div>

                                            <div class=" row form-group row-up-1">
                                                <div class="col-topic-start"></div>
                                                <label class=" col-form-label new-label-box" style="width: 20%">Description</label>
                                                <div class="col-15" style="width: 75%">

                                                    <textarea rows="3" class="form-control form-control-sm" id="hr_emp_txt_area"> </textarea>                            
                                                </div>
                                            </div>
                                        </div>

                                        <div id="transfer_promotion_div" style="display: none;">
                                            <div class=" row form-group row-up-1">
                                                <label class="col-form-label new-label-box" style="width: 20%">User</label>
                                                <div class="col-15" style="width: 45%">
                                                    <select class="form-control-xs" id="transfer_users" tabindex="-1">
                                                    </select>
                                                </div>
                                            </div>
                                            <hr>
                                            <div class="row form-group row-up-1">
                                                <div class="col-topic-start"></div>
                                                <label class="col-form-label new-label-box" style="width: 30%">Department</label>
                                                <div class="col-15" style="width: 10%">
                                                    <input type="checkbox" value="0" id="transfer_emp_dep_check">                         
                                                </div>
                                                <div class="col-15" style="width: 50%; display: none;" id="transfer_emp_dep_div">
                                                    <select class="form-control-sm" style="margin-top: -4px;" id="dep_transfer" tabindex="-1">
                                                        <!-- Options here -->
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="row form-group row-up-1">
                                                <div class="col-topic-start"></div>
                                                <label class="col-form-label new-label-box" style="width: 30%">Branch</label>
                                                <div class="col-15" style="width: 10%">
                                                    <input type="checkbox" value="0" id="transfer_emp_branch_check">                         
                                                </div>
                                                <div class="col-15" style="width: 50%; display: none;" id="transfer_emp_branch_div">
                                                    <select class="form-control-sm" style="margin-top: -4px;" id="branch_transfer" tabindex="-1">
                                                        <!-- Options here -->
                                                    </select>                   
                                                </div>
                                            </div>

                                            <div class="row form-group row-up-1">
                                                <div class="col-topic-start"></div>
                                                <label class="col-form-label new-label-box" style="width: 30%">Designation</label>
                                                <div class="col-15" style="width: 10%">
                                                    <input type="checkbox" value="0" id="transfer_emp_designation_check">              
                                                </div>
                                                <div class="col-15" style="width: 50%; display: none;" id="transfer_emp_designation_div">
                                                    <select class="form-control-sm" style="margin-top: -4px;" id="des_transfer" tabindex="-1">
                                                        <!-- Options here -->
                                                    </select>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="terminate" style="display: none;">
                                            <div class=" row form-group row-up">
                                                <div class="col-topic-start"></div>
                                                <label class=" col-form-label new-label-box" style="width: 20%" >Employee</label>
                                                <div class="col-15" style="width: 45%">
                                                    <select class="form-control-xs" id="terminate_users" tabindex="-1">
                                                    </select>
                                                </div>
                                            </div>
                                            <div class=" row form-group row-up">
                                                <div class="col-topic-start"></div>
                                                <label class=" col-form-label new-label-box" style="width: 20%">Last Date</label>
                                                <div class="col-15" style="width: 45%">
                                                    <input id="last_date_terminate" type="date" class="form-control form-control-xs">
                                                </div>
                                            </div>
                                            <div class=" row form-group row-up">
                                                <div class="col-topic-start"></div>
                                                <label class=" col-form-label new-label-box" style="width: 20%">Remove All Access</label>
                                                <div class="col-15" style="width: 45%; margin-left: -110px; margin-top: 10px;">
                                                    <input id="ralcheck" type="checkbox" value="0">                                                                                   
                                                </div>
                                            </div>
                                        </div>


                                        <div class="tab-pane active show" id="application" style="width: 800px;">
                                            <div id="issue_div">
                                                <div class="row" style="height: 10px">
                                                </div>
                                                <div class=" row form-group row-up">
                                                    <div class="col-topic-start"></div>
                                                    <label class=" col-form-label new-label-box" style="width: 20%" id="lbl_type">Category<span class="text-danger">*</span></label>
                                                    <div class="col-15" style="width: 75%">
                                                        <div style="display: none">
                                                            <select id="select_application" style="margin-top:-5px">

                                                            </select>
                                                        </div>
                                                        <div style="display: none">
                                                            <select id="select_hardware" style="margin-top:-5px">
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row form-group row-up">
                                                    <div class="col-topic-start"></div>
                                                    <label class="col-form-label new-label-box" style="width: 20%">Priority</label>
                                                    <div class="col-15 " style="width: 75%">
                                                        <select style="margin-top:-5px;" id="select_level">
                                                            <option value="1">Normal</option>
                                                            <option value="2">Urgent</option>
                                                        </select>
                                                    </div>
                                                </div>      
                                                <br>

                                                <div class=" row form-group row-up">
                                                    <div class="col-topic-start"></div>
                                                    <label class=" col-form-label new-label-box" style="width: 20%">Subject<span class="text-danger">*</span></label>
                                                    <div class="col-15 " style="width: 75%">
                                                        <input type="text" onkeyup="this.value = this.value.toUpperCase();" max="100" class="form-control form-control-xs" autocomplete="off" id="subject_input">
                                                    </div>
                                                </div>

                                                <div class="row form-group">
                                                    <div class="col-topic-start"></div>
                                                    <label class="col-form-label new-label-box" style="width: 20%">Description<span class="text-danger">*</span></label>
                                                    <div class="col-15 " style="width: 75%">
                                                        <textarea class="form-control" rows="8" name="description" id="description"></textarea>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div id="fileList"></div>
                                                    <div class="col-topic-start"></div>
                                                    <label class=" col-form-label new-label-box" style="width: 20%">Attachments</label>
                                                    <div class="col-8">
                                                        <div class="col-sm-12 col-form-label input-images" id="upload_document_div">
                                                            <div class="jquery-image-uploader"><input type="file" id="image_upload" name="images" multiple="multiple"><div class="uploaded"></div><div class="upload-text"><i class="material-icons"></i><span>(6 Files only)</span></div></div></div>                
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="tab-pane" id="incident" role="tabpanel">
                                            <br>
                                            <div class=" row form-group  row-up-1">
                                                <div class="col-topic-start"></div>
                                                <label class=" col-form-label new-label-box" style="width: 25%;margin-top: -10px">Incident  Type<span class="text-danger">*</span></label>
                                                <div class="col-15 " style="width: 100%">
                                                    <select style="margin-top: -18px" id="incident_select">
                                                    </select>
                                                </div>
                                            </div>
                                            <div class=" row form-group  row-up-1">
                                                <div class="col-topic-start"></div>
                                                <label class=" col-form-label new-label-box" style="width: 25%">Date of Incident<span class="text-danger">*</span></label>
                                                <div class="col-15 " style="width: 100%">
                                                    <input name="report_incident_date" id="report_incident_date" type="datetime-local" class="form-control  form-control-xs">
                                                </div>
                                            </div>
                                            <div class="row form-group">
                                                <div class="col-topic-start"></div>
                                                <label class=" col-form-label new-label-box" style="width: 25%">Nature of Incident<span class="text-danger">*</span></label>
                                                <div class="col-15 " style="width: 100%">
                                                    <textarea name="report_incident_nature" rows="8" spellcheck="false" id="report_incident_nature" type="text" class="form-control  form-control-xs"></textarea>
                                                </div>
                                            </div>
                                            <br>
                                        </div>
                                        <div class="tab-pane" id="recruitment" role="tabpanel">
                                            <br>
                                            <div class=" row form-group  row-up-1">
                                                <div class="col-topic-start"></div>
                                                <label class=" col-form-label new-label-box" style="width: 20%;margin-top: -10px">Incident  Type<span class="text-danger">*</span></label>
                                                <div class="col-15 " style="width: 75%">
                                                    <select style="margin-top: -18px" id="incident_select">
                                                    </select>
                                                </div>
                                            </div>
                                            <div class=" row form-group  row-up-1">
                                                <div class="col-topic-start"></div>
                                                <label class=" col-form-label new-label-box" style="width: 20%">Date of Incident<span class="text-danger">*</span></label>
                                                <div class="col-15 " style="width:75%">
                                                    <input name="report_incident_date" id="report_incident_date" type="datetime-local" class="form-control  form-control-xs">
                                                </div>
                                            </div>
                                            <div class="row form-group">
                                                <div class="col-topic-start"></div>
                                                <label class=" col-form-label new-label-box" style="width: 20%">Nature of Incident<span class="text-danger">*</span></label>
                                                <div class="col-15 " style="width:75%">
                                                    <textarea name="report_incident_nature" rows="8" spellcheck="false" id="report_incident_nature" type="text" class="form-control  form-control-xs"></textarea>
                                                </div>
                                            </div>
                                            <br>
                                        </div>
                                    </div>
                                </div>


                                <div class="card tab-pane" style="display: none; margin-left: 100px;height: 500px;width: 500px;" id="recruit">
                                    <div class="card-body" style="">
                                        <div class="row">
                                            <div class="col-6">
                                                <div class="row">
                                                </div>
                                                <table id="ttable" class="table table-sm table-bordered" style="width:100px;">
                                                    <thead>
                                                        <tr>
                                                    <h6>System List</h6>
                                                    <th hidden="">Name</th>
                                                    <th>Name</th>
                                                    <th></th>
                                                    <h6>System List</h6>
                                                    <th hidden="">Name</th>
                                                    <th>Name</th>
                                                    <th></th>
                                                    </tr>
                                                    </thead>
                                                    <tbody style="font-size: 10px" id="asset_list_body">

                                                        <tr>
                                                            <td hidden="">1</td>
                                                            <td>PC</td>
                                                            <td><input type="checkbox" value="1" ></td>
                                                            <td hidden="">4</td>
                                                            <td>CORE SYSTEM</td>
                                                            <td><input type="checkbox" value="9" ></td>
                                                        </tr>

                                                        <tr>
                                                            <td hidden="">2</td>
                                                            <td>LAPTOP</td>
                                                            <td><input type="checkbox" value="2" ></td>
                                                            <td hidden="">5</td>
                                                            <td>RECOVERY</td>
                                                            <td><input type="checkbox" value="10" ></td>
                                                        </tr>

                                                        <tr>
                                                            <td hidden="">3</td>
                                                            <td>TAB</td>
                                                            <td><input type="checkbox" value="3" ></td>
                                                            <td hidden="">6</td>
                                                            <td>Email</td>
                                                            <td><input type="checkbox" value="11" ></td>
                                                        </tr>

                                                        <tr>
                                                            <td hidden="">7</td>
                                                            <td>Mobile Phone</td>
                                                            <td><input type="checkbox" value="4" ></td>
                                                        </tr>

                                                        <tr>
                                                            <td hidden="">8</td>
                                                            <td>Land Phone</td>
                                                            <td><input type="checkbox" value="5" ></td>
                                                        </tr>

                                                        <tr>
                                                            <td hidden="">9</td>
                                                            <td>Office Package</td>
                                                            <td><input type="checkbox" value="6" ></td>
                                                        </tr>

                                                        <tr>
                                                            <td hidden="">10</td>
                                                            <td>Lending</td>
                                                            <td><input type="checkbox" value="7" ></td>
                                                        </tr>

                                                        <tr>
                                                            <td hidden="">11</td>
                                                            <td>Gold Loan System</td>
                                                            <td><input type="checkbox" value="8" ></td>
                                                        </tr>

                                                    </tbody>
                                                </table>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                                <div class="pull-right leftfix" id="small-user-card">

                                    <div class="" id="admincard" style="width: 470px;height: 180px;padding: 20px; margin-left: 20px;margin-top: -18px;">

                                        <div class=" row form-group row-up" style="">
                                            <label class=" col-form-label new-label-box" style="width: 25%">Entered By</label>
                                            <div class="col-15 " style="width: 60%">

                                                <select class="form-control-xs" id="select_user" tabindex="-1" disabled>
                                                    <option value="<%=session.getAttribute("uid")%>" selected><%=session.getAttribute("username")%></option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class=" row form-group row-up" style="" id="approver_select">
                                            <label class=" col-form-label new-label-box" style="width: 25%">Approver<span class="text-danger">*</span></label>
                                            <div class="col-15 " style="width: 60%">
                                                <select class="form-control-xs" id="assign" tabindex="-1" >
                                                </select>
                                            </div>
                                        </div>
                                        <div class=" row form-group row-up" style="">
                                            <label class=" col-form-label new-label-box" style="width: 25%">On Behalf Of</label>
                                            <div class="col-15 " style="width: 60%">
                                                <select class="form-control-xs" id="behalf" tabindex="-1" >
                                                    <option value="<%=session.getAttribute("uid")%>" selected><%=session.getAttribute("username")%></option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                </div>

                            </div>
                            <div class="pull-right">
                                <button type="button" id="save_btn" style="align-items: center; width: 100px;margin-right: 20px;" class="btn btn-sm btn-success mb-3 pull-right"><i class="fa fa-check-circle"></i>Submit</button>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="modal-footer">
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
            var filter = '';
            filter = "1";
            $('#time_table').change(function () {

                if ($(this).val() === '1') {
                    filter = "1";
                    dtable.ajax.reload();

                }
                if ($(this).val() === '2') {
                    filter = "2";
                    dtable.ajax.reload();

                }
                if ($(this).val() === '3') {
                    filter = "3";
                    dtable.ajax.reload();

                }
                if ($(this).val() === '4') {
                    filter = "4";
                    dtable.ajax.reload();

                }
                if ($(this).val() === '5') {
                    filter = "5";
                    dtable.ajax.reload();

                }
            });


            function clear() {
                $('#description').val('');
                $('#assign').val('');
                $('#subject_input').val('');
                $('#select_application').val('');
                $('#select_hardware').val('');
                $('#incident_select').val('');
                $('#report_incident_date').val('');
                $('#report_incident_nature').val('');
                var checkbox1 = document.getElementById('radio1');
                var checkbox2 = document.getElementById('radio2');
                var checkbox3 = document.getElementById('radio3');
                var checkbox4 = document.getElementById('radio4');
                var checkbox5 = document.getElementById('radio5');
                var checkbox6 = document.getElementById('radio6');
                var checkbox7 = document.getElementById('radio7');
                var checkbox8 = document.getElementById('radio8');
                var checkbox9 = document.getElementById('radio9');
                checkbox1.checked = false;
                checkbox2.checked = false;
                checkbox3.checked = false;
                checkbox4.checked = false;
                checkbox5.checked = false;
                checkbox6.checked = false;
                checkbox7.checked = false;
                checkbox8.checked = false;
                checkbox9.checked = false;
                $("#assign").val('');
            }


            const radio1 = document.getElementById("radio1");
            const radio2 = document.getElementById("radio2");
            const radio4 = document.getElementById("radio4");
            const radio5 = document.getElementById("radio5");
            const radio8 = document.getElementById("radio8");
            const radio3 = document.getElementById("radio3");
            const radio6 = document.getElementById("radio6");
            const radio7 = document.getElementById("radio7");
            radio1.addEventListener("change", function () {

                if (radio1.checked) {
                    radio2.checked = false;
                    radio4.checked = false;
                    radio5.checked = false;
                    $('#approver_select').addClass('hidden');
                } else {
                    $('#approver_select').removeClass('hidden');
                }
            });
            radio2.addEventListener("change", function () {
                if (radio2.checked) {
                    radio1.checked = false;
                    radio4.checked = false;
                    radio5.checked = false;
                    $('#approver_select').removeClass('hidden');
                } else {
                    $('#approver_select').addClass('hidden');
                }
            });
            radio4.addEventListener("change", function () {
                if (radio4.checked) {
                    radio1.checked = false;
                    radio2.checked = false;
                    radio5.checked = false;
                    $('#approver_select').removeClass('hidden');
                } else {
                    $('#approver_select').addClass('hidden');
                }
            });
            radio5.addEventListener("change", function () {
                if (radio5.checked) {
                    radio1.checked = false;
                    radio2.checked = false;
                    radio4.checked = false;
                    $('#approver_select').removeClass('hidden');
                } else {
                    $('#approver_select').addClass('hidden');
                }
            });
            radio8.addEventListener("change", function () {

                if (radio8.checked) {
                    radio3.checked = false;
                    radio6.checked = false;
                    radio7.checked = false;
                    $('#approver_select').addClass('hidden');
                } else {
                    $('#approver_select').removeClass('hidden');
                }
            });
            radio3.addEventListener("change", function () {
                if (radio3.checked) {
                    radio8.checked = false;
                    radio6.checked = false;
                    radio7.checked = false;
                    $('#approver_select').removeClass('hidden');
                } else {
                    $('#approver_select').addClass('hidden');
                }
            });
            radio6.addEventListener("change", function () {
                if (radio6.checked) {
                    radio8.checked = false;
                    radio3.checked = false;
                    radio7.checked = false;
                    $('#approver_select').addClass('hidden');
                } else {
                    $('#approver_select').removeClass('hidden');
                }
            });
            radio7.addEventListener("change", function () {
                if (radio7.checked) {
                    radio8.checked = false;
                    radio3.checked = false;
                    radio6.checked = false;
                    $('#approver_select').removeClass('hidden');
                } else {
                    $('#approver_select').addClass('hidden');
                }
            });
            radio9.addEventListener("change", function () {

                if (radio9.checked) {
                    $('#approver_select').addClass('hidden');
                } else {
                    $('#approver_select').removeClass('hidden');
                }
            });
            document.addEventListener("DOMContentLoaded", function () {
                var typeSelector = document.getElementById("type");
                var checkboxes = document.querySelectorAll("input[type='checkbox']");
                //            var saveButton = document.getElementById("ticket_type_btn");
                var saveButton = document.getElementById("save_btn");
                function checkValidity() {
                    var isTypeSelected = typeSelector.value !== "";
                    var isChecked = Array.from(checkboxes).some(function (checkbox) {
                        return checkbox.checked;
                    });
                    if (isTypeSelected && isChecked) {
                        saveButton.disabled = false;
                        saveButton.classList.remove("disabled");
                    } else {
                        saveButton.disabled = true;
                        saveButton.classList.add("disabled");
                    }
                }

                typeSelector.addEventListener("change", checkValidity);
                checkboxes.forEach(function (checkbox) {
                    checkbox.addEventListener("change", checkValidity);
                });
                checkValidity(); // Initial check on page load
            });
            const depCheckbox = document.getElementById('transfer_emp_dep_check');
            const depSelect = document.getElementById('transfer_emp_dep_div');
            depCheckbox.addEventListener('click', function () {
                if (depCheckbox.checked) {
                    depSelect.style.display = 'block';
                } else {
                    depSelect.style.display = 'none';
                }
            });
            const branchCheckbox = document.getElementById('transfer_emp_branch_check');
            const branchSelect = document.getElementById('transfer_emp_branch_div');
            branchCheckbox.addEventListener('click', function () {
                if (branchCheckbox.checked) {
                    branchSelect.style.display = 'block';
                } else {
                    branchSelect.style.display = 'none';
                }
            });
            const designationCheckbox = document.getElementById('transfer_emp_designation_check');
            const designationSelect = document.getElementById('transfer_emp_designation_div');
            designationCheckbox.addEventListener('click', function () {
                if (designationCheckbox.checked) {
                    designationSelect.style.display = 'block';
                } else {
                    designationSelect.style.display = 'none';
                }
            });
            var dep_transfer = new SlimSelect({
                select: '#dep_transfer',
                ajax: function (search, callback) {
                    fetch('ticket/get-dep', {
                        method: 'POST',
                        body: new URLSearchParams({search: search || ''})
                    }).then(res => res.json()).then((data) => {
                        callback(data);
                    });
                },
                allowDeselect: true,
                deselectLabel: '<span class="red">✖</span>'
            });
            $('#dep_transfer').data('select', dep_transfer);
            var des_transfer = new SlimSelect({
                select: '#des_transfer',
                ajax: function (search, callback) {
                    fetch('ticket/get-des', {
                        method: 'POST',
                        body: new URLSearchParams({search: search || ''})
                    }).then(res => res.json()).then((data) => {
                        callback(data);
                    });
                },
                allowDeselect: true,
                deselectLabel: '<span class="red">✖</span>'
            });
            $('#des_transfer').data('select', des_transfer);
            var branch_transfer = new SlimSelect({
                select: '#branch_transfer',
                ajax: function (search, callback) {
                    fetch('user/search-branch', {
                        method: 'POST',
                        body: new URLSearchParams({search: search || ''})
                    }).then(res => res.json()).then((data) => {
                        callback(data);
                    });
                },
                allowDeselect: true,
                deselectLabel: '<span class="red">✖</span>'
            });
            $('#branch_transfer').data('select', branch_transfer);

            function loadCardCount() {
                fetch('ticket/cards').then((res) => res.json()).then((data) => {
                    for (var i = 0; i < data.length; i++) {
                        if (data[i].status === -1) {
                            $('#all_tickets_card').html(data[i].noOfTickets);
                        } else if (data[i].status === 5) {
                            $('#queued_card_all').html(data[i].noOfTickets);
                        } else if (data[i].status === 4) {
                            $('#closed_card_all').html(data[i].noOfTickets);
                        } else if (data[i].status === 3) {
                            $('#inprogress_card_all').html(data[i].noOfTickets);
                        } else if (data[i].status === 2) {
                            $('#finished_card_all').html(data[i].noOfTickets);
                        } else if (data[i].status === 8) {
                            $('#recruitment_card_all').html(data[i].noOfTickets);
                        } else if (data[i].status === 7) {
                            $('#assigned_card_all').html(data[i].noOfTickets);
                        } else if (data[i].status === 9) {
                            $('#approval_card_all').html(data[i].noOfTickets);
                        } else if (data[i].status === 10) {
                            $('#department_card_all').html(data[i].noOfTickets);
                        }
                    }

                });
            }


            $("#new_ticket").click(function () {
                $("#ticket_type_modal").modal('show');
            });
            var mode;
            $('#type').change(function () {
                clear();
                if ($(this).val() === '1') {
                    mode = "1";
                    document.getElementById('label_type').innerHTML = 'Application Ticket';
                    $(".dashcontainer").hide();
                    $("#datatable").hide();
                    $("#ticket").fadeIn();
                    $('#issue_div,#application_type').show();
                    $('#transfer_promotion_div,#hardware_type,#incident_type').hide();
                    $('#not_termination_div').hide();
                    $('#lbl_type').show();
                    $('#application').show();
                    $('#select_application').parent().show();
                    $('#select_hardware').parent().hide();
                    $('#recruit').hide();
                    $('#recruitment_div').hide();
                    $('#terminate').hide();
                    $('#incident').hide();
                    document.getElementById('lbl_type').innerHTML = 'Application<span class="text-danger">*</span>';
                    $('#subject_input').val('');
                    $('#description').val('');
                } else if ($(this).val() === '2') {
                    mode = "2";
                    document.getElementById('label_type').innerHTML = 'Hardware Ticket';
                    $(".dashcontainer").hide();
                    $("#datatable").hide();
                    $("#ticket").fadeIn();
                    $('#issue_div,#hardware_type').show();
                    $('#transfer_promotion_div,#application_type,#incident_type').hide();
                    $('#not_termination_div').hide();
                    $('#lbl_type').show();
                    $('#select_application').parent().hide();
                    $('#select_hardware').parent().show();
                    $('#application').show();
                    $('#terminate').hide();
                    $('#recruit').hide();
                    $('#recruitment_div').hide();
                    $('#incident').hide();
                    document.getElementById('lbl_type').innerHTML = 'Equipment<span class="text-danger">*</span>';
                    $('#subject_input').val('');
                    $('#description').val('');
                } else if ($(this).val() === '3') {
                    mode = "3";
                    document.getElementById('label_type').innerHTML = 'Recruitment Ticket';
                    $(".dashcontainer").hide();
                    $("#datatable").hide();
                    $("#ticket").fadeIn();
                    $('#issue_div,#hardware_type,#application_type').hide();
                    $('#transfer_promotion_div').hide();
                    $('#not_termination_div').hide();
                    $('#lbl_type').hide();
                    $('#terminate').hide();
                    $('#select_application').parent().hide();
                    $('#select_hardware').parent().hide();
                    $('#recruit').show();
                    $('#recruitment_div').show();
                    $('#application').hide();
                    $('#incident').hide();
                    $('#subject_input').val('');
                    $('#description').val('');
                } else if ($(this).val() === '4') {
                    mode = "4";
                    document.getElementById('label_type').innerHTML = 'Incident Ticket';
                    $(".dashcontainer").hide();
                    $("#datatable").hide();
                    $("#ticket").fadeIn();
                    $('#issue_div,#incident_type').show();
                    $('#transfer_promotion_div,#hardware_type,#application_type').hide();
                    $('#not_termination_div').hide();
                    $('#recruit').hide();
                    $('#recruitment_div').hide();
                    $('#terminate').hide();
                    $('#select_application').parent().hide();
                    $('#select_hardware').parent().hide();
                    $('#lbl_type').hide();
                    $('#application').hide();
                    $('#incident').show();
                    $('#subject_input').val('');
                    $('#description').val('');
                } else if ($(this).val() === '5') {
                    mode = "5";
                    document.getElementById('label_type').innerHTML = 'Termination Ticket';
                    $(".dashcontainer").hide();
                    $("#datatable").hide();
                    $("#ticket").fadeIn();
                    $('#issue_div,#hardware_type,#application_type').hide();
                    $('#transfer_promotion_div').hide();
                    $('#not_termination_div').hide();
                    $('#recruit').hide();
                    $('#recruitment_div').hide();
                    $('#terminate').show();
                    $('#select_application').parent().hide();
                    $('#select_hardware').parent().hide();
                    $('#lbl_type').hide();
                    $('#application').hide();
                    $('#incident').hide();
                    $('#subject_input').val('');
                    $('#description').val('');
                    document.getElementById('lbl_type').innerHTML = '';
                } else if ($(this).val() === '6') {
                    mode = "6";
                    document.getElementById('label_type').innerHTML = 'Transfer/Promotion Ticket';
                    $(".dashcontainer").hide();
                    $("#datatable").hide();
                    $("#ticket").fadeIn();
                    $('#transfer_promotion_div').show();
                    $('#not_termination_div').show();
                    $('#issue_div,#hardware_type,#application_type').hide();
                    $('#terminate').hide();
                    $('#recruitment_div').hide();
                    $('#incident').hide();
                } else {
                    $('#issue_div').show();
                    $('#transfer_promotion_div').hide();
                    $('#recruitment_div').hide();
                    mode = "none";
                    document.getElementById('lbl_type').innerHTML = 'Category<span class="text-danger">*</span>';
                    $('#incident').hide();
                    $('#select_application').parent().hide();
                    $('#select_hardware').parent().hide();
                    $('#recruit').hide();
                    $('#application').show();
                    $('#lbl_type').show();
                    document.getElementById('label_type').innerHTML = '';
                }
            });
            var users_assign = new SlimSelect({
                select: '#users_assign',
                placeholder: "User List",
                ajax: function (search, callback) {
                    fetch('user/search-admin-users', {
                        method: 'POST',
                        body: new URLSearchParams({search: search || ''})
                    }).then(res => res.json()).then((data) => {
                        callback(data);
                    });
                },
                allowDeselect: true,
                deselectLabel: '<span class="red">✖</span>'
            });
            $('#users_assign').data('select', users_assign);
            var behalf = new SlimSelect({
                select: '#behalf',
                placeholder: "User List",
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
            $('#behalf').data('select', behalf);
            var behalf = new SlimSelect({
                select: '#assign',
                placeholder: "User List",
                ajax: function (search, callback) {
                    fetch('user/search-users', {
                        method: 'POST',
                        body: new URLSearchParams({search: search})
                    }).then(res => res.json()).then((data) => {
                        callback(data);
                    });
                },
                allowDeselect: true,
                deselectLabel: '<span class="red">✖</span>'
            });
            $('#assign').data('select', behalf);
            var terminate_users = new SlimSelect({
                select: '#terminate_users',
                placeholder: "User List",
                ajax: function (search, callback) {
                    fetch('user/search-employee', {
                        method: 'POST',
                        body: new URLSearchParams({search: search || ''})
                    }).then(res => res.json()).then((data) => {
                        callback(data);
                    });
                },
                allowDeselect: true,
                deselectLabel: '<span class="red">✖</span>'
            });
            $('#terminate_users').data('select', terminate_users);
            var transfer_users = new SlimSelect({
                select: '#transfer_users',
                placeholder: "User List",
                ajax: function (search, callback) {
                    fetch('user/search-employee', {
                        method: 'POST',
                        body: new URLSearchParams({search: search || ''})
                    }).then(res => res.json()).then((data) => {
                        callback(data);
                    });
                },
                allowDeselect: true,
                deselectLabel: '<span class="red">✖</span>'
            });
            $('#transfer_users').data('select', transfer_users);

            var type = new SlimSelect({
                select: '#type',
                ajax: function (search, callback) {
                    fetch('ticket/search-type', {
                        method: 'POST',
                        body: new URLSearchParams({search: search || ''})
                    }).then(res => res.json()).then((data) => {
                        callback(data);
                    });
                },
                allowDeselect: false,
                deselectLabel: '<span class="red">✖</span>',
                showSearch: false
            });
            $('#type').data('select', type);
            var select_user = new SlimSelect({
                select: '#select_user',
                settings: {
                    disabled: true
                }
            });
            $('#select_user').data('select', select_user);
            var select_level = new SlimSelect({
                select: '#select_level'
            });
            var select_application = new SlimSelect({
                select: '#select_application',
                ajax: function (search, callback) {
                    fetch('ticket/get-app', {
                        method: 'POST',
                        body: new URLSearchParams({search: search || ''})
                    }).then(res => res.json()).then((data) => {
                        callback(data);
                    });
                },
                allowDeselect: true,
                deselectLabel: '<span class="red">✖</span>'
            });
            $('#select_application').data('select', select_application);
            var hr_emp_select_department = new SlimSelect({
                select: '#hr_emp_select_department',
                ajax: function (search, callback) {
                    fetch('ticket/get-dep', {
                        method: 'POST',
                        body: new URLSearchParams({search: search || ''})
                    }).then(res => res.json()).then((data) => {
                        callback(data);
                    });
                },
                allowDeselect: true,
                deselectLabel: '<span class="red">✖</span>'
            });
            $('#hr_emp_select_department').data('select', hr_emp_select_department);
            var hr_emp_select_designation = new SlimSelect({
                select: '#hr_emp_select_designation',
                ajax: function (search, callback) {
                    fetch('ticket/get-des', {
                        method: 'POST',
                        body: new URLSearchParams({search: search || ''})
                    }).then(res => res.json()).then((data) => {
                        callback(data);
                    });
                },
                allowDeselect: true,
                deselectLabel: '<span class="red">✖</span>'
            });
            $('#hr_emp_select_designation').data('select', hr_emp_select_designation);
            var hr_emp_select_gender = new SlimSelect({
                select: '#hr_emp_select_gender',
                allowDeselect: true,
                deselectLabel: '<span class="red">✖</span>'
            });
            var time_table = new SlimSelect({
                select: '#time_table'
            });
            var suggestion_comment_id = new SlimSelect({
                select: '#suggestion_comment_id',
                allowDeselect: true,
                deselectLabel: '<span class="red">✖</span>'
            });
            var hr_emp_select_location = new SlimSelect({
                select: '#hr_emp_select_location',
                ajax: function (search, callback) {
                    fetch('ticket/get-loc', {
                        method: 'POST',
                        body: new URLSearchParams({search: search || ''})
                    }).then(res => res.json()).then((data) => {
                        callback(data);
                    });
                },
                allowDeselect: true,
                deselectLabel: '<span class="red">✖</span>'
            });
            $('#hr_emp_select_location').data('select', hr_emp_select_location);
            var select_hardware = new SlimSelect({
                select: '#select_hardware',
                ajax: function (search, callback) {
                    fetch('ticket/get-hard', {
                        method: 'POST',
                        body: new URLSearchParams({search: search || ''})
                    }).then(res => res.json()).then((data) => {
                        callback(data);
                    });
                },
                allowDeselect: true,
                deselectLabel: '<span class="red">✖</span>'
            });
            $('#select_hardware').data('select', select_hardware);
            var incident_select = new SlimSelect({
                select: '#incident_select',
                ajax: function (search, callback) {
                    fetch('ticket/get-incident', {
                        method: 'POST',
                        body: new URLSearchParams({search: search || ''})
                    }).then(res => res.json()).then((data) => {
                        callback(data);
                    });
                },
                allowDeselect: true,
                deselectLabel: '<span class="red">✖</span>'
            });
            $('#incident_select').data('select', incident_select);
            $('#post_btn').click(function () {
                Swal.fire({
                    title: 'Are you sure?',
                    text: "This Chat Will Be Sent!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, Proceed!',
                    showLoaderOnConfirm: true,
                    preConfirm: () => {
                        return fetch('ticket/save-chat', {
                            method: 'POST',
                            body: new URLSearchParams({
                                ticketId: $('#editcard').data('id'),
                                chat: document.getElementById('myTextarea').value
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
                            Swal.fire('Successfull!', 'Chat has been sent!', 'success');
                        }
                    }
                });
            });
            $('#upload_new_attachment').click(function () {
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
                                ticketId: $('#editcard').data('id'),
                                comment: document.getElementById('cmt').value
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
                            $("#cmt").val("");
                            commentTable.ajax.reload();
                        }
                    }
                });
            });
            $('#suggetion_btn').click(function () {
                return fetch('ticket/save-comment', {
                    method: 'POST',
                    body: new URLSearchParams({
                        ticketId: $('#editcard').data('id'),
                        status: document.getElementById('suggestion_comment_id').value
                    })
                }).then(response => {
                    if (!response.ok) {
                        throw new Error(response.statusText);
                    } else {
                        Swal.fire('Successfull!', 'Comment has been successfully submitted');
                    }
                    return response.json();
                }).catch(error => {
                    Swal.fire("Empty Description!", "Please Enter a Valid Subject!", "warning");
                });
                dtable1.ajax.reload();
            });
            $('#save_btn').click(function () {

                if (!$('#approver_select').hasClass('hidden')) {
                    if ($('#assign').val() === null) {
                        Swal.fire("Empty Approver!", "Please Enter a Valid Approver!", "warning");
                        return;
                    }
                }

                if (mode === "1") {
                    if ($('#select_application').val() === null) {
                        Swal.fire("Empty Application!", "Please Enter a Valid Application!", "warning");
                        return;
                    }
                }

                if (mode === "2") {
                    if ($('#select_hardware').val() === null) {
                        Swal.fire("Empty Hardware!", "Please Enter a Valid Hardware!", "warning");
                        return;
                    }
                }

                if (mode === "4") {

                    if ($('#incident_select').val() === null) {
                        Swal.fire("Empty Incident!", "Please Enter a Valid Incident!", "warning");
                        return;
                    }

                    if ($('#report_incident_date').val().trim() === '') {
                        Swal.fire("Empty Incident Date!", "Please Enter a Valid Incident Date!", "warning");
                        return;
                    }

                    if ($('#report_incident_nature').val().trim() === '') {
                        Swal.fire("Empty Incident Nature!", "Please Enter a Valid Incident Nature!", "warning");
                        return;
                    }

                }


                if (mode === "1" || mode === "2") {
                    if ($('#subject_input').val().trim() === '') {
                        Swal.fire("Empty Subject!", "Please Enter a Valid Subject!", "warning");
                        return;
                    }

                    if ($('#description').val().trim() === '') {
                        Swal.fire("Empty Description!", "Please Enter a Valid Description!", "warning");
                        return;
                    }
                }

                const formData = new FormData();
                const checkboxes = document.getElementsByClassName('checkbox');
                const selectedValues = [];
                for (let i = 0; i < checkboxes.length; i++) {
                    if (checkboxes[i].checked) {
                        selectedValues.push(checkboxes[i].value);
                    }
                }

                formData.append('selected', JSON.stringify(selectedValues));
                formData.append('type', $('#type').val());
                if ($('#assign').val()) {
                    formData.append('assign', $('#assign').val());
                    formData.append('status', 9);
                }
                formData.append('select_app', $('#select_application').val());
                formData.append('priority', $('#select_level').val());
                formData.append('subject', $('#subject_input').val());
                formData.append('description', $('#description').val());
                formData.append('user', $('#select_user').val());
                formData.append('behalf', $('#behalf').val());
                formData.append('select_hard', $('#select_hardware').val());
                console.log(formData);
                Swal.fire({
                    title: 'Are you sure?',
                    text: "Ticket Will be created",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, Continue!',
                    showLoaderOnConfirm: true,
                    searchHighlight: true,
                    preConfirm: () => {
                        if (mode === "1") {
                            return fetch('ticket/save-ticket-application', {
                                method: 'POST',
                                body: formData
                            }).then(response => {
                                if (!response.ok) {
                                    throw new Error(response.statusText);
                                }
                                return response.json();
                            }).catch(error => {
                                Swal.showValidationMessage('Request failed:' + error);
                            });
                        }
                        if (mode === "2") {
                            return fetch('ticket/save-ticket-hardware', {
                                method: 'POST',
                                body: formData
                            }).then(response => {
                                if (!response.ok) {
                                    throw new Error(response.statusText);
                                }
                                return response.json();
                            }).catch(error => {
                                Swal.showValidationMessage('Request failed:' + error);
                            });
                        }
                        if (mode === "3") {

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
                            return fetch('ticket/save-ticket-recruitment', {
                                method: 'POST',
                                body: new URLSearchParams({
                                    access: JSON.stringify(selectedCheckboxes),
                                    type: document.getElementById('type').value,
                                    description: document.getElementById('hr_emp_txt_area').value,
                                    behalf: document.getElementById('behalf').value,
                                    fullname: document.getElementById('hr_full_name_input').value,
                                    calling: document.getElementById('hr_call_name_input').value,
                                    epf: document.getElementById('hr_emp_epf_input').value,
                                    joindate: document.getElementById('hr_join_date_input').value,
                                    address: document.getElementById('hr_address_input').value,
                                    phone: document.getElementById('hr_pno_input').value,
                                    nic: document.getElementById('hr_emp_nic_input').value,
                                    department: document.getElementById('hr_emp_select_department').value,
                                    designation: document.getElementById('hr_emp_select_designation').value,
                                    gender: document.getElementById('hr_emp_select_gender').value,
                                    location: document.getElementById('hr_emp_select_location').value
                                })
                            }).then(response => {
                                if (!response.ok) {
                                    throw new Error(response.statusText);
                                }
                                return response.json();
                            }).catch(error => {
                                Swal.showValidationMessage('Request failed:' + error);
                            });
                        }
                        if (mode === "5") {
                            var checkbox = document.getElementById("ralcheck");
                            return fetch('ticket/save-ticket-termination', {
                                method: 'POST',
                                body: new URLSearchParams({

                                    type: document.getElementById('type').value,
                                    behalf: document.getElementById('behalf').value,
                                    employee: document.getElementById('terminate_users').value,
                                    lastdate: document.getElementById('last_date_terminate').value,
                                    access: checkbox.checked ? true : false
                                })
                            }).then(response => {
                                if (!response.ok) {
                                    throw new Error(response.statusText);
                                }
                                return response.json();
                            }).catch(error => {
                                Swal.showValidationMessage('Request failed:' + error);
                            });
                        }
                        if (mode === "6") {
                            return fetch('ticket/save-ticket-transfer', {
                                method: 'POST',
                                body: new URLSearchParams({
                                    type: document.getElementById('type').value,
                                    behalf: document.getElementById('behalf').value,
                                    employee: document.getElementById('transfer_users').value,
                                    department: document.getElementById('dep_transfer').value,
                                    branch: document.getElementById('branch_transfer').value,
                                    designation: document.getElementById('des_transfer').value
                                })
                            }).then(response => {
                                if (!response.ok) {
                                    throw new Error(response.statusText);
                                }
                                return response.json();
                            }).catch(error => {
                                Swal.showValidationMessage('Request failed:' + error);
                            });
                        }
                        if (mode === "4") {

                            const requestBody = new FormData();
                            requestBody.append('type', $('#type').val());
                            if ($('#assign').val()) {
                                requestBody.append('assign', $('#assign').val());
                                requestBody.append('status', 9);
                            }
                            requestBody.append('incident_type', $('#incident_select').val());
                            requestBody.append('time_of_incident', $('#report_incident_date').val());
                            requestBody.append('nature_of_incident', $('#report_incident_nature').val());
                            requestBody.append('behalf', $('#behalf').val());
                            requestBody.append('user', $('#select_user').val());
                            return fetch('ticket/save-ticket-incident', {
                                method: 'POST',
                                body: requestBody
                            }).then(response => {
                                if (!response.ok) {
                                    throw new Error(response.statusText);
                                }
                                return response.json();
                            }).catch(error => {
                                Swal.showValidationMessage('Request failed:' + error);
                            });
                        }
                    },
                    allowOutsideClick: () => !Swal.isLoading()

                }).then((result) => {
                    if (result.value) {
                        if (result.value.status !== 200) {
                            Swal.fire('Error!', result.value.msg, 'error');
                        } else {
                            Swal.fire('Successfull!', 'Ticket has been successfully submitted');
                            dtable.ajax.reload();
                        }
                    }
                });
            });
            var status = '';
            var status_new = '';
            var department = "";
            $("#all_tickets1").click(function () {
                status = '';
                status_new = '';
                dtable.ajax.reload();
            });
            $("#queued").click(function () {
                status = '5';
                status_new = '5';
                dtable.ajax.reload();
            });
            $("#approval").click(function () {
                status = '9';
                status_new = '9';
                dtable.ajax.reload();
            });
            $("#closed_tickets").click(function () {
                status = '4';
                status_new = '4';
                dtable.ajax.reload();
            });
            $("#in_progress").click(function () {
                status = '3';
                status_new = '3';
                dtable.ajax.reload();
            });
            $("#finished_tickets").click(function () {
                status = '2';
                status_new = '2';
                dtable.ajax.reload();
            });
            $("#recruitment").click(function () {
                status = '8';
                status_new = '8';
                dtable.ajax.reload();
            });
            $("#assigned_ticket").click(function () {
                status = '7';
                status_new = '7';
                dtable.ajax.reload();
            });
            $("#department_tickets").click(function () {
                status = '10';
                status_new = '10';
                dtable.ajax.reload();
            });
            $.fn.dataTable.ext.errMode = 'none';
            var dtable = $('#tbll').DataTable(
                    {
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
                            "url": "ticket/shows",
                            "contentType": "application/json",
                            "type": "POST",
                            "data": function (d) {
                                d.data = status;
                                d.filter = filter;
                                return JSON.stringify(d);
                            },
                            error: function (xhr, error, code) {
                                console.log(xhr);
                                console.log(code);
                            }
                        },
                        "columns": [
                            {"data": "id", className: "text-right", visible: false},
                            {"data": "code"},
                            {"data": "ticketType"},
                            {"data": "priority"},
                            {"data": "subject"},
                            {"data": "description"},
                            {"data": "modBy"},
                            {"data": "modOn"},
                            {"data": "status", className: "text-center"}
                        ], "language": {
                            'loadingRecords': '&nbsp;',
                            'processing': '<div class="loader2"></div>'
                        }, "createdRow": function (row, data) {
                            let action_td = document.createElement('td');
                            $(action_td).addClass('text-center');
                            if (data['status'] === '4' && status_new === '4') {
                                $(action_td).append('<a href="javascript:void(0)" idd="' + data.id + '" class="editrec" data-toggle="modal" data-target="#exampleModalCenter"><i class="icon feather icon-eye f-w-600 f-16 m-r-10 text-c-green"></i></a>');
                            } else if (data['status'] === '4') {
                                $(action_td).append('<a href="javascript:void(0)" class="rerec"><i class="feather icon-refresh-cw f-w-600 f-16 text-c-blue"></i></a>');
                            } else if (data['status'] === '2') {
                                $(action_td).append('<a href="javascript:void(0)" idd="' + data.id + '" class="editrec" data-toggle="modal" data-target="#exampleModalCenter"><i class="icon feather icon-edit f-w-600 f-16 m-r-10 text-c-green" data-toggle="tooltip" data-placement="top" title="Edit/View"></i></a><a href="javascript:void(0)" class="delrec"><i class="feather icon-check f-w-600 f-16 text-danger" data-toggle="tooltip" data-placement="top" title="Close"></i></a><a style="margin-left: 10px;" href="javascript:void(0)" class="rerec" data-toggle="tooltip" data-placement="top" title="Re-Open"><i class="feather icon-refresh-cw f-w-600 f-16 text-c-blue"></i></a>');
                            } else if (data['status'] === '3') {
                                $(action_td).append('<a href="javascript:void(0)" idd="' + data.id + '" class="editrec" data-toggle="modal" data-target="#exampleModalCenter"><i class="icon feather icon-edit f-w-600 f-16 m-r-10 text-c-green"></i></a>');
                            } else if (data['status'] === '5') {
                                $(action_td).append('<a href="javascript:void(0)" idd="' + data.id + '" class="editrec" data-toggle="modal" data-target="#exampleModalCenter"><i class="icon feather icon-edit f-w-600 f-16 m-r-10 text-c-green"></i></a><a href="javascript:void(0)" class="delrec"><i class="feather icon-trash-2 f-w-600 f-16 text-danger"></i></a>');
                            } else if (data['status'] === '7') {
                                $(action_td).append('<a href="javascript:void(0)" idd="' + data.id + '" class="editrec" data-toggle="modal" data-target="#exampleModalCenter"><i class="icon feather icon-edit f-w-600 f-16 m-r-10 text-c-green"></i></a>');
                            } else if (data['status'] === '9') {
                                $(action_td).append('<a href="javascript:void(0)" idd="' + data.id + '" class="editrec" data-toggle="modal" data-target="#exampleModalCenter"><i class="icon feather icon-edit f-w-600 f-16 m-r-10 text-c-green"></i></a>');
                            } else {
                                $(action_td).append('<a href="javascript:void(0)" idd="' + data.id + '" class="editrec" data-toggle="modal" data-target="#exampleModalCenter"><i class="icon feather icon-edit f-w-600 f-16 m-r-10 text-c-green"></i></a><a href="javascript:void(0)" class="delrec"><i class="feather icon-trash-2 f-w-600 f-16 text-danger"></i></a>');
                            }
                            $(row).append(action_td);
                            setTableStatus($(row).find('td').eq(7));
                            $(row).data('id', data['id']);
                        }
                    });
            function setTableStatus(td)
            {
                if ($(td).html().startsWith('4')) {
                    $(td).html('<label class="label label-danger" style="white-space: nowrap">Closed</label>');
                } else if ($(td).html().startsWith('2')) {
                    $(td).html('<label class="badge " style="white-space: nowrap; background:#5ba9fd">Finished</label>');
                } else if ($(td).html().startsWith('7')) {
                    $(td).html('<label class="badge " style="white-space: nowrap; background:#219B9D">Assigned</label>');
                } else if ($(td).html().startsWith('3')) {
                    $(td).html('<label class="badge " style="white-space: nowrap; background:#FF7400">In Progress</label>');
                } else if ($(td).html().startsWith('5')) {
                    $(td).html('<label class="badge " style="white-space: nowrap; background:#B112AA">Queued</label>');
                } else if ($(td).html().startsWith('9')) {
                    $(td).html('<label class="badge " style="white-space: nowrap; background:#6A16C8">Approval Pending</label>');
                } else {
                    $(td).html('<label class="label label-success" style="white-space: nowrap">Active</label>');
                }
            }
            function setTableStatus1(td)
            {
                if ($(td).html().startsWith('Approved')) {

                } else {
                    $(td).html('<label class="badge badge-info" style="white-space: nowrap">Approved</label>');
                }
            }

            function formatDateTime(dateTimeString) {
                var formattedDateTime = new Date(dateTimeString).toLocaleString();
                return formattedDateTime;
            }


            var commentTableTicketId = 0;
            var commentTable = $('#comment_table').DataTable(
                    {
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
                            "url": "ticket/comments",
                            "contentType": "application/json",
                            "type": "POST",
                            "data": function (d) {
                                d.data = commentTableTicketId;
                                return JSON.stringify(d);
                            },
                            error: function (xhr, error, code) {
                                console.log(xhr);
                                console.log(code);
                            }
                        },
                        "columns": [
                            {"data": "id", className: "text-right", visible: false},
                            {"data": "user"},
                            {"data": "comment"},
                            {"data": "dateandtime"},
                            {"data": "status", visible: false}
                        ], "language": {
                            'loadingRecords': '&nbsp;',
                            'processing': '<div class="loader2"></div>'
                        }, "createdRow": function (row, data) {
                            let action_td = document.createElement('td');
                            $(action_td).addClass('text-center');
                            if (data['status'] === 'Approved') {
                                setTableStatus1($(row).find('td').eq(1));
                            }
                        }
                    });


            $(document).on('click', '.editrec', function () {
                var idd = ($(this).attr('idd'));
                $('#editcard').modal('show');
                $('#editcard').data('id', idd);
                $('#lod_table thead').html('');
                $('#lod_table tbody').html('');
                $('#dtable1').html('');
                $('#lod_table tfoot').html('');
                commentTableTicketId = idd;
                commentTable.ajax.reload();
                $.post('ticket/ticket-data', {id: idd}, function (data) {

                    $('#priority').html('');
                    $('#subject').html('');
                    $('#ticketid').html('');
                    $('#reported').html('');
                    $('#category').html('');
                    $('#desc').html('');
                    $('#bradep').html('');
                    $('#users_assign').html('');
                    users_assign.set([]);
                    $('#subject').val(data.subject);
                    $('#ticketid').html(data.code);
                    $('#reported').html(data.reporter);
                    $('#category').val(data.category);
                    $('#desc').val(data.description);
                    $('#ttype').val(data.ticketType);
                    $('#date').val(data.entOn);
                    $('#bradep').html(data.reporter);
                    var pr = $('#newpriority').val(data.priority);
                    if ($(pr).html() === ('Normal')) {
                        $(pr).html('<span class="badge" style="background: 	#f0ffff"> Normal </span>');
                    } else {
                        $(pr).html('<span class="badge" style="background:#c0c0c0"> Urgent </span>');
                    }
                    var tr = $('#newstatus').html(data.status);
                    if ($(tr).html() === ('3')) {
                        $(tr).html('<span class="badge badge-info">In Progress</span>');
                        $('#editrow').hide();
                    } else if ($(tr).html() === '5') {
                        $(tr).html('<span class="badge badge-success" style="white-space: nowrap">Queued</span>');
                        $('#editrow').hide();
                    } else if ($(tr).html() === '4') {
                        $(tr).html('<span class="badge badge-danger" style="white-space: nowrap">Closed</span>');
                        $('#editrow').hide();
                    } else if ($(tr).html() === '7') {
                        $(tr).html('<span class="badge badge-danger" style="white-space: nowrap">Assigned</span>');
                        $('#editrow').hide();
                    } else if ($(tr).html() === '9') {
                        $(tr).html('<span class="badge badge-warning" style="white-space: nowrap">Approval Pending</span>');
                        $('#editrow').hide();
                    } else if ($(tr).html() === '2') {
                        $(tr).html('<span class="badge" style="white-space: nowrap;background:#5ba9fd">Finish</span>');
                        $('#editrow').show();
                    }

                    if (data.assignee) {
                        let a = JSON.parse(data.assignee);
                        let  ary = [];
                        let  arySelect = [];
                        for (var i = 0; i < a.length; i++) {
                            ary.push({value: a[i].id, text: a[i].name});
                            arySelect.push(a[i].id);
                        }
                        users_assign.setData(ary);
                        users_assign.set(arySelect);
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

                    let log = JSON.parse(data.ticketLog);
                    $('.ticketTracking').html('');
                    var timelineContainer = document.querySelector('.ticketTracking');
                    timelineContainer.innerHTML = '';
                    var dotColors = ['red', 'blue', 'green', 'yellow']; // Add more colors as needed
                    var colorIndex = 0; // Initialize the color index

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
                        tlContent.innerHTML = '<div><span class="tl-date text-muted mt-1">Step - </span>' + (index + 1).toString() + '</div>' +
                                '<div class="tl-date text-muted mt-1">Name - ' + item.user + '</div>' +
                                '<div class="tl-date text-muted mt-1">Date - ' + convertedTicketAge + '</div>' +
                                '<div class="tl-date text-muted mt-1" style="background: #e6f2ff;">Action - ' + item.action + '</div>';
                        tlItem.appendChild(tlDot);
                        tlItem.appendChild(tlContent);
                        timelineContainer.appendChild(tlItem);
                    });
                    var chat = JSON.parse(data.chat);
                    $("#received_msg").html('');
                    if (data.chat) {
                        for (var i = 0; i < chat.length; i++) {
                            var timeFormat = formatDateTime(chat[i].time);
                            var temp = '<div class="received_withd_msg pull-left" style="margin-left : -10px;">'
                                    + '<p style="font-size: 12px; pull-left">'
                                    + '<strong style="font-weight: 700;font-size: 12px;" class="user pull-left">' + chat[i].user + '</strong>'
                                    + '<br><span class="chat">' + chat[i].chat + '</span> </p>'
                                    + '<span class="time_date time pull-left">' + timeFormat + '</span>'
                                    + '</div>'

                            $('#received_msg').append(temp);
                        }
                    }
                });

                $(document).on('click', '#ticket_assign_btn', function () {
                    Swal.fire({
                        title: 'Are you sure?',
                        text: "This Ticket Will be Assigned!",
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Yes, Proceed!',
                        showLoaderOnConfirm: true,
                        preConfirm: () => {
                            return fetch('ticket/assign-user', {
                                method: 'POST',
                                body: new URLSearchParams({
                                    user: JSON.stringify(users_assign.selected()),
                                    ticketId: $('#editcard').data('id')
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
                                Swal.fire('Successfull!', 'Ticket has been Assigned !', 'success');
                                dtable1.ajax.reload();
                                loadCount();
                            }
                        }
                    });
                });
                $.get('ticket/edit', {id: idd}, function (data) {

                    let log = JSON.parse(data.ticketLog);
                    $('#lod_table tbody').html('');
                    for (var i = 0; i < log.length; i++) {

                        let tr = document.createElement('tr');
                        $(tr).append('<td>' + log[i].id + '</td>');
                        $(tr).append('<td>' + log[i].user + '</td>');
                        $(tr).append('<td>' + log[i].action + '</td>');
                        $(tr).append('<td>' + log[i].data + '</td>');
                        $('#lod_table tbody').append(tr);
                    }

                });
            });
            $(document).on('click', '.rerec', function () {
                let id = $(this).parents('tr').data('id');
                Swal.fire({
                    title: 'This Ticket Will be Re-Open!',
                    text: "Please Provide Reason For Re-Open",
                    icon: 'warning',
                    input: 'textarea',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, Re-Open!',
                    showLoaderOnConfirm: true,
                    inputValidator: (value) => {
                        if (!value) {
                            return 'Please enter a reason for re-opening.';
                        }
                    },
                    preConfirm: (comment) => {
                        return fetch('ticket/re-open-ticket', {
                            method: 'POST',
                            body: new URLSearchParams({
                                ticketId: id,
                                comment: comment
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
                            Swal.fire('Successfull!', 'Ticket has been Re-Open !', 'success');
                            dtable.ajax.reload();
                            loadCardCount();
                        }
                    }
                });
            });

            loadCardCount();

            $(document).on('click', '.delrec', function () {
                let idd = $(this).parents('tr').data('id');
                let wrap = document.createElement('div');
                wrap.setAttribute('class', 'text-muted');
                wrap.setAttribute('style', 'display: flex; justify-content: center; align-items: center; height: 100%;');
                wrap.innerHTML = ' <div class="rate">'
                        + '<input type="radio" id="star5" name="rate" value="5" />'
                        + '<label for="star5" title="text">5 stars</label>'
                        + '<input type="radio" id="star4" name="rate" value="4" />'
                        + '<label for="star4" title="text">4 stars</label>'
                        + '<input type="radio" id="star3" name="rate" value="3" />'
                        + '<label for="star3" title="text">3 stars</label>'
                        + '<input type="radio" id="star2" name="rate" value="2" />'
                        + '<label for="star2" title="text">2 stars</label>'
                        + '<input type="radio" id="star1" name="rate" value="1" />'
                        + '<label for="star1" title="text">1 star</label>'
                        + '</div>';
                Swal.fire({
                    title: "How would you like to Rate us",
                    text: "How do you like the new features?",
                    icon: "info",
                    className: '',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Save !',
                    showLoaderOnConfirm: true,
                    html: wrap,
                    customClass: {
                        confirmButton: "btn btn-default text-center",
                    },
                    preConfirm: () => {
                        const rating = document.querySelector('input[name="rate"]:checked');
                        if (!rating) {
                            Swal.showValidationMessage('Please select a rating');
                            return false;
                        }

                        return fetch('ticket/rate-ticket', {
                            method: 'POST',
                            body: new URLSearchParams({
                                ticketId: idd,
                                rate: rating.value
                            })
                        })
                                .then(response => {
                                    if (!response.ok) {
                                        throw new Error(response.statusText);
                                    }
                                    return response.json();
                                })
                                .catch(error => {
                                    Swal.showValidationMessage('Request failed: ' + error);
                                });
                    },
                    allowOutsideClick: () => !Swal.isLoading()

                }).then((result) => {
                    if (result.value) {
                        if (result.value.status !== 200) {
                            Swal.fire('Error!', result.value.msg, 'error');
                        } else {
                            Swal.fire('Successful!', 'Ticket has been Closed!', 'success');
                            dtable.ajax.reload();
                            loadCardCount();
                        }
                    }
                });
            });

            $(document).on('click', '#re-open-btn', async function () {
                var idd = $('#editcard').data('id');
                Swal.fire({
                    title: 'This Ticket Will be Re-Open!',
                    text: "Please Provide Reason For Re-Open",
                    icon: 'warning',
                    input: 'textarea',
                    inputAttributes: {
                        autocapitalize: 'off'
                    },
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    showCancelButton: true,
                    confirmButtonText: 'Yes! Re-Open',
                    showLoaderOnConfirm: true,
                    backdrop: true, // Set backdrop to true
                    allowOutsideClick: true, // Set allowOutsideClick to true
                    inputValidator: (value) => {
                        if (!value) {
                            return 'Please enter a reason for re-opening.';
                        }
                    },
                    preConfirm: (comment) => {

                        return fetch('ticket/re-open-ticket', {
                            method: 'POST',
                            body: new URLSearchParams({
                                ticketId: idd,
                                comment: comment
                            })
                        })
                                .then(response => {
                                    if (!response.ok) {
                                        throw new Error(response.statusText);
                                    }
                                    return response.json();
                                })
                                .catch(error => {
                                    Swal.showValidationMessage('Request failed: ' + error);
                                });
                    },
                    allowOutsideClick: () => !Swal.isLoading()

                }).then((result) => {
                    if (result.value) {
                        if (result.value.status !== 200) {
                            Swal.fire('Error!', result.value.msg, 'error');
                        } else {
                            Swal.fire('Successful!', 'Ticket has been Re-open!', 'success');
                            dtable.ajax.reload();
                            loadCardCount();
                        }
                    }
                });
            });


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
                                ticketId: $('#editcard').data('id'),
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

        </script>
    </body>
</html>
