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
        <style>
            .card .card-header span {
                color: #919aa3;
                display: block;
                font-size: 13px;
                margin-top: 0px;
            }
        </style>
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
                                                            <h4 class="m-t-20">Department MIS REPORT -</h4>
                                                            <div class="m-t-20 col-lg-3 col-6">
                                                                <div class="form-group">
                                                                    <select id="user_type" name="user_type" class="" required autocomplete="off">
                                                                    </select>
                                                                </div>
                                                            </div>  
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
                                                                            <!--<th>Ticket NO</th>-->
                                                                            <th>Subject</th>
                                                                            <th>Priority</th>
                                                                            <th>Reported By</th>
                                                                            <!--<th>Assigned</th>-->
                                                                            <th>Status</th>

                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>

                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                        <div class="card-footer">
                                                            <div class="text-right">
                                                                <button id="addUserBtn" class="btn btn-sm waves-effect waves-light btn-danger"><i class="icon feather icon-plus"></i>Add User</button>
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
            var user_type = new SlimSelect({
                select: '#user_type',
                placeholder: "Select a Usertype",
                ajax: function (search, callback) {
                    fetch('admin/search-user-types', {
                        method: 'POST',
                        body: new URLSearchParams({search: search || ''})
                    }).then(res => res.json()).then((data) => {
                        callback(data);
                    });
                },
                allowDeselect: true,
                deselectLabel: '<span class="red">✖</span>'
            });
            $('#user_type').data('select', user_type);

            $.fn.dataTable.ext.errMode = 'none';

            var dtable = $('#tbll').DataTable({
                "aLengthMenu": [[5, 10, 25, -1], [5, 10, 25, "All"]],
                "pageLength": 5,
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
                    {"data": "id", className: "text-right", "visible": false},
                    {"data": "subject"},
                    {"data": "priority"},
                    {"data": "entBy"},
                    {"data": "status"}
                ], "language": {
                    'loadingRecords': '&nbsp;',
                    'processing': '<div class="loader2"></div>'
                }, "createdRow": function (row, data) {
                    //                        let action_td = document.createElement('td');
                    //                        $(action_td).addClass('text-center');
                    //                        if (data['status'] === 'deactivated') {
                    //                            $(action_td).append('<a href="javascript:void(0)" class="rerec"><i class="feather icon-refresh-cw f-w-600 f-16 text-c-blue"></i></a>');
                    //                        } else {
                    //                            $(action_td).append('<a href="javascript:void(0)" class="editrec"><i class="icon feather icon-edit f-w-600 f-16 m-r-10 text-c-green"></i></a><a href="javascript:void(0)" class="delrec"><i class="feather icon-trash-2 f-w-600 f-16 text-danger"></i></a>');
                    //                        }
                    //                        $(row).append(action_td);

                    //                        setTableStatus($(row).find('td').eq(4));
                    //                        $(row).data('id', data['id']);
                }
            });

            function setTableStatus(td) {
                if ($(td).html().trim().startsWith('active')) {
                    $(td).html('<label class="label label-success" style="white-space: nowrap">Active</label>');
                } else if ($(td).html() === 'deactivated') {
                    $(td).html('<label class="label label-danger" style="white-space: nowrap">Deactivated</label>');
                }
            }
        </script>
    </body>
</html>
