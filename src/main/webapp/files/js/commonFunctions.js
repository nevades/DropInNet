function CreatePage(parent, name, tableData, formData) {

    this.mainTable = null;
    let additionalData = {};
    this.setAdditionData = function (val) {
        additionalData = val;
    }
    this.loadDtable = function () {
        if (tableData.classes) {
            $(parent).find('#maintable').addClass(tableData.classes);
        }
        if (tableData.style) {
            $(parent).find('#maintable').attr('style', tableData.style);
        }
        $(parent).find('#cardHeader').html('Search ' + name);
        let cols = [];
        cols.push({name: 'ID', data: 'id', visible: false});
        $(parent).find('#maintable thead').find('tr').first().append('<th style="width:1px;">ID</th>');
        for (var i = 0; i < tableData.columns.length; i++) {
            cols.push(tableData.columns[i]);
            $(parent).find('#maintable thead').find('tr').first().append('<th>' + tableData.columns[i].name + '</th>');
        }
        cols.push({name: 'Status', data: 'status', responsivePriority: 2, visible: (typeof tableData.showStatus !== 'undefined') ? tableData.showStatus : true});
        $(parent).find('#maintable thead').find('tr').first().append('<th style="width:1px;">Status</th>');
        $(parent).find('#maintable thead').find('tr').first().append('<th style="width:1px;">Action</th>');

        if (typeof tableData.showHeader !== 'undefined') {
            if (tableData.showHeader) {
                $(parent).find('#maintable thead').show();
            } else {
                $(parent).find('#maintable thead').hide();
            }
        }

        this.mainTable = $(parent).find('#maintable').DataTable({
            responsive: (typeof tableData.responsive !== 'undefined') ? tableData.responsive : false,
            "bLengthChange": true,
            "bInfo": true,
            "aLengthMenu": tableData.aLengthMenu || [[5, 10, 15], [5, 10, 15]],
            "pageLength": tableData.pageLength || 5,
            "ordering": true,
            "autoWidth": false,
            "processing": true,
            "serverSide": true,
            "order": [[tableData.orderBy || 0, "desc"]],
            "ajax": {
                "url": tableData.url,
                "contentType": "application/json",
                "type": "POST",
                "data": function (d) {
                    Object.keys(additionalData).forEach(function (key) {
                        d[key] = additionalData[key];
                    });
                    return JSON.stringify(d);
                },
                error: function (xhr, error, code) {
                    console.log(xhr);
                    console.log(code);
                }
            },
            "columns": cols,
            "language": {
                'loadingRecords': '&nbsp;',
                'processing': '<div class="loader2"></div>'
            }, "createdRow": function (row, data, idx) {
                if (tableData.createdRow) {
                    tableData.createdRow(row, data, idx);
                    return;
                }
                let action_td = document.createElement('td');
                $(action_td).addClass('text-center');

                let viewIcon = '<a href="javascript:void(0)" class="viewRec m-r-5 m-l-5"><i class="icon feather icon-file-text f-16 text-c-blue"></i></a>';
                $(action_td).append(viewIcon);
                let editIcon = '<a href="javascript:void(0)" class="editRec m-r-5 m-l-5"><i class="icon feather icon-edit f-16 text-c-green"></i></a>';
                if (typeof tableData.showEditWhen !== 'undefined') {
                    if (tableData.showEditWhen.includes(data['status'])) {
                        $(action_td).append(editIcon);
                    }
                } else {
                    $(action_td).append(editIcon);
                }


                if (!(typeof tableData.showDeactivate !== 'undefined' && tableData.showDeactivate == false)) {
                    if ($(row).find('td').eq(cols.length - 2).text() == 'deactivated') {
                        let deleteIcon = '<a href="javascript:void(0)" class="reactRec m-r-5 m-l-5"><i class="icon feather icon-rotate-ccw f-16 text-warning"></i></a>';
                        $(action_td).append(deleteIcon);
                    } else {
                        let deleteIcon = '<a href="javascript:void(0)" class="dltRec m-r-5 m-l-5"><i class="icon feather icon-trash-2 f-16 text-danger"></i></a>';
                        $(action_td).append(deleteIcon);
                    }
                }
                $(row).append(action_td);
                $(row).data('id', data['id']);
                setTableStatus($(row).find('td').last().prev(), tableData.customStatus);
            }
        });
    }

    this.clearForm = function () {
        $(parent).find('#fields').find('input[type!=search],textarea,select,img').each(function () {
            if ($(this).is("img")) {
                $(this).attr('src', '#');
            } else if ($(this).is("select")) {
                $(this).data('select').set('');
            } else {
                $(this).val("");
            }
            let disableOnEdit = $(this).attr('doe');
            if ((typeof disableOnEdit !== 'undefined' && disableOnEdit !== false)) {
                $(this).removeAttr('readonly');
            }
        });
        $(parent).find('.file-el').remove();
        $(parent).find('#detailTab').click();
    }

    this.setupFields = function () {
        let obj = this;
        $(parent).find('#header2').html(name);
        $(parent).find('.cls-card').click(function () {
            $('#tableSection').fadeIn();
            $('#detailSection').hide();
        });

        $(parent).find('#auditTab').click(function () {
            $('#historyDetail').hide();
            $('#historyRow').fadeIn();
            loadAudit();
        });

        function loadAudit(from) {
            if (!$('#saveBtn').data('id')) {
                return;
            }
            const recId = $('#saveBtn').data('id');
            loadDiv($(parent).find('#detailSection'));
            if (!from) {
                $(parent).find('#historyRow').html('');
            }
            const audit_url = formData.audit_url;
            fetch(audit_url, {
                method: 'POST',
                body: new URLSearchParams({
                    id: recId,
                    from: from
                })
            }).then(function (result) {
                if (result.redirected) {
                    return {status: "timeout"};
                }
                return result.json();
            }).then(function (res) {
                if (res.status == 'timeout') {
                    Swal.fire('Session Timed Out !', 'Please Login to Continue', 'warning');
                    return
                } else if (res.status !== 'success') {
                    Swal.fire('Error !', res.msg, 'error');
                    return
                }
                let audit = res.data;
                for (var i = 0; i < audit.length; i++) {
                    let el = new AuditRow(audit[i].hdate, audit[i].username, audit[i].name, audit[i].action, recId, audit[i].rn, audit_url);
                    $(parent).find('#historyRow').append(el);
                }
                if (audit.length > 10) {

                }
                finishLoadDiv($(parent).find('#detailSection'));
            }).catch(function (err) {
                console.log(err);
                Swal.fire('Error !', err, 'error');
            });
        }

        $(parent).find('#addBtn').click(function () {
            obj.clearForm();
            $('#saveBtn').data('mode', 'save');
            $('#tableSection').hide();
            $('#detailSection').fadeIn();
        });

        let fields = formData.fields;

        if (fields == null) {
            $(formData.customFields).appendTo($(parent).find('#fields'));
        } else {
            for (var i = 0; i < fields.length; i++) {
                let div = document.createElement('div');
                $(div).addClass('col-' + fields[i].col);
                if (fields[i].hidden) {
                    $(div).attr('style', 'display:none;');
                }
                let mandatory = '';
                if (fields[i].mandatory) {
                    mandatory = ' <span class="text-danger">*</span>'
                }
                $(div).append('<label class="col-sm-12 col-form-label">' + fields[i].name + mandatory + '</label>');
                let div2 = document.createElement('div');
                $(div2).addClass('col-sm-12');

                if (fields[i].type == 'text') {
                    let el = document.createElement('input');
                    if (fields[i].mandatory) {
                        $(el).attr('required', true);
                    }
                    if (fields[i].disableOnEdit) {
                        $(el).attr('doe', true);
                    }
                    $(el).attr('type', 'text');
                    $(el).attr('autocomplete', 'off');
                    $(el).addClass('form-control');
                    $(el).attr('id', fields[i].id);
                    $(div2).append(el);
                } else if (fields[i].type == 'select') {
                    let el = document.createElement('select');
                    if (fields[i].mandatory) {
                        $(el).attr('required', true);
                    }
                    if (fields[i].disableOnEdit) {
                        $(el).attr('doe', true);
                    }
                    $(el).attr('id', fields[i].id);
                    $(div2).append(el);
                    var sel = new SlimSelect({
                        select: el,
                        placeholder: fields[i].placeholder || 'Please Select',
                        ajax: fields[i].ajax,
                        allowDeselect: true,
                        deselectLabel: '<span class="red">✖</span>'
                    });
                    $(el).data('select', sel);
                    if (fields[i].change) {
                        $(el).change(fields[i].change);
                    }
                    if (fields[i].data) {
                        sel.setData(fields[i].data);
                    }
                } else if (fields[i].type == 'int') {
                    let el = document.createElement('input');
                    if (fields[i].mandatory) {
                        $(el).attr('required', true);
                    }
                    if (fields[i].disableOnEdit) {
                        $(el).attr('doe', true);
                    }
                    $(el).attr('type', 'text');
                    $(el).attr('autocomplete', 'off');
                    $(el).addClass('form-control autoint');
                    $(el).attr('id', fields[i].id);
                    $(el).autoNumeric({mDec: '0'});
                    $(div2).append(el);
                } else if (fields[i].type == 'double') {
                    let el = document.createElement('input');
                    if (fields[i].mandatory) {
                        $(el).attr('required', true);
                    }
                    if (fields[i].disableOnEdit) {
                        $(el).attr('doe', true);
                    }
                    $(el).attr('type', 'text');
                    $(el).attr('autocomplete', 'off');
                    $(el).addClass('form-control autodouble');
                    $(el).attr('id', fields[i].id);
                    $(el).autoNumeric();
                    $(div2).append(el);
                } else if (fields[i].type == 'file') {
                    let el = document.createElement('input');
                    if (fields[i].mandatory) {
                        $(el).attr('required', true);
                    }
                    if (fields[i].disableOnEdit) {
                        $(el).attr('doe', true);
                    }
                    $(el).attr('type', 'file');
                    $(el).attr('autocomplete', 'off');
                    $(el).addClass('form-control');
                    $(el).attr('id', fields[i].id);
                    $(div2).append(el);
                }
                $(div).append(div2);
                $(parent).find('#fields').append(div);
            }
        }

        $(parent).find('#saveBtn').click(function () {
            saveData(false);
        });

        $(parent).find('#submitBtn').click(function () {
            saveData(true);
        });

        function saveData(submit) {
            let data = {};
            let deleted_files = [];
            let validated = true;
            const fd = new FormData();
            $(parent).find('#fields').find('input[type!=search],select,textarea').each(function () {
                let label = $(this).parent().parent().find('label').first();
                let required = $(this).attr('required');
                let visible = $(this).parent().parent().is(":visible");
                let value = $(this).val();
                if ($(this).is("input[type=file]") && $(this).parent().parent().find('.file-el').length > 0) {
                    value = 'ok';
                }
                if (visible) {
                    if (submit && required && (value == null || value.toString().trim() == '')) {
                        Swal.fire('Field Required !', 'Please set a valid value for "' + $(label).html() + '"', 'warning');
                        validated = false;
                        return false;
                    }
                    if ($(this).is("input[type=file]")) {
                        if ($(this).data('file')) {
                            fd.append($(this).attr('id'), $(this).data('file'));
                        } else {
                            let files = $(this).prop('files');
                            for (var i = 0; i < files.length; i++) {
                                fd.append($(this).attr('id'), files[i]);
                            }
                        }
                        if ($(this).data('deleted')) {
                            deleted_files.push($(this).attr('id'));
                        }
                    } else if ($(this).is("select")) {
                        let selected = $(this).data('select').selected() || '';
                        data[$(this).attr('id')] = selected;
                    } else if ($(this).hasClass('autodouble') | $(this).hasClass('autoint')) {
                        data[$(this).attr('id')] = $(this).val().replace(new RegExp(",", 'g'), '');
                    } else {
                        data[$(this).attr('id')] = $(this).val();
                    }
                }
            });

            if (!validated) {
                return false;
            }

            if (typeof formData.autoSubmit !== 'undefined' && !formData.autoSubmit) {
                data.submit = submit;
            }

            if ($('#saveBtn').data('mode') === 'save') {
                fd.append('data', JSON.stringify(data));
                Swal.fire({
                    title: 'Are you sure?',
                    text: "You are about to save this record",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, Save!',
                    showLoaderOnConfirm: true,
                    allowOutsideClick: () => !Swal.isLoading(),
                    preConfirm: () => {
                        return fetch(formData.save_url, {
                            method: 'POST',
                            body: fd
                        });
                    }
                }).then(function (res) {
                    if (res.value) {
                        if (res.value.redirected) {
                            return {status: "timeout"};
                        }
                        return  res.value.json();
                    }
                }).then((res) => {

                    if (res.status == 'timeout') {
                        Swal.fire('Session Timed Out !', 'Please Login to Continue', 'warning');
                        return
                    } else if (res.status !== 'success') {
                        Swal.fire('Error !', res.msg, 'error');
                        return
                    }
                    Swal.fire('Successfull !', res.msg, 'success');
                    obj.mainTable.ajax.reload();
                    $('#tableSection').fadeIn();
                    $('#detailSection').hide();
                    obj.clearForm();
                }).catch(function (err) {
                    console.log(err);
                    Swal.fire('Error !', 'Something Went Wrong', 'error');
                });

            } else if ($('#saveBtn').data('mode') === 'update') {
                data['id'] = $('#saveBtn').data('id');
                if (deleted_files.length > 0) {
                    data.deleted = deleted_files;
                }
                fd.append('data', JSON.stringify(data));
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
                        return fetch(formData.update_url, {
                            method: 'POST',
                            body: fd
                        });
                    }
                }).then(function (res) {
                    if (res.value) {
                        if (res.value.redirected) {
                            return {status: "timeout"};
                        }
                        return  res.value.json();
                    }
                    return Promise.reject("cancelled");
                }).then(function (res) {
                    if (res.status == 'timeout') {
                        Swal.fire('Session Timed Out !', 'Please Login to Continue', 'warning');
                        return
                    } else if (res.status !== 'success') {
                        Swal.fire('Error !', res.msg, 'error');
                        return
                    }
                    Swal.fire('Successfull !', res.msg, 'success');
                    obj.mainTable.ajax.reload();
                    obj.clearForm();
                    $('#tableSection').fadeIn();
                    $('#detailSection').hide();
                }).catch(function (err) {
                    console.log(err);
                    if (err != 'cancelled') {
                        Swal.fire('Error !', 'Something Went Wrong', 'error');
                    }
                });
            }
        }

        $(parent).find('#maintable').on('click', '.editRec', function () {
            obj.clearForm();
            $('#saveBtn').show();
            $('#submitBtn').show();
            loadDiv($('#tableSection').find('.card'));
            let id = $(this).parents('tr').eq(0).data('id');
            $('#saveBtn').data('id', id);
            getData(id).then(function (result) {
                if (result.redirected) {
                    return {status: "timeout"};
                }
                return result.json();
            }).then(function (res) {
                if (res.status == 'timeout') {
                    Swal.fire('Session Timed Out !', 'Please Login to Continue', 'warning');
                    return
                } else if (res.status !== 'success') {
                    Swal.fire('Error !', res.msg, 'error');
                    return
                }
                let data = res.data;
                fillData(data);

                $('#tableSection').hide();
                $('#detailSection').fadeIn();
                $('#saveBtn').data('mode', 'update');
                $('#saveBtn').html('Update');
            }).catch((err) => {
                Swal.fire('Error !', err, 'error');
            }).finally(() => {
                finishLoadDiv($('#tableSection').find('.card'));
            });
        });

        $(parent).find('#maintable').on('click', '.viewRec', function () {
            obj.clearForm();
            $('#saveBtn').hide();
            $('#submitBtn').hide();
            loadDiv($('#tableSection').find('.card'));
            let id = $(this).parents('tr').eq(0).data('id');
            $('#saveBtn').data('id', id);
            getData(id).then(function (result) {
                if (result.redirected) {
                    return {status: "timeout"};
                }
                return result.json();
            }).then(function (res) {
                if (res.status == 'timeout') {
                    Swal.fire('Session Timed Out !', 'Please Login to Continue', 'warning');
                    return
                } else if (res.status !== 'success') {
                    Swal.fire('Error !', res.msg, 'error');
                    return
                }
                let data = res.data;
                fillData(data, true);

                $('#tableSection').hide();
                $('#detailSection').fadeIn();
            }).catch((err) => {
                Swal.fire('Error !', err, 'error');
            }).finally(() => {
                finishLoadDiv($('#tableSection').find('.card'));
            });
        });

        function getData(id) {
            return  fetch(formData.data_url, {
                method: 'POST',
                body: new URLSearchParams({
                    id: id
                }),
                headers: {
                    'Accept': 'application/json',
                }, redirect: "follow"
            });
        }

        function fillData(data, readonly = false) {
            $(parent).find('#fields').find('input[type!=search],select,textarea,img').each(function () {
                let disableOnEdit = $(this).attr('doe');
                if (readonly | (typeof disableOnEdit !== 'undefined' && disableOnEdit !== false)) {
                    if ($(this).is("select")) {
                        $(this).data('select').disable();
                    } else if ($(this).is("input[type=file]")) {
                        $(this).attr('disabled', '');
                    } else {
                        $(this).attr('readonly', '');
                    }
                } else {
                    if ($(this).is("select")) {
                        $(this).data('select').enable();
                    } else if ($(this).is("input[type=file]")) {
                        $(this).removeAttr('disabled');
                    } else {
                        $(this).removeAttr('readonly');
                    }
                }
                if (data[$(this).attr('id')]) {
                    if ($(this).is("select")) {
                        if ($(this).data('select').ajax) {
                            if ($(this).data('select').config.isMultiple) {
                                let multi_data = data[$(this).attr('id')];
                                $(this).data('select').setData(multi_data);
                                for (var i = 0; i < multi_data.length; i++) {
                                    $(this).data('select').set(multi_data[i].value);
                                }
                            } else {
                                $(this).data('select').setData([{value: data[$(this).attr('id')], text: data[$(this).attr('id') + '_txt']}]);
                                $(this).data('select').set(data[$(this).attr('id')]);
                            }
                        } else {
                            if ($(this).data('select').config.isMultiple) {
                                let multi_data = data[$(this).attr('id')];
                                for (var i = 0; i < multi_data.length; i++) {
                                    $(this).data('select').set(multi_data[i]);
                                }
                            } else {
                                $(this).data('select').set(data[$(this).attr('id')]);
                            }
                        }
                    } else if ($(this).is("img")) {
                        $(this).attr('src', data[$(this).attr('id')]);
                    } else if ($(this).is("input[type=file]")) {
                        let file = data[$(this).attr('id')];
                        if (!file.name) {
                            return;
                        }
                        let doc_el = '<div class="row m-1 file-el" style="background-color: #e5e5e5;border-radius: 4px;">'
                                + '<div class="col-2 text-center justify-content-center align-self-center">'
                                + '<span class="pcoded-micon" style="font-size: 25px"><i class="feather icon-file"></i></span>'
                                + '</div>'
                                + '<div class="col-8 justify-content-center align-self-center">'
                                + '<a href="' + file.url + '" target="_blank" style="font-size: 12px" class="file-name">' + file.name + '</a>'
                                + '</div>'
                                + '<div class="col-2 text-center justify-content-center align-self-center">'
                                + '<span class="pcoded-micon file-cls" style="font-size: 20px;"> <i class="feather icon-x-circle"></i></span>'
                                + '</div>'
                                + '</div>';
                        let doc = document.createElement('div');
                        $(doc).html(doc_el);
                        $(doc).find('.file-cls').click(function () {
                            $(this).parent().parent().parent().find('input').show();
                            $(this).parent().parent().parent().find('input').data('deleted', true);
                            $(this).parent().parent().parent().find('.file-el').remove();
                        });
                        $(this).after($(doc).children());
                        $(this).hide();
                    } else {
                        $(this).val(data[$(this).attr('id')]);
                        $(this).trigger('focusout');
                    }
                }
            });

            if (formData.afterFill) {

                formData.afterFill();
        }
        }

    }

    this.initialize = function () {
        let obj = this;
        $(parent).load('files/templates/page.html', null, function (data, status, jqXGR) {
            if (formData.formSize) {
                $(parent).find('#detailSection').children().first().removeClass('col-lg-8').removeClass('col-lg-12').removeClass('offset-lg-2').addClass(formData.formSize);
            }
            if (typeof formData.autoSubmit !== 'undefined' && !formData.autoSubmit) {
                $(parent).find('#saveBtn').before('<button class="btn btn-sm btn-success pull-right m-l-10" id="submitBtn">Submit</button>');
            }
            obj.loadDtable();
            obj.setupFields();
        });
    }

    this.initialize();

}

