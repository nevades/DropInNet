
function formatDouble(val) {
    if (parseFloat(val)) {
        return parseFloat(val).toLocaleString('en-US', {minimumFractionDigits: 0, maximumFractionDigits: 2});
    } else {
        return val;
    }
}

function formatInt(val) {
    if (parseInt(val)) {
        return parseInt(val).toLocaleString('en-US', {maximumFractionDigits: 0});
    } else {
        return val;
    }
}

function  createProposalRecommendation(recommendation) {
    let div = document.createElement('div');
    let jo = recommendation;
    for (var i = 0; i < jo.length; i++) {
        console.log(jo[i]);

        let tem = '<div class="col-12"><div class="media">' +
                '<a class="media-left" href="#">' +
                '    <img class="media-object img-radius m-r-10 img-60" onerror="this.onError=null;this.src=\'files/images/user.png\';"  src="userimages/' + jo[i].r_from.username + '.jpg">' +
                '</a>' +
                '<div class="media-body b-b-theme social-client-description">' +
                '<span>' + jo[i].rec_date + '</span>' +
                '<div class="chat-header">' + jo[i].r_from.name + ' <label class="label label-info" style="white-space: nowrap">Recommended to</label> ' + jo[i].r_to.name + '</div>' +
                '<p>' + jo[i].rec_from_cmnt + '</p>' +
                '</div>' +
                '</div></div>';

        if (['return', 'approve', 'reject'].includes(jo[i].app_type)) {
            let action = jo[i].app_type;
            let color = 'label-success';
            if (jo[i].app_type == 'reject') {
                color = 'label-danger';
            }
            let doc = '';
            if (jo[i].app_document) {
                doc = '<a href="proposal/approval-document?file=' + jo[i].app_document + '" target="_blank">View Approval Document</a>';
            }
            tem += '<div class="col-12"><div class="media">' +
                    '<a class="media-left" href="#">' +
                    '    <img class="media-object img-radius m-r-10 img-60" onerror="this.onError=null;this.src=\'files/images/user.png\';"  src="userimages/' + jo[i].r_to.username + '.jpg">' +
                    '</a>' +
                    '<div class="media-body b-b-theme social-client-description">' +
                    '<span>' + jo[i].app_date + '</span>' +
                    '<div class="chat-header">' + jo[i].r_to.name + ' <label class="label ' + color + '" style="white-space: nowrap">' + action + 'ed</label> the Proposal </div>' +
                    '<p>' + jo[i].app_cmnt + '</p>' + doc +
                    '</div>' +
                    '</div></div>';
        }
        $(div).append(tem);
    }
    return $(div).html();
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
                '<p>' + (rec.comment || '') + '</p>' +
                '</div>' +
                '</div></div>';

        $(div).append(tem);
    }
    return $(div).html();
}

