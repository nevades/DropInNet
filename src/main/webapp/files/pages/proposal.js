//config
$.fn.dataTable.ext.errMode = 'none';
var form_loaded = false;
$('.pt1,.pt2,.pt3').hide();

$('.autodouble').autoNumeric();
$('.autoint').autoNumeric({mDec: '0'});
$('.autoyear').autoNumeric({aSep: '', mDec: '0', vMax: "9999", vMin: "0"});

$('#secu_doc').click(function () {
    var d = "StandardSecuritiesCovenantsConditions.pdf";
    window.open('Get_secu_document?name=' + d + '');
});
$('#repay_doc').click(function () {
    var d = "Repayment Method for Term Loan.pdf";
    window.open('Get_repayment_doc?name=' + d + '');
});

function loadCards() {
    fetch('proposal/cards').then(response => response.json()).then(function (res) {
        if (res.status !== 'success') {
            return;
        }
        let data = res.data;
        for (let i = 0; i < data.length; i++) {
            if (data[i].status === 'all') {
                $('#summary').find('h2').eq(0).html(data[i].val || '0');
            } else if (data[i].status === 'in progress') {
                $('#summary').find('h2').eq(1).html(data[i].val || '0');
            } else if (data[i].status === 'pending') {
                $('#summary').find('h2').eq(2).html(data[i].val || '0');
            } else if (data[i].status === 'active') {
                $('#summary').find('h2').eq(3).html(data[i].val || '0');
            } else if (data[i].status === 'rejected') {
                $('#summary').find('h2').eq(4).html(data[i].val || '0');
            }
        }
    });
}
loadCards();

$('.order-card').click(function () {
    $('.order-card').removeClass('cardActive');
    $(this).addClass('cardActive');

    if ($(this).parent().index() === 0) {
        status = 'all';
    } else if ($(this).parent().index() === 1) {
        status = 'in progress';
    } else if ($(this).parent().index() === 2) {
        status = 'pending';
    } else if ($(this).parent().index() === 3) {
        status = 'active';
    } else if ($(this).parent().index() === 4) {
        status = 'rejected';
    }
    proposals.ajax.reload();
});

//main table
let  status = "all";
let proposals = $('#maintable').DataTable({
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
        "url": "proposal/search",
        "contentType": "application/json",
        "type": "POST",
        "data": function (d) {
            d.status = status;
            return JSON.stringify(d);
        },
        error: function (xhr, error, code) {
            console.log(xhr);
            console.log(code);
        }
    },
    "columns": [
        {"data": "id", visible: false},
        {"data": "code"},
        {"data": "customer"},
        {"data": "laction"},
        {"data": "status"},
    ], "language": {
        'loadingRecords': '&nbsp;',
        'processing': '<div class="loader2"></div>'
    }, "createdRow": function (row, data) {
        let action_td = document.createElement('td');
        $(row).data('id', data['id']);
        $(row).data('code', data['code']);
        $(action_td).addClass('text-center');
        if (data.status !== 'in progress') {
            $(action_td).append('<a href="javascript:void(0)" class="viewproposal"><i class="icon feather icon-list f-w-600 f-16 m-r-10 text-c-blue"></i></a>');
        } else {
            $(action_td).append('<a href="javascript:void(0)" class="viewproposal"><i class="icon feather icon-list f-w-600 f-16 m-r-10 text-c-blue"></i></a><a href="javascript:void(0)" class="editproposal"><i class="icon feather icon-edit f-w-600 f-16 m-r-10 text-c-green"></i></a>');
        }
        setTableStatus($(row).find('td').eq(3));
        $(row).append(action_td);
    }
});

$('#allCard').click(function () {
    status = 'all';
    loadMenuCards();
    proposals.ajax.reload();
});
$('#iprogressgcrd').click(function () {
    status = 'in progress';
    loadMenuCards();
    proposals.ajax.reload();
});
$('#pendingcrd').click(function () {
    status = 'pending';
    loadMenuCards();
    proposals.ajax.reload();
});
$('#activecrd').click(function () {
    status = 'active';
    loadMenuCards();
    proposals.ajax.reload();
});

$('.widget-visitor-card').click(function () {
    $('.widget-visitor-card').removeClass('cardActive');
    $(this).addClass('cardActive');
});


$('#add_proposal_btn').click(function () {
    if (form_loaded) {
        clearFields()
        $('#tablerow').hide();
        $('#proposalrow').fadeIn();
    } else {
        let cb = function () {
            clearFields()
            $('#tablerow').hide();
            $('#proposalrow').fadeIn();
            finishLoadDiv($('#tablerow').find('.card'));
        }
        loadDiv($('#tablerow').find('.card'));
        loadFields(cb);
    }
    $('#saveProposalBtn').data('mode', 'save');
    $('#viewProposalBtn').hide();
    $('#summary').hide();
});

$('.cls-card').click(function () {
    $('#tablerow').fadeIn();
    $('#proposalrow').hide();
    $('#summary').fadeIn();
});

var working_capital_facility = new SlimSelect({
    select: '#working_capital_facility',
    placeholder: "Please Select",
    showSearch: false,
//    allowDeselect: true,
//    deselectLabel: '<span class="red">✖</span>'
});
$('#working_capital_facility').data('select', working_capital_facility);

$('#working_capital_facility').change(function () {
    if ($(this).val() == 'yes') {
        $('#wc_section').show();
    } else {
        $('#wc_section').hide();
    }
});

var request_type = new SlimSelect({
    select: '#request_type',
    placeholder: "Select a Type",
    showSearch: false,
    allowDeselect: true,
    deselectLabel: '<span class="red">✖</span>'
});
$('#request_type').data('select', request_type);

var select_branch = new SlimSelect({
    select: '#branch',
    placeholder: "Select a Branch",
    ajax: function (search, callback) {
        $.post('proposal/searchBranch', {q: search}, function (res) {
            callback(JSON.parse(res));
        });
    },
    allowDeselect: true,
    deselectLabel: '<span class="red">✖</span>'
});
$('#branch').data('select', select_branch);

var sme_eligibility = new SlimSelect({
    select: '#sme_eligibility',
    placeholder: "Please Select",
    showSearch: false,
    allowDeselect: true,
    deselectLabel: '<span class="red">✖</span>'
});
$('#sme_eligibility').data('select', sme_eligibility);

var no_of_emps = new SlimSelect({
    select: '#no_of_emps',
    placeholder: "Please Select",
    showSearch: false,
    allowDeselect: true,
    deselectLabel: '<span class="red">✖</span>'
});
$('#no_of_emps').data('select', no_of_emps);

var mkt_officer = new SlimSelect({
    select: '#mkt_officer',
    placeholder: "Please Select",
    ajax: function (search, callback) {
        $.post('proposal/searchMo', {q: search}, function (res) {
            callback(JSON.parse(res));
        });
    },
    allowDeselect: true,
    deselectLabel: '<span class="red">✖</span>'
});
$('#mkt_officer').data('select', mkt_officer);

var selectCustomer = new SlimSelect({
    select: '#customer_code',
    placeholder: "Select a Customer",
    ajax: function (search, callback) {
        $.post('proposal/customerSearch', {q: search}, function (res) {
            callback(JSON.parse(res));
        });
    },
    allowDeselect: true,
    deselectLabel: '<span class="red">✖</span>'
});
$('#customer_code').data('select', selectCustomer);

var joint_customer = new SlimSelect({
    select: '#joint_customer',
    placeholder: "Select a joint customer",
    ajax: function (search, callback) {
        $.post('proposal/customerSearch', {q: search}, function (res) {
            callback(JSON.parse(res));
        });
    },
    allowDeselect: true,
    deselectLabel: '<span class="red">✖</span>'
});
$('#joint_customer').data('select', joint_customer);

var customer_type = new SlimSelect({
    select: '#customer_type',
    placeholder: "Select a customer type",
    allowDeselect: true,
    deselectLabel: '<span class="red">✖</span>',
    showSearch: false,
});
$('#customer_type').data('select', customer_type);

var sub_sector = new SlimSelect({
    select: '#sub_sector',
    placeholder: "Select an Option",
    allowDeselect: true,
    deselectLabel: '<span class="red">✖</span>',
});
$('#sub_sector').data('select', sub_sector);

var maritial_status = new SlimSelect({
    select: '#maritial_status',
    placeholder: "Select an Option",
    allowDeselect: true,
    deselectLabel: '<span class="red">✖</span>',
    showSearch: false,
});
$('#maritial_status').data('select', maritial_status);

var audited = new SlimSelect({
    select: '#audited',
    placeholder: "Select an Option",
    allowDeselect: true,
    deselectLabel: '<span class="red">✖</span>',
    showSearch: false,
});
$('#audited').data('select', audited);

var cpe = new SlimSelect({
    select: '#credit_policy_exception',
    placeholder: "Select an Option",
    allowDeselect: true,
    deselectLabel: '<span class="red">✖</span>',
    showSearch: false,
});
$('#credit_policy_exception').data('select', cpe);

var select_rec_user = new SlimSelect({
    select: '#rec_user',
    placeholder: "Select an User",
    ajax: function (search, callback) {
        $.post('proposal/searchUser', {q: search}, function (res) {
            callback(JSON.parse(res));
        });
    },
    allowDeselect: true,
    deselectLabel: '<span class="red">✖</span>'
});
$('#rec_user').data('select', select_rec_user);

function clearFields() {
    $('#tab-basic-details').find('input[type!=search],textarea').each(function () {
        $(this).val("");
    });
    joint_customer.set('');
    request_type.set(0);
    customer_type.set(0);
    select_branch.set(0);
    sme_eligibility.set(-1);
    mkt_officer.set(0);
    selectCustomer.set(0);
    selectCustomer.setData([]);
    customer_type.set(0);
    sub_sector.set(0);
    maritial_status.set(0);
    no_of_emps.set('');
    audited.set(-1);
    working_capital_facility.set('yes');
    $('#table-wc').find('input').val('');
    $('#partners-table').find('tbody').html('');
    $('#FAC-total_exp').parent().prevAll().remove();
    $('#shareholder-table').find('tbody').html('');
    $('#declared-assets-company-table').find('tbody').html('');
    $('#declared-assets-partner-table').find('tbody').html('');
    $('#other_financial_commitments_table').find('tbody').html('');
    $('#financial-commitments').find('tbody').html('');
    $('#table-security').find('tbody').html('');
    $('#table-covenants').find('tbody').html('');
    $('#table-tnc').find('.quills').each(function () {
        $(this).data('editor').root.innerHTML = '';
    });
    $('#table-security-policy').find('tbody').html('');
    if ($('#table-crib').find('tr').eq(0).children().length > 1) {
        $('#table-crib').find('tr').each(function () {
            $(this).children().slice(1).remove();
        });
    }
    $('#bank_statements').html('');
    $('#table-wallet').find('input').val('');
    //$('#table-riskassessment').find('input').val('');
    $('#table-riskassessment').find('.quills').each(function () {
        $(this).data('editor').root.innerHTML = '';
    });
    //$('#table-swot').find('textarea').val('');
    $('#table-swot').find('.quills').each(function () {
        $(this).data('editor').root.innerHTML = '';
    });
    $('#app_hist_table').find('tbody').html();
    $('#rec_comment').val('');

    $('#financial-highlights tbody').find('tr').each(function () {
        $(this).find('td').slice(1).html('');
    });
    $('#financial-highlights thead').find('tr').each(function () {
        $(this).find('th').slice(1).each(function () {
            if ($(this).html() != '%') {
                $(this).html('');
            }
        });
    });
    $('#app_hist_').html('');

    operation_details_editor.root.innerHTML = '';
    operation_details_editor.root.innerHTML = '';
    present_request_editor.root.innerHTML = '';
    facility_justification_editor.root.innerHTML = '';
    facility_detail_comment_editor.root.innerHTML = '';
    //security_desc_editor.root.innerHTML = '';
    repayment_plan_editor.root.innerHTML = '';
    //repayment_plan_oferLetter_editor.root.innerHTML = '';
    repayment_primary_editor.root.innerHTML = '';
    repayment_secondary_editor.root.innerHTML = '';
    irregular_facilities_editor.root.innerHTML = '';
    other_financial_commitments_editor.root.innerHTML = '';
    conduct_of_facilities_editor.root.innerHTML = '';
    wallet_cmt_editor.root.innerHTML = '';
    tnc_editor.root.innerHTML = '';
    track_record_editor.root.innerHTML = '';
    financial_justification_editor.root.innerHTML = '';
    income_statement_editor.root.innerHTML = '';
    balance_sheet_editor.root.innerHTML = '';
    projected_financials_editor.root.innerHTML = '';
    offer_letter_details.root.innerHTML = '';
}

$('#customer_type').change(function () {
    $('.pt1,.pt2,.pt3').hide();
    $('.pt1,.pt2,.pt3').find('input[type!=search],select,textarea').removeClass('ignore');
    $('.pt1,.pt2,.pt3').find('input[type!=search],select,textarea').addClass('ignore');
    $('.pt' + $(this).val()).show();
    $('.pt' + $(this).val()).find('input[type!=search],select,textarea').removeClass('ignore');
});

$('#customer_code').change(function () {
    if ($(this).val()) {
        loadDiv($('#proposalrow').find('.card'));
        $.post('proposal/customerData', {cus_id: $(this).val()}, function (res) {
            let data = res;
            Object.keys(data).forEach(function (key) {
                if (key == 'financials') {
                    $('#financial-highlights tbody').find('tr').each(function () {
                        $(this).find('td').slice(1).html('');
                    });
                    $('#financial-highlights thead').find('tr').each(function () {
                        $(this).find('th').slice(1).each(function () {
                            if ($(this).html() != '%') {
                                $(this).html('');
                            }
                        });
                    });
                    setFinancials(data[key]);
                    return;
                }
                let el = $(document).find('#' + key);
                if ($(el).is("input") | $(el).is("textarea")) {
                    $(el).val(data[key]);
                    $(el).trigger('focusout');
                } else if ($(el).is("select")) {
                    let select = $(el).data('select');
                    if (select) {
                        select.set(data[key]);
                    }
                }
            });
            finishLoadDiv($('#proposalrow').find('.card'));
        });
    }
});

$('#addPartnerBtn').click(function () {
    addPartner();
});

