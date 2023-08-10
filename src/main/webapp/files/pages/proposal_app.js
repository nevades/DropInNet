//config
$.fn.dataTable.ext.errMode = 'none';
var form_loaded = false;
$('.pt1,.pt2,.pt3').hide();

$('.autodouble').autoNumeric({

});
$('.autoint').autoNumeric({
    mDec: '0'
});
$('.autoyear').autoNumeric({
    aSep: '',
    mDec: '0',
    vMax: "9999",
    vMin: "0"
});

//main table
let proposals = $('#maintable').DataTable({
    "bLengthChange": true,
    "bInfo": true,
    "aLengthMenu": [[5, 10, 15], [5, 10, 15]],
    "pageLength": 10,
    "ordering": true,
    "autoWidth": false,
    "processing": true,
    "serverSide": true,
    "order": [[5, "desc"]],
    "ajax": {
        "url": "proposal/searchpending",
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
        {"data": "id", visible: false},
        {"data": "code"},
        {"data": "req_type"},
        {"data": "cus_type"},
        {"data": "cus"},
        {"data": "last_action"},
    ], "language": {
        'loadingRecords': '&nbsp;',
        'processing': '<div class="loader2"></div>'
    }, "createdRow": function (row, data) {
        $(row).data('id', data['id']);
        let action_td = document.createElement('td');
        $(action_td).addClass('text-center');
        $(action_td).append('<a href="javascript:void(0)" class="approvebtn"><i class="icon feather icon-check-circle f-w-600 f-16 m-r-10 text-c-blue"></i></a>');

        $(row).append(action_td);
    }
});


var action = new SlimSelect({
    select: '#action',
    placeholder: "Select an Option",
    allowDeselect: true,
    deselectLabel: '<span class="red">✖</span>',
    showSearch: false,
});
//$('#action').data('select', action);

var fwd_to = new SlimSelect({
    select: '#fwd_to',
    placeholder: "Select an User",
    ajax: function (search, callback) {
        $.post('proposal/searchUser', {q: search}, function (res) {
            callback(JSON.parse(res));
        });
    },
    allowDeselect: true,
    deselectLabel: '<span class="red">✖</span>'
});
$('#fwd_to').data('select', fwd_to);


$('.cls-card').click(function () {
    $('#tablerow').fadeIn();
    $('#proposalrow').hide();
});

function clearFields() {
    $('#tab-basic-details').find('input[type!=search],textarea').each(function () {
        $(this).val("");
    });

    $('#partners-table').find('tbody').html('');
    $('#table-facilities').find('tbody').find('tr').each(function () {
        if ($(this).find('select').length > 0) {
            $(this).remove();
        }
    });
    $('#financial-highlights').find('tbody').find('tr').each(function () {
        $(this).find('td').slice(1).html('');
    });
    $('#table-facilities').find('tbody').find('tr').each(function () {
        let attr = $(this).children().first().attr('id');
        if (typeof attr !== 'undefined' && attr !== false) {
            return false;
        }
        $(this).remove();
    });
    $('#shareholder-table').find('tbody').html('');
    $('#financial-commitments').find('tbody').html('');
    $('#app_hist_table').find('tbody').html('');
    $('#mda').find('tbody').html('');
    $('#app_hist_').html('');
    action.set(0);
    fwd_to.set(0);
}

$(document).on('click', '.approvebtn', function () {
    loadDiv($('#tablerow').find('.card'));
    let code = $(this).parents('tr').first().find('td').eq(0).html().trim();
    let id = $(this).parents('tr').data('id');
    $('#submitbtn').data('id', id);
    $.post('proposal/get_app', {code: code}, function (response) {
        let res = JSON.parse(response);
        if (res.status === 'success') {
            finishLoadDiv('#crd');
            console.log(res);
            clearFields();
            fillData(res.data);
            $('#tablerow').hide();
            $('#proposalrow').fadeIn();
            finishLoadDiv($('#tablerow').find('.card'));
        } else if (res.status == 'err') {
            Swal.fire('Error !', res.msg, 'error');
            finishLoadDiv($('#tablerow').find('.card'));
        } else {
            Swal.fire('Error !', 'Something Went Wrong', 'error');
            finishLoadDiv($('#tablerow').find('.card'));
        }
    }).fail(function (response) {
        Swal.fire('Error !', response.responseText, 'error');
        finishLoadDiv($('#tablerow').find('.card'));
    });

});


