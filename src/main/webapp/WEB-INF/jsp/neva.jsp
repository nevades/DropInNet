<html>
    <head>
        <title>title</title>
    </head>
    <body>
        <style>

            /*count card*/
            /*            * {
                            margin: 0;
                            padding: 0;
                            box-sizing: border-box;
                            font-family: "Poppins", sans-serif;
                        }*/

            .pcoded-content {
                display: flex;
                justify-content: center;
                align-items: center;
                flex-wrap: wrap;
                min-height: 100vh;
                /*background: #232427;*/
            }

            .count-container {
                display: flex;
                justify-content: center;
                align-items: center;
                flex-wrap: wrap;
                /*                max-width: 1200px;*/
                margin: 40px 0;
            }

            .count-container .count-card {
                position: relative;
                min-width: 200px;
                height: 140px;
                box-shadow: inset 5px 5px 5px rgba(0, 0, 0, 0.2),
                    inset -5px -5px 15px rgba(255, 255, 255, 0.1),
                    5px 5px 15px rgba(0, 0, 0, 0.3), -5px -5px 15px rgba(255, 255, 255, 0.1);
                border-radius: 15px;
                margin: 10px;
                transition: 0.5s;
            }

            .count-container .count-card :nth-child(1) .box1 .content a {
                background: #2196f3;
            }

            .count-container .count-card :nth-child(2) .box1 .content a {
                background: #e91e63;
            }

            .count-container .count-card :nth-child(3) .box1 .content a {
                background: #23c186;
            }

            .count-container .count-card .box1 {
                position: absolute;
                top: 5px;
                left: 5px;
                right: 5px;
                bottom: 5px;
                background: #2a2b2f;
                border-radius: 15px;
                display: flex;
                justify-content: center;
                align-items: center;
                overflow: hidden;
                transition: 0.5s;
            }

            .count-container .count-card .box1:hover {
                transform: translateY(-30px);
            }

            .count-container .count-card  .box1:before {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                width: 50%;
                height: 100%;
                background: rgba(255, 255, 255, 0.03);
            }

            .count-container .count-card  .box1 .content {
                padding: 20px;
                text-align: center;
            }

            body .container .card .box1 .content h2 {
                position: absolute;
                top: -10px;
                right: 30px;
                font-size: 8rem;
                color: rgba(255, 255, 255, 0.1);
            }

            .count-container .count-card .box1 .content h3 {
                font-size: 1rem;
                color: #fff;
                z-index: 1;
                transition: 0.5s;
                margin-bottom: 15px;
            }

            .count-container .count-card  .box1 .content  {
                font-size: 1rem;
                font-weight: 300;
                color: rgba(255, 255, 255, 0.9);
                z-index: 1;
                transition: 0.5s;
            }

            .count-container .count-card  .box1 .content p{
                position: relative;
                display: inline-block;
                padding: 8px 20px;
                background: black;
                border-radius: 5px;
                text-decoration: none;
                color: white;
                margin-top: 20px;
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
                transition: 0.5s;
            }
            .count-container .count-card .box1 .content p:hover {
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.6);
                background: #fff;
                color: #000;
            }

        </style>
        <div class="container count-container">
            <div class="card count-card">
                <div class="box1">
                    <div class="content">
                        <h2 id="queued_card_all">01</h2>
                        <h3>Queued Ticket</h3>


                    </div>
                </div>
                <div style="margin-top: 110px"><table style="height: 25px; width: 200px">
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
                        </tbody></table> </div>
            </div>
            <div class="card count-card" id="inprogress_card">
                <div class="box1">
                    <div class="content">
                        <h2 id="inprogress_card_all">01</h2>
                        <h3>Inprogress Ticket</h3>


                    </div>
                </div>
                <div style="margin-top: 110px"><table style="height: 25px; width: 200px">
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
                        </tbody></table> </div>
            </div>
            <div class="card count-card" id="development_card">
                <div class="box1">
                    <div class="content">
                        <h2 id="development_card_all">01</h2>
                        <h3>Development Ticket</h3>


                    </div>
                </div>
                <div style="margin-top: 110px"><table style="height: 25px; width: 200px">
                        <tbody><tr>
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
                        </tbody></table> </div>
            </div>


        </div>
    </body>
</html>