function addPartner(name = "", nic = "", position = "", qualification = "", experiance = "") {
    let tr = document.createElement('tr');
    $(tr).append('<td><input type="text" class="form-control" value="' + name + '"></td>');
    $(tr).append('<td><input type="text" class="form-control" value="' + nic + '"></td>');
    $(tr).append('<td><input type="text" class="form-control" value="' + position + '"></td>');
    $(tr).append('<td><textarea class="form-control">' + qualification + '</textarea></td>');
    $(tr).append('<td><textarea class="form-control">' + experiance + '</textarea></td>');
    $(tr).append('<td class="text-center"><a href="javascript:void(0)" class="dltbtn"><i class="feather icon-trash-2 f-w-600 f-16 text-danger"></i></a></td>');
    $('#partners-table').find('tbody').append(tr);
}

$('#addShareholderBtn').click(function () {
    addShareholder();
});

function addShareholder(name = '', nic = '', precentage = '') {
    let tr = document.createElement('tr');
    $(tr).append('<td><input type="text" class="form-control" value="' + name + '"></td>');
    $(tr).append('<td><input type="text" class="form-control" value="' + nic + '"></td>');
    $(tr).append('<td><input type="text" class="form-control autodouble" value="' + precentage + '"></td>');
    $(tr).append('<td class="text-center"><a href="javascript:void(0)" class="dltbtn"><i class="feather icon-trash-2 f-w-600 f-16 text-danger"></i></a></td>');
    $('#shareholder-table').find('tbody').append(tr);
    $(tr).find('.autodouble').autoNumeric({
        digitGroupSeparator: '.',
        decimalCharacter: ',',
        caretPositionOnFocus: 'decimalRight'
    });
}

$('#addasset1').click(function () {
    addCompanyAsset();
});

function addCompanyAsset(type = '', desc = '', value = '') {
    let tr = document.createElement('tr');
    $(tr).append('<td><input type="text" class="form-control" value="' + type + '"></td>');
    $(tr).append('<td><input type="text" class="form-control" value="' + desc + '"></td>');
    $(tr).append('<td><input type="text" class="form-control autodouble" value="' + value + '"></td>');
    $(tr).append('<td class="text-center"><a href="javascript:void(0)" class="dltbtn"><i class="feather icon-trash-2 f-w-600 f-16 text-danger"></i></a></td>');
    $('#declared-assets-company-table').find('tbody').append(tr);
    $(tr).find('.autodouble').autoNumeric({
        digitGroupSeparator: '.',
        decimalCharacter: ',',
        caretPositionOnFocus: 'decimalRight'
    });
    $(tr).find('.autodouble').focusout();
}

$('#addasset2').click(function () {
    addPartnerAsset();
});
$('#addasset67').click(function () {
    addFinancialCommitments();
});

function addPartnerAsset(type = '', desc = '', value = '') {
    let tr = document.createElement('tr');
    $(tr).append('<td><input type="text" class="form-control" value="' + type + '"></td>');
    $(tr).append('<td><input type="text" class="form-control" value="' + desc + '"></td>');
    $(tr).append('<td><input type="text" class="form-control autodouble" value="' + value + '"></td>');
    $(tr).append('<td class="text-center"><a href="javascript:void(0)" class="dltbtn"><i class="feather icon-trash-2 f-w-600 f-16 text-danger"></i></a></td>');
    $('#declared-assets-partner-table').find('tbody').append(tr);
    $(tr).find('.autodouble').autoNumeric({
        digitGroupSeparator: '.',
        decimalCharacter: ',',
        caretPositionOnFocus: 'decimalRight'
    });
    $(tr).find('.autodouble').focusout();
}

function addFinancialCommitments(fcompany = '', ftype = '', flimit = '', fos = '', fsecurity = '', fmonthly_commitments = '', fpast_6months = '', fpast_12months = '') {
    let tr = document.createElement('tr');
    $(tr).append('<td><input type="text" class="form-control" value="' + fcompany + '"></td>');
    $(tr).append('<td><input type="text" class="form-control" value="' + ftype + '"></td>');
    $(tr).append('<td><input type="text" class="form-control" value="' + flimit + '"></td>');
    $(tr).append('<td><input type="text" class="form-control" value="' + fos + '"></td>');
    $(tr).append('<td><input type="text" class="form-control" value="' + fsecurity + '"></td>');
    $(tr).append('<td><input type="text" class="form-control" value="' + fmonthly_commitments + '"></td>');
    $(tr).append('<td><input type="text" class="form-control" value="' + fpast_6months + '"></td>');
    $(tr).append('<td><input type="text" class="form-control" value="' + fpast_12months + '"></td>');
    $(tr).append('<td class="text-center"><a href="javascript:void(0)" class="dltbtn"><i class="feather icon-trash-2 f-w-600 f-16 text-danger"></i></a></td>');
    $('#other_financial_commitments_table').find('tbody').append(tr);
    $(tr).find('.autodouble').autoNumeric({
        digitGroupSeparator: '.',
        decimalCharacter: ',',
        caretPositionOnFocus: 'decimalRight'
    });
    $(tr).find('.autodouble').focusout();
}

$('#addFinancialCommitmentBtn').click(function () {
    let tr = document.createElement('tr');
    $(tr).append('<td><select></select></td>');
    $(tr).append('<td><select></select></td>');
    let s1 = $(tr).find('select').eq(0)[0];
    let s2 = $(tr).find('select').eq(1)[0];

    let sl1 = new SlimSelect({
        select: s1,
        placeholder: "Select a finanical institute",
        ajax: function (search, callback) {
            $.post('proposal/financeinstitute', {q: search}, function (res) {
                callback(JSON.parse(res));
            });
        },
        allowDeselect: true,
        deselectLabel: '<span class="red">✖</span>'
    });

    let sl2 = new SlimSelect({
        select: s2,
        placeholder: "Select a product",
        ajax: function (search, callback) {
            $.post('proposal/products', {q: search}, function (res) {
                callback(JSON.parse(res));
            });
        },
        allowDeselect: true,
        deselectLabel: '<span class="red">✖</span>'
    });

    $(tr).append('<td><input type="text" class="form-control autodouble"></td>');
    $(tr).append('<td><input type="text" class="form-control autodouble"></td>');
    $(tr).append('<td><input type="text" class="form-control autodouble"></td>');
    $(tr).append('<td><input type="text" class="form-control autodouble"></td>');
    $(tr).append('<td><input type="text" class="form-control autoint"></td>');
    $(tr).append('<td><input type="text" class="form-control autoint"></td>');
    $(tr).append('<td class="text-center"><a href="javascript:void(0)" class="dltfcbtn"><i class="feather icon-trash-2 f-w-600 f-16 text-danger"></i></a></td>');
    $('#financial-commitments').find('tbody').append(tr);
    $(tr).find('.autodouble').autoNumeric();
    $(tr).find('.autoint').autoNumeric({
        mDec: '0'
    });
    $(tr).find('.autodouble,.autoint').change(function () {
        fcTotal();
    });

    fcTotal();
});

$(document).on('click', '.dltbtn', function () {
    $(this).parents('tr').first().remove();
});

$(document).on('click', '.dltcribbtn', function () {
    $(this).parents('.crib_temp').first().remove();
});

$(document).on('click', '.dltbstbtn ', function () {
    $(this).parents('.bank_st_temp').first().remove();
});

$(document).on('click', '.dltexpbtn', function () {
    $(this).parents('tr').first().remove();
    expencesTotal();
});

$(document).on('click', '.dltincbtn', function () {
    $(this).parents('tr').first().remove();
    incomeTotal();
});

$(document).on('click', '.dltfcbtn', function () {
    $(this).parents('tr').first().remove();
    fcTotal();
});

function formatDouble(val) {
    if (parseFloat(val)) {
        return parseFloat(val).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
    } else {
        return val;
    }
}

function formatInt(val) {
    if (parseInt(val)) {
        return parseInt(val).toString().replace(/\d(?=(\d{3})+\.)/g, '$&,');
    } else {
        return val;
    }
}

function fcTotal() {
    let lim_tot = 0;
    let os_tot = 0;
    let sec_tot = 0;
    let mon_tot = 0;
    let m6_tot = 0;
    let m12_tot = 0;
    $('#financial-commitments').find('tbody').find('tr').each(function () {
        let v1 = $(this).find('td').eq(2).find('input').val().replace(new RegExp(",", 'g'), '');
        let v2 = $(this).find('td').eq(3).find('input').val().replace(new RegExp(",", 'g'), '');
        let v3 = $(this).find('td').eq(4).find('input').val().replace(new RegExp(",", 'g'), '');
        let v4 = $(this).find('td').eq(5).find('input').val().replace(new RegExp(",", 'g'), '');
        let v5 = $(this).find('td').eq(6).find('input').val().replace(new RegExp(",", 'g'), '');
        let v6 = $(this).find('td').eq(7).find('input').val().replace(new RegExp(",", 'g'), '');
        if (parseFloat(v1)) {
            lim_tot += parseFloat(v1);
        }
        if (parseFloat(v2)) {
            os_tot += parseFloat(v2);
        }
        if (parseFloat(v3)) {
            sec_tot += parseFloat(v3);
        }
        if (parseFloat(v4)) {
            mon_tot += parseFloat(v4);
        }
        if (parseInt(v5)) {
            m6_tot = parseInt(v5);
        }
        if (parseInt(v6)) {
            m12_tot = parseInt(v6);
        }
    });
    $('#financial-commitments').find('thead').eq(1).find('th').eq(1).html(formatDouble(lim_tot));
    $('#financial-commitments').find('thead').eq(1).find('th').eq(2).html(formatDouble(os_tot));
    $('#financial-commitments').find('thead').eq(1).find('th').eq(3).html(formatDouble(sec_tot));
    $('#financial-commitments').find('thead').eq(1).find('th').eq(4).html(formatDouble(mon_tot));
    $('#financial-commitments').find('thead').eq(1).find('th').eq(5).html(formatInt(m6_tot));
    $('#financial-commitments').find('thead').eq(1).find('th').eq(6).html(formatInt(m12_tot));
}

let security_types = [];
let mortgage_types = [];
function loadFields(cb) {
    $.post('proposal/allfields', {}, function (res) {
        let data = JSON.parse(res);
        request_type.setData(data.rtypes);
        customer_type.setData(data.ctypes);
        maritial_status.setData(data.mstatus);
        let ss = [];
        for (var i = 0; i < data.sub_sectors.length; i++) {
            let obj = {
                label: data.sub_sectors[i].label,
                options: JSON.parse(data.sub_sectors[i].options),
            }
            ss.push(obj);
        }
        sub_sector.setData(ss);
        no_of_emps.setData(data.no_of_emps);
        security_types = data.security_types;
        mortgage_types = data.mortgage_types;
        let yn = [{value: "0", text: "NO"}, {value: "1", text: "YES"}]
        sme_eligibility.setData(yn);
        audited.setData(yn);
        form_loaded = true;
        if (cb) {
            cb();
        }
    });
}

$('#audited').change(function () {
    if ($(this).val() === '0') {
        $('#name_of_auditor').parent().hide();
        $('#name_of_auditor').removeAttr('required');
    } else if ($(this).val() === '1') {
        $('#name_of_auditor').parent().show();
        $('#name_of_auditor').attr('required', "");
    }
});

$('#saveProposalBtn').click(function () {
    saveProposal();
});

$('#submitProposalBtn').click(function () {
    saveProposal(true);
});