function setDscrTbl(data) {
    if (data.CUSTOMER_TYPE) {
        $('#cus_code_id').val(data.CUS_CODE);
        var tp = data.CUSTOMER_TYPE;

        $.post('customer/get', {code: data.CUS_CODE}, function (response) {
            let res = JSON.parse(response);
            var data1 = res.data;

            if (data1.type === 'Salaried Individual') {
                console.log(data.type);
                //individual
                $('#salaried_main_income').text(formatDouble(data1.main_income));
                $('#salaried_addtnl_fix_income').text(formatDouble(data1.additional_fix_income));
                $('#salaried_avarage_varialble').text(formatDouble(data1.average_variable_income));
                $('#salaried_additional_income').text(formatDouble(data1.additional_income));
                $('#salaried_total_income_label').text(formatDouble(data1.total_income));
                $('#salaried_loan_rental').text(formatDouble(data1.loan_lease_rentals));
                $('#salaried_od_interest').text(formatDouble(data1.OD_interest));
                $('#salaried_credit_cards').text(formatDouble(data1.credit_cards));
                $('#salaried_others').text(formatDouble(data1.others_if_any));
                $('#salaried_proposed').text(formatDouble(data1.proposed_installment_for_FFL));
                $('#salaried_total_financial_label').text(formatDouble(data1.total_financial_obligations));
                $('#salaried_debit_service_cover_label').text(formatDouble(data1.debt_service_cover_ratio));
            }
            if (data1.type === 'Self Employed') {
                //self emplyd
                $('#selfEmp_monthly_income').text(formatDouble(data1.average_monthly_business_turnover));
                $('#selfEmp_netProfitMargin').text(formatDouble(data1.net_profit_margin));
                $('#selfEmp_netProfit').text(formatDouble(data1.net_profit));
                $('#selfEmp_otherFixed').text(formatDouble(data1.other_fixed_monthly_income));
                $('#selfEmp_monthIncome').text(formatDouble(data1.variable_monthly_income));
                $('#selfEmp_additionalIncome').text(formatDouble(data1.additional_income));
                $('#selfEmp_total_income').text(formatDouble(data1.total_income));
                $('#selfEmp_loan_rental').text(formatDouble(data1.loan_lease_rentals));
                $('#selfEmp_od_interest').text(formatDouble(data1.OD_interest));
                $('#selfEmp_credit_cards').text(formatDouble(data1.credit_cards));
                $('#selfEmp_others').text(formatDouble(data1.others_if_any));
                $('#selfEmp_proposed').text(formatDouble(data1.proposed_installment_for_FFL));
                $('#selfEmp_total_financial_label').text(formatDouble(data1.total_financial_obligations));
                $('#selfEmp_debit_service_cover_label').text(formatDouble(data1.debt_service_cover_ratio));
            }
            if (data.type === 'Corporate') {
                //coporate
                $('#coporate_annual_income').text(formatDouble(data.operatingProfit_annual_income));
                $('#coporate_average_monthly_calculation').text(formatDouble(data.average_monthly_operating_profit));
                $('#coporate__other_mnt_income').text(formatDouble(data.other_monthly_income));
                $('#coporate_addtional_mnth_income').text(formatDouble(data.additional_income));
                $('#coporate_total_income').text(formatDouble(data.total_income));
                $('#coporate_loan_rental').text(formatDouble(data.loan_lease_rentals));
                $('#coporate_od_interest').text(formatDouble(data.OD_interest));
                $('#coporate_others').text(formatDouble(data.others_if_any));
                $('#coporate_proposed').text(formatDouble(data.proposed_installment_for_FFL));
                $('#coporate_total_financial_label').text(formatDouble(data.total_financial_obligations));
                $('#coporate_debit_service_cover_label').text(formatDouble(data.debt_service_cover_ratio));
            }
            if (data.type === 'SME') {
                //self emplyd
                $('#selfEmp_monthly_income').text(formatDouble(data.average_monthly_business_turnover));
                $('#selfEmp_netProfitMargin').text(formatDouble(data.net_profit_margin));
                $('#selfEmp_netProfit').text(formatDouble(data.net_profit));
                $('#selfEmp_otherFixed').text(formatDouble(data.other_fixed_monthly_income));
                $('#selfEmp_monthIncome').text(formatDouble(data.variable_monthly_income));
                $('#selfEmp_additionalIncome').text(formatDouble(data.additional_income));
                $('#selfEmp_total_income').text(formatDouble(data.total_income));
                $('#selfEmp_loan_rental').text(formatDouble(data.loan_lease_rentals));
                $('#selfEmp_od_interest').text(formatDouble(data.OD_interest));
                $('#selfEmp_credit_cards').text(formatDouble(data.credit_cards));
                $('#selfEmp_others').text(formatDouble(data.others_if_any));
                $('#selfEmp_proposed').text(formatDouble(data.proposed_installment_for_FFL));
                $('#selfEmp_total_financial_label').text(formatDouble(data.total_financial_obligations));
                $('#selfEmp_debit_service_cover_label').text(formatDouble(data.debt_service_cover_ratio));
            }

            if (tp == null || tp == '') {
                $('#salaried_tbl').hide();
                $('#selfEmp_tbl').hide();
                $('#coporate_tbl').hide();
            } else if (tp == '1') {
                $('#salaried_tbl').show();
                $('#selfEmp_tbl').hide();
                $('#coporate_tbl').hide();
            } else if (tp == '9') {
                $('#coporate_tbl').hide();
                $('#salaried_tbl').hide();
                $('#selfEmp_tbl').show();
            } else if (tp == '2') {
                $('#selfEmp_tbl').hide();
                $('#salaried_tbl').hide();
                $('#coporate_tbl').show();
            }

        }).fail(function (response) {
            Swal.fire('Error !', response.responseText, 'error');
        });
    }
}

function setCharges(data) {
    if (data.charges) {
        current_charges = data.charges;
        let tot_amt = 0;
        let tot_charge = 0;
        let tot_adjustment = 0;
        let tot_amortized = 0;
        for (var i = 0; i < current_charges.length; i++) {
            let charge = current_charges[i];
            let tr = document.createElement('tr');
            $(tr).append('<td>' + charge.name + '</td>');
            $(tr).data('id', charge.id);
            $(tr).data('name', charge.name);
            tot_amt += parseFloat(charge.org_charge);
            if (charge.method) {
                if (charge.method == 'Upfront') {
                    tot_charge += parseFloat(charge.charge);
                } else if (charge.method == 'Amortized') {
                    tot_amortized += parseFloat(charge.charge);
                }
            }
            if (charge.adjustment) {
                tot_adjustment += parseFloat(charge.adjustment);
            }
            if (charge.rate) {
                $(tr).data('rate', charge.rate);
                $(tr).data('minimum', charge.minimum);
                $(tr).append('<td class="text-right">' + formatDouble(charge.rate) + '</td>');
                $(tr).append('<td class="text-right">-</td>');
                $(tr).append('<td class="text-right">' + formatDouble(charge.minimum) + '</td>');
                $(tr).append('<td class="text-right">' + formatDouble(charge.org_charge) + '</td>');
                $(tr).append('<td class="text-right">' + formatDouble(charge.adjustment) + '</td>');
                $(tr).append('<td class="text-right">' + formatDouble(charge.charge) + '</td>');
            } else {
                $(tr).data('flat', charge.flat);
                $(tr).append('<td class="text-right">-</td>');
                $(tr).append('<td class="text-right">' + formatDouble(charge.flat) + '</td>');
                $(tr).append('<td class="text-right">-</td>');
                $(tr).append('<td class="text-right">' + formatDouble(charge.org_charge) + '</td>');
                $(tr).append('<td class="text-right">' + formatDouble(charge.adjustment) + '</td>');
                $(tr).append('<td class="text-right">' + formatDouble(charge.charge) + '</td>');
            }
            if (charge.payee) {
                $(tr).append('<td class="text-center">' + charge.payee_txt + '</td>');
            } else {
                $(tr).append('<td class="text-center">-</td>');
            }
            if (charge.method) {
                $(tr).append('<td class="text-center">' + charge.method + '</td>');
            } else {
                $(tr).append('<td class="text-center">-</td>');
            }
            $('#chargeTable').find('tbody').append(tr);
            $('#chargeTable').find('tfoot').find('th').eq(4).html(formatDouble(tot_amt));
            $('#chargeTable').find('tfoot').find('th').eq(5).html(formatDouble(tot_adjustment));
            $('#chargeTable').find('tfoot').find('th').eq(6).html(formatDouble(tot_charge));
            // $('#amortized').html(formatDouble(tot_amortized));
        }
    }
}

