<%-- 
    Document   : audit_report
    Created on : Mar 21, 2023, 2:11:58 PM
    Author     : Akash
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Fintrex - DropinNet </title>
        <%@include file="../jspf/header.jspf" %>
    </head>
    <body>
        <%@include file="../jspf/loader.jspf" %>
        <div id="pcoded" class="pcoded">
            <div class="pcoded-overlay-box"></div>
            <div class="pcoded-container navbar-wrapper">
                <%@include file="../jspf/navbar.jspf" %>
                <div class="pcoded-main-container">
                    <div class="pcoded-wrapper">
                        <%@include file="../jspf/sidenav.jspf" %>
                        <div class="pcoded-content">
                            <div class="pcoded-inner-content">
                                <div class="main-body">
                                    <div class="page-wrapper">
                                        <div class="page-body">

                                            <div class="col-lg-10 offset-lg-1 col-xl-8 offset-xl-2 col-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <div class="row align-items-center justify-content-center">
                                                            <h4 class="m-t-20">SYSTEM ACCESS REPORT</h4>
                                                            <div class="card-header-right">
                                                                <ul class="list-unstyled card-option">
                                                                    <li><i class="feather icon-maximize full-card"></i></li>
                                                                </ul>
                                                            </div>
                                                        </div>

                                                        <div class="card-block p-b-0">
                                                            <div class="table-responsive">
                                                                <table class="table table-hover table-bordered m-b-0" id="tbll">
                                                                    <thead>
                                                                        <tr>
                                                                            <th>Id</th>
                                                                            <th>Ticket NO</th>
                                                                            <th>Subject</th>
                                                                            <th>Priority</th>
                                                                            <th>Reported By</th>
                                                                            <th>Assigned</th>
                                                                            <th>Status</th>

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

                                            <div id="report_modal" class="modal fade show" style="padding-right: 17px;  display: none;">
                                                <div class="modal-dialog modal-lgxl">
                                                    <div class="modal-content">
                                                        <div class="modal-header">                   
                                                            <div class="col-10 ">
                                                                <h5> Ticket Details </h5>
                                                            </div>                    
                                                            <div class="col-1 ">
                                                            </div> 
                                                            <div class="col-1">
                                                                <button type="button" class="close pull-right " data-dismiss="modal" aria-label="Close">
                                                                    <span aria-hidden="true">×</span>
                                                                </button> 
                                                            </div> 
                                                        </div>
                                                        <div class="modal-body" style="background-color: #ebebeb">
                                                            <div class="row">
                                                                <div class="col-8">
                                                                    <div class=" row form-group  ">
                                                                        <div class="col-12">
                                                                            <div class="card">
                                                                                <div class="card-body pt-1">
                                                                                    <div class="row">
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
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="../jspf/scripts.jspf" %>
        <script type="text/javascript" src="files/js/slimselect.js"></script>
        <script type="text/javascript" src="files/js/datatables.min.js"></script>
        <script type="text/javascript" src="files/js/sweetalert2.js"></script>
        <script type="text/javascript" src="files/js/func.js"></script>
        <script type="text/javascript" src="files/js/autoNumeric.js"></script>
        <script type="text/javascript" src="files/js/dataTables.responsive.min.js"></script>
        <script>
            $.fn.dataTable.ext.errMode = 'none';

            var dtable = $('#tbll').DataTable({
                "aLengthMenu": [[5, 10, 25, -1], [5, 10, 25, "All"]],
                "pageLength": 10,
                "ordering": true,
                "autoWidth": false,
                "processing": true,
                "serverSide": true,
                "order": [[0, "desc"]],
                "searchHighlight": true,
                "searchDelay": 350,
                "ajax": {
                    "url": "reports/audit",
                    "contentType": "application/json",
                    "type": "POST",
                    "data": function (d) {
                        return JSON.stringify(d);
                    },
                    error: function (xhr, error, code) {
                        console.log(xhr);
                        console.log(code);
                    }
                },
                "columns": [
                    {"data": "id", className: "text-right", id: "id", "visible": false},
                    {"data": "code"},
                    {"data": "subject"},
                    {"data": "priority", className: "text-center"},
                    {"data": "entBy"},
                    {"data": "assignedTo"},
                    {"data": "status", className: "text-center"}
                ], "language": {
                    'loadingRecords': '&nbsp;',
                    'processing': '<div class="loader2"></div>'
                }, "createdRow": function (row, data) {
                    setTableStatus($(row).find('td').eq(5));
//
//
//                    setTableStatus($(row).find('td').eq(5));
//                    //                        $(row).data('id', data['id']);
//                    let tr = document.createElement('td');
//                    $(row).click(function () {
//                        var $row = $(this).closest("tr");
//                        var $text = $row.find("#id").text();
//                        alert($text);
////                        $('#report_modal').modal('show');
//                    });
                }
            });
//
//            function setTableStatus(td) {
//                if ($(td).html().trim().startsWith('Closed')) {
//                    $(td).html('<label class="badge alert-success" style="background-color: #d4edda;">Closed</label>');
//                } else if ($(td).html() === 'Pending') {
//                    $(td).html('<label class="badge alert-danger" style="background-color: #f8d7da;">Pending</label>');
//                }
//            }
//
//            function loadContracts(row, col) {
//                alert(row + " - " + col);
//            }

            function setTableStatus(td)
            {
                if ($(td).html().startsWith('Closed')) {
                    $(td).html('<label class="label label-danger" style="white-space: nowrap">Closed</label>');
                } else if ($(td).html().startsWith('Finished')) {
                    $(td).html('<label class="badge " style="white-space: nowrap; background:#5ba9fd">Finished</label>');
                } else if ($(td).html().startsWith('Assigned')) {
                    $(td).html('<label class="badge " style="white-space: nowrap; background:#219B9D">Assigned</label>');
                } else if ($(td).html().startsWith('In Progress')) {
                    $(td).html('<label class="badge " style="white-space: nowrap; background:#FF7400">In Progress</label>');
                } else if ($(td).html().startsWith('Queued')) {
                    $(td).html('<label class="badge " style="white-space: nowrap; background:#B112AA">Queued</label>');
                } else if ($(td).html().startsWith('Approval Assign')) {
                    $(td).html('<label class="badge " style="white-space: nowrap; background:#6A16C8">Approval Pending</label>');
                } else {
                    $(td).html('<label class="label label-success" style="white-space: nowrap">Active</label>');
                }
            }
        </script>
    </body>
</html>