function saveProposal(submit = false) {
    if ($('#customer_code').val() === 'undefined' || $('#customer_code').val() === null || $('#customer_code').val().trim() === '') {
        Swal.fire('Field Required !', 'Please set a valid value for "Customer !"', 'warning');
        return;
    }

    if ($('#customer_type').val() === 'undefined' || $('#customer_type').val() === null || $('#customer_type').val().trim() === '') {
        Swal.fire('Field Required !', 'Please set a valid value for "Customer Type !"', 'warning');
        return;
    }

    let data = {};
    let validated = true;
    $('#tab-basic-details').find('input[type!=search],select,textarea').each(function () {
        let label = $(this).parents('.form-group').first().find('label').first();
        let attr = $(this).attr('required');
        if (!$(this).hasClass('ignore')) {
            if (submit && typeof attr !== 'undefined' && attr !== false) {
                if ($(this).val() === 'undefined' || $(this).val() === null || $(this).val().trim() === '') {
                    Swal.fire('Field Required !', 'Please set a valid value for "' + $(label).html() + '"', 'warning');
                    validated = false;
                    return false;
                }
                if ($(this).hasClass('autodouble') | $(this).hasClass('autoint')) {
                    data[$(this).attr('id')] = $(this).val().replace(new RegExp(",", 'g'), '');
                } else {
                    data[$(this).attr('id')] = $(this).val();
                }
            } else {
                if ($(this).hasClass('autodouble') | $(this).hasClass('autoint')) {
                    data[$(this).attr('id')] = $(this).val().replace(new RegExp(",", 'g'), '');
                } else {
                    data[$(this).attr('id')] = $(this).val();
                }
            }
        }
    });

    if (!validated) {
        return false;
    }

    //background
    if (submit && operation_details_editor.getText().trim() == '') {
        Swal.fire('Field Required !', 'Please set a valid value for "Operational Details of the Business <span class="text-danger">*</span>"', 'warning');
        $('a[href$="#tab-background"]').trigger('click');
        return;
    }
    data['operation_details'] = operation_details_editor.root.innerHTML;

    if ($('#customer_type').val() && $('#customer_type').val() != '3') {
        if (submit && $('#partners-table').find('tbody').find('tr').length == 0) {
            Swal.fire('Field Required !', 'Please add at least one record for "Proprietor/Partner/Board of Director detail <span class="text-danger">*</span>"', 'warning');
            $('a[href$="#tab-background"]').trigger('click');
            return;
        }
        let partners = [];
        $('#partners-table').find('tbody').find('tr').each(function () {
            let partner = {};
            let td = $(this).find('td');
            let vldt = true;
            $(this).find('input,textarea').each(function () {
                if (submit && $(this).val().trim() === '') {
                    vldt = false;
                    return false;
                }
            });
            if (!vldt) {
                validated = false;
                return false;
            }
            partner.name = $(td).eq(0).find('input').val();
            partner.nic = $(td).eq(1).find('input').val();
            partner.position = $(td).eq(2).find('input').val();
            partner.qualification = $(td).eq(3).find('textarea').val();
            partner.experiance = $(td).eq(4).find('textarea').val();
            partners.push(partner);
        });
        if (!validated) {
            Swal.fire('Incomplete Data !', 'Please fill all fields in "Proprietor/Partner/Board of Director detail <span class="text-danger">*</span>"', 'warning');
            $('a[href$="#tab-background"]').trigger('click');
            return;
        }
        data['partners'] = partners;

        if (submit && $('#shareholder-table').find('tbody').find('tr').length == 0) {
            Swal.fire('Field Required !', 'Please add at least one record for "Shareholding Structure <span class="text-danger">*</span>"', 'warning');
            $('a[href$="#tab-background"]').trigger('click');
            return;
        }
        let shareholders = [];
        $('#shareholder-table').find('tbody').find('tr').each(function () {
            let shareholder = {};
            let td = $(this).find('td');
            shareholder.name = $(td).eq(0).find('input').val();
            shareholder.nic = $(td).eq(1).find('input').val();
            shareholder.precentage = $(td).eq(2).find('input').val().replace(new RegExp(",", 'g'), '');
            shareholders.push(shareholder);
        });
        data['share_holders'] = shareholders;
    }



//    if (submit && $('#declared-assets-company-table').find('tbody').find('tr').length == 0) {
//        Swal.fire('Field Required !', 'Please add at least one record for "Declared Assets of the Company <span class="text-danger">*</span>"', 'warning');
//        $('a[href$="#tab-background"]').trigger('click');
//        return;
//    }
    let company_assets = [];
    $('#declared-assets-company-table').find('tbody').find('tr').each(function () {
        let asset = {};
        let td = $(this).find('td');
        asset.type = $(td).eq(0).find('input').val();
        asset.desc = $(td).eq(1).find('input').val();
        asset.value = $(td).eq(2).find('input').val().replace(new RegExp(",", 'g'), '');
        company_assets.push(asset);
    });
    data['company_assets'] = company_assets;

//    if (submit && $('#declared-assets-partner-table').find('tbody').find('tr').length == 0) {
//        Swal.fire('Field Required !', 'Please add at least one record for "Declared Assets of Proprietor/Partner/Board of Director <span class="text-danger">*</span>"', 'warning');
//        $('a[href$="#tab-background"]').trigger('click');
//        return;
//    }
    let partner_assets = [];
    $('#declared-assets-partner-table').find('tbody').find('tr').each(function () {
        let asset = {};
        let td = $(this).find('td');
        asset.type = $(td).eq(0).find('input').val();
        asset.desc = $(td).eq(1).find('input').val();
        asset.value = $(td).eq(2).find('input').val().replace(new RegExp(",", 'g'), '');
        partner_assets.push(asset);
    });
    data['partner_assets'] = partner_assets;


    //proposition
    if (submit && present_request_editor.getText().trim() == '') {
        Swal.fire('Field Required !', 'Please set a valid value for "Present Request <span class="text-danger">*</span>"', 'warning');
        $('a[href$="#tab-proposition"]').trigger('click');
        return;
    }
    data['present_request'] = present_request_editor.root.innerHTML;

    if (submit && $('#purpose').val().trim() == '') {
        Swal.fire('Field Required !', 'Please set a valid value for "Purpose <span class="text-danger">*</span>"', 'warning');
        $('a[href$="#tab-proposition"]').trigger('click');
        return;
    }
    data['purpose'] = $('#purpose').val();

    if (submit && $('#facility_type').val().trim() == '') {
        Swal.fire('Field Required !', 'Please set a valid value for "Facility type <span class="text-danger">*</span>"', 'warning');
        $('a[href$="#tab-proposition"]').trigger('click');
        return;
    }
    if ($('#facility_type').val()) {
        data['facility_type'] = $('#facility_type').val();
    } else {
        data['facility_type'] = "";
    }

    if (submit && facility_justification_editor.getText().trim() == '') {
        Swal.fire('Field Required !', 'Please set a valid value for "Facility requirement justification <span class="text-danger">*</span>"', 'warning');
        $('a[href$="#tab-proposition"]').trigger('click');
        return;
    }
    data['facility_justification'] = facility_justification_editor.root.innerHTML;

    data['working_capital_facility'] = $('#working_capital_facility').val();

    if ($('#working_capital_facility').val() == 'yes') {
        let working_capital = {};
        $('#table-wc').find("input[id^=WC]").each(function () {
            let value = $(this).val().trim().replace(new RegExp(",", 'g'), '');
            if (submit && value === '') {
                validated = false;
                return false;
            }
            working_capital[$(this).attr("id").split("WC-")[1]] = value;
        });
        data['working_capital'] = working_capital;
    }

    if ($('#working_capital_facility').val() == 'yes' && !validated) {
        Swal.fire('Incomplete Data !', 'Working Capital Requirement <span class="text-danger">*</span>"', 'warning');
        $('a[href$="#tab-proposition"]').trigger('click');
        return;
    }

    //facility details

    if (submit && $('#FAC-total_exp').parent().prevAll().length == 0) {
        Swal.fire('Field Required !', 'Please add at least one record for "Facility Details <span class="text-danger">*</span>"', 'warning');
        $('a[href$="#tab-facility-details"]').trigger('click');
        return;
    }
    let facility_details = [];
    $('#FAC-total_exp').parent().prevAll().each(function () {
        let jo = {};
        let td = $(this).find('td');
        jo.facility = $(td).eq(0).find('select').val();
        jo.e_limits = $(td).eq(1).find('input').val().replace(new RegExp(",", 'g'), '');
        jo.e_os = $(td).eq(2).find('input').val().replace(new RegExp(",", 'g'), '');
        jo.e_pricing = $(td).eq(3).find('input').val().replace(new RegExp(",", 'g'), '');
        jo.e_tenor = $(td).eq(4).find('input').val().replace(new RegExp(",", 'g'), '');
        jo.p_limits = $(td).eq(5).find('input').val().replace(new RegExp(",", 'g'), '');
        jo.p_sub_limit = $(td).eq(6).find('select').val();
        jo.p_pricing = $(td).eq(7).find('input').val().replace(new RegExp(",", 'g'), '');
        jo.p_tenor = $(td).eq(8).find('input').val().replace(new RegExp(",", 'g'), '');
        facility_details.push(jo);

        if (submit) {
            Object.keys(jo).forEach(function (key) {
                if (jo[key] === '') {
                    validated = false;
                    return false;
                }
            });
        }

    });
    data['facility_details'] = facility_details.reverse();

    let fac_total_exp = [];
    let fac_secured_exp = [];
    let fac_unsecured_exp = [];
    let fac_group_total_exp = [];
    let fac_group_secured_exp = [];
    let fac_group_unsecured_exp = [];

    $('#FAC-total_exp').parent().find('input').each(function () {
        if (submit && $(this).val().trim().replace(new RegExp(",", 'g'), '') === '') {
            validated = false;
            return false;
        }
        fac_total_exp.push($(this).val().trim().replace(new RegExp(",", 'g'), ''));
    });
    $('#FAC-secured_exp').parent().find('input').each(function () {
        if (submit && $(this).val().trim().replace(new RegExp(",", 'g'), '') === '') {
            validated = false;
            return false;
        }
        fac_secured_exp.push($(this).val().trim().replace(new RegExp(",", 'g'), ''));
    });
    $('#FAC-unsecured_exp').parent().find('input').each(function () {
        if (submit && $(this).val().trim().replace(new RegExp(",", 'g'), '') === '') {
            validated = false;
            return false;
        }
        fac_unsecured_exp.push($(this).val().replace(new RegExp(",", 'g'), ''));
    });
    $('#FAC-group_total_exp').parent().find('input').each(function () {
        if (submit && $(this).val().trim().replace(new RegExp(",", 'g'), '') === '') {
            validated = false;
            return false;
        }
        fac_group_total_exp.push($(this).val().trim().replace(new RegExp(",", 'g'), ''));
    });
    $('#FAC-group_secured_exp').parent().find('input').each(function () {
        if (submit && $(this).val().trim().replace(new RegExp(",", 'g'), '') === '') {
            validated = false;
            return false;
        }
        fac_group_secured_exp.push($(this).val().replace(new RegExp(",", 'g'), ''));
    });
    $('#FAC-group_unsecured_exp').parent().find('input').each(function () {
        if (submit && $(this).val().trim().replace(new RegExp(",", 'g'), '') === '') {
            validated = false;
            return false;
        }
        fac_group_unsecured_exp.push($(this).val().trim().replace(new RegExp(",", 'g'), ''));
    });

    if (!validated) {
        Swal.fire('Incomplete Data !', 'Facility Details <span class="text-danger">*</span>"', 'warning');
        $('a[href$="#tab-facility-details"]').trigger('click');
        return;
    }

    data['facility_details_data'] = {
        total_exp: fac_total_exp,
        secured_exp: fac_secured_exp,
        unsecured_exp: fac_unsecured_exp,
        group_total_exp: fac_group_total_exp,
        group_secured_exp: fac_group_secured_exp,
        group_unsecured_exp: fac_group_unsecured_exp
    };

    data['facility_details_comment'] = facility_detail_comment_editor.root.innerHTML;

    //security
    if (submit && $('#table-security').find('tbody').find('tr').length == 0) {
        Swal.fire('Field Required !', 'Please add at least one record for "Securities <span class="text-danger">*</span>"', 'warning');
        $('a[href$="#tab-securities"]').trigger('click');
        return;
    }
    let security_data = [];
    $('#table-security').find('tbody').find('tr').each(function () {
        let rec = {};
        let td = $(this).find('td');
        if (td.length == 10) {
            rec.facility = $(td).eq(0).find('select').val();
            let present = {};
            let proposed = {};

            present.security_type = $(td).eq(2).find('select').val();
            present.mortgage_type = $(td).eq(3).find('select').val();
            present.date_of_valuation = $(td).eq(4).find('input').val();
            present.valuer = $(td).eq(5).find('input').val().trim().replace(new RegExp(",", 'g'), '');
            present.market_value = $(td).eq(6).find('input').val().replace(new RegExp(",", 'g'), '');
            present.fsv = $(td).eq(7).find('input').val().replace(new RegExp(",", 'g'), '');
            present.ltv = $(td).eq(8).find('input').val().replace(new RegExp(",", 'g'), '');

            let ntd = $(this).next().find('td');

            proposed.security_type = $(ntd).eq(1).find('select').val();
            proposed.mortgage_type = $(ntd).eq(2).find('select').val();
            proposed.date_of_valuation = $(ntd).eq(3).find('input').val();
            proposed.valuer = $(ntd).eq(4).find('input').val().trim().replace(new RegExp(",", 'g'), '');
            proposed.market_value = $(ntd).eq(5).find('input').val().replace(new RegExp(",", 'g'), '');
            proposed.fsv = $(ntd).eq(6).find('input').val().replace(new RegExp(",", 'g'), '');
            proposed.ltv = $(ntd).eq(7).find('input').val().replace(new RegExp(",", 'g'), '');

            rec.present = present;
            rec.proposed = proposed;
            let ntd1 = $(this).next().next().find('td');
            rec.desc = $(ntd1).eq(1).find('textarea').val();
            security_data.push(rec);

            if (submit) {
                Object.keys(rec).forEach(function (key) {
                    if (rec[key] === '') {
                        validated = false;
                        return false;
                    }
                });
            }
        }
    });
    if (!validated) {
        Swal.fire('Incomplete Data !', 'Securities <span class="text-danger">*</span>"', 'warning');
        $('a[href$="#tab-securities"]').trigger('click');
        return;
    }
    data['security_data'] = security_data;

    data['credit_policy_exception'] = $('#credit_policy_exception').val();

    let security_policy = [];
    $('#table-security-policy').find('tbody').find('tr').each(function () {
        let policy = {};
        let td = $(this).find('td');
        policy.name = $(td).eq(0).find('input').val();
        policy.section = $(td).eq(1).find('textarea').val();
        policy.justification = $(td).eq(2).find('textarea').val();
        security_policy.push(policy);
    });
    data['security_policy'] = security_policy;

    data['offer_letter_details'] = offer_letter_details.root.innerHTML;

    //repayment
//    if (submit && $('#table-covenants').find('tbody').find('tr').length == 0) {
//        Swal.fire('Field Required !', 'Please add at least one record for "Covenants <span class="text-danger">*</span>"', 'warning');
//        $('a[href$="#tab-covenants"]').trigger('click');
//        return;
//    }
    let covenants = [];
    $('#table-covenants').find('tbody').find('tr').each(function () {
        let jo = {};
        let td = $(this).find('td');
        jo.facility = $(td).eq(0).find('select').val().trim();
        jo.covenants = $(td).eq(1).find('textarea').val().trim();
        jo.remarks = $(td).eq(2).find('textarea').val().trim();
        jo.active_from = $(td).eq(3).find('input').val().trim();
        jo.frequency = $(td).eq(4).find('select').val().trim();
        covenants.push(jo);
        if (submit) {
            Object.keys(jo).forEach(function (key) {
                if (jo[key] === '') {
                    validated = false;
                    return false;
                }
            });
        }
    });
    if (!validated) {
        Swal.fire('Incomplete Data !', 'Covenants <span class="text-danger">*</span>"', 'warning');
        $('a[href$="#tab-covenants"]').trigger('click');
        return;
    }
    data['covenants'] = covenants;

    //terms & conditions
    data['terms_and_conditions'] = {
        pre_disbursement: $('#table-tnc').find('tbody').find('tr').eq(0).find('.quills').eq(0).data('editor').root.innerHTML,
        other: $('#table-tnc').find('tbody').find('tr').eq(1).find('.quills').eq(0).data('editor').root.innerHTML
    };

    if (submit && repayment_plan_editor.getText().trim() == '') {
        Swal.fire('Field Required !', 'Please set a valid value for "Repayment Plan <span class="text-danger">*</span>"', 'warning');
        $('a[href$="#tab-covenants"]').trigger('click');
        return;
    }
    data['repayment_plan'] = repayment_plan_editor.root.innerHTML;

//    if (submit && repayment_plan_oferLetter_editor.getText().trim() == '') {
//        Swal.fire('Field Required !', 'Please set a valid value for "Repayment Plan for Offer Letter<span class="text-danger">*</span>"', 'warning');
//        $('a[href$="#tab-covenants"]').trigger('click');
//        return;
//    }
//    data['repayment_plan_oferLetter'] = repayment_plan_oferLetter_editor.root.innerHTML;

    if (submit && repayment_primary_editor.getText().trim() == '') {
        Swal.fire('Field Required !', 'Please set a valid value for "Primary Sources of Repayment <span class="text-danger">*</span>"', 'warning');
        $('a[href$="#tab-covenants"]').trigger('click');
        return;
    }
    data['repayment_primary'] = repayment_primary_editor.root.innerHTML;

    if (submit && repayment_secondary_editor.getText().trim() == '') {
        Swal.fire('Field Required !', 'Please set a valid value for "Secondary Sources of Repayment <span class="text-danger">*</span>"', 'warning');
        $('a[href$="#tab-covenants"]').trigger('click');
        return;
    }
    data['repayment_secondary'] = repayment_secondary_editor.root.innerHTML;

    //financial
    data['financial_justification'] = financial_justification_editor.root.innerHTML;
    data['income_statement'] = income_statement_editor.root.innerHTML;
    data['balance_sheet'] = balance_sheet_editor.root.innerHTML;
    data['projected_financials'] = projected_financials_editor.root.innerHTML;

    //crib data
    let crib_analysis = [];
    let crib_tbl = $('#table-crib').find('tr');
    let crib_cols = $(crib_tbl).eq(0).find('td');
    if (submit && crib_cols.length == 0) {
        Swal.fire('Field Required !', 'Please add at least one record for "CRIB Analysis <span class="text-danger">*</span>"', 'warning');
        $('a[href$="#tab-crib"]').trigger('click');
        return;
    }

    for (var i = 0; i < crib_cols.length; i++) {
        let crib = {};
        crib.applicant = $(crib_tbl).eq(0).find('input').eq(i).val();
        crib.nic = $(crib_tbl).eq(1).find('input').eq(i).val();
        crib.no_of_facility = $(crib_tbl).eq(2).find('input').eq(i).val().replace(new RegExp(",", 'g'), '');
        crib.settled_in_last5 = $(crib_tbl).eq(3).find('input').eq(i).val().replace(new RegExp(",", 'g'), '');
        crib.total_granted = $(crib_tbl).eq(4).find('input').eq(i).val().replace(new RegExp(",", 'g'), '');
        crib.total_outstanding = $(crib_tbl).eq(5).find('input').eq(i).val().replace(new RegExp(",", 'g'), '');
        let days_in_arreas = {};
        days_in_arreas._0_cnt = $(crib_tbl).eq(7).find('input').eq(i * 2).val().replace(new RegExp(",", 'g'), '');
        days_in_arreas._0_os = $(crib_tbl).eq(7).find('input').eq((i * 2) + 1).val().replace(new RegExp(",", 'g'), '');
        days_in_arreas._1_30_cnt = $(crib_tbl).eq(8).find('input').eq(i * 2).val().replace(new RegExp(",", 'g'), '');
        days_in_arreas._1_30_os = $(crib_tbl).eq(8).find('input').eq((i * 2) + 1).val().replace(new RegExp(",", 'g'), '');
        days_in_arreas._30_61_cnt = $(crib_tbl).eq(9).find('input').eq(i * 2).val().replace(new RegExp(",", 'g'), '');
        days_in_arreas._30_61_os = $(crib_tbl).eq(9).find('input').eq((i * 2) + 1).val().replace(new RegExp(",", 'g'), '');
        days_in_arreas._61_90_cnt = $(crib_tbl).eq(10).find('input').eq(i * 2).val().replace(new RegExp(",", 'g'), '');
        days_in_arreas._61_90_os = $(crib_tbl).eq(10).find('input').eq((i * 2) + 1).val().replace(new RegExp(",", 'g'), '');
        days_in_arreas._ov_90_cnt = $(crib_tbl).eq(11).find('input').eq(i * 2).val().replace(new RegExp(",", 'g'), '');
        days_in_arreas._ov_90_os = $(crib_tbl).eq(11).find('input').eq((i * 2) + 1).val().replace(new RegExp(",", 'g'), '');
        days_in_arreas.dishonored_cheques_cnt = $(crib_tbl).eq(12).find('input').eq(i * 2).val().replace(new RegExp(",", 'g'), '');
        days_in_arreas.dishonored_cheques_os = $(crib_tbl).eq(12).find('input').eq((i * 2) + 1).val().replace(new RegExp(",", 'g'), '');
        days_in_arreas.guaranteed_facilities_cnt = $(crib_tbl).eq(13).find('input').eq(i * 2).val().replace(new RegExp(",", 'g'), '');
        days_in_arreas.guaranteed_facilities_os = $(crib_tbl).eq(13).find('input').eq((i * 2) + 1).val().replace(new RegExp(",", 'g'), '');
        crib.inquiries_in_last6m = $(crib_tbl).eq(14).find('input').eq(i).val().replace(new RegExp(",", 'g'), '');
        crib.days_in_arreas = days_in_arreas;
        crib_analysis.push(crib);
        if (submit) {
            Object.keys(crib).forEach(function (key) {
                if (crib[key] === '') {
                    validated = false;
                    return false;
                }
            });
        }
    }
    if (!validated) {
        Swal.fire('Incomplete Data !', 'CRIB Analysis <span class="text-danger">*</span>"', 'warning');
        $('a[href$="#tab-crib"]').trigger('click');
        return;
    }

    let other_financial_commitments_tbl = [];
    $('#other_financial_commitments_table').find('tbody').find('tr').each(function () {
        let asset = {};
        let td = $(this).find('td');
        asset.fcompany = $(td).eq(0).find('input').val();
        asset.ftype = $(td).eq(1).find('input').val();
        asset.flimit = $(td).eq(2).find('input').val();
        asset.fos = $(td).eq(3).find('input').val();
        asset.fsecurity = $(td).eq(4).find('input').val();
        asset.fmonthly_commitments = $(td).eq(5).find('input').val();
        asset.fpast_6months = $(td).eq(6).find('input').val();
        asset.fpast_12months = $(td).eq(7).find('input').val();
        other_financial_commitments_tbl.push(asset);
    });
    data['other_financial_commitments_tbl'] = other_financial_commitments_tbl;

    data['crib_analysis'] = crib_analysis;
    data['irregular_facilities'] = irregular_facilities_editor.root.innerHTML;
    data['other_financial_commitments'] = other_financial_commitments_editor.root.innerHTML;

    //bank statement
    let bank_statement = [];
    if (submit && $('#bank_statements').find('.bank_st_temp').length == 0) {
        Swal.fire('Field Required !', 'Please add at least one record for "Bank Account Statement <span class="text-danger">*</span>"', 'warning');
        $('a[href$="#tab-bankstatement"]').trigger('click');
        return;
    }
    $('#bank_statements').find('.bank_st_temp').each(function () {
        let jo = {};
        jo.bank = $(this).find('select').eq(0).val();
        jo.acc_no = $(this).find('input[type!=search]').eq(0).val();
        let data = [];
        $(this).find('tbody').find('tr').each(function () {
            let obj = {};
            obj.month = $(this).find('input').eq(0).val();
            obj.d_trans = $(this).find('input').eq(1).val().replace(new RegExp(",", 'g'), '');
            obj.d_debit = $(this).find('input').eq(2).val().replace(new RegExp(",", 'g'), '');
            obj.c_trans = $(this).find('input').eq(3).val().replace(new RegExp(",", 'g'), '');
            obj.c_credit = $(this).find('input').eq(4).val().replace(new RegExp(",", 'g'), '');
            data.push(obj);
        });
        jo.data = data;
        bank_statement.push(jo);
        if (submit) {
            Object.keys(jo).forEach(function (key) {
                if (jo[key] === '') {
                    validated = false;
                    return false;
                }
            });
        }
    });
    if (!validated) {
        Swal.fire('Incomplete Data !', 'Bank Account Statement <span class="text-danger">*</span>"', 'warning');
        $('a[href$="#tab-bankstatement"]').trigger('click');
        return;
    }
    data['bank_statement'] = bank_statement;

    //relationship
    if (submit && conduct_of_facilities_editor.getText().trim() == '') {
        Swal.fire('Field Required !', 'Please set a valid value for "Conduct of Facilities <span class="text-danger">*</span>"', 'warning');
        $('a[href$="#tab-relationship"]').trigger('click');
        return;
    }
    data['conduct_of_facilities'] = conduct_of_facilities_editor.root.innerHTML;

    if (submit) {
        $('#table-wallet').find('input').each(function () {
            if ($(this).val().trim() === '') {
                validated = false;
                return false;
            }
        });
    }
    if (!validated) {
        Swal.fire('Incomplete Data !', 'Wallet Information <span class="text-danger">*</span>"', 'warning');
        $('a[href$="#tab-relationship"]').trigger('click');
        return;
    }

    data['wallet_info'] = {
        loan: {
            previous_year: $('#table-wallet').find('tbody').find('tr').first().find('input').eq(0).val().replace(new RegExp(",", 'g'), ''),
            previous_year_actual: $('#table-wallet').find('tbody').find('tr').first().find('input').eq(1).val().replace(new RegExp(",", 'g'), ''),
            projected: $('#table-wallet').find('tbody').find('tr').first().find('input').eq(2).val().replace(new RegExp(",", 'g'), '')
        },
        deposit: {
            previous_year: $('#table-wallet').find('tbody').find('tr').eq(1).find('input').eq(0).val().replace(new RegExp(",", 'g'), ''),
            previous_year_actual: $('#table-wallet').find('tbody').find('tr').eq(1).find('input').eq(1).val().replace(new RegExp(",", 'g'), ''),
            projected: $('#table-wallet').find('tbody').find('tr').eq(1).find('input').eq(2).val().replace(new RegExp(",", 'g'), '')
        },
        fees: {
            previous_year: $('#table-wallet').find('tbody').find('tr').eq(2).find('input').eq(0).val().replace(new RegExp(",", 'g'), ''),
            previous_year_actual: $('#table-wallet').find('tbody').find('tr').eq(2).find('input').eq(1).val().replace(new RegExp(",", 'g'), ''),
            projected: $('#table-wallet').find('tbody').find('tr').eq(2).find('input').eq(2).val().replace(new RegExp(",", 'g'), '')
        }
    };

    data['wallet_cmt'] = wallet_cmt_editor.root.innerHTML;
    if (submit && tnc_editor.getText().trim() == '') {
        Swal.fire('Field Required !', 'Please set a valid value for "Non-Compliance of Terms & Conditions <span class="text-danger">*</span>"', 'warning');
        $('a[href$="#tab-relationship"]').trigger('click');
        return;
    }
    data['tnc'] = tnc_editor.root.innerHTML;

    if (submit && track_record_editor.getText().trim() == '') {
        Swal.fire('Field Required !', 'Please set a valid value for "Track Record with Other Banks <span class="text-danger">*</span>"', 'warning');
        $('a[href$="#tab-relationship"]').trigger('click');
        return;
    }
    data['track_record'] = track_record_editor.root.innerHTML;

    //risk
    data['risk_assesment'] = {
        financial: {
            risk: $('#table-riskassessment').find('tbody').find('tr').eq(0).find('.quills').eq(0).data('editor').root.innerHTML,
            mitigant: $('#table-riskassessment').find('tbody').find('tr').eq(0).find('.quills').eq(1).data('editor').root.innerHTML
        },
        business: {
            risk: $('#table-riskassessment').find('tbody').find('tr').eq(1).find('.quills').eq(0).data('editor').root.innerHTML,
            mitigant: $('#table-riskassessment').find('tbody').find('tr').eq(1).find('.quills').eq(1).data('editor').root.innerHTML
        },
        management: {
            risk: $('#table-riskassessment').find('tbody').find('tr').eq(2).find('.quills').eq(0).data('editor').root.innerHTML,
            mitigant: $('#table-riskassessment').find('tbody').find('tr').eq(2).find('.quills').eq(1).data('editor').root.innerHTML
        },
        structural: {
            risk: $('#table-riskassessment').find('tbody').find('tr').eq(3).find('.quills').eq(0).data('editor').root.innerHTML,
            mitigant: $('#table-riskassessment').find('tbody').find('tr').eq(3).find('.quills').eq(1).data('editor').root.innerHTML
        },
        succession: {
            risk: $('#table-riskassessment').find('tbody').find('tr').eq(4).find('.quills').eq(0).data('editor').root.innerHTML,
            mitigant: $('#table-riskassessment').find('tbody').find('tr').eq(4).find('.quills').eq(1).data('editor').root.innerHTML
        }
    };

    if (submit) {
        $('#table-swot').find('textarea').each(function () {
            if ($(this).val().trim() === '') {
                validated = false;
                return false;
            }
        });
    }

    if (!validated) {
        Swal.fire('Incomplete Data !', 'SWOT Analysis <span class="text-danger">*</span>"', 'warning');
        $('a[href$="#tab-risk"]').trigger('click');
        return;
    }

    data['swot'] = {
        S: $('#table-swot').find('tbody').find('tr').eq(0).find('.quills').data('editor').root.innerHTML,
        W: $('#table-swot').find('tbody').find('tr').eq(1).find('.quills').data('editor').root.innerHTML,
        O: $('#table-swot').find('tbody').find('tr').eq(2).find('.quills').data('editor').root.innerHTML,
        T: $('#table-swot').find('tbody').find('tr').eq(3).find('.quills').data('editor').root.innerHTML
    };

    //console.log($('#rec_user').val());

    if (submit && ($('#rec_user').val() == null || $('#rec_user').val().trim() == '')) {
        Swal.fire('Field Required !', 'Please select a user for "Recommended User <span class="text-danger">*</span>"', 'warning');
        $('a[href$="#tab-recommendation"]').trigger('click');
        return;
    }

    if (submit && ($('#rec_comment').val().trim() == '')) {
        Swal.fire('Field Required !', 'Please select a user for "Recommendation Comment <span class="text-danger">*</span>"', 'warning');
        $('a[href$="#tab-recommendation"]').trigger('click');
        return;
    }

    if ($('#rec_user').val() != null) {
        data['rec_user'] = $('#rec_user').val();
        data['rec_comment'] = $('#rec_comment').val();
    }

    if ($('#saveProposalBtn').data('mode') === 'save') {
        loadDiv($('#proposalrow').find('.card'));
        $.post('proposal/save', {data: JSON.stringify(data), submit: submit}, function (result) {
            console.log(result);
            let res = JSON.parse(result);
            if (res.status === 'success') {
                Swal.fire('Successfull !', res.msg, 'success');
                proposals.ajax.reload();
                $('#tablerow').fadeIn();
                $('#proposalrow').hide();
                clearFields();
            } else if (res.status == 'error') {
                Swal.fire('Error !', res.msg, 'error');
            } else {
                Swal.fire('Error !', 'Something Went Wrong', 'error');
            }
            finishLoadDiv($('#proposalrow').find('.card'));
        });
    } else if ($('#saveProposalBtn').data('mode') === 'update') {
        loadDiv($('#proposalrow').find('.card'));
        data['proposal_id'] = $('#saveProposalBtn').data('id');
        $.post('proposal/update', {data: JSON.stringify(data), submit: submit}, function (result) {
            console.log(result);
            let res = JSON.parse(result);
            if (res.status === 'success') {
                Swal.fire('Successfull !', res.msg, 'success');
                proposals.ajax.reload();
                if (submit) {
                    $('#tablerow').fadeIn();
                    $('#proposalrow').hide();
                    clearFields();
                }
            } else if (res.status == 'error') {
                Swal.fire('Error !', res.msg, 'error');
            } else {
                Swal.fire('Error !', 'Something Went Wrong', 'error');
            }
            finishLoadDiv($('#proposalrow').find('.card'));
        });
}

}

