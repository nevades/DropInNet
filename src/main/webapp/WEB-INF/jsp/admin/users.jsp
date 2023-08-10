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
        <%@include file="../jspf/header.jspf" %>
        <link rel="stylesheet" type="text/css" href="files/css/dataTables.searchHighlight.css">
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

                                            <div class="row" id="tableSection">
                                                <div class="col-lg-10 offset-lg-1 col-xl-8 offset-xl-2 col-12">
                                                    <div class="card">
                                                        <div class="card-header">
                                                            <h6>Users</h6>
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
                                                                            <th>Username</th>
                                                                            <th>User</th>
                                                                            <th>User Type</th>
                                                                            <th>ModBy</th>
                                                                            <th>ModOn</th>
                                                                            <th style="width:1px;">Status</th>
                                                                            <th style="width:1px;">Action</th>
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

                                            <div class="row" id="formSection" style="display: none">
                                                <div class="col-lg-8 offset-lg-2 col-12">
                                                    <div class="card">
                                                        <div class="card-header">
                                                            <h6>Add/Update Users</h6>
                                                            <div class="card-header-right">
                                                                <ul class="list-unstyled card-option">
                                                                    <li><i class="feather icon-x cls-card"></i></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                        <div class="card-block p-b-0">
                                                            <div class="row">
                                                                <div class="col-12 col-lg-12">
                                                                    <div class="row">
                                                                        <div class="col-lg-6 col-12">
                                                                            <div class="form-group">
                                                                                <label for="name">Name<span class="text-danger">*</span></label>
                                                                                <input id="name" type="text" name="name" class="form-control"  required autocomplete="off">
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-lg-6 col-12">
                                                                            <div class="form-group">
                                                                                <label for="username">Username<span class="text-danger">*</span></label>
                                                                                <input id="username"  type="text" name="username" class="form-control" required autocomplete="off">
                                                                            </div>
                                                                        </div>

                                                                        <div class="col-lg-6 col-12">
                                                                            <div class="form-group">
                                                                                <label for="user_type">User Type<span class="text-danger">*</span></label>
                                                                                <select id="user_type" name="user_type" class="" required autocomplete="off">
                                                                                </select>
                                                                            </div>
                                                                        </div>  
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="card-footer">
                                                            <div class="text-right">
                                                                <button id="saveBtn" class="btn btn-sm waves-effect waves-light btn-primary"><i class="icon feather icon-save"></i>Save</button>
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
        <script type="text/javascript" src="files/js/jquery.highlight.js"></script>
        <script type="text/javascript" src="files/js/datatables.min.js"></script>
        <script type="text/javascript" src="files/js/sweetalert2.js"></script>
        <script type="text/javascript" src="files/js/func.js"></script>
        <script type="text/javascript" src="files/js/autoNumeric.js"></script>
        <script type="text/javascript" src="files/js/dataTables.responsive.min.js"></script>
        <script type="text/javascript" src="files/js/dataTables.searchHighlight.min.js"></script>
        <script>

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
                    "url": "admin/users",
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
                    {"data": "username", "visible": false},
                    {"data": "name"},
                    {"data": "userType"},
                    {"data": "modBy"},
                    {"data": "modOn"},
                    {"data": "status"}
                ], "language": {
                    'loadingRecords': '&nbsp;',
                    'processing': '<div class="loader2"></div>'
                }, "createdRow": function (row, data) {
                    let action_td = document.createElement('td');
                    $(action_td).addClass('text-center');
                    if (data['status'] === 'deactivated') {
                        $(action_td).append('<a href="javascript:void(0)" class="rerec"><i class="feather icon-refresh-cw f-w-600 f-16 text-c-blue"></i></a>');
                    } else {
                        $(action_td).append('<a href="javascript:void(0)" class="editrec"><i class="icon feather icon-edit f-w-600 f-16 m-r-10 text-c-green"></i></a><a href="javascript:void(0)" class="delrec"><i class="feather icon-trash-2 f-w-600 f-16 text-danger"></i></a>');
                    }
                    $(row).append(action_td);
                    var temp = '<div style="white-space:nowrap;"><img src=user_img?name=' + data['username'] + ' onerror="this.onerror=null; this.src=\'files/images/user.png\'"  class="img-radius img-40 align-top m-r-15" height="40" style="object-fit: cover;">' +
                            '<div class="d-inline-block">' +
                            ' <h6 style="word-break: break-all;word-wrap: break-word;" class="m-b-0">' + data['name'] + '</h6><p class="text-muted m-b-0">' + data['username'] + '</p></div></div>';
                    $(row).find('td').eq(0).html(temp);
                    setTableStatus($(row).find('td').eq(4));
                    $(row).data('id', data['id']);
                }
            });

            function setTableStatus(td) {
                if ($(td).html().trim().startsWith('active')) {
                    $(td).html('<label class="label label-success" style="white-space: nowrap">Active</label>');
                } else if ($(td).html() === 'deactivated') {
                    $(td).html('<label class="label label-danger" style="white-space: nowrap">Deactivated</label>');
                }
            }

            $('#addUserBtn').click(function () {
                $('#saveBtn').data('mode', 'save');
                $('#saveBtn').html('<i class="icon feather icon-save"></i>Save');
                clearForm();
                $('#tableSection').hide();
                $('#formSection').fadeIn();
            });
            $('.cls-card').click(function () {
                $('#formSection').hide();
                $('#tableSection').fadeIn();
            });
            function clearForm() {
                $('#formSection').find('input[type!=search]').val('');
                $('#formSection').find('select').each(function () {
                    if ($(this).data('select')) {
                        if ($(this).data('select').ajax) {
                            $(this).data('select').data.data = [];
                        }
                        $(this).data('select').set('');
                    }
                });
            }

            $('#uimguploadbtn').find('a').click(function () {
                $('#user_image').click();
            });
            var user_type = new SlimSelect({
                select: '#user_type',
                placeholder: "Select a Usertype",
                searchHighlight: true,

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

            $(document).on('click', '.editrec', function () {
                loadDiv($('#tableSection'));
                let id = $(this).parents('tr').data('id');
                fetch('admin/user/' + id).then(resp => resp.json())
                        .then((data) => {
                            clearForm();
                            $('#name').val(data.name);
                            $('#username').val(data.username);
                            if (data.userType) {
                                user_type.setData([{value: data.userType.id, text: data.userTypeName}]);
                                user_type.set(data.userType.id);
                            }
                            $('#saveBtn').data('mode', 'update');
                            $('#saveBtn').html('<i class="icon feather icon-save"></i>Update');
                            $('#saveBtn').data('id', id);
                            $('#formSection').fadeIn();
                            $('#tableSection').hide();

                            finishLoadDiv($('#tableSection'));
                        });
            });

            $('#saveBtn').click(function () {
                if ($('#name').val().trim() === '') {
                    Swal.fire("Empty Name!", "Please Enter a Valid Name!", "warning");
                    return;
                }
                if ($('#username').val().trim() === '') {
                    Swal.fire("Empty Username!", "Please Enter a Valid Username!", "warning");
                    return;
                }
                if ($('#user_type').val() === null) {
                    Swal.fire("UserType not Selected!", "Please Select a UserType!", "warning");
                    return;
                }

                let mode = $('#saveBtn').data('mode');

                const formData = new FormData();
                if (mode === 'update') {
                    formData.append('id', $('#saveBtn').data('id'));
                }
                formData.append('name', $('#name').val().trim());
                formData.append('username', $('#username').val().trim());
                formData.append('type', $('#user_type').val());

                Swal.fire({
                    title: 'Are you sure?',
                    text: "User Will be " + (mode === 'update' ? 'Updated' : 'Saved') + " !",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, Continue!',
                    showLoaderOnConfirm: true,
                    searchHighlight: true,
                    preConfirm: () => {
                        return fetch('admin/' + $('#saveBtn').data('mode') + '-user', {
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
                    },
                    allowOutsideClick: () => !Swal.isLoading()

                }).then((result) => {
                    if (result.value) {
                        if (result.value.status !== 200) {
                            Swal.fire('Error!', result.value.msg, 'error');
                        } else {
                            Swal.fire('Successfull!', 'User has been updated.', 'success');
                            dtable.ajax.reload();
                            $('#formSection').hide();
                            $('#tableSection').fadeIn();
                        }
                    }
                });
            });

            $(document).on('click', '.delrec', function () {
                let id = $(this).parents('tr').data('id');
                console.log(id);
                Swal.fire({
                    title: 'Are you sure?',
                    text: "This User Will be Deleted!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, Proceed!',
                    showLoaderOnConfirm: true,
                    preConfirm: () => {
                        return fetch('admin/deactivate-user', {
                            method: 'POST',
                            body: new URLSearchParams({
                                id: id
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
                            Swal.fire('Successfull!', 'User has been Deactivated !', 'success');
                            dtable.ajax.reload();
                            $('#formSection').hide();
                            $('#tableSection').fadeIn();
                        }
                    }
                });
            });

            $(document).on('click', '.rerec', function () {
                let id = $(this).parents('tr').data('id');
                Swal.fire({
                    title: 'Are you sure?',
                    text: "This User Will be Activated!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, Proceed!',
                    showLoaderOnConfirm: true,
                    preConfirm: () => {
                        return fetch('admin/reactivate-user', {
                            method: 'POST',
                            body: new URLSearchParams({
                                id: id
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
                            Swal.fire('Successfull!', 'User has been Activated !', 'success');
                            dtable.ajax.reload();
                            $('#formSection').hide();
                            $('#tableSection').fadeIn();
                        }
                    }
                });
            });

            $.fn.dataTable.Debounce = function (table) {
                var tableId = table.settings()[0].sTableId;
                $('.dataTables_filter input[aria-controls="' + tableId + '"]')
                        .unbind()
                        .bind('input', (delay(function (e) {
                            table.search($(this).val()).draw();
                            return;
                        }, 500)));
            };

            function delay(callback, ms) {
                var timer = 0;
                return function () {
                    var context = this, args = arguments;
                    clearTimeout(timer);
                    timer = setTimeout(function () {
                        callback.apply(context, args);
                    }, ms || 0);
                };
            }

            var debounce = new $.fn.dataTable.Debounce(dtable);

        </script>
    </body>
</html>
