<%-- 
    Document   : user_type
    Created on : Jun 19, 2023, 2:20:49 PM
    Author     : asus
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

                                            <div class="row" id="table_sec">
                                                <div class="col-lg-10 offset-lg-1 col-xl-12 offset-xl-0 col-12">
                                                    <div class="card">
                                                        <div class="card-header">
                                                            <h6>User Types</h6>
                                                            <div class="card-header-right">
                                                                <ul class="list-unstyled card-option">
                                                                    <li><i class="feather icon-maximize full-card"></i></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                        <div class="card-block p-b-0">
                                                            <div class="table-responsive">
                                                                <table class="table table-hover table-bordered m-b-0" id="userTypeTbl">
                                                                    <thead>
                                                                        <tr>
                                                                            <th>Id</th>
                                                                            <th>User Type</th>
                                                                            <th>Dashboard</th>
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
                                                                <button id="addUserTypeBtn" class="btn btn-sm waves-effect waves-light btn-danger"><i class="icon feather icon-plus"></i>Add User Type</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row" id="detail_sec" style="display: none">
                                                <div class="col-lg-10 offset-lg-1 col-12">
                                                    <div class="card">
                                                        <div class="card-header">
                                                            <h6>Add/Update User Type</h6>
                                                            <div class="card-header-right">
                                                                <ul class="list-unstyled card-option">
                                                                    <li><i class="feather icon-x cls-card"></i></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                        <div class="card-block p-b-0">
                                                            <div class="row">
                                                                <div class="col-12 col-lg-12 row">
                                                                    <div class="col-lg-6 col-12">
                                                                        <div class="form-group">
                                                                            <label for="name">User Type Name<span class="text-danger">*</span></label>
                                                                            <input id="name" type="text" name="name" class="form-control"  required autocomplete="off">
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="dashboard">Dashboard<span class="text-danger">*</span></label>
                                                                            <select id="dashboard" name="dashboard" class="" required autocomplete="off">
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-lg-6 col-12">
                                                                        <label for="name">Access Page<span class="text-danger">*</span></label>
                                                                        <div id="pages">
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

            <%@include file="../jspf/scripts.jspf" %>
            <script type="text/javascript" src="files/js/slimselect.js"></script>
            <script type="text/javascript" src="files/js/datatables.min.js"></script>
            <script type="text/javascript" src="files/js/sweetalert2.js"></script>
            <script type="text/javascript" src="files/js/func.js"></script>
            <script type="text/javascript" src="files/js/autoNumeric.js"></script>
            <script type="text/javascript" src="files/js/dataTables.responsive.min.js"></script>
            <script type="text/javascript" src="files/jstree/js/jstree.min.js"></script>

            <script>
                $.fn.dataTable.ext.errMode = 'none';

                var dtable = $('#userTypeTbl').DataTable({
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
                        "url": "admin/userType",
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
                        {"data": "name"},
                        {"data": "dashboard"},
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

                $('#addUserTypeBtn').click(function () {
                    $('#saveBtn').data('mode', 'save');
                    $('#saveBtn').html('<i class="icon feather icon-save"></i>Save');
                    clearForm();
                    $('#table_sec').hide();
                    $('#detail_sec').fadeIn();
                });
                $('.cls-card').click(function () {
                    $('#detail_sec').hide();
                    $('#table_sec').fadeIn();
                });


                fetch('admin/getpages', {
                    method: 'POST',
                })
                        .then(resp => resp.json())
                        .then(resp => {
                            let data = JSON.parse(resp.allPage);
                            data.sort((a, b) => a.odr - b.odr);

                            for (var i = 0; i < data.length; i++) {
                                if (data[i].parent) {
                                    data[i].parent = data[i].parent.toString();
                                } else {
                                    data[i].parent = '#';
                                }

                                if (data[i].children) {
                                    data[i].children.sort((a, b) => a.odr - b.odr);
                                }
                            }

                            console.log(data);

                            $("#pages").jstree('destroy');
                            $('#pages').jstree({
                                'core': {
                                    'themes': {
                                        'responsive': false
                                    },
                                    'data': data,
                                    'check_callback': true
                                },
                                'types': {
                                    'default': {
                                        'icon': 'feather icon-chevron-right'
                                    },
                                    'file': {
                                        'icon': 'feather icon-chevron-right'
                                    }
                                },
                                'plugins': ['types', 'checkbox'],
                                'checkbox': {
                                    'keep_selected_style': false
                                },
                                'check_callback': true,
                                'dnd': {
                                    'is_draggable': function (node) {
                                        return false;
                                    }
                                },
                                'core': {
                                    'data': data.map(item => ({
                                            id: item.id,
                                            parent: item.parent,
                                            text: item.name,
                                            name: item.name
                                        })),
                                    'check_callback': true
                                },
                                'render': {
                                    'item': function (node, data) {
                                        var checkbox = '<i class="jstree-checkbox"></i>';
                                        var text = '<span class="jstree-text">' + data.node.text + '</span>';
                                        var name = '<span class="jstree-name">' + data.node.original.name + '</span>';

                                        return '<li>' + checkbox + text + ' ' + name + '</li>';
                                    }
                                }
                            }).on('loaded.jstree', function () {
                                $(this).jstree('open_all');
                            });
                        });

                var dashboard = new SlimSelect({
                    select: '#dashboard',
                    placeholder: "Select a Dashboard",
                    searchHighlight: true,

                    ajax: function (search, callback) {
                        fetch('admin/search-dashboard', {
                            method: 'POST',
                            body: new URLSearchParams({search: search || ''})
                        }).then(res => res.json()).then((data) => {
                            callback(data);
                        });
                    },
                    allowDeselect: true,
                    deselectLabel: '<span class="red">✖</span>'
                });
                $('#dashboard').data('select', dashboard);


                $('#saveBtn').click(function () {

                    if ($('#name').val().trim() === '') {
                        Swal.fire("Empty Name!", "Please Enter a Valid User Type Name !", "warning");
                        return;
                    }
                    if ($('#dashboard').val() === null) {
                        Swal.fire("Dashboard not Selected!", "Please Select a Dashboard !", "warning");
                        return;
                    }
                    if ($('#pages').val() === null) {
                        Swal.fire("Pages not Selected!", "Please Select a Access Page !", "warning");
                        return;
                    }

                    let page = $("#pages").jstree("get_json");
                    let selectPages = [];

                    for (var i = 0; i < page.length; i++) {
                        let level1 = page[i];
                        if (level1.state.selected) {
                            selectPages.push(level1.id);
                        }
                        for (var j = 0; j < level1.children.length; j++) {
                            let level2 = level1.children[j];
                            if (level2.state.selected) {
                                selectPages.push(level2.id);
                            }
                            for (var k = 0; k < level2.children.length; k++) {
                                let level3 = level2.children[k];
                                if (level3.state.selected) {
                                    selectPages.push(level3.id);
                                }
                            }
                        }

                    }

                    if ($('#saveBtn').data('mode') === 'save') {
                        loadDiv($('#detail_sec').find('.card'));
//                        formData.append('data', JSON.stringify(data));

                        Swal.fire({
                            title: 'Are you sure?',
                            text: "You are about to save a User Type!",
                            icon: 'warning',
                            showCancelButton: true,
                            confirmButtonColor: '#3085d6',
                            cancelButtonColor: '#d33',
                            confirmButtonText: 'Yes, Save!',
                            showLoaderOnConfirm: true,
                            allowOutsideClick: () => !Swal.isLoading(),
                            preConfirm: () => {
                                return fetch('admin/user-type-save', {
                                    method: 'POST',
                                    body: new URLSearchParams({
                                        name: document.getElementById('name').value,
                                        dashboard: document.getElementById('dashboard').value,
                                        pages: JSON.stringify(selectPages)
                                    })
                                }).then(response => {
                                    if (!response.ok) {
                                        throw new Error(response.statusText);
                                        finishLoadDiv($('#detail_sec').find('.card'));

                                    }
                                    return response.json();
                                }).catch(error => {
                                    Swal.showValidationMessage('Request failed:' + error);
                                    finishLoadDiv($('#detail_sec').find('.card'));

                                });
                            },
                            allowOutsideClick: () => !Swal.isLoading()
//                                        finishLoadDiv($('#detail_sec').find('.card'));
                        }).then((result) => {
                            if (result.value) {
                                if (result.value.status !== 200) {
                                    Swal.fire('Error!', result.value.msg, 'error');
                                    finishLoadDiv($('#detail_sec').find('.card'));

                                } else {
                                    Swal.fire('Successfull!', 'User Type has been Saved !', 'success');
                                    dtable.ajax.reload();
                                    clearForm();

                                    $('#table_sec').fadeIn();
                                    $('#detail_sec').hide();
                                    finishLoadDiv($('#detail_sec').find('.card'));

                                }
                            }
                            finishLoadDiv($('#detail_sec').find('.card'));
                        });

                    } else if ($('#saveBtn').data('mode') === 'update') {
                        loadDiv($('#detail_sec').find('.card'));
                        $('#saveBtn').data('id');
//                        formData.append('data', JSON.stringify(data));

                        Swal.fire({
                            title: 'Are you sure?',
                            text: "You won't be able to revert this!",
                            icon: 'warning',
                            showCancelButton: true,
                            confirmButtonColor: '#3085d6',
                            cancelButtonColor: '#d33',
                            confirmButtonText: 'Yes, Update!',
                            showLoaderOnConfirm: true,
                            allowOutsideClick: () => !Swal.isLoading(),
                            preConfirm: () => {
                                return fetch('admin/user-type-update', {
                                    method: 'POST',
                                    body: new URLSearchParams({
                                        id: $('#saveBtn').data('id'),
                                        name: document.getElementById('name').value,
                                        dashboard: document.getElementById('dashboard').value,
                                        pages: JSON.stringify(selectPages)
                                    })
                                }).then(response => {
                                    if (!response.ok) {
                                        throw new Error(response.statusText);
                                    }
                                    return response.json();
                                }).catch(error => {
                                    Swal.showValidationMessage('Request failed:' + error);
                                    finishLoadDiv($('#detail_sec').find('.card'));

                                });
                            },
                            allowOutsideClick: () => !Swal.isLoading()
                        }).then((result) => {
                            if (result.value) {
                                if (result.value.status !== 200) {
                                    Swal.fire('Error!', result.value.msg, 'error');
                                    finishLoadDiv($('#detail_sec').find('.card'));

                                } else {
                                    Swal.fire('Successfull!', 'User Type has been updated !', 'success');
                                    dtable.ajax.reload();
                                    clearForm();
                                    $('#table_sec').fadeIn();
                                    $('#detail_sec').hide();
                                    finishLoadDiv($('#detail_sec').find('.card'));

                                }
                            }
                        });
                    }

                });

                $(document).on('click', '.editrec', function () {

                    let id = $(this).parents('tr').eq(0).data('id');
                    $('#saveBtn').data('id', id);

                    $.post('admin/get-userType', {id: id}, function (result) {


                        dashboard.setData([{value: result.dashboard, text: result.dashboard_name}]);
                        dashboard.set(result.dashboard);
                        $('#name').val(result.name);


                        let data = JSON.parse(result.allPage);
                        data.sort((a, b) => a.odr - b.odr);

                        for (var i = 0; i < data.length; i++) {
                            if (data[i].parent) {
                                data[i].parent = data[i].parent.toString();
                            } else {
                                data[i].parent = '#';
                            }

                            if (data[i].children) {
                                data[i].children.sort((a, b) => a.odr - b.odr);
                            }
                        }

                        $("#pages").jstree('destroy');
                        $('#pages').jstree({
                            'core': {
                                'themes': {
                                    'responsive': false
                                },
                                'data': data,
                                'check_callback': true
                            },
                            'types': {
                                'default': {
                                    'icon': 'feather icon-chevron-right'
                                },
                                'file': {
                                    'icon': 'feather icon-chevron-right'
                                }
                            },
                            'plugins': ['types', 'checkbox'],
                            'checkbox': {
                                // 'keep_selected_style': true
                            },
                            'check_callback': true,
                            'dnd': {
                                'is_draggable': function (node) {
                                    return false;
                                }
                            },
                            'core': {
                                'data': data.map(item => ({
                                        id: item.id,
                                        parent: item.parent,
                                        text: item.name,
                                        name: item.name,
                                        state: item.state
                                    })),
                                'check_callback': true
                            },
                            'render': {
                                'item': function (node, data) {
                                    var checkbox = '<i class="jstree-checkbox"></i>';
                                    var text = '<span class="jstree-text">' + data.node.text + '</span>';
                                    var name = '<span class="jstree-name">' + data.node.original.name + '</span>';

                                    return '<li>' + checkbox + text + ' ' + name + '</li>';
                                }
                            }
                        }).on('loaded.jstree', function () {
                            $(this).jstree('open_all');
                        });
//                        }

                    });


                    $('#table_sec').hide();
                    $('#detail_sec').fadeIn();
                    $('#saveBtn').data('mode', 'update');
                    $('#saveBtn').html('Update User Type');
                });

                $(document).on('click', '.delrec', function () {
                    let id = $(this).parents('tr').data('id');
                    console.log(id);
                    Swal.fire({
                        title: 'Are you sure?',
                        text: "This User Type Will be Deleted!",
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Yes, Proceed!',
                        showLoaderOnConfirm: true,
                        preConfirm: () => {
                            return fetch('admin/deactivate-user-Type', {
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
                                Swal.fire('Successfull!', 'User Type has been Deactivated !', 'success');
                                dtable.ajax.reload();
                                $('#detail_sec').hide();
                                $('#table_sec').fadeIn();
                            }
                        }
                    });
                });

                $(document).on('click', '.rerec', function () {
                    let id = $(this).parents('tr').data('id');
                    Swal.fire({
                        title: 'Are you sure?',
                        text: "This User Type Will be Activated!",
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Yes, Proceed!',
                        showLoaderOnConfirm: true,
                        preConfirm: () => {
                            return fetch('admin/reactivate-user-Type', {
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
                                Swal.fire('Successfull!', 'User Type has been Activated !', 'success');
                                dtable.ajax.reload();
                                $('#detail_sec').hide();
                                $('#table_sec').fadeIn();
                            }
                        }
                    });
                });

                function clearForm() {
                    $('#dashboard').data('select').set('');
                    $('#name').val('');
                    var tree = $('#pages').jstree(true);
                    var selectedNodes = tree.get_selected();
                    selectedNodes.forEach(function (nodeId) {
                        tree.uncheck_node(nodeId);
                    });
                }
            </script>
    </body>
</html>