function CreateApprovalPage(parent, name, tableData, formData) {

    $(parent).load('files/templates/approval-page.html', null, function (data, status, jqXGR) {
        loadDtable();
        setupFields();
    });

    this.mainTable = null;

    function loadDtable() {

        $(parent).find('#cardHeader').html('Search ' + name);
        let cols = [];
        cols.push({name: 'ID', data: 'id', visible: false});
        $(parent).find('#maintable thead').find('tr').first().append('<th style="width:1px;">ID</th>');
        for (var i = 0; i < tableData.columns.length; i++) {
            cols.push(tableData.columns[i]);
            $(parent).find('#maintable thead').find('tr').first().append('<th>' + tableData.columns[i].name + '</th>');
        }
        cols.push({name: 'Status', data: 'status'});
        $(parent).find('#maintable thead').find('tr').first().append('<th style="width:1px;">Status</th>');
        $(parent).find('#maintable thead').find('tr').first().append('<th style="width:1px;">Action</th>');

        console.log(cols);

        this.mainTable = $(parent).find('#maintable').DataTable({
            "bLengthChange": true,
            "bInfo": true,
            "aLengthMenu": [[5, 10, 15], [5, 10, 15]],
            "pageLength": 5,
            "ordering": true,
            "autoWidth": false,
            "processing": true,
            "serverSide": true,
            "order": [[0, "desc"]],
            "ajax": {
                "url": tableData.url,
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
            "columns": cols,
            "language": {
                'loadingRecords': '&nbsp;',
                'processing': '<div class="loader2"></div>'
            }, "createdRow": function (row, data) {
                let action_td = document.createElement('td');
                $(action_td).addClass('text-center');
                $(action_td).append('<a href="javascript:void(0)" class="approveRecord"><i class="icon feather icon-check-circle f-w-600 f-16 m-r-10 text-c-blue"></i></a>');
                $(row).append(action_td);
                $(row).data('id', data['id']);
                setTableStatus($(row).find('td').eq(cols.length - 2));
            }
        });
    }

    function setupFields() {
        $('#header2').html(name);

        $(parent).find('.cls-card').click(function () {
            $('#tableSection').fadeIn();
            $('#detailSection').hide();
        });

        $(parent).find('#auditTab').click(function () {
            if (!$('#approveBtn').data('id')) {
                return;
            }
            loadDiv($(parent).find('#detailSection'));
            $(parent).find('#historyRow').html('');
            const id = $('#approveBtn').data('id');
            const audit_url = formData.audit_url;
            $.post(audit_url, {id: id}, function (resp) {
                let audit = JSON.parse(resp);
                for (var i = 0; i < audit.length; i++) {
                    let el = new AuditRow(audit[i].hdate, audit[i].username, audit[i].name, audit[i].action, id, audit[i].rn, audit_url);
                    $(parent).find('#historyRow').append(el);
                }
                finishLoadDiv($(parent).find('#detailSection'));
            });
        });

        let fields = formData.fields;
        for (var i = 0; i < fields.length; i++) {

            let div = document.createElement('div');
            $(div).addClass('col-' + fields[i].col);
            if (fields[i].hidden) {
                $(div).attr('style', 'display:none;');
            }
            let mandatory = '';
            if (fields[i].mandatory) {
                mandatory = ' <span class="text-danger">*</span>'
            }
            $(div).append('<label class="col-sm-12 col-form-label">' + fields[i].name + mandatory + '</label>');
            let div2 = document.createElement('div');
            $(div2).addClass('col-sm-12');

            if (fields[i].type == 'text') {
                let el = document.createElement('input');
                $(el).attr('readonly', true);
                if (fields[i].mandatory) {
                    $(el).attr('required', true);
                }
                $(el).attr('type', 'text');
                $(el).attr('autocomplete', 'off');
                $(el).addClass('form-control');
                $(el).attr('id', fields[i].id);
                $(div2).append(el);
            } else if (fields[i].type == 'select') {
                let el = document.createElement('select');
                $(el).attr('readonly', true);
                if (fields[i].mandatory) {
                    $(el).attr('required', true);
                }
                $(el).attr('id', fields[i].id);
                $(div2).append(el);
                var sel = new SlimSelect({
                    select: el,
                    placeholder: fields[i].placeholder || 'Please Select',
                    ajax: fields[i].ajax,
                    allowDeselect: true,
                    deselectLabel: '<span class="red">✖</span>'
                });
                sel.disable();
                $(el).data('select', sel);
                if (fields[i].change) {
                    $(el).change(fields[i].change);
                }
                if (fields[i].data) {
                    sel.setData(fields[i].data);
                }
            } else if (fields[i].type == 'int') {
                let el = document.createElement('input');
                $(el).attr('readonly', true);
                if (fields[i].mandatory) {
                    $(el).attr('required', true);
                }
                $(el).attr('type', 'text');
                $(el).attr('autocomplete', 'off');
                $(el).addClass('form-control autoint');
                $(el).attr('id', fields[i].id);
                $(el).autoNumeric({mDec: '0'});
                $(div2).append(el);
            } else if (fields[i].type == 'double') {
                let el = document.createElement('input');
                $(el).attr('readonly', true);
                if (fields[i].mandatory) {
                    $(el).attr('required', true);
                }
                $(el).attr('type', 'text');
                $(el).attr('autocomplete', 'off');
                $(el).addClass('form-control autodouble');
                $(el).attr('id', fields[i].id);
                $(el).autoNumeric();
                $(div2).append(el);
            }
            $(div).append(div2);

            $(parent).find('#fields').append(div);
        }

        $(parent).find('#approveBtn').click(function () {
            //loadDiv($('#detailSection').find('.card'));
            let id = $(this).data('id');
            Swal.fire({
                title: 'Are you sure?',
                text: "This record will be approved",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, Approve!',
                showLoaderOnConfirm: true,
                allowOutsideClick: () => !Swal.isLoading(),
                preConfirm: () => {
                    return $.post(formData.approve_url, {id: id});
                }
            }).then((result) => {
                if (result.value) {
                    let res = JSON.parse(result.value);
                    if (res.status === 'success') {
                        Swal.fire('Successfull !', res.msg, 'success');
                        mainTable.ajax.reload();
                        clearForm();
                        $('#tableSection').fadeIn();
                        $('#detailSection').hide();
                        //finishLoadDiv($('#detail_sec').find('.card'));
                    } else if (res.status == 'error') {
                        Swal.fire('Error !', res.msg, 'error');
                    } else {
                        Swal.fire('Error !', 'Something Went Wrong', 'error');
                    }
                }
            });
        });

        $(parent).find('#maintable').on('click', '.approveRecord', function () {
            clearForm();
            loadDiv($('#tableSection').find('.card'));
            let id = $(this).parents('tr').eq(0).data('id');
            $('#approveBtn').data('id', id);
            $.post(formData.data_url, {id: id}, function (result) {
                let res = JSON.parse(result);
                let data = JSON.parse(res.data);
                $(parent).find('#fields').find('input[type!=search],select,textarea').each(function () {
                    if ($(this).is("select") && $(this).data('select').ajax) {
                        $(this).data('select').setData([{value: data[$(this).attr('id')], text: data[$(this).attr('id') + '_txt']}]);
                        $(this).data('select').set(data[$(this).attr('id')]);
                    } else {
                        if (data[$(this).attr('id')]) {
                            $(this).val(data[$(this).attr('id')]);
                        }
                    }
                });
                $('#tableSection').hide();
                $('#detailSection').fadeIn();
                finishLoadDiv($('#tableSection').find('.card'));
            });
        });
    }

    function clearForm() {
        $('#tab-basic-details').find('input[type!=search],textarea').each(function () {
            $(this).val("");
        });
        $('#detailTab').click();
    }
}

function AuditRow(date, username, name, action, recNo, rowNo, auditUrl) {
    let div = document.createElement('div');
    $(div).addClass('col-12 auditDiv');
    let el = `<div class="media"><a class="media-left" href="javascript:void(0);"><img class="media-object img-radius m-r-10 img-60" onerror="this.onError=null;this.src='files/images/user.png';" src="userimages/${username}.jpg"></a><div class="media-body b-b-theme social-client-description"><span>${date}</span><div class="chat-header">${action} - ${name}</div></div></div>`;
    $(div).html(el);
    const rid = recNo;
    const rn = rowNo;
    $(div).find('.chat-header').click(function () {
        $('#historyDetail').html('');
        loadDiv($('#detailSection').find('.card'));
        fetch(auditUrl + '/' + rid + "/" + rn, {
            method: 'GET',
            headers: {
                'Accept': 'application/json',
            }, redirect: "follow"
        }).then(function (result) {
            if (result.redirected) {
                return {status: "timeout"};
            }
            return result.json();
        }).then(function (res) {
            if (res.status == 'timeout') {
                Swal.fire('Session Timed Out !', 'Please Login to Continue', 'warning');
                finishLoadDiv($('#detailSection').find('.card'));
                return
            } else if (res.status !== 'success') {
                Swal.fire('Error !', res.msg, 'error');
                finishLoadDiv($('#detailSection').find('.card'));
                return
            }
            let data = res.data;
            console.log(data);

            if (data.action === 'update') {
                let tbl = document.createElement('table');
                $(tbl).addClass('table table-sm table-bordered');
                $(tbl).append('<thead><tr><th>Field</th><th>From</th><th>To</th></tr></thead><tbody></tbody>');

                $('#fields').find('input[type!=search],select,textarea').each(function () {
                    let label = $(this).parent().parent().find('label').first().html();
                    let fieldId = $(this).attr('id');
                    let dataFrom = getDta($(this), data.from, fieldId);
                    let dataTo = getDta($(this), data.to, fieldId);

                    let tr = document.createElement('tr');
                    $(tr).append('<th>' + label + '</th>');
                    $(tr).append('<td>' + dataFrom + '</td>');
                    $(tr).append('<td>' + dataTo + '</td>');

                    if (dataFrom != dataTo) {
                        $(tr).addClass('table-danger');
                    }

                    $(tbl).append(tr);
                });
                $('#historyDetail').append(tbl).fadeIn();
                $('#historyRow').hide();
            } else if (data.action === 'insert') {
                let tbl = document.createElement('table');
                $(tbl).addClass('table table-sm table-bordered');
                $(tbl).append('<thead><tr><th>Field</th><th>Data</th></tr></thead><tbody></tbody>');

                $('#fields').find('input[type!=search],select,textarea').each(function () {
                    let label = $(this).parent().parent().find('label').first().html();
                    if (!label) {
                        return;
                    }
                    let fieldId = $(this).attr('id');
                    let dataFrom = getDta($(this), data.data, fieldId);

                    let tr = document.createElement('tr');
                    $(tr).append('<th>' + label + '</th>');
                    $(tr).append('<td>' + dataFrom + '</td>');
                    $(tbl).append(tr);
                });
                $('#historyDetail').append(tbl).fadeIn();
                $('#historyRow').hide();
            }

            finishLoadDiv($('#detailSection').find('.card'));
        }).catch((err) => {
            console.log(err);
            Swal.fire('Error !', 'Something Went Wrong!', 'error');
            finishLoadDiv($('#detailSection').find('.card'));
        });
    });
    return div;
}

function getDta(element, data, fieldId) {
    let retData = '';
    if ($(element).is("select")) {
        if ($(element).data('select').ajax) {
            if ($(element).data('select').config.isMultiple) {
                if (!data[fieldId]) {
                    return retData;
                }
                let multi_data = [];
                for (var i = 0; i < data[fieldId].length; i++) {
                    multi_data.push(data[fieldId][i].text);
                }
                retData = multi_data.join();
            } else {
                if (!data[fieldId + '_txt']) {
                    return retData;
                }
                retData = data[fieldId + '_txt'];
            }
        } else {
            if ($(element).data('select').config.isMultiple) {
                if ($(element).data('select').config.isMultiple) {
                    if (!data[fieldId]) {
                        return retData;
                    }
                    let multi_data = [];
                    for (var i = 0; i < data[fieldId].length; i++) {
                        multi_data.push(data[fieldId][i].text);
                    }
                    retData = multi_data.join();
                } else {
                    if (!data[fieldId + '_txt']) {
                        return retData;
                    }
                    retData = data[fieldId + '_txt'];
                }
            } else {
                if (!data[fieldId]) {
                    return retData;
                }
                retData = data[fieldId];
            }
        }
    } else if ($(element).is("img")) {
        //$(this).attr('src', data[$(this).attr('id')]);
    } else if ($(element).is("input[type=file]")) {
        if (!data[fieldId]) {
            return retData;
        }
        let doc_el = '<div class="row m-1 file-el" style="background-color: #e5e5e5;border-radius: 4px;">'
                + '<div class="col-auto text-center justify-content-center align-self-center">'
                + '<span class="pcoded-micon" style="font-size: 15px"><i class="feather icon-file"></i></span>'
                + '</div>'
                + '<div class="col-8 justify-content-center align-self-center">'
                + '<a href="assetimages/' + data[fieldId] + '" target="_blank" style="font-size: 12px" class="file-name">' + data[fieldId] + '</a>'
                + '</div>'
                + '</div>';
        retData = doc_el;
    } else {
        if (!data[fieldId]) {
            return retData;
        }
        retData = data[fieldId];
    }

    return retData;
}