function formatDouble(val) {
    if (parseFloat(val)) {
        // return parseFloat(val).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
        return parseFloat(val).toLocaleString('en-US', {minimumFractionDigits: 0, maximumFractionDigits: 2});
    } else {
        return val;
    }
}

function formatInt(val) {
    if (parseInt(val)) {
        //return parseInt(val).toString().replace(/\d(?=(\d{3})+\.)/g, '$&,');
        return parseInt(val).toLocaleString('en-US', {maximumFractionDigits: 0});
    } else {
        return val;
    }
}

function fillCusType(data) {
    if (data.customer_type == '1') {
        let temp = document.getElementById("custype1_temp");
        let clone = temp.content.cloneNode(true);
        let p = $(clone).find('td');
        $(p).eq(0).html(data.legal_state);
        $(p).eq(1).html(data.address);
        $(p).eq(2).html(data.sector_txt);
        $(p).eq(3).html(data.sub_sector_txt);
        $(p).eq(4).html(data.current_business_activity);
        $(p).eq(5).html(data.other_business);
        $(p).eq(6).html(data.cur_experiance + " Years");
        $(p).eq(7).html(data.tot_experiance + " Years");
        $(p).eq(8).html(data.no_of_emps_txt);
        $(p).eq(9).html(" As of - " + data.annual_turnover_asat + " <br>LKR - " + formatDouble(data.annual_turnover_amt));
        $(p).eq(10).html(" As of - " + data.annual_income_asat + " <br>LKR - " + formatDouble(data.annual_income_amt));
        $(p).eq(11).html(" As of - " + data.other_income_asat + " <br>LKR - " + formatDouble(data.other_income_amt));
        if (data.audited == '0') {
            $(p).eq(12).html('No');
        } else {
            $(p).eq(12).html('Yes');
            $(p).eq(13).html(data.name_of_auditor);
        }
        $(p).eq(14).html(data.current_risk_rating);
        $(p).eq(15).html(data.proposed_risk_rating);
        $('#infotable').append(clone);
    } else if (data.customer_type == '2') {
        let temp = document.getElementById("custype2_temp");
        let clone = temp.content.cloneNode(true);
        let p = $(clone).find('td');
        $(p).eq(0).html(data.business_name);
        $(p).eq(1).html(data.legal_state);
        $(p).eq(2).html(data.address);
        $(p).eq(3).html(data.age + " / " + data.maritial_status_txt);
        $(p).eq(4).html(data.dependant_cnt);
        $(p).eq(5).html(data.sector_txt);
        $(p).eq(6).html(data.sub_sector_txt);
        $(p).eq(7).html(data.current_business_activity);
        $(p).eq(8).html(data.other_business);
        $(p).eq(9).html(data.cur_experiance + " Years");
        $(p).eq(10).html(data.tot_experiance + " Years");
        $(p).eq(11).html(data.no_of_emps_txt);
        $(p).eq(12).html(" As of - " + data.annual_turnover_asat + " <br>LKR - " + formatDouble(data.annual_turnover_amt));
        $(p).eq(13).html(" As of - " + data.annual_income_asat + " <br>LKR - " + formatDouble(data.annual_income_amt));
        $(p).eq(14).html(" As of - " + data.other_income_asat + " <br>LKR - " + formatDouble(data.other_income_amt));
        if (data.audited == '0') {
            $(p).eq(15).html('No');
        } else {
            $(p).eq(15).html('Yes');
            $(p).eq(16).html(data.name_of_auditor);
        }
        $(p).eq(17).html(data.current_risk_rating);
        $(p).eq(18).html(data.proposed_risk_rating);
        $('#infotable').append(clone);
    } else if (data.customer_type == '3') {
        let temp = document.getElementById("custype3_temp");
        let clone = temp.content.cloneNode(true);
        let p = $(clone).find('td');
        $(p).eq(0).html(data.address);
        $(p).eq(1).html(data.age + ' / ' + data.maritial_status_txt);
        $(p).eq(2).html(data.dependant_cnt);
        $(p).eq(3).html(data.current_designation);
        $(p).eq(4).html(data.employer_name);
        $(p).eq(5).html(data.cur_experiance_3 + " Years");
        $(p).eq(6).html(data.tot_experiance_3 + " Years");
        $(p).eq(7).html(" As of - " + data.annual_income_asat + " <br>LKR - " + formatDouble(data.annual_income_amt));
        $(p).eq(8).html(" As of - " + data.other_income_asat + " <br>LKR - " + formatDouble(data.other_income_amt));
        $(p).eq(9).html(data.current_risk_rating);
        $(p).eq(10).html(data.proposed_risk_rating);
        $('#infotable').append(clone);
    }
}