$(document).on('click', '.editproposal', function () {
    if ($(this).find('i').hasClass('text-dark')) {
        // Swal.fire('Error !', res.msg, 'warning');
        return;
    }
    $('#summary').hide();
    $('#saveProposalBtn').data('mode', 'update');
    $('#viewProposalBtn').show();
    loadDiv($('#tablerow').find('.card'));
    let id = $(this).parents('tr').data('id');
    let code = $(this).parents('tr').data('code');
    $('#saveProposalBtn').data('id', id);
    $.post('proposal/get', {code: code}, function (response) {
        let res = JSON.parse(response);
        if (res.status === 'success') {
            if (form_loaded) {
                console.log(res.data);
                clearFields();
                fillData(res.data);
                finishLoadDiv($('#tablerow').find('.card'));
                $('#tablerow').hide();
                $('#proposalrow').fadeIn();
            } else {
                let cb = function () {
                    clearFields();
                    fillData(res.data);
                    finishLoadDiv($('#tablerow').find('.card'));
                    $('#tablerow').hide();
                    $('#proposalrow').fadeIn();
                };
                loadFields(cb);
            }
        } else if (res.status == 'err') {
            Swal.fire('Error !', res.msg, 'error');
            finishLoadDiv($('#tablerow').find('.card'));
        } else {
            Swal.fire('Error !', 'Something Went Wrong', 'error');
            finishLoadDiv($('#tablerow').find('.card'));
        }
    }).fail(function (response) {
        Swal.fire('Error !', response.responseText, 'error');
        finishLoadDiv($('#custblrow').find('.card'));
    });
});

