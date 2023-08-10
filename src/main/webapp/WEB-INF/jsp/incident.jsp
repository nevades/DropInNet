<%-- 
    Document   : incident
    Created on : Mar 21, 2023, 9:26:57 AM
    Author     : Nevanjith
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="jspf/header.jspf" %>
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
                        <%@include file="jspf/sidenav.jspf" %>
                        <div class="pcoded-content">
                            <div class="pcoded-inner-content">
                                <div class="main-body">
                                    <div class="row" id="tableSection" style="margin-top: 60px;">
                                        <div class="col-lg-12 offset-lg-0 col-xl-12 offset-xl-0 col-12">
                                            <div class="card">
                                                <div class="card-header">
                                                    <h6>Incident Report</h6>
                                                    <div class="card-header-right">
                                                        <ul class="list-unstyled card-option">
                                                            <li><i class="feather icon-maximize full-card"></i></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                                <div class="card-block p-b-0">
                                                    <div class="table">
                                                        <div class="page-wrapper">
                                                            <div class="page-body">
                                                                <table class="table table-hover table-bordered m-b-0" id="incident_table">
                                                                    <thead>
                                                                        <tr>                    
                                                                            <th>ID</th>
                                                                            <th>Code</th>
                                                                            <th>Status</th>
                                                                            <th>Time Of Incident</th>
                                                                            <th style="width: 800px;">Description</th>
                                                                            <th>Action</th>
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



        <%@include file="jspf/scripts.jspf" %>
        <script type="text/javascript" src="files/js/slimselect.js"></script>
        <script type="text/javascript" src="files/js/datatables.min.js"></script>
        <script type="text/javascript" src="files/js/sweetalert2.js"></script>
        <script type="text/javascript" src="files/js/func.js"></script>
        <script type="text/javascript" src="files/js/autoNumeric.js"></script>
        <script type="text/javascript" src="files/js/dataTables.responsive.min.js"></script>

        <script>
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
//                buttonsStyling: true,
                    customClass: {
                        confirmButton: "btn btn-default text-center"
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
                            IncidentTable.ajax.reload();
                        }
                    }
                });
            });

            var IncidentTable = $('#incident_table').DataTable(
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
                            "url": "ticket/incident",
                            "contentType": "application/json",
                            "type": "POST",
                            "data": function (d) {
                                d.data = status;
                                return JSON.stringify(d);
                            },
                            error: function () {
                            }
                        },
                        "columns": [
                            {"data": "id", className: "text-center", visible: false},
                            {"data": "code", className: "text-center"},
                            {"data": "status", className: "text-center"},
                            {"data": "timeOfIncident", className: "text-center"},
                            {"data": "description", className: "text-center"}
                        ], "language": {
                            'loadingRecords': '&nbsp;',
                            'processing': '<div class="loader2"></div>'
                        }, "createdRow": function (row, data) {
                            let action_td = document.createElement('td');
                            $(action_td).addClass('text-center');
                            if (data['status'] === 4) {
                                $(action_td).append('<a href="javascript:void(0)" idd="' + data.id + '" class="seerec" data-toggle="modal" data-target="#exampleModalCenter"><i class="icon feather icon-eye f-w-600 f-16 m-r-10 text-c-green"></i></a>');
                            } else {
                                $(action_td).append('<a href="javascript:void(0)" idd="' + data.id + '" class="editrec" data-toggle="modal" data-target="#exampleModalCenter"><i class="icon feather icon-edit f-w-600 f-16 m-r-10 text-c-green"></i></a><a href="javascript:void(0)" class="delrec"><i class="feather icon-trash-2 f-w-600 f-16 text-danger"></i></a>');
                            }
                            $(row).append(action_td);
                            setTableStatus($(row).find('td').eq(1));
                            $(row).addClass('text-center');
                        }
                    });
        </script>
    </body>
</html>