function fillData(data) {

    if (data.cus) {
        let cus = data.cus;
        $('#infotable td').eq(0).find('label[name=customer_code]').text(cus.code);
        $('#infotable td').eq(0).find('label[name=customer_txt]').text(cus.name);
        $('#infotable td').eq(0).find('label[name=nic]').text(cus.nic);
        $('#infotable td').eq(0).find('label[name=address]').text(cus.address);
        $('#infotable td').eq(0).find('label[name=dscr]').text(cus.dscr);
    }

    if (data.jcus) {
        let cus = data.jcus;
        $('#infotable td').eq(1).find('label[name=customer_code]').text(cus.code);
        $('#infotable td').eq(1).find('label[name=customer_txt]').text(cus.name);
        $('#infotable td').eq(1).find('label[name=nic]').text(cus.nic);
        $('#infotable td').eq(1).find('label[name=address]').text(cus.address);
        $('#infotable td').eq(1).find('label[name=dscr]').text(cus.dscr);
    } else {
        $('#infotable tr').eq(1).hide();
    }

    $('.pt' + data['customer_type']).show();

    Object.keys(data).forEach(function (key) {
        let el = $(document).find('#' + key);
        $(el).html(data[key]);
    });

    fillCusType(data);

    if (data.partners) {
        let jo = data.partners;
        for (var i = 0; i < jo.length; i++) {
            let tr = document.createElement('tr');
            $(tr).append('<td>' + jo[i].name + '</td>');
            $(tr).append('<td>' + jo[i].nic + '</td>');
            $(tr).append('<td>' + jo[i].position + '</td>');
            $(tr).append('<td>' + jo[i].qualification + '</td>');
            $(tr).append('<td>' + jo[i].experiance + '</td>');
            $('#partners-table').find('tbody').append(tr);
        }
    }

    if (data.share_holders) {
        let jo = data.share_holders;
        for (var i = 0; i < jo.length; i++) {
            let tr = document.createElement('tr');
            $(tr).append('<td>' + jo[i].name + '</td>');
            $(tr).append('<td>' + jo[i].nic + '</td>');
            $(tr).append('<td class="text-right">' + formatDouble(jo[i].precentage) + '</td>');
            $('#shareholder-table').find('tbody').append(tr);
        }
    }

    if (data.company_assets) {
        let jo = data.company_assets;
        for (var i = 0; i < jo.length; i++) {
            let tr = document.createElement('tr');
            $(tr).append('<td>' + jo[i].type + '</td>');
            $(tr).append('<td>' + jo[i].desc + '</td>');
            $(tr).append('<td class="text-right">' + formatDouble(jo[i].value) + '</td>');
            $('#declared-assets-company-table').find('tbody').append(tr);
        }
    }

    if (data.partner_assets) {
        let jo = data.partner_assets;
        for (var i = 0; i < jo.length; i++) {
            let tr = document.createElement('tr');
            $(tr).append('<td>' + jo[i].type + '</td>');
            $(tr).append('<td>' + jo[i].desc + '</td>');
            $(tr).append('<td class="text-right">' + formatDouble(jo[i].value) + '</td>');
            $('#declared-assets-partner-table').find('tbody').append(tr);
        }
    }

    if (data.other_financial_commitments_tbl) {
        let jo = data.other_financial_commitments_tbl;
        for (var i = 0; i < jo.length; i++) {
            let tr = document.createElement('tr');
            $(tr).append('<td>' + jo[i].fcompany + '</td>');
            $(tr).append('<td>' + jo[i].ftype + '</td>');
            $(tr).append('<td>' + jo[i].flimit + '</td>');
            $(tr).append('<td>' + jo[i].fos + '</td>');
            $(tr).append('<td>' + jo[i].fsecurity + '</td>');
            $(tr).append('<td>' + jo[i].fmonthly_commitments + '</td>');
            $(tr).append('<td>' + jo[i].fpast_6months + '</td>');
            $(tr).append('<td>' + jo[i].fpast_12months + '</td>');
            $('#other_financial_commitments_table').find('tbody').append(tr);
        }
    }

    if (data.working_capital_facility && data.working_capital_facility == 'yes') {
        if (data.working_capital) {
            let jo = data.working_capital;
            Object.keys(jo).forEach(function (key) {
                let inputs = $(document).find('#WCV-' + key.toUpperCase());
                $(inputs).html(formatDouble(jo[key]));
                $(inputs).addClass('text-right');
            });
        }
        $('#wc_section').show();
    } else {
        $('#wc_section').hide();
    }

    if (data.wallet_info) {
        let jo = data.wallet_info;
        let tot_1 = 0;
        let tot_2 = 0;
        let tot_3 = 0;
        $('#table-wallet').find('tbody').find('tr').eq(0).find('td').eq(1).html(formatDouble(jo.loan.previous_year));
        $('#table-wallet').find('tbody').find('tr').eq(0).find('td').eq(2).html(formatDouble(jo.loan.previous_year_actual));
        $('#table-wallet').find('tbody').find('tr').eq(0).find('td').eq(3).html(formatDouble(jo.loan.projected));
        $('#table-wallet').find('tbody').find('tr').eq(1).find('td').eq(1).html(formatDouble(jo.deposit.previous_year));
        $('#table-wallet').find('tbody').find('tr').eq(1).find('td').eq(2).html(formatDouble(jo.deposit.previous_year_actual));
        $('#table-wallet').find('tbody').find('tr').eq(1).find('td').eq(3).html(formatDouble(jo.deposit.projected));
        $('#table-wallet').find('tbody').find('tr').eq(2).find('td').eq(1).html(formatDouble(jo.fees.previous_year));
        $('#table-wallet').find('tbody').find('tr').eq(2).find('td').eq(2).html(formatDouble(jo.fees.previous_year_actual));
        $('#table-wallet').find('tbody').find('tr').eq(2).find('td').eq(3).html(formatDouble(jo.fees.projected));
        $('#table-wallet').find('input').trigger('focusout');
        if (parseFloat(jo.loan.previous_year)) {
            tot_1 += parseFloat(jo.loan.previous_year);
        }
        if (parseFloat(jo.loan.previous_year_actual)) {
            tot_2 += parseFloat(jo.loan.previous_year_actual);
        }
        if (parseFloat(jo.loan.projected)) {
            tot_3 += parseFloat(jo.loan.projected);
        }
        if (parseFloat(jo.deposit.previous_year)) {
            tot_1 += parseFloat(jo.deposit.previous_year);
        }
        if (parseFloat(jo.deposit.previous_year_actual)) {
            tot_2 += parseFloat(jo.deposit.previous_year_actual);
        }
        if (parseFloat(jo.deposit.projected)) {
            tot_3 += parseFloat(jo.deposit.projected);
        }
        if (parseFloat(jo.fees.previous_year)) {
            tot_1 += parseFloat(jo.fees.previous_year);
        }
        if (parseFloat(jo.fees.previous_year_actual)) {
            tot_2 += parseFloat(jo.fees.previous_year_actual);
        }
        if (parseFloat(jo.fees.projected)) {
            tot_2 += parseFloat(jo.fees.projected);
        }
        $('#table-wallet').find('thead').eq(1).find('th').eq(1).html(formatDouble(tot_1));
        $('#table-wallet').find('thead').eq(1).find('th').eq(2).html(formatDouble(tot_2));
        $('#table-wallet').find('thead').eq(1).find('th').eq(3).html(formatDouble(tot_3));
    }
    if (data.risk_assesment) {
        let jo = data.risk_assesment;
        $('#table-riskassessment').find('tbody').find('tr').eq(0).find('td').eq(1).html(jo.financial.risk);
        $('#table-riskassessment').find('tbody').find('tr').eq(0).find('td').eq(2).html(jo.financial.mitigant);
        $('#table-riskassessment').find('tbody').find('tr').eq(1).find('td').eq(1).html(jo.business.risk);
        $('#table-riskassessment').find('tbody').find('tr').eq(1).find('td').eq(2).html(jo.business.mitigant);
        $('#table-riskassessment').find('tbody').find('tr').eq(2).find('td').eq(1).html(jo.management.risk);
        $('#table-riskassessment').find('tbody').find('tr').eq(2).find('td').eq(2).html(jo.management.mitigant);
        $('#table-riskassessment').find('tbody').find('tr').eq(3).find('td').eq(1).html(jo.structural.risk);
        $('#table-riskassessment').find('tbody').find('tr').eq(3).find('td').eq(2).html(jo.structural.mitigant);
        $('#table-riskassessment').find('tbody').find('tr').eq(4).find('td').eq(1).html(jo.succession.risk);
        $('#table-riskassessment').find('tbody').find('tr').eq(4).find('td').eq(2).html(jo.succession.mitigant);
        $('#table-riskassessment').find('input').trigger('focusout');
    }
    if (data.swot) {
        let jo = data.swot;
        $('#table-swot').find('tbody').find('tr').eq(0).find('td').eq(1).html(jo.S);
        $('#table-swot').find('tbody').find('tr').eq(1).find('td').eq(1).html(jo.W);
        $('#table-swot').find('tbody').find('tr').eq(2).find('td').eq(1).html(jo.O);
        $('#table-swot').find('tbody').find('tr').eq(3).find('td').eq(1).html(jo.T);
    }


    if (data.facility_details) {
        let jo = data.facility_details;
        for (var i = 0; i < jo.length; i++) {
            let tr = document.createElement('tr');
            $(tr).append('<td>' + jo[i].facility_txt + '</td>');
            $(tr).append('<td class="text-right">' + formatDouble(jo[i].e_limits) + '</td>');
            $(tr).append('<td class="text-right">' + formatDouble(jo[i].e_os) + '</td>');
            $(tr).append('<td class="text-right">' + jo[i].e_pricing + '% P.a</td>');
            $(tr).append('<td class="text-right">' + jo[i].e_tenor + ' Months</td>');
            $(tr).append('<td class="text-right">' + formatDouble(jo[i].p_limits) + '</td>');
            $(tr).append('<td class="text-center">' + formatDouble(jo[i].p_sub_limit) + '</td>');
            $(tr).append('<td class="text-right">' + jo[i].p_pricing + '% P.a</td>');
            $(tr).append('<td class="text-right">' + jo[i].p_tenor + ' Months</td>');
            $('#FACV-total_exp').parent().before(tr);
        }
    }

    if (data.facility_details_data) {
        let jo = data.facility_details_data;
        Object.keys(jo).forEach(function (key) {
            if (key === 'total_exp' | key === 'group_total_exp') {
                let tr = $(document).find('#FACV-' + key).parent();
                $(tr).find('th').eq(1).html(formatDouble(jo[key][0])).addClass('text-right');
                $(tr).find('th').eq(2).html(formatDouble(jo[key][1])).addClass('text-right');
                $(tr).find('th').eq(5).html(formatDouble(jo[key][2])).addClass('text-right');
            } else {
                console.log('#FACV-' + key);
                let tr = $(document).find('#FACV-' + key).parent();
                $(tr).find('td').eq(1).html(formatDouble(jo[key][0])).addClass('text-right');
                $(tr).find('td').eq(2).html(formatDouble(jo[key][1])).addClass('text-right');
                $(tr).find('td').eq(5).html(formatDouble(jo[key][2])).addClass('text-right');
            }
        });
    }

    if (data.securities) {
        let jo = data.securities;
        for (var i = 0; i < jo.length; i++) {
            addSecurityRecord(jo[i].facility, jo[i].facility_txt, jo[i].present, jo[i].proposed, jo[i].desc);
        }
    }

    if (data.security_policy) {
        let jo = data.security_policy;
        for (var i = 0; i < jo.length; i++) {
            let tr = document.createElement('tr');
            $(tr).append('<td>' + jo[i].name + '</td>');
            $(tr).append('<td>' + jo[i].section + '</td>');
            $(tr).append('<td>' + jo[i].justification + '</td>');
            $('#table-security-policy').find('tbody').append(tr);
        }
    }

    if (data.covenants) {
        let jo = data.covenants;
        for (var i = 0; i < jo.length; i++) {
            let tr = document.createElement('tr');
            $(tr).append('<td>' + jo[i].facility_txt + '</td>');
            $(tr).append('<td>' + jo[i].covenants + '</td>');
            $(tr).append('<td>' + jo[i].remarks + '</td>');
            $(tr).append('<td>' + jo[i].active_from + '</td>');
            $(tr).append('<td>' + jo[i].frequency + '</td>');
            $('#table-covenants').find('tbody').append(tr);
        }
    }

    if (data.terms_and_conditions) {
        let jo = data.terms_and_conditions;
        $('#table-tnc').find('tbody').find('tr').eq(0).find('td').html(jo.pre_disbursement);
        $('#table-tnc').find('tbody').find('tr').eq(1).find('td').eq(0).html(jo.other);
    }

    if (data.crib_analysis) {
        let jo = data.crib_analysis;
        for (var i = 0; i < jo.length; i++) {
            addCribRecord(jo[i].applicant, jo[i].nic, jo[i].no_of_facility, jo[i].settled_in_last5, jo[i].total_granted, jo[i].total_outstanding, jo[i].days_in_arreas, jo[i].inquiries_in_last6m);
        }
    }

    if (data.bank_statement) {
        let jo = data.bank_statement;
        for (var i = 0; i < jo.length; i++) {
            addBankStatement(jo[i].bank, jo[i].bank_txt, jo[i].acc_no, jo[i].data);
        }
    }

    if (data.financials) {
        let jo = data.financials;
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
            $('#financial-highlights').find('#fh-quick_ratio').find('td').eq(i + 1).html(formatDouble(((total_current_assets - stocks) / total_current_liabilities)) + "");

            let total_liabilities = bs[i]['total_liabilities'];
            let net_worth = bs[i]['net_worth'];

            let long_term_loans = bs[i]['long_term_loans'];
            let short_term_loans_od = bs[i]['short_term_loans_od'];
            let short_term_loans_tl = bs[i]['short_term_loans_tl'];
            let share_capital = bs[i]['share_capital'];
            let profit_and_lost_balance = bs[i]['profit_and_lost_balance'];
//            $('#financial-highlights').find('#fh-leverage').find('td').eq(i + 1).html(formatDouble((parseFloat(total_liabilities) / (parseFloat(share_capital) + parseFloat(profit_and_lost_balance)))) + "");
//            $('#financial-highlights').find('#fh-gearing').find('td').eq(i + 1).html(formatDouble(((parseFloat(long_term_loans) + parseFloat(short_term_loans_od) + parseFloat(short_term_loans_tl)) / (parseFloat(share_capital) + parseFloat(profit_and_lost_balance)))) + "");
            $('#financial-highlights').find('#fh-leverage').find('td').eq(i + 1).html(formatDouble((parseFloat(total_liabilities) / (parseFloat(net_worth)))) + "");
            $('#financial-highlights').find('#fh-gearing').find('td').eq(i + 1).html(formatDouble(((parseFloat(long_term_loans) + parseFloat(short_term_loans_od) + parseFloat(short_term_loans_tl)) / (parseFloat(net_worth)))) + "");
        }
    }

    if (data.recommendation) {
        let div = createRecommendation(data.recommendation);
        $('#app_hist_').append(div);
    }

    if (data.approval) {
        let jo = data.approval;
        let auth = true;
        for (var i = 0; i < jo.length; i++) {
            let tr = document.createElement('tr');
            $(tr).append('<td>' + jo[i].product + '</td>');
            $(tr).append('<td class="text-right">' + jo[i].proposed + '</td>');
            $(tr).append('<td class="text-right">' + jo[i].max + '</td>');
            $(tr).append('<td>' + jo[i].auth + '</td>');
            $('#mda').find('tbody').append(tr);
            if (jo[i].auth == 'no') {
                auth = false;
            }
        }
        if (auth) {
            $("#action option[value*='approve']").removeAttr('disabled');
            $("#action option[value*='reject']").removeAttr('disabled');
        } else {
            $("#action option[value*='approve']").prop('disabled', true);
            $("#action option[value*='reject']").prop('disabled', true);
        }

        action.destroy();
        //ACTION.create();

        action = new SlimSelect({
            select: '#action',
            placeholder: "Select an Option",
            allowDeselect: true,
            deselectLabel: '<span class="red">✖</span>',
            showSearch: false,
        });
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
                '<p>' + (rec.comment || '') + '</p>' + (rec.document ? '<a href="proposal/approval-document?file=' + rec.document + '" target="_blank">View Approval Document</a>' : '')
        '</div>' +
                '</div></div>';

        $(div).append(tem);
    }
    return $(div).html();
}