$(document).on('click', '.viewproposal', function () {
    let id = $(this).parents('tr').first().find('td').eq(0).html().trim();
    var win = window.open('view-proposal?id=' + id, '_blank');
    win.focus();
});

function fillData(data) {
    Object.keys(data).forEach(function (key) {
        let el = $(document).find('#' + key);
        if ($(el).is("input") | $(el).is("textarea")) {
            $(el).val(data[key]);
            $(el).trigger('focusout');
        } else if ($(el).is("select")) {
            let select = $(el).data('select');
            if (select) {
                select.set(data[key]);
            }
        } else if ($(el).is("div")) {
            $(el).data('editor').root.innerHTML = data[key];
        }
    });
    if (data.branch) {
        let p = {};
        p.value = data.branch;
        p.text = data.branch_txt;
        let ar = [p];
        select_branch.setData(ar);
        select_branch.set(data.branch);
    }
    if (data.mkt_officer) {
        let p = {};
        p.value = data.mkt_officer;
        p.text = data.mkt_officer_txt;
        let ar = [p];
        mkt_officer.setData(ar);
        mkt_officer.set(data.mkt_officer);
    }
    if (data.customer_code) {
        let p = {};
        p.value = data.customer_code;
        p.text = data.customer_code_txt;
        let ar = [p];
        selectCustomer.setData(ar);
        selectCustomer.set(data.customer_code);
    }

    if (data.joint_customer) {
        let p = {};
        p.value = data.joint_customer;
        p.text = data.joint_customer_txt;
        let ar = [p];
        joint_customer.setData(ar);
        joint_customer.set(data.joint_customer);
    }


    if (data.partners) {
        let jo = data.partners;
        for (var i = 0; i < jo.length; i++) {
            addPartner(jo[i].name, jo[i].nic, jo[i].position, jo[i].qualification, jo[i].experiance);
        }
    }

    if (data.share_holders) {
        let jo = data.share_holders;
        for (var i = 0; i < jo.length; i++) {
            addShareholder(jo[i].name, jo[i].nic, jo[i].precentage);
        }
    }

    if (data.company_assets) {
        let jo = data.company_assets;
        for (var i = 0; i < jo.length; i++) {
            addCompanyAsset(jo[i].type, jo[i].desc, jo[i].value);
        }
    }

    if (data.partner_assets) {
        let jo = data.partner_assets;
        for (var i = 0; i < jo.length; i++) {
            addPartnerAsset(jo[i].type, jo[i].desc, jo[i].value);
        }
    }
    if (data.other_financial_commitments_tbl) {
        let jo = data.other_financial_commitments_tbl;
        for (var i = 0; i < jo.length; i++) {
            addFinancialCommitments(jo[i].fcompany, jo[i].ftype, jo[i].flimit, jo[i].fos, jo[i].fsecurity, jo[i].fmonthly_commitments, jo[i].fpast_6months, jo[i].fpast_12months);
        }
    }

    if (data.working_capital_facility && data.working_capital_facility == 'yes') {
        if (data.working_capital) {
            let jo = data.working_capital;
            Object.keys(jo).forEach(function (key) {
                let inputs = $(document).find('#WC-' + key);
                $(inputs).val(jo[key]);
            });
            $('#table-wc').find('input').trigger('focusout');
        }
    }

    if (data.securities) {
        let jo = data.securities;
        for (var i = 0; i < jo.length; i++) {
            addSecurityRecord(jo[i].facility, jo[i].facility_txt, jo[i].present, jo[i].proposed, jo[i].desc);
        }
//        $('#table-security').find('textarea').each(function () {
//            this.style.height = this.scrollHeight + 'px';
//        });
    }

    if (data.security_policy) {
        let jo = data.security_policy;
        for (var i = 0; i < jo.length; i++) {
            addSecurityPolicy(jo[i].name, jo[i].section, jo[i].justification);
        }
    }

    if (data.covenants) {
        let jo = data.covenants;
        for (var i = 0; i < jo.length; i++) {
            addCovenant(jo[i].facility, jo[i].facility_txt, jo[i].covenants, jo[i].remarks, jo[i].active_from, jo[i].frequency);
        }
    }

    if (data.terms_and_conditions) {
        let jo = data.terms_and_conditions;
        $('#table-tnc').find('tbody').find('tr').eq(0).find('.quills').eq(0).data('editor').root.innerHTML = jo.pre_disbursement;
        $('#table-tnc').find('tbody').find('tr').eq(1).find('.quills').eq(0).data('editor').root.innerHTML = jo.other;
    }

    if (data.crib_analysis) {
        let jo = data.crib_analysis;
        for (var i = 0; i < jo.length; i++) {
            addCribRecord(jo[i].applicant, jo[i].nic, jo[i].no_of_facility, jo[i].settled_in_last5, jo[i].total_granted, jo[i].total_outstanding, jo[i].days_in_arreas, jo[i].inquiries_in_last6m);
        }
    }

    if (data.financials) {
        setFinancials(data.financials);
    }

    if (data.wallet_info) {
        let jo = data.wallet_info;
        $('#table-wallet').find('tbody').find('tr').eq(0).find('input').eq(0).val(jo.loan.previous_year);
        $('#table-wallet').find('tbody').find('tr').eq(0).find('input').eq(1).val(jo.loan.previous_year_actual);
        $('#table-wallet').find('tbody').find('tr').eq(0).find('input').eq(2).val(jo.loan.projected);
        $('#table-wallet').find('tbody').find('tr').eq(1).find('input').eq(0).val(jo.deposit.previous_year);
        $('#table-wallet').find('tbody').find('tr').eq(1).find('input').eq(1).val(jo.deposit.previous_year_actual);
        $('#table-wallet').find('tbody').find('tr').eq(1).find('input').eq(2).val(jo.deposit.projected);
        $('#table-wallet').find('tbody').find('tr').eq(2).find('input').eq(0).val(jo.fees.previous_year);
        $('#table-wallet').find('tbody').find('tr').eq(2).find('input').eq(1).val(jo.fees.previous_year_actual);
        $('#table-wallet').find('tbody').find('tr').eq(2).find('input').eq(2).val(jo.fees.projected);
        $('#table-wallet').find('input').trigger('focusout');
    }
    if (data.risk_assesment) {
        let jo = data.risk_assesment;
        $('#table-riskassessment').find('tbody').find('tr').eq(0).find('.quills').eq(0).data('editor').root.innerHTML = jo.financial.risk;
        $('#table-riskassessment').find('tbody').find('tr').eq(0).find('.quills').eq(1).data('editor').root.innerHTML = jo.financial.mitigant;
        $('#table-riskassessment').find('tbody').find('tr').eq(1).find('.quills').eq(0).data('editor').root.innerHTML = jo.business.risk;
        $('#table-riskassessment').find('tbody').find('tr').eq(1).find('.quills').eq(1).data('editor').root.innerHTML = jo.business.mitigant;
        $('#table-riskassessment').find('tbody').find('tr').eq(2).find('.quills').eq(0).data('editor').root.innerHTML = jo.management.risk;
        $('#table-riskassessment').find('tbody').find('tr').eq(2).find('.quills').eq(1).data('editor').root.innerHTML = jo.management.mitigant;
        $('#table-riskassessment').find('tbody').find('tr').eq(3).find('.quills').eq(0).data('editor').root.innerHTML = jo.structural.risk;
        $('#table-riskassessment').find('tbody').find('tr').eq(3).find('.quills').eq(1).data('editor').root.innerHTML = jo.structural.mitigant;
        $('#table-riskassessment').find('tbody').find('tr').eq(4).find('.quills').eq(0).data('editor').root.innerHTML = jo.succession.risk;
        $('#table-riskassessment').find('tbody').find('tr').eq(4).find('.quills').eq(1).data('editor').root.innerHTML = jo.succession.mitigant;
        $('#table-riskassessment').find('input').trigger('focusout');
    }
    if (data.swot) {
        let jo = data.swot;
        $('#table-swot').find('tbody').find('tr').eq(0).find('.quills').eq(0).data('editor').root.innerHTML = jo.S;
        $('#table-swot').find('tbody').find('tr').eq(1).find('.quills').eq(0).data('editor').root.innerHTML = jo.W;
        $('#table-swot').find('tbody').find('tr').eq(2).find('.quills').eq(0).data('editor').root.innerHTML = jo.O;
        $('#table-swot').find('tbody').find('tr').eq(3).find('.quills').eq(0).data('editor').root.innerHTML = jo.T;
    }

    if (data.bank_statement) {
        let jo = data.bank_statement;
        for (var i = 0; i < jo.length; i++) {
            addBankStatement(jo[i].bank, jo[i].bank_txt, jo[i].acc_no, jo[i].data);
        }
    }

    if (data.facility_details) {
        let jo = data.facility_details;
        for (var i = 0; i < jo.length; i++) {
            addFacilityDetailRecord(jo[i].facility, jo[i].facility_txt, jo[i].e_limits, jo[i].e_os, jo[i].e_pricing, jo[i].e_tenor, jo[i].p_limits, jo[i].p_sub_limit, jo[i].p_pricing, jo[i].p_tenor);
        }
    }

    if (data.facility_details_data) {
        let jo = data.facility_details_data;
        Object.keys(jo).forEach(function (key) {
            let tr = $(document).find('#FAC-' + key).parent();
            $(tr).find('input').each(function (i) {
                $(this).val(jo[key][i]);
                $(this).trigger('focusout');
            });
        });

    }

    fdTotalExp();

    if (data.recommendation) {
        let div = createRecommendation(data.recommendation);
        $('#app_hist_').append(div);
        $('#app_hist_').parent().show();
    } else {
        $('#app_hist_').parent().hide();
    }
}


function createRecommendation(data) {
    let div = document.createElement('div');
    let recommendations = data;
    for (let i = 0; i < recommendations.length; i++) {
        let rec = recommendations[i];

        let action_div = '<div class="chat-header">' + rec.user.name + ' <label class="label label-info" style="white-space: nowrap">Recommended to</label> ' + (rec.fwd_user ? rec.fwd_user.name : '') + '</div>';
        if (rec.action !== 'recommended to') {
            let color = 'label-success';
            if (rec.action == 'returned' | rec.action == 'returned to reverify') {
                color = 'label-warning';
            } else if (rec.action == 'rejected') {
                color = 'label-danger';
            }
            action_div = '<div class="chat-header"> <label class="label ' + color + '" style="white-space: nowrap">' + rec.action + '</label>' + ' - ' + rec.user.name + '</div>';
        }

        let tem = '<div class="col-12"><div class="media">' +
                '<a class="media-left" href="#">' +
                '    <img class="media-object img-radius m-r-10 img-60" onerror="this.onError=null;this.src=\'files/images/user.png\';"  src="userimages/' + rec.user.username + '.jpg">' +
                '</a>' +
                '<div class="media-body b-b-theme social-client-description">' +
                '<span>' + rec.date + '</span>' +
                action_div +
                '<p>' + (rec.comment || '') + '</p>' + (rec.document ? '<a href="proposal/approval-document?file=' + rec.document + '" target="_blank">View Approval Document</a>' : '') +
                '</div>' +
                '</div></div>';

        $(div).append(tem);
    }
    return $(div).html();
}