function setGroupExp(data) {
    if (data.groupexp) {
        let groupexp = data.groupexp;
        let totExp = 0;
        groupexp.forEach((exp) => {
            $('#groupExposure tbody').append('<tr><td>' + exp.customer + '</td><td>' + exp.product + '</td><td class="text-right">' + exp.exp + '</td></tr>');
            totExp += parseFloat(exp.exp.replace(new RegExp(",", 'g'), '')) || 0;
        });
        $('#groupExposure tbody').append('<tr><td colspan="2">Current Facility</td><td class="text-right">' + formatDouble((data.loan_amount ? removeCommas(data.loan_amount) : '0')) + '</td></tr>');
        totExp += parseFloat((data.loan_amount ? removeCommas(data.loan_amount) : '0')) || 0;
        $('#groupExposure tfoot').find('th').last().html(formatDouble(totExp));
    }
}

function removeCommas(tar) {
    return tar.toString().replace(new RegExp(",", 'g'), '');
}

function setPaymentSchedule(data) {
    let schedule = data.payment_schedule;
    let capitalTot = 0;
    let interestTot = 0;
    let installmentTot = 0;
    let outstanding = parseFloat(data.loan_amount.toString().replace(new RegExp(",", 'g'), '')) + (data.amortized ? parseFloat(data.amortized.toString().replace(new RegExp(",", 'g'), '')) : 0);
    for (var i = 0; i < schedule.length; i++) {
        let tr = document.createElement('tr');
        $(tr).append('<td class="text-center">' + schedule[i].installment + '</td>');
        $(tr).append('<td class="text-right">' + formatInt(schedule[i].capital) + '</td>');
        $(tr).append('<td class="text-right">' + formatInt(schedule[i].interest) + '</td>');
        $(tr).append('<td class="text-right">' + formatInt(schedule[i].gross) + '</td>');
        $(tr).append('<td class="text-right">' + formatInt(outstanding -= parseFloat(schedule[i].capital)) + '</td>');
        $('#paymentSchedule tbody').append(tr);
        capitalTot += parseFloat(schedule[i].capital);
        interestTot += parseFloat(schedule[i].interest);
        installmentTot += parseFloat(schedule[i].gross);
    }

    $('#paymentSchedule tfoot').find('th').eq(1).text(formatInt(capitalTot));
    $('#paymentSchedule tfoot').find('th').eq(2).text(formatInt(interestTot));
    $('#paymentSchedule tfoot').find('th').eq(3).text(formatInt(installmentTot));
}

$('#dscrBtn').click(function () {
    if ($(this).find('i').first().hasClass('icon-chevrons-down')) {
        $(this).find('i').first().removeClass('icon-chevrons-down').addClass('icon-chevrons-up');
        $(this).find('.pcoded-mtext').text('Hide Details');
        $('#dscrTbl').show();
    } else {
        $(this).find('i').first().removeClass('icon-chevrons-up').addClass('icon-chevrons-down');
        $(this).find('.pcoded-mtext').text('Show Details');
        $('#dscrTbl').hide();
    }
});

function addDocument(name, exists, url) {
    if (exists) {
        $('#documentList').append('<div class="row m-b-5"><div class="col-11"><a href="leasedocs/' + url + '" target="_blank">' + name + '</a></div><div class="col-1"><i class="icon feather icon-check-circle f-w-600 f-16 text-success"></i></div></div>');
    } else {
        $('#documentList').append('<div class="row m-b-5"><div class="col-11"><a href="javascript:void(0)">' + name + '</a><</div><div class="col-1"><i class="icon feather icon-x-circle f-w-600 f-16 text-danger"></i></div></div>');
    }
}

