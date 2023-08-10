<%-- 
    Document   : ticket_categories
    Created on : Mar 17, 2023, 11:06:15 AM
    Author     : Akash
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
                                            <div class="col-lg-10 offset-lg-1 col-xl-8 offset-xl-2 col-12">
                                                <div class="card" id="tableSection">
                                                    <div class="card-header">
                                                        <h6>Ticket Category</h6>
                                                        <div class="card-header-right">
                                                            <ul class="list-unstyled card-option">
                                                                <li><i class="feather icon-maximize full-card"></i></li>
                                                            </ul>
                                                        </div>
                                                    </div>

                                                    <!--<div class="card-body">-->
                                                    <div class="card-block p-b-0">
                                                        <div class="table-responsive">
                                                            <table class="table table-hover table-bordered m-b-0" id="tbll">
                                                                <thead>
                                                                    <tr>
                                                                        <th>ID</th>
                                                                        <th>Name</th>
                                                                        <th>Category</th>
                                                                        <th>Status</th>
                                                                        <th style="width:1px;" class="text-center">Action</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                    <!--</div>-->  
                                                    <div class="card-footer">
                                                        <div class="text-right">
                                                            <button id="addCategoryBtn" class="btn btn-sm waves-effect waves-light btn-danger"><i class="icon feather icon-plus"></i>Add Category</button>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>

                                            <div class="row" id="formSection" style="display: none">
                                                <div class="col-lg-8 offset-lg-2 col-12">
                                                    <div class="card">
                                                        <div class="card-header">
                                                            <h6>Add/Update Category</h6>
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
                                                                                <label for="categoryname">Category Type<span class="text-danger">*</span></label>
                                                                                <select id="categoryname" name="categoryname" class="" required autocomplete="off">
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
        <script type="text/javascript" src="files/js/datatables.min.js"></script>
        <script type="text/javascript" src="files/js/sweetalert2.js"></script>
        <script type="text/javascript" src="files/js/func.js"></script>
        <script type="text/javascript" src="files/js/autoNumeric.js"></script>
        <script type="text/javascript" src="files/js/dataTables.responsive.min.js"></script>
        <script>
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
                            "url": "ticket/category",
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
                            {"data": "id", className: "text-right", visible: false},
                            {"data": "name"},
                            {"data": "type"},
                            {"data": "status"},
                        ], "language": {
                            'loadingRecords': '&nbsp;',
                            'processing': '<div class="loader2"></div>'
                        }, "createdRow": function (row, data) {
                            let action_td = document.createElement('td');
//                            let td = document.createElement('td');
//                            $(td).data('id', data['id']);
                            $(row).data('id', data['id']);

                            if (data['status'] === 'deactive') {
                                $(action_td).append('<a href="javascript:void(0)" class="rerec"><i class="feather icon-refresh-cw f-w-600 f-16 text-c-blue"></i></a>');
                            } else {
                                $(action_td).append('<a href="javascript:void(0)" class="editrec"><i class="icon feather icon-edit f-w-600 f-16 m-r-10 text-c-green"></i></a><a href="javascript:void(0)" class="delrec"><i class="feather icon-trash-2 f-w-600 f-16 text-danger"></i></a>');
                            }
                            $(row).append(action_td);
                            $(row).find('td').eq(3).addClass('text-center')

                            var tr1 = $(row).find('td').eq(2).html();
                            console.log(tr1);

                            setTableStatus($(row).find('td').eq(2).addClass('text-center'));

                        }
                    });

            function setTableStatus(td) {
                if ($(td).html().trim().startsWith('active')) {
                    $(td).html('<label class="label label-success text-center" style="white-space: nowrap">Active</label>');
                } else if ($(td).html() === 'deactive') {
                    $(td).html('<label class="label label-danger text-center" style="white-space: nowrap">Deactivated</label>');
                }
            }
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

            $('#addCategoryBtn').click(function () {
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

            var categoryname = new SlimSelect({
                select: '#categoryname',
                placeholder: "Select a Category Type",
                searchHighlight: true,
                ajax: function (search, callback) {
                    fetch('admin/search-category-type', {
                        method: 'POST',
                        body: new URLSearchParams({search: search || ''})
                    }).then(res => res.json()).then((data) => {
                        callback(data);
                    });
                },
                allowDeselect: true,
                deselectLabel: '<span class="red">✖</span>'
            });
            $('#categoryname').data('select', categoryname);

            $('#saveBtn').click(function () {
                if ($('#name').val().trim() === '') {
                    Swal.fire("Empty Name!", "Please Enter a Valid Name!", "warning");
                    return;
                }

                if ($('#categoryname').val() === null) {
                    Swal.fire("Category Type not Selected!", "Please Select a Category Type!", "warning");
                    return;
                }

                let mode = $('#saveBtn').data('mode');

                const formData = new FormData();
                if (mode === 'update') {
                    formData.append('id', $('#saveBtn').data('id'));
                }
                formData.append('name', $('#name').val());
                formData.append('categoryname', $('#categoryname').val());

                Swal.fire({
                    title: 'Are you sure?',
                    text: "Ticket type Will be " + (mode === 'update' ? 'Updated' : 'Saved') + " !",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, Continue!',
                    showLoaderOnConfirm: true,
                    searchHighlight: true,
                    preConfirm: () => {
                        return fetch('admin/' + $('#saveBtn').data('mode') + '-ticket-type', {
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

            $(document).on('click', '.editrec', function () {
                loadDiv($('#tableSection'));
                let id = $(this).parents('tr').data('id');
                fetch('admin/ticket/' + id).then(resp => resp.json())
                        .then((data) => {
                            clearForm();
                            $('#name').val(data.name);
                            if (data.ctype) {
                                categoryname.setData([{value: data.ctype.id, text: data.categoryTypeName}]);
                                categoryname.set(data.ctype.id);
                            }
                            $('#saveBtn').data('mode', 'update');
                            $('#saveBtn').html('<i class="icon feather icon-save"></i>Update');
                            $('#saveBtn').data('id', id);
                            $('#formSection').fadeIn();
                            $('#tableSection').hide();

                            finishLoadDiv($('#tableSection'));
                        });
            });

            $(document).on('click', '.delrec', function () {
                let id = $(this).parents('tr').data('id');
                Swal.fire({
                    title: 'Are you sure?',
                    text: "This Category Will be Deleted!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, Proceed!',
                    showLoaderOnConfirm: true,
                    preConfirm: () => {
                        return fetch('admin/deactivate-ticket-category', {
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
                            Swal.fire('Successfull!', 'Ticket Category has been Deactivated !', 'success');
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
                    text: "This Category Will be Activated!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, Proceed!',
                    showLoaderOnConfirm: true,
                    preConfirm: () => {
                        return fetch('admin/reactivate-ticket-category', {
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
                            Swal.fire('Successfull!', 'Ticket Category has been Activated !', 'success');
                            dtable.ajax.reload();
                            $('#formSection').hide();
                            $('#tableSection').fadeIn();
                        }
                    }
                });
            });
        </script>
    </body>
</html>