function setFinancials(data) {
    let jo = data;
    let pnl = jo.pnl;
    let bs = jo.balance_sheet;
    let pnl_prev = null;
    let bs_prev = null;
    if (pnl.length > 4) {
        pnl_prev = pnl[pnl.length - 5];
        bs_prev = pnl[bs.length - 5];
        pnl = pnl.slice(pnl.length - 4);
        bs = bs.slice(bs.length - 4);
    }
    for (var i = 0; i < pnl.length; i++) {
        $('#financial-highlights').find('#fh-finrtype').find('th').eq(i + 1).html(pnl[i].rtype);
        $('#financial-highlights').find('#fh-finyear').find('th').eq((i * 2) + 1).html(pnl[i].year);
        Object.keys(pnl[i]).forEach(function (key) {
            let el = $('#financial-highlights').find('#fh-' + key);
            if (el) {
                let tds = $(el).find('td');
                if (tds.length === 9) {
                    $(el).find('td').eq((i * 2) + 1).html(formatDouble(pnl[i][key]));
                    if (i == 0 && pnl_prev != null) {
                        let a = parseFloat(pnl_prev[key]);
                        let b = parseFloat(pnl[i][key]);
                        $(el).find('td').eq((i * 2) + 2).html(formatDouble(((b - a) / a) * 100) + "%");
                    } else if (i !== 0) {
                        let a = parseFloat(pnl[i - 1][key]);
                        let b = parseFloat(pnl[i][key]);
                        $(el).find('td').eq((i * 2) + 2).html(formatDouble(((b - a) / a) * 100) + "%");
                    }
                } else {
                    if (key == 'current_ratio' | key == 'interest_cover_ratio' | key == 'dscr') {
                        $(el).find('td').eq(i + 1).html(formatDouble(pnl[i][key]) + "");
                    } else {
                        $(el).find('td').eq(i + 1).html(formatDouble(pnl[i][key]) + "%");
                    }
                }

            }
        });
        Object.keys(bs[i]).forEach(function (key) {
            let el = $('#financial-highlights').find('#fh-' + key);
            if (el) {
                let tds = $(el).find('td');
                if (tds.length === 9) {
                    $(el).find('td').eq((i * 2) + 1).html(formatDouble(bs[i][key]));
                    if (i == 0 && pnl_prev != null) {
                        let a = parseFloat(bs_prev[key]);
                        let b = parseFloat(bs[i][key]);
                        $(el).find('td').eq((i * 2) + 2).html(formatDouble(((b - a) / a) * 100) + "%");
                    } else if (i !== 0) {
                        let a = parseFloat(bs[i - 1][key]);
                        let b = parseFloat(bs[i][key]);
                        $(el).find('td').eq((i * 2) + 2).html(formatDouble(((b - a) / a) * 100) + "%");
                    }
                } else {
                    $(el).find('td').eq(i + 1).html(formatDouble(bs[i][key]) + "%");
                }
            }
        });

        let stocks = bs[i]['stocks'];
        let total_current_assets = bs[i]['total_current_assets'];
        let total_current_liabilities = bs[i]['total_current_liabilities'];

        $('#financial-highlights').find('#fh-quick_ratio').find('td').eq(i + 1).html(formatDouble(((stocks - total_current_assets) / total_current_liabilities)) + "");

        let total_liabilities = bs[i]['total_liabilities'];
        let net_worth = bs[i]['net_worth'];
        //edited on 2021-08-02

        let long_term_loans = bs[i]['long_term_loans'];
        let short_term_loans_od = bs[i]['short_term_loans_od'];
        let short_term_loans_tl = bs[i]['short_term_loans_tl'];
        let share_capital = bs[i]['share_capital'];
        let profit_and_lost_balance = bs[i]['profit_and_lost_balance'];
//        $('#financial-highlights').find('#fh-leverage').find('td').eq(i + 1).html(formatDouble((parseFloat(total_liabilities) / (parseFloat(share_capital) + parseFloat(profit_and_lost_balance)))) + "");
//        $('#financial-highlights').find('#fh-gearing').find('td').eq(i + 1).html(formatDouble(((parseFloat(long_term_loans) + parseFloat(short_term_loans_od) + parseFloat(short_term_loans_tl)) / (parseFloat(share_capital) + parseFloat(profit_and_lost_balance)))) + "");
        $('#financial-highlights').find('#fh-leverage').find('td').eq(i + 1).html(formatDouble((parseFloat(total_liabilities) / (parseFloat(net_worth)))) + "");
        $('#financial-highlights').find('#fh-gearing').find('td').eq(i + 1).html(formatDouble(((parseFloat(long_term_loans) + parseFloat(short_term_loans_od) + parseFloat(short_term_loans_tl)) / (parseFloat(net_worth)))) + "");
    }
}

//proposition
function updateCurrentFinancingReq() {
    let a = 0;
    let b = 0;
    let c = 0;
    if (parseFloat($('#WC-stock_balance').val().replace(new RegExp(",", 'g'), ''))) {
        a = parseFloat($('#WC-stock_balance').val().replace(new RegExp(",", 'g'), ''));
    }
    if (parseFloat($('#WC-debtor_balance').val().replace(new RegExp(",", 'g'), ''))) {
        b = parseFloat($('#WC-debtor_balance').val().replace(new RegExp(",", 'g'), ''));
    }
    if (parseFloat($('#WC-creditor_balance').val().replace(new RegExp(",", 'g'), ''))) {
        c = parseFloat($('#WC-creditor_balance').val().replace(new RegExp(",", 'g'), ''));
    }
    $('#WC-current_financing_req').val(a + b + c);
    $('#WC-current_financing_req').trigger('focusout');
}
$(document).on('change', '#WC-stock_balance,#WC-debtor_balance,#WC-creditor_balance', function () {
    updateCurrentFinancingReq();
});

function updateStokingTurnover() {
    let a = 0;
    let b = 0;
    let c = 0;
    if (parseFloat($('#WC-stock_balance').val().replace(new RegExp(",", 'g'), ''))) {
        a = parseFloat($('#WC-stock_balance').val().replace(new RegExp(",", 'g'), ''));
    }
    if (parseFloat($('#WC-cogs').val().replace(new RegExp(",", 'g'), ''))) {
        b = parseFloat($('#WC-cogs').val().replace(new RegExp(",", 'g'), ''));
    }
    $('#WC-stocking_tp1').val((a / b) * 365);
    $('#WC-stocking_tp1').trigger('focusout');
}
$(document).on('change', '#WC-stock_balance,#WC-cogs', function () {
    updateStokingTurnover();
});

function updateDbtorTurnover() {
    let a = 0;
    let b = 0;
    let c = 0;
    if (parseFloat($('#WC-debtor_balance').val().replace(new RegExp(",", 'g'), ''))) {
        a = parseFloat($('#WC-debtor_balance').val().replace(new RegExp(",", 'g'), ''));
    }
    if (parseFloat($('#WC-cogs').val().replace(new RegExp(",", 'g'), ''))) {
        b = parseFloat($('#WC-cogs').val().replace(new RegExp(",", 'g'), ''));
    }
    $('#WC-debtor_tp1').val((a / b) * 365);
    $('#WC-debtor_tp1').trigger('focusout');
}
$(document).on('change', '#WC-debtor_balance,#WC-cogs', function () {
    updateDbtorTurnover();
});

function updateCreditorTurnover() {
    let a = 0;
    let b = 0;
    let c = 0;
    if (parseFloat($('#WC-creditor_balance').val().replace(new RegExp(",", 'g'), ''))) {
        a = parseFloat($('#WC-creditor_balance').val().replace(new RegExp(",", 'g'), ''));
    }
    if (parseFloat($('#WC-cogs').val().replace(new RegExp(",", 'g'), ''))) {
        b = parseFloat($('#WC-cogs').val().replace(new RegExp(",", 'g'), ''));
    }
    $('#WC-credit_tp1').val((a / b) * 365);
    $('#WC-credit_tp1').trigger('focusout');
}
$(document).on('change', '#WC-creditor_balance,#WC-cogs', function () {
    updateCreditorTurnover();
});

$('#addfacilitybtn').click(function () {
    addFacilityDetailRecord();
});

function addFacilityDetailRecord(facility = '', facility_txt = '', e_limits = '', e_os = '', e_pricing = '', e_tenor = '', p_limits = '', p_sub_limit = 'no', p_pricing = '', p_tenor = '') {
    let tr = document.createElement('tr');
    $(tr).append('<td><select></select></td>');
    $(tr).append('<td><input type="text" class="form-control autodouble" value="' + e_limits + '"></td>');
    $(tr).append('<td><input type="text" class="form-control autodouble" value="' + e_os + '"></td>');
    $(tr).append('<td><input type="text" class="form-control autodouble" value="' + e_pricing + '"></td>');
    $(tr).append('<td><input type="text" class="form-control autoint" value="' + e_tenor + '"></td>');
    $(tr).append('<td><input type="text" class="form-control autodouble" value="' + p_limits + '"></td>');
    $(tr).append('<td><select><option value="no">No</option><option value="yes">Yes</option></select></td>');
    $(tr).append('<td><input type="text" class="form-control autodouble" value="' + p_pricing + '"></td>');
    $(tr).append('<td><input type="text" class="form-control autoint" value="' + p_tenor + '"></td>');
    $(tr).append('<td class="text-center"><a href="javascript:void(0)" class="dltbtn"><i class="feather icon-trash-2 f-w-600 f-16 text-danger"></i></a></td>');

    let pr = $(tr).find('select')[0];
    let pr_sel = new SlimSelect({
        select: pr,
        placeholder: "Select a Product",
        ajax: function (search, callback) {
            $.post('proposal/cproducts', {q: search}, function (res) {
                callback(JSON.parse(res));
            });
        },
        allowDeselect: true,
        deselectLabel: '<span class="red">✖</span>'
    });

    pr_sel.setData([{value: facility, text: facility_txt}]);
    pr_sel.set(facility);

    let sl = $(tr).find('select')[1];
    let sl_sel = new SlimSelect({
        select: sl,
        allowDeselect: false,
        deselectLabel: '<span class="red">✖</span>',
        showSearch: false
    });
    sl_sel.set(p_sub_limit);
    $(sl).change(function () {
        fdTotalExp();
    });

    $('#FAC-total_exp').parent().before(tr);
    $(tr).find('.autodouble').autoNumeric();
    $(tr).find('.autoint').autoNumeric({
        mDec: '0'
    });
    $(tr).find('.autodouble').change(function () {
        fdTotalExp();
    });
    fdTotalExp();
}

$('#addSecurityBtn').click(function () {
    addSecurityRecord();
});

function addSecurityRecord(facility = '', faciliy_txt = '', present = {security_type:'', mortgage_type:'', date_of_valuation:'', valuer:'', market_value:'', fsv:'', ltv:''}, proposed = {security_type:'', mortgage_type:'', date_of_valuation:'', valuer:'', market_value:'', fsv:'', ltv:''}, desc = '') {
    let tr = document.createElement('tr');
    $(tr).append('<td rowspan="3"><select></select></td>');
    $(tr).append('<td>Present</td>');
    $(tr).append('<td><select></select></td>');
    $(tr).append('<td><select></select></td>');
    $(tr).append('<td><input type="date" class="form-control" value="' + present.date_of_valuation + '" style="width: 115px;"></td>');
    $(tr).append('<td><input type="text" class="form-control" value="' + present.valuer + '"></td>');
    $(tr).append('<td><input type="text" class="form-control autodouble" value="' + present.market_value + '"></td>');
    $(tr).append('<td><input type="text" class="form-control autodouble" value="' + present.fsv + '"></td>');
    $(tr).append('<td><input type="text" class="form-control autodouble" value="' + present.ltv + '"></td>');
    $(tr).append('<td rowspan="3" class="text-center"><a href="javascript:void(0)" class="dltbtn_se"><i class="feather icon-trash-2 f-w-600 f-16 text-danger"></i></a></td>');
    $('#table-security').find('tbody').append(tr);
    $(tr).find('.autodouble').autoNumeric();

    let pr = $(tr).find('select')[0];
    let pr_sel = new SlimSelect({
        select: pr,
        placeholder: "Please Select",
        ajax: function (search, callback) {
            $.post('proposal/cproducts', {q: search}, function (res) {
                callback(JSON.parse(res));
            });
        },
        allowDeselect: true,
        deselectLabel: '<span class="red">✖</span>'
    });

    if (facility != '') {
        pr_sel.setData([{value: facility, text: faciliy_txt}]);
    }
    pr_sel.set(facility);

    let stype = $(tr).find('select')[1];
    let stype_sel = new SlimSelect({
        select: stype,
        placeholder: "Please Select",
        showSearch: false,
        allowDeselect: true,
        deselectLabel: '<span class="red">✖</span>'
    });
    stype_sel.setData(security_types);
    stype_sel.set(present.security_type);

    let mtype = $(tr).find('select')[2];
    let mtype_sel = new SlimSelect({
        select: mtype,
        placeholder: "Please Select",
        showSearch: false,
        allowDeselect: true,
        deselectLabel: '<span class="red">✖</span>'
    });
    mtype_sel.setData(mortgage_types);
    mtype_sel.set(present.mortgage_type);

    let tr2 = document.createElement('tr');
    $(tr2).append('<td>Proposed</td>');
    $(tr2).append('<td><select></select></td>');
    $(tr2).append('<td><select></select></td>');
    $(tr2).append('<td><input type="date" class="form-control" value="' + proposed.date_of_valuation + '" style="width: 115px;"></td>');
    $(tr2).append('<td><input type="text" class="form-control" value="' + proposed.valuer + '"></td>');
    $(tr2).append('<td><input type="text" class="form-control autodouble" value="' + proposed.market_value + '"></td>');
    $(tr2).append('<td><input type="text" class="form-control autodouble" value="' + proposed.fsv + '"></td>');
    $(tr2).append('<td><input type="text" class="form-control autodouble" value="' + proposed.ltv + '"></td>');
    $('#table-security').find('tbody').append(tr2);
    $(tr2).find('.autodouble').autoNumeric();

    let stype2 = $(tr2).find('select')[0];
    let stype_sel2 = new SlimSelect({
        select: stype2,
        placeholder: "Please Select",
        showSearch: false,
        allowDeselect: true,
        deselectLabel: '<span class="red">✖</span>'
    });
    stype_sel2.setData(security_types);
    stype_sel2.set(proposed.security_type);

    let mtype2 = $(tr2).find('select')[1];
    let mtype_sel2 = new SlimSelect({
        select: mtype2,
        placeholder: "Please Select",
        showSearch: false,
        allowDeselect: true,
        deselectLabel: '<span class="red">✖</span>'
    });
    mtype_sel2.setData(mortgage_types);
    mtype_sel2.set(proposed.mortgage_type);

    let tr3 = document.createElement('tr');
    $(tr3).append('<td>Description of Security</td>');
    $(tr3).append('<td colspan="7"><textarea class="form-control">' + desc + '</textarea></td>');
    $('#table-security').find('tbody').append(tr3);
}

$(document).on('click', '.dltbtn_se', function () {
    $(this).parents('tr').next().next().remove();
    $(this).parents('tr').next().remove();
    $(this).parents('tr').remove();
});


$('#addCovenantsBtn').click(function () {
    addCovenant();
});