function addSecurityRecord(facility = '', faciliy_txt = '', present = {security_type:'', mortgage_type:'', date_of_valuation:'', valuation:'', market_value:'', fsv:'', ltv:''}, proposed = {security_type:'', mortgage_type:'', date_of_valuation:'', valuation:'', market_value:'', fsv:'', ltv:''}, desc = '') {
    let tr = document.createElement('tr');
    $(tr).append('<td rowspan="3">' + faciliy_txt + '</td>');
    $(tr).append('<td>Present</td>');
    $(tr).append('<td>' + present.security_type_txt + '</td>');
    $(tr).append('<td>' + present.mortgage_type_txt + '</td>');
    $(tr).append('<td>' + present.date_of_valuation + '</td>');
    $(tr).append('<td>' + formatDouble(present.valuer) + '</td>');
    $(tr).append('<td class="text-right">' + formatDouble(present.market_value) + '</td>');
    $(tr).append('<td class="text-right">' + formatDouble(present.fsv) + '</td>');
    $(tr).append('<td class="text-right">' + formatDouble(present.ltv) + '</td>');
    $('#table-security').find('tbody').append(tr);

    let tr2 = document.createElement('tr');
    $(tr2).append('<td>Proposed</td>');
    $(tr2).append('<td>' + proposed.security_type_txt + '</td>');
    $(tr2).append('<td>' + proposed.mortgage_type_txt + '</td>');
    $(tr2).append('<td>' + proposed.date_of_valuation + '</td>');
    $(tr2).append('<td>' + formatDouble(proposed.valuer) + '</td>');
    $(tr2).append('<td class="text-right">' + formatDouble(proposed.market_value) + '</td>');
    $(tr2).append('<td class="text-right">' + formatDouble(proposed.fsv) + '</td>');
    $(tr2).append('<td class="text-right">' + formatDouble(proposed.ltv) + '</td>');
    $('#table-security').find('tbody').append(tr2);

    let tr3 = document.createElement('tr');
    $(tr3).append('<td>Description of Security</td>');
    $(tr3).append('<td colspan="7">' + desc.replace(new RegExp("\n", 'g'), '<br>') + '</td>');
    $('#table-security').find('tbody').append(tr3);
}