function addCovenant(facility = '', facility_txt = '', covenants = '', remarks = '', active_from = '', frequency = '') {
    let tr = document.createElement('tr');
    $(tr).append('<td><select></select></td>');
    $(tr).append('<td><textarea class="form-control">' + covenants + '</textarea></td>');
    $(tr).append('<td><textarea class="form-control">' + remarks + '</textarea></td>');
    $(tr).append('<td><input type="date" class="form-control" value="' + active_from + '"></td>');
    $(tr).append('<td><select><option value="Monthly">Monthly</option><option value="Quarterly">Quarterly</option><option value="Semi Annually">Semi Annually</option><option value="Annually">Annually</option><option value="Pre Disbursement">Pre Disbursement</option><option value="Pre Disbursement & Annually">Pre Disbursement & Annually</option></select></td>');
    $(tr).append('<td class="text-center"><a href="javascript:void(0)" class="dltbtn"><i class="feather icon-trash-2 f-w-600 f-16 text-danger"></i></a></td>');

    let pr = $(tr).find('select')[0];
    let pr_sel = new SlimSelect({
        select: pr,
        placeholder: "Please Select",
        ajax: function (search, callback) {
            $.post('proposal/cproducts', {q: search}, function (res) {
                callback(JSON.parse(res));
            });
        },
        allowDeselect: true,
        deselectLabel: '<span class="red">✖</span>'
    });

    if (facility != '') {
        pr_sel.setData([{value: facility, text: facility_txt}]);
    }
    pr_sel.set(facility);

    let fq = $(tr).find('select')[1];
    let fq_sel = new SlimSelect({
        select: fq,
        placeholder: "Please Select",
        showSearch: false,
        allowDeselect: true,
        deselectLabel: '<span class="red">✖</span>'
    });
    fq_sel.set(frequency);

    $('#table-covenants').find('tbody').append(tr);
}

$('#security_policy_btn').click(function () {
    addSecurityPolicy();
});

function addSecurityPolicy(name = '', section = '', justification = '') {
    let tr = document.createElement('tr');
    $(tr).append(`<td><input type="text" class="form-control" value="${name}"></td>`);
    $(tr).append(`<td><textarea class="form-control">${section}</textarea></td>`);
    $(tr).append(`<td><textarea class="form-control">${justification}</textarea></td>`);
    $(tr).append('<td class="text-center"><a href="javascript:void(0)" class="dltbtn"><i class="feather icon-trash-2 f-w-600 f-16 text-danger"></i></a></td>');
    $('#table-security-policy').find('tbody').append(tr);
}

$('#adincomebtn').click(function () {
    let tr = document.createElement('tr');
    $(tr).append('<td><input type="text" class="form-control"></td>');
    $(tr).append('<td><input type="text" class="form-control autodouble"></td>');
    $(tr).append('<td class="text-center"><a href="javascript:void(0)" class="dltincbtn"><i class="feather icon-trash-2 f-w-600 f-16 text-danger"></i></a></td>');
    $('#table-repaymentplan-imcome').find('tbody').append(tr);
    $(tr).find('.autodouble').autoNumeric();
    $(tr).find('.autodouble').change(function () {
        incomeTotal();
    });
});

function incomeTotal() {
    let tot = 0;
    $('#table-repaymentplan-imcome').find('tbody').find('tr').each(function () {
        if (parseFloat($(this).find('input').eq(1).val().replace(new RegExp(",", 'g'), ''))) {
            tot += parseFloat($(this).find('input').eq(1).val().replace(new RegExp(",", 'g'), ''));
        }
    });
    $('#table-repaymentplan-imcome').find('thead').eq(1).find('th').eq(1).html(formatDouble(tot));
}

$('#addexpencebtn').click(function () {
    let tr = document.createElement('tr');
    $(tr).append('<td><input type="text" class="form-control"></td>');
    $(tr).append('<td><input type="text" class="form-control autodouble"></td>');
    $(tr).append('<td class="text-center"><a href="javascript:void(0)" class="dltexpbtn"><i class="feather icon-trash-2 f-w-600 f-16 text-danger"></i></a></td>');
    $('#table-repaymentplan-expences').find('tbody').append(tr);
    $(tr).find('.autodouble').autoNumeric();
    $(tr).find('.autodouble').change(function () {
        expencesTotal();
    });
});

function expencesTotal() {
    let tot = 0;
    $('#table-repaymentplan-expences').find('tbody').find('tr').each(function () {
        if (parseFloat($(this).find('input').eq(1).val().replace(new RegExp(",", 'g'), ''))) {
            tot += parseFloat($(this).find('input').eq(1).val().replace(new RegExp(",", 'g'), ''));
        }
    });
    $('#table-repaymentplan-expences').find('thead').eq(1).find('th').eq(1).html(formatDouble(tot));
}

$('#addBnkStBtn').click(function () {
    addBankStatement();
});

function addBankStatement(bank = '', bank_txt = '', account_no = '', data = []) {
    var temp = document.getElementById("bank_st_temp");
    var clon = temp.content.cloneNode(true);
    let bnk = $(clon).find('select').eq(0)[0];
    let sel_bnk = new SlimSelect({
        select: bnk,
        placeholder: "Select a bank",
        ajax: function (search, callback) {
            $.post('proposal/financeinstitute', {q: search}, function (res) {
                callback(JSON.parse(res));
            });
        },
        allowDeselect: true,
        deselectLabel: '<span class="red">✖</span>'
    });

    if (bank != '') {
        sel_bnk.setData([{value: bank, text: bank_txt}]);
    }
    sel_bnk.set(bank);
    $(clon).find('input[type!=search]').eq(0).val(account_no);

    let d_trans_tot = 0;
    let d_debit_tot = 0;
    let c_trans_tot = 0;
    let c_credit_tot = 0;
    let cnt = 0;

    for (var i = 0; i < data.length; i++) {
        let tr = $(clon).find('tbody').find('tr').eq(i);
        $(tr).find('input').eq(0).val(data[i].month);
        $(tr).find('input').eq(1).val(data[i].d_trans);
        $(tr).find('input').eq(2).val(data[i].d_debit);
        $(tr).find('input').eq(3).val(data[i].c_trans);
        $(tr).find('input').eq(4).val(data[i].c_credit);
        if (data[i].month) {
            cnt++;
            d_trans_tot += parseFloat(data[i].d_trans.replace(new RegExp(",", 'g'), ''));
            d_debit_tot += parseFloat(data[i].d_debit.replace(new RegExp(",", 'g'), ''));
            c_trans_tot += parseFloat(data[i].c_trans.replace(new RegExp(",", 'g'), ''));
            c_credit_tot += parseFloat(data[i].c_credit.replace(new RegExp(",", 'g'), ''));
        }

    }

    $(clon).find('thead').eq(1).find('tr').first().find('th').eq(1).html(formatInt(d_trans_tot));
    $(clon).find('thead').eq(1).find('tr').first().find('th').eq(2).html(formatDouble(d_debit_tot));
    $(clon).find('thead').eq(1).find('tr').first().find('th').eq(3).html(formatInt(c_trans_tot));
    $(clon).find('thead').eq(1).find('tr').first().find('th').eq(4).html(formatDouble(c_credit_tot));
    $(clon).find('thead').eq(1).find('tr').eq(1).find('th').eq(1).html(formatDouble(d_trans_tot / cnt));
    $(clon).find('thead').eq(1).find('tr').eq(1).find('th').eq(2).html(formatDouble(d_debit_tot / cnt));
    $(clon).find('thead').eq(1).find('tr').eq(1).find('th').eq(3).html(formatDouble(c_trans_tot / cnt));
    $(clon).find('thead').eq(1).find('tr').eq(1).find('th').eq(4).html(formatDouble(c_credit_tot / cnt));

    $(clon).find('.autodouble').autoNumeric({
        digitGroupSeparator: '.',
        decimalCharacter: ',',
        caretPositionOnFocus: 'decimalRight'
    });
    $(clon).find('.autoint').autoNumeric({
        mDec: '0'
    });
    $(clon).find('.autodouble,.autoint').focusout();

    $(clon).find('tbody').find('input').change(function () {
        updateBankStatementTotals($(this).parents('.bank_st_temp').first());
    });

    $('#bank_statements').append(clon);
}

function updateBankStatementTotals(clon) {
    let d_trans_tot = 0;
    let d_debit_tot = 0;
    let c_trans_tot = 0;
    let c_credit_tot = 0;
    let cnt = 0;

    let data = $(clon).find('tbody').find('tr');

    for (var i = 0; i < data.length; i++) {
        let tr = $(data).eq(i);
        if ($(tr).find('input').eq(0).val() != '') {
            cnt++;
            d_trans_tot += parseFloat($(tr).find('input').eq(1).val().replace(new RegExp(",", 'g'), ''));
            d_debit_tot += parseFloat($(tr).find('input').eq(2).val().replace(new RegExp(",", 'g'), ''));
            c_trans_tot += parseFloat($(tr).find('input').eq(3).val().replace(new RegExp(",", 'g'), ''));
            c_credit_tot += parseFloat($(tr).find('input').eq(4).val().replace(new RegExp(",", 'g'), ''));
        }

    }

    $(clon).find('thead').eq(1).find('tr').first().find('th').eq(1).html(formatInt(d_trans_tot));
    $(clon).find('thead').eq(1).find('tr').first().find('th').eq(2).html(formatDouble(d_debit_tot));
    $(clon).find('thead').eq(1).find('tr').first().find('th').eq(3).html(formatInt(c_trans_tot));
    $(clon).find('thead').eq(1).find('tr').first().find('th').eq(4).html(formatDouble(c_credit_tot));
    $(clon).find('thead').eq(1).find('tr').eq(1).find('th').eq(1).html(formatDouble(d_trans_tot / cnt));
    $(clon).find('thead').eq(1).find('tr').eq(1).find('th').eq(2).html(formatDouble(d_debit_tot / cnt));
    $(clon).find('thead').eq(1).find('tr').eq(1).find('th').eq(3).html(formatDouble(c_trans_tot / cnt));
    $(clon).find('thead').eq(1).find('tr').eq(1).find('th').eq(4).html(formatDouble(c_credit_tot / cnt));
}

$('#addCribBtn').click(function () {
    addCribRecord();
});

function addCribRecord(applicant = '', nic = '', no_of_facility = '', settled_in_last5 = '', total_granted = '', total_outstanding = '', days_in_arreas = {_0_cnt:'', _0_os:'', _1_30_cnt:'', _1_30_os:'', _30_61_cnt:'', _30_61_os:'', _61_90_cnt:'', _61_90_os:'', _ov_90_cnt:'', _ov_90_os:'', dishonored_cheques_cnt : '', dishonored_cheques_os:'', guaranteed_facilities_cnt : '', guaranteed_facilities_os : ''}, inquiries_in_last6m = '') {
    let t1 = addCribTxt(true, '', applicant);
    $(t1).css('position', 'relative');
    $(t1).append('<a href="javascript:void(0)" style="position:absolute;right: 10px;z-index:100;top:25%" class="dltCribBtn"><i class="feather icon-trash-2 f-w-600 f-16 text-danger"></i></a>');
    $('#table-crib').find('tr').eq(0).append(t1);
    $('#table-crib').find('tr').eq(1).append(addCribTxt(true, '', nic));
    $('#table-crib').find('tr').eq(2).append(addCribTxt(true, 'autoint', no_of_facility));
    $('#table-crib').find('tr').eq(3).append(addCribTxt(true, 'autoint', settled_in_last5));
    $('#table-crib').find('tr').eq(4).append(addCribTxt(true, 'autodouble', total_granted));
    $('#table-crib').find('tr').eq(5).append(addCribTxt(true, 'autodouble', total_outstanding));
    $('#table-crib').find('tr').eq(6).append('<th>#facilities</th><th>O/s Rs</th>');
    $('#table-crib').find('tr').eq(7).append(addCribTxt(false, 'autoint', days_in_arreas._0_cnt));
    $('#table-crib').find('tr').eq(7).append(addCribTxt(false, 'autodouble', days_in_arreas._0_os));
    $('#table-crib').find('tr').eq(8).append(addCribTxt(false, 'autoint', days_in_arreas._1_30_cnt));
    $('#table-crib').find('tr').eq(8).append(addCribTxt(false, 'autodouble', days_in_arreas._1_30_os));
    $('#table-crib').find('tr').eq(9).append(addCribTxt(false, 'autoint', days_in_arreas._30_61_cnt));
    $('#table-crib').find('tr').eq(9).append(addCribTxt(false, 'autodouble', days_in_arreas._30_61_os));
    $('#table-crib').find('tr').eq(10).append(addCribTxt(false, 'autoint', days_in_arreas._61_90_cnt));
    $('#table-crib').find('tr').eq(10).append(addCribTxt(false, 'autodouble', days_in_arreas._61_90_os));
    $('#table-crib').find('tr').eq(11).append(addCribTxt(false, 'autoint', days_in_arreas._ov_90_cnt));
    $('#table-crib').find('tr').eq(11).append(addCribTxt(false, 'autodouble', days_in_arreas._ov_90_os));
    $('#table-crib').find('tr').eq(12).append(addCribTxt(false, 'autoint', days_in_arreas.dishonored_cheques_cnt));
    $('#table-crib').find('tr').eq(12).append(addCribTxt(false, 'autodouble', days_in_arreas.dishonored_cheques_os));
    $('#table-crib').find('tr').eq(13).append(addCribTxt(false, 'autoint', days_in_arreas.guaranteed_facilities_cnt));
    $('#table-crib').find('tr').eq(13).append(addCribTxt(false, 'autodouble', days_in_arreas.guaranteed_facilities_os));
    $('#table-crib').find('tr').eq(14).append(addCribTxt(true, 'autoint', inquiries_in_last6m));
}

function addCribTxt(colspan, cls, value) {
    let td = document.createElement('td');
    if (colspan) {
        $(td).attr('colspan', '2');
    }
    let inpt = document.createElement('input');
    $(inpt).addClass('form-control');
    $(inpt).attr('type', 'text');
    $(inpt).addClass(cls);
    $(inpt).val(value);
    $(td).append(inpt);

    $(td).find('.autodouble').autoNumeric({
        digitGroupSeparator: '.',
        decimalCharacter: ',',
        caretPositionOnFocus: 'decimalRight'
    });
    $(td).find('.autoint').autoNumeric({
        mDec: '0'
    });
    $(td).find('.autodouble,.autoint').focusout();

    return td;
}

$(document).on('click', '.dltCribBtn', function () {
    let x = $(this).parent().index();
    $('#table-crib').find("tr").each(function () {
        if ($(this).children().eq(x).attr('colspan')) {
            $(this).children().eq(x).remove();
        } else {
            $(this).children().eq(x).remove();
            $(this).children().eq(x).remove();
        }
    });
});