function addCribRecord(applicant = '', nic = '', no_of_facility = '', settled_in_last5 = '', total_granted = '', total_outstanding = '', days_in_arreas = {_0_cnt:'', _0_os:'', _1_30_cnt:'', _1_30_os:'', _30_61_cnt:'', _30_61_os:'', _61_90_cnt:'', _61_90_os:'', _ov_90_cnt:'', _ov_90_os:'', dishonored_cheques_cnt : '', dishonored_cheques_os:'', guaranteed_facilities_cnt : '', guaranteed_facilities_os : ''}, inquiries_in_last6m = '') {
    let t1 = addCribTxt(true, '', applicant);
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
    if (cls == 'autodouble') {
        $(td).addClass('text-right');
        $(td).html(formatDouble(value));
    } else if (cls == 'autoint') {
        $(td).addClass('text-right');
        $(td).html(formatInt(value));
    } else {
        $(td).html(value);
    }
    return td;
}

function addBankStatement(bank = '', bank_txt = '', account_no = '', data = []) {
    var temp = document.getElementById("bank_st_temp");
    var clon = temp.content.cloneNode(true);

    $(clon).find('select').eq(0).replaceWith(bank_txt);
    $(clon).find('input').eq(0).replaceWith(account_no);

    let d_trans_tot = 0;
    let d_debit_tot = 0;
    let c_trans_tot = 0;
    let c_credit_tot = 0;
    let cnt = 0;
    for (var i = 0; i < data.length; i++) {
        let tr = $(clon).find('tbody').find('tr').eq(i);
        if (data[i].month) {
            cnt++;
            d_trans_tot += parseFloat(data[i].d_trans.replace(new RegExp(",", 'g'), ''));
            d_debit_tot += parseFloat(data[i].d_debit.replace(new RegExp(",", 'g'), ''));
            c_trans_tot += parseFloat(data[i].c_trans.replace(new RegExp(",", 'g'), ''));
            c_credit_tot += parseFloat(data[i].c_credit.replace(new RegExp(",", 'g'), ''));
            $(tr).find('input').eq(0).val(data[i].month);
            $(tr).find('input').eq(1).val(data[i].d_trans);
            $(tr).find('input').eq(2).val(data[i].d_debit);
            $(tr).find('input').eq(3).val(data[i].c_trans);
            $(tr).find('input').eq(4).val(data[i].c_credit);
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

    $(clon).find('input').each(function (t) {
        $(this).parent().addClass('text-right');
        $(this).replaceWith($(this).val());
    });

    $('#bank_statements').append(clon);
}

$('#action').change(function () {
    if ($(this).val() === 'forward') {
        $('#fwd_to').parent().parent().show();
        $('#approval_document').parent().parent().hide();
    } else if ($(this).val() === 'approve') {
        $('#fwd_to').parent().parent().hide();
        $('#approval_document').parent().parent().show();
    } else {
        $('#fwd_to').parent().parent().hide();
        $('#approval_document').parent().parent().hide();
    }
});

$('#submitbtn').click(function () {
    if ($('#action').val() === null || $('#action').val() === '') {
        Swal.fire('No Action !', 'Please select an action !', 'warning');
        return;
    }
    if ($('#action').val() === 'forward' && ($('#fwd_to').val() === null || $('#fwd_to').val() === '')) {
        Swal.fire('No User Selected !', 'Please select a user  to forward!', 'warning');
        return;
    }
    let dat = {
        pid: $('#submitbtn').data('id'),
        action: $('#action').val(),
        fwd_to: $('#fwd_to').val(),
        comment: $('#rec_comment').val()
    }

    const formData = new FormData();
    formData.append('pid', $('#submitbtn').data('id'));
    formData.append('action', $('#action').val());
    formData.append('fwd_to', $('#fwd_to').val());
    formData.append('comment', $('#rec_comment').val());
    if ($('#approval_document').prop('files').length > 0) {
        formData.append('file', $('#approval_document').prop('files')[0]);
    }

    Swal.fire({
        title: 'Are you sure?',
        text: "You won't be able to revert this!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, Submit!',
        showLoaderOnConfirm: true,
        allowOutsideClick: () => !Swal.isLoading(),
        preConfirm: () => {
            return fetch('proposal/approve', {
                method: 'POST',
                body: formData
            });
        }
    }).then(response => response.value.text()).then((response) => {
        console.log(response);

        let res = JSON.parse(response);
        if (res.status === 'success') {
            Swal.fire('Successfull !', res.msg, 'success');
            proposals.ajax.reload();
            $('#tablerow').fadeIn();
            $('#proposalrow').hide();
        } else if (res.status == 'error') {
            Swal.fire('Error !', res.msg, 'error');
        } else {
            Swal.fire('Error !', 'Something Went Wrong', 'error');
        }

    });

});