//bank statement totals
function BnkTotal() {
    let cr = 0;
    let crt = 0;
    let drt = 0;
    $('#table-bankstatement').find('tbody').find('tr').each(function () {
        let v1 = $(this).find('td').eq(3).find('input').val().replace(new RegExp(",", 'g'), '');
        if (parseFloat(v1)) {
            cr += parseFloat(v1);
        }
        let v2 = $(this).find('td').eq(4).find('input').val().replace(new RegExp(",", 'g'), '');
        if (parseFloat(v2)) {
            crt += parseFloat(v2);
        }
        let v3 = $(this).find('td').eq(5).find('input').val().replace(new RegExp(",", 'g'), '');
        if (parseFloat(v3)) {
            drt += parseFloat(v3);
        }
    });
    $('#table-bankstatement').find('thead').eq(1).find('th').eq(3).html(formatDouble(cr));
    $('#table-bankstatement').find('thead').eq(1).find('th').eq(4).html(formatDouble(crt));
    $('#table-bankstatement').find('thead').eq(1).find('th').eq(5).html(formatDouble(drt));
    // alert(cr);
}


//totls
function fdTotalExp() {
    let e_limit = 0;
    let e_os = 0;
    let p_limit = 0;
    $('#FAC-total_exp').parent().prevAll().each(function () {
        e_os += parseFloat($(this).find('input[type!=search]').eq(1).val().replace(new RegExp(",", 'g'), ''));
        if ($(this).find('select').eq(1).val() === 'no') {
            e_limit += parseFloat($(this).find('input[type!=search]').eq(0).val().replace(new RegExp(",", 'g'), ''));
            p_limit += parseFloat($(this).find('input[type!=search]').eq(4).val().replace(new RegExp(",", 'g'), ''));
        }
    });

    $('#FAC-total_exp').parent().find('input[type!=search]').eq(0).val(e_limit);
    $('#FAC-total_exp').parent().find('input[type!=search]').eq(1).val(e_os);
    $('#FAC-total_exp').parent().find('input[type!=search]').eq(2).val(p_limit);
    $('#FAC-total_exp').parent().find('input[type!=search]').focusout();

    fdUnsecuredExp();
}

function fdUnsecuredExp() {
    let vals = [];
    $('#FAC-total_exp').parent().find('input').each(function () {
        if (parseFloat($(this).val().replace(new RegExp(",", 'g'), ''))) {
            vals.push(parseFloat($(this).val().replace(new RegExp(",", 'g'), '')));
        } else {
            vals.push(0);
        }
    });

    $('#FAC-secured_exp').parent().find('input').each(function (i) {
        if (parseFloat($(this).val().replace(new RegExp(",", 'g'), ''))) {
            vals[i] -= parseFloat($(this).val().replace(new RegExp(",", 'g'), ''));
        }
    });

    let tar = $('#FAC-unsecured_exp').parent().find('input[type!=search]');
    for (var i = 0; i < tar.length; i++) {
        $(tar).eq(i).val(vals[i]);
        $(tar).trigger('focusout');
    }
}

function fdGroupUnsecuredExp() {
    let vals = [];
    $('#FAC-group_total_exp').parent().find('input').each(function () {
        if (parseFloat($(this).val().replace(new RegExp(",", 'g'), ''))) {
            vals.push(parseFloat($(this).val().replace(new RegExp(",", 'g'), '')));
        } else {
            vals.push(0);
        }
    });

    $('#FAC-group_secured_exp').parent().find('input').each(function (i) {
        if (parseFloat($(this).val().replace(new RegExp(",", 'g'), ''))) {
            vals[i] -= parseFloat($(this).val().replace(new RegExp(",", 'g'), ''));
        }
    });

    let tar = $('#FAC-group_unsecured_exp').parent().find('input[type!=search]');
    for (var i = 0; i < tar.length; i++) {
        $(tar).eq(i).val(vals[i]);
        $(tar).trigger('focusout');
    }
}

$('#FAC-secured_exp').parent().find('input').change(function () {
    fdUnsecuredExp();
});

$('#FAC-group_total_exp').parent().find('input').change(function () {
    fdGroupUnsecuredExp();
});
$('#FAC-group_secured_exp').parent().find('input').change(function () {
    fdGroupUnsecuredExp();
});

function walletTotal() {
    let pro = 0;
    let ly = 0;
    let py = 0;
    $('#table-wallet').find('tbody').find('tr').each(function () {
        if (parseFloat($(this).find('input').eq(0).val().replace(new RegExp(",", 'g'), ''))) {
            pro += parseFloat($(this).find('input').eq(0).val().replace(new RegExp(",", 'g'), ''));
        }
        if (parseFloat($(this).find('input').eq(1).val().replace(new RegExp(",", 'g'), ''))) {
            ly += parseFloat($(this).find('input').eq(1).val().replace(new RegExp(",", 'g'), ''));
        }
        if (parseFloat($(this).find('input').eq(2).val().replace(new RegExp(",", 'g'), ''))) {
            py += parseFloat($(this).find('input').eq(2).val().replace(new RegExp(",", 'g'), ''));
        }
    });
    $('#table-wallet').find('thead').eq(1).find('th').eq(1).html(formatDouble(pro));
    $('#table-wallet').find('thead').eq(1).find('th').eq(2).html(formatDouble(ly));
    $('#table-wallet').find('thead').eq(1).find('th').eq(3).html(formatDouble(py));
}

$('#table-wallet').find('.autodouble').change(function () {
    walletTotal();
});

var operation_details_editor = null;
var present_request_editor = null;
var facility_justification_editor = null;
var facility_detail_comment_editor = null;
//var security_desc_editor = null;
var repayment_plan_editor = null;
//var repayment_plan_oferLetter_editor = null;
var repayment_primary_editor = null;
var repayment_secondary_editor = null;
var irregular_facilities_editor = null;
var other_financial_commitments_editor = null;
var conduct_of_facilities_editor = null;
var wallet_cmt_editor = null;
var tnc_editor = null;
var track_record_editor = null;
var financial_justification_editor = null;
var income_statement_editor = null;
var balance_sheet_editor = null;
var projected_financials_editor = null;

document.addEventListener("DOMContentLoaded", function () {
    Quill.register({"modules/better-table": quillBetterTable}, true);
    operation_details_editor = setQuill('#operation_details');
    present_request_editor = setQuill('#present_request');
    facility_justification_editor = setQuill('#facility_justification');
    facility_detail_comment_editor = setQuill('#facility_details_comment');
    //security_desc_editor = setQuill('#security_desc');
    repayment_plan_editor = setQuill('#repayment_plan');
    //repayment_plan_oferLetter_editor = setQuill('#repayment_plan_oferLetter');
    repayment_primary_editor = setQuill('#repayment_primary');
    repayment_secondary_editor = setQuill('#repayment_secondary');
    irregular_facilities_editor = setQuill('#irregular_facilities');
    other_financial_commitments_editor = setQuill('#other_financial_commitments');
    conduct_of_facilities_editor = setQuill('#conduct_of_facilities');
    wallet_cmt_editor = setQuill('#wallet_cmt');
    tnc_editor = setQuill('#tnc');
    track_record_editor = setQuill('#track_record');
    financial_justification_editor = setQuill('#financial_justification');
    income_statement_editor = setQuill('#income_statement');
    balance_sheet_editor = setQuill('#balance_sheet');
    projected_financials_editor = setQuill('#projected_financials');
    offer_letter_details = setQuill('#offer_letter_details');

    $('.quills').each(function () {
        setQuillSimple(this);
    });

});


function setQuill(id) {
    let options = [
        ['bold', 'italic', 'underline', 'strike'],
        [{'header': [1, 2, 3, 4, 5, 6, false]}],
        [{'list': 'ordered'}, {'list': 'bullet'}],
        [{'script': 'sub'}, {'script': 'super'}],
        [{'indent': '-1'}, {'indent': '+1'}],
        [{'size': ['small', false, 'large', 'huge']}],
        [{'color': []}, {'background': []}],
    ];
    let editor = new Quill(id, {
        modules: {
            toolbar: options,
            table: false,
            'better-table': {
                operationMenu: {
                    items: {
                        unmergeCells: {
                            text: 'Another unmerge cells name'
                        }
                    },
                    color: {
                        colors: ['green', 'red', 'yellow', 'blue', 'white'],
                        text: 'Background Colors:'
                    }
                }
            }
        },
        theme: "snow"
    });
    let tblbtn = document.createElement('span');
    $(tblbtn).addClass('ql-formats');
    $(tblbtn).html(`<span class="ql-picker "><span class="ql-picker-label" tabindex="0" role="button" aria-expanded="false" aria-controls="ql-picker-options-2"><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 445 445" style="enable-background:new 0 0 445 445;" xml:space="preserve">
        <path d="M0,37.215v55v15v300.57h445v-300.57v-15v-55H0z M276.667,277.595H168.333v-70.19h108.334V277.595z M306.667,207.405H415
	v70.19H306.667V207.405z M276.667,307.595v70.19H168.333v-70.19H276.667z M30,207.405h108.333v70.19H30V207.405z M168.333,177.405
	v-70.19h108.334v70.19H168.333z M138.333,107.215v70.19H30v-70.19H138.333z M30,307.595h108.333v70.19H30V307.595z M306.667,377.785
	v-70.19H415v70.19H306.667z M415,177.405H306.667v-70.19H415V177.405z"></path><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g>
        </svg></span><span class="ql-picker-options" aria-hidden="true" tabindex="-1" id="ql-picker-options-2"><span tabindex="0" role="button" class="ql-picker-item ql-primary"></span><span tabindex="0" role="button" class="ql-picker-item ql-primary" data-value="#e60000" style="background-color: rgb(230, 0, 0);"></span><span tabindex="0" role="button" class="ql-picker-item ql-primary" data-value="#ff9900" style="background-color: rgb(255, 153, 0);"></span><span tabindex="0" role="button" class="ql-picker-item ql-primary" data-value="#ffff00" style="background-color: rgb(255, 255, 0);"></span><span tabindex="0" role="button" class="ql-picker-item ql-primary" data-value="#008a00" style="background-color: rgb(0, 138, 0);"></span><span tabindex="0" role="button" class="ql-picker-item ql-primary" data-value="#0066cc" style="background-color: rgb(0, 102, 204);"></span><span tabindex="0" role="button" class="ql-picker-item ql-primary" data-value="#9933ff" style="background-color: rgb(153, 51, 255);"></span><span tabindex="0" role="button" class="ql-picker-item" data-value="#ffffff" style="background-color: rgb(255, 255, 255);"></span><span tabindex="0" role="button" class="ql-picker-item" data-value="#facccc" style="background-color: rgb(250, 204, 204);"></span><span tabindex="0" role="button" class="ql-picker-item" data-value="#ffebcc" style="background-color: rgb(255, 235, 204);"></span><span tabindex="0" role="button" class="ql-picker-item" data-value="#ffffcc" style="background-color: rgb(255, 255, 204);"></span><span tabindex="0" role="button" class="ql-picker-item" data-value="#cce8cc" style="background-color: rgb(204, 232, 204);"></span><span tabindex="0" role="button" class="ql-picker-item" data-value="#cce0f5" style="background-color: rgb(204, 224, 245);"></span><span tabindex="0" role="button" class="ql-picker-item" data-value="#ebd6ff" style="background-color: rgb(235, 214, 255);"></span><span tabindex="0" role="button" class="ql-picker-item" data-value="#bbbbbb" style="background-color: rgb(187, 187, 187);"></span><span tabindex="0" role="button" class="ql-picker-item" data-value="#f06666" style="background-color: rgb(240, 102, 102);"></span><span tabindex="0" role="button" class="ql-picker-item" data-value="#ffc266" style="background-color: rgb(255, 194, 102);"></span><span tabindex="0" role="button" class="ql-picker-item" data-value="#ffff66" style="background-color: rgb(255, 255, 102);"></span><span tabindex="0" role="button" class="ql-picker-item" data-value="#66b966" style="background-color: rgb(102, 185, 102);"></span><span tabindex="0" role="button" class="ql-picker-item" data-value="#66a3e0" style="background-color: rgb(102, 163, 224);"></span><span tabindex="0" role="button" class="ql-picker-item" data-value="#c285ff" style="background-color: rgb(194, 133, 255);"></span><span tabindex="0" role="button" class="ql-picker-item" data-value="#888888" style="background-color: rgb(136, 136, 136);"></span><span tabindex="0" role="button" class="ql-picker-item" data-value="#a10000" style="background-color: rgb(161, 0, 0);"></span><span tabindex="0" role="button" class="ql-picker-item" data-value="#b26b00" style="background-color: rgb(178, 107, 0);"></span><span tabindex="0" role="button" class="ql-picker-item" data-value="#b2b200" style="background-color: rgb(178, 178, 0);"></span><span tabindex="0" role="button" class="ql-picker-item" data-value="#006100" style="background-color: rgb(0, 97, 0);"></span><span tabindex="0" role="button" class="ql-picker-item" data-value="#0047b2" style="background-color: rgb(0, 71, 178);"></span><span tabindex="0" role="button" class="ql-picker-item" data-value="#6b24b2" style="background-color: rgb(107, 36, 178);"></span><span tabindex="0" role="button" class="ql-picker-item" data-value="#444444" style="background-color: rgb(68, 68, 68);"></span><span tabindex="0" role="button" class="ql-picker-item" data-value="#5c0000" style="background-color: rgb(92, 0, 0);"></span><span tabindex="0" role="button" class="ql-picker-item" data-value="#663d00" style="background-color: rgb(102, 61, 0);"></span><span tabindex="0" role="button" class="ql-picker-item" data-value="#666600" style="background-color: rgb(102, 102, 0);"></span><span tabindex="0" role="button" class="ql-picker-item" data-value="#003700" style="background-color: rgb(0, 55, 0);"></span><span tabindex="0" role="button" class="ql-picker-item" data-value="#002966" style="background-color: rgb(0, 41, 102);"></span><span tabindex="0" role="button" class="ql-picker-item" data-value="#3d1466" style="background-color: rgb(61, 20, 102);"></span></span></span>`);

    $(id).prev('.ql-toolbar').append(tblbtn);

    let table = editor.getModule('better-table');

    tblbtn.addEventListener('click', function () {
        table.insertTable(2, 2);
    });

    $(id).data('editor', editor);
    return editor;
}

function setQuillSimple(id) {

    let editor = new Quill(id, {
        modules: {
            toolbar: false,
        },
        theme: "snow"
    });

    $(id).data('editor', editor);
    return editor;
}

$('#viewProposalBtn').click(function () {
    var win = window.open('view-proposal?id=' + $('#saveProposalBtn').data('id'), '_blank');
    win.focus();
});