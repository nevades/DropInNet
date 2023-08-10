if ($.fn.dataTable) {
    $.fn.dataTable.ext.errMode = 'none';
}
$('.autodouble').autoNumeric();

$('.cls-card').click(function () {
    $('#tableCard').fadeIn();
    $('#addCard').hide();
});

function loadMainTable(url) {
    return  $('#main_table').DataTable({
        "bLengthChange": true,
        "bInfo": true,
        "aLengthMenu": [[5, 10, 15], [5, 10, 15]],
        "pageLength": 5,
        "ordering": true,
        "autoWidth": false,
        "processing": true,
        "serverSide": true,
        "order": [[0, "desc"]],
        searchDelay: 1500,
        "ajax": {
            "url": url,
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
            {"data": "id", "visible": false, },
            {"data": "code"},
            {"data": "customer"},
            {"data": "product"},
            {"data": "asset"},
            {"data": "last_action"},
        ], "language": {
            'loadingRecords': '&nbsp;',
            'processing': '<div class="loader2"></div>'
        }, "createdRow": function (row, data) {
            let action_td = document.createElement('td');
            $(action_td).addClass('text-center');
            $(action_td).append('<a href="javascript:void(0)" class="viewSanction"><i class="icon feather icon-list f-w-600 f-16 m-r-10 text-c-blue"></i></a><a href="javascript:void(0)" class="approvebtn"><i class="icon feather icon-check-circle f-w-600 f-16 m-r-10 text-c-blue"></i></a>');
            $(row).append(action_td);
            $(row).data('id', data['id']);
        }
    });
}


$(document).on('click', '.approvebtn', function () {
    loadDiv($('#tableCard'));
    let id = $(this).parents('tr').first().data('id');
    $('#submitbtn').data('id', id);
    $.post('leasing/sanctionLetter', {id: id}, function (response) {
        let res = JSON.parse(response);
        if (res.status === 'success') {
            fillData(res.data);
            finishLoadDiv($('#tableCard'));
            $('#tableCard').hide();
            $('#addCard').fadeIn();
        } else if (res.status == 'err') {
            Swal.fire('Error !', res.msg, 'error');
            finishLoadDiv($('#tableCard').find('.card'));
        } else {
            Swal.fire('Error !', 'Something Went Wrong', 'error');
            finishLoadDiv($('#tableCard'));
        }
    }).fail(function (response) {
        Swal.fire('Error !', response.responseText, 'error');
        finishLoadDiv($('#tableCard'));
    });
});


var action = new SlimSelect({
    select: '#action',
    placeholder: "Select an Option",
    allowDeselect: true,
    deselectLabel: '<span class="red">✖</span>',
    showSearch: false,
});

var fwd_to = null;

if ($('#fwd_to').length > 0) {
    fwd_to = new SlimSelect({
        select: '#fwd_to',
        placeholder: "Select an User",
        ajax: function (search, callback) {
            $.post('leasing/userSearch', {q: search}, function (res) {
                callback(JSON.parse(res));
            });
        },
        allowDeselect: true,
        deselectLabel: '<span class="red">✖</span>'
    });
    $('#fwd_to').data('select', fwd_to);
}

$('#action').change(function () {
    if ($(this).val() === 'forward') {
        $('#fwd_to').parent().parent().show();
        //$('#approval_document').parent().parent().hide();
    } else if ($(this).val() === 'approve') {
        $('#fwd_to').parent().parent().hide();
        //$('#approval_document').parent().parent().show();
    } else {
        $('#fwd_to').parent().parent().hide();
        // $('#approval_document').parent().parent().hide();
    }
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
                '<p>' + (rec.comment || '') + '</p>' + (rec.action === 'verified' && rec.document ? '<a href="leasedocs/' + rec.document + '" target="_blank"><span class="pcoded-micon" style="font-size: 16px"><i class="feather icon-file"></i></span> <span class="pcoded-mtext">Charge Proof</span></a>' : '') +
                '</div>' +
                '</div></div>';

        $(div).append(tem);
    }
    return $(div).html();
}

function  createRecommendation_old(recommendation) {
    let div = document.createElement('div');
    let jo = recommendation;
    for (var i = 0; i < jo.length; i++) {
        let tem = '';
        if (jo[i].r_from) {
            tem = '<div class="col-12"><div class="media">' +
                    '<a class="media-left" href="#">' +
                    '    <img class="media-object img-radius m-r-10 img-60" onerror="this.onError=null;this.src=\'files/images/user.png\';"  src="userimages/' + jo[i].r_from.username + '.jpg">' +
                    '</a>' +
                    '<div class="media-body b-b-theme social-client-description">' +
                    '<span>' + jo[i].rec_date + '</span>' +
                    '<div class="chat-header">' + jo[i].r_from.name + ' <label class="label label-info" style="white-space: nowrap">Recommended to</label> ' + jo[i].r_to.name + '</div>' +
                    '<p>' + jo[i].rec_comment + '</p>' +
                    '</div>' +
                    '</div></div>';
        }

        if (['return', 'approve', 'activated', 'reject', 'credit approve', 'deviation approve', 'modified', 'verified', 'insurance confirmed', 'marked as documents received', 'payment confirmed', 'returned to reverify'].includes(jo[i].app_type)) {
            let action = jo[i].app_type;
            let color = 'label-success';
            if (jo[i].app_type == 'return' | jo[i].app_type == 'returned to reverify') {
                color = 'label-warning';
            } else if (jo[i].app_type == 'reject') {
                color = 'label-danger';
            }
            tem += '<div class="col-12"><div class="media">' +
                    '<a class="media-left" href="#">' +
                    '    <img class="media-object img-radius m-r-10 img-60" onerror="this.onError=null;this.src=\'files/images/user.png\';" src="userimages/' + jo[i].r_to.usrername + '.jpg">' +
                    '</a>' +
                    '<div class="media-body b-b-theme social-client-description">' +
                    '<span>' + jo[i].app_date + '</span>' +
                    '<div class="chat-header"> <label class="label ' + color + '" style="white-space: nowrap">' + action + '</label>' + ' - ' + jo[i].r_to.name + '</div>' +
                    '<p>' + jo[i].app_comment + '</p>' +
                    '</div>' +
                    '</div></div>';
        }
        $(div).append(tem);
    }
    return $(div).html();
}

function clearFields() {
    $('#coBorrowerList').html('');
    $('#coBorrowerList').prev().hide();
    $('#guarantorList').html('');
    $('#guarantorList').prev().hide();
    $('#chargeTable tbody').html('');
    $('#payInstructions tbody').html('');
    $('#paymentSchedule tbody').html('');
    $('#groupExposure tbody').html('');
    $('#mda tbody').html('');
    $('#assetList').html('');
    $('#deviations tbody').html('');
    $('#app_hist_').html('');
    $('#customer-documents').html('');
    $('#historyRow').html('');
    $('#documentList').html('');
    $('#documents tbody').find('tr').each(function () {
        $(this).find('td').last().replaceWith('<td class="text-center">NO</td>');
    });
    $('#action').val('').change();
    $('#rec_comment').val('').change();
    $('a[href="#tab-lease-details"]').click();
}

function setCustomers(data) {
    $('#cus_img').attr('src', 'customerimages/' + data.customer + '.jpg');

    if (data.crib_docs) {
        let docs = data.crib_docs;
        for (let i = 0; i < docs.length; i++) {
            let temp = document.getElementById("fileTemplate");
            let clone = temp.content.cloneNode(true);
            $(clone).find('.file-name').data('url', 'leasedocs/' + docs[i]);
            $(clone).find('.file-name').html('CRIB ' + (i + 1));
            $('#customer-cribDocuments').append(clone);
        }
    }

    if (data.cus_crib_deviations) {
        let deviations = data.cus_crib_deviations;
        for (let i = 0; i < deviations.length; i++) {
            $('#customer-criDeviations').append('<div>' + deviations[i].deviation_txt + '</div>');
        }
    }

    if (data.customer_docs) {
        let docs = data.customer_docs;
        console.log(docs);
        for (let i = 0; i < docs.length; i++) {
            let temp = document.getElementById("fileTemplate");
            let clone = temp.content.cloneNode(true);
            $(clone).find('.file-name').data('url', 'cusfile/' + docs[i].file);
            $(clone).find('.file-name').html(docs[i].dname);
            $('#customer-documents').append(clone);
        }
    }

    if (data.risk_tbl) {
        $('#riskRatingTbl').html("");
        $('#riskRatingTbl').append(data.risk_tbl);
//        $('#riskRatingTbl').find('thead').hide();
//        $('#riskRatingTbl').find('tbody').hide();

    }

    if (data.co_borrowers) {
        let co_borrowers = data.co_borrowers;
        for (var i = 0; i < co_borrowers.length; i++) {
            let clone = document.createElement("div");
            let co_borrower = co_borrowers[i];
            $(clone).load('files/templates/cbTemplate.html', null, function (data, status, jqXGR) {
                $(clone).find('.cb-img').attr('src', 'customerimages/' + co_borrower.co_borrower + '.jpg');
                $(clone).find('.cb-code').html(co_borrower.code);
                $(clone).find('.cb-name').html(co_borrower.name);
                $(clone).find('.cb-nic').html(co_borrower.nic);
                $(clone).find('.cb-relationship').html(co_borrower.relationship_txt);
                $(clone).find('.cb-address').html(co_borrower.address);
                $(clone).find('.cb-dcsr').html(co_borrower.dcsr);
                $(clone).find('.cb-ndia').html(co_borrower.ndia);
                $(clone).find('.cb-cribnote').html(co_borrower.note);

                if (co_borrower.docs) {
                    let docs = co_borrower.docs;
                    for (let i = 0; i < docs.length; i++) {
                        let file_temp = document.getElementById("fileTemplate");
                        let file_clone = file_temp.content.cloneNode(true);
                        $(file_clone).find('.file-name').data('url', 'cusfile/' + docs[i].file);
                        $(file_clone).find('.file-name').html(docs[i].dname);
                        $(clone).find('.cb-documents').append(file_clone);
                    }
                }

                if (co_borrower.crib_docs) {
                    let docs = co_borrower.crib_docs;
                    for (let i = 0; i < docs.length; i++) {
                        let file_temp = document.getElementById("fileTemplate");
                        let file_clone = file_temp.content.cloneNode(true);
                        $(file_clone).find('.file-name').data('url', 'leasedocs/' + docs[i]);
                        $(file_clone).find('.file-name').html('CRIB ' + (i + 1));
                        $(clone).find('.cb-cribDocuments').append(file_clone);
                    }
                }

                if (co_borrower.crib_deviations) {
                    let deviations = co_borrower.crib_deviations;
                    for (let i = 0; i < deviations.length; i++) {
                        $(clone).find('.cb-cribdeviations').append('<div>' + deviations[i].text + '</div>');
                    }
                }

                $('#coBorrowerList').append($(clone).children());
            });
        }
        $('#coBorrowerList').prev().show();
    } else {
        $('#coBorrowerList').prev().hide();
    }

    if (data.guarantors) {
        let guarantors = data.guarantors;
        for (var i = 0; i < guarantors.length; i++) {

            let clone = document.createElement("div");
            let guarantor = guarantors[i];
            $(clone).load('files/templates/cbTemplate.html', null, function (data, status, jqXGR) {
                $(clone).find('.cb-img').attr('src', 'customerimages/' + guarantor.guarantor + '.jpg');
                $(clone).find('.cb-code').html(guarantor.code);
                $(clone).find('.cb-name').html(guarantor.name);
                $(clone).find('.cb-nic').html(guarantor.nic);
                $(clone).find('.cb-relationship').html(guarantor.relationship_txt);
                $(clone).find('.cb-address').html(guarantor.address);
                $(clone).find('.cb-dcsr').html(guarantor.dcsr);
                $(clone).find('.cb-ndia').html(guarantor.ndia);
                $(clone).find('.cb-cribnote').html(guarantor.note);

                if (guarantor.docs) {
                    let docs = guarantor.docs;
                    for (let i = 0; i < docs.length; i++) {
                        let file_temp = document.getElementById("fileTemplate");
                        let file_clone = file_temp.content.cloneNode(true);
                        $(file_clone).find('.file-name').data('url', 'cusfile/' + docs[i].file);
                        $(file_clone).find('.file-name').html(docs[i].dname);
                        $(clone).find('.cb-documents').append(file_clone);
                    }
                }

                if (guarantor.crib_docs) {
                    let docs = guarantor.crib_docs;
                    for (let i = 0; i < docs.length; i++) {
                        let file_temp = document.getElementById("fileTemplate");
                        let file_clone = file_temp.content.cloneNode(true);
                        $(file_clone).find('.file-name').data('url', 'leasedocs/' + docs[i]);
                        $(file_clone).find('.file-name').html('CRIB ' + (i + 1));
                        $(clone).find('.cb-cribDocuments').append(file_clone);
                    }
                }

                if (guarantor.crib_deviations) {
                    let deviations = guarantor.crib_deviations;
                    for (let i = 0; i < deviations.length; i++) {
                        $(clone).find('.cb-cribdeviations').append('<div>' + deviations[i].text + '</div>');
                    }
                }

                $('#guarantorList').append($(clone).children());
            });
        }
        $('#guarantorList').prev().show();
    } else {
        $('#guarantorList').prev().hide();
    }

    setDscrTbl(data);
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
            if (data1.type === 'Corporate') {
                //coporate
                $('#coporate_annual_income').text(formatDouble(data1.operatingProfit_annual_income));
                $('#coporate_average_monthly_calculation').text(formatDouble(data1.average_monthly_operating_profit));
                $('#coporate__other_mnt_income').text(formatDouble(data1.other_monthly_income));
                $('#coporate_addtional_mnth_income').text(formatDouble(data1.additional_income));
                $('#coporate_total_income').text(formatDouble(data1.total_income));
                $('#coporate_loan_rental').text(formatDouble(data1.loan_lease_rentals));
                $('#coporate_od_interest').text(formatDouble(data1.OD_interest));
                $('#coporate_others').text(formatDouble(data1.others_if_any));
                $('#coporate_proposed').text(formatDouble(data1.proposed_installment_for_FFL));
                $('#coporate_total_financial_label').text(formatDouble(data1.total_financial_obligations));
                $('#coporate_debit_service_cover_label').text(formatDouble(data1.debt_service_cover_ratio));
            }
            if (data1.type === 'SME') {
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
            $('#amortized').html(formatDouble(tot_amortized));
        }
    }
}

function setAssets(data, modifyInsurance = false) {
    if (data.assets) {
        let assets = data.assets;
        for (var i = 0; i < assets.length; i++) {
            var temp = document.getElementById("assetTemplate");
            var clone = temp.content.cloneNode(true);
            let asset = assets[i];
            //$(clone).find('th').eq(0).html(asset.asset_txt);
            if (asset.details) {
                if (asset.details['images']) {
                    let imgs = asset.details['images'];
                    let splide_div = document.createElement('div');
                    $(splide_div).addClass('splide');
                    $(splide_div).html('<div class="splide__track"><ul class="splide__list"></ul></div>');

                    for (var i = 0; i < imgs.length; i++) {
                        let splide_slide = document.createElement('li');
                        $(splide_slide).addClass('splide__slide');
                        if (['Valuation', 'Valuation2', 'CR'].includes(imgs[i].name) && !imgs[i].name.endsWith(".jpg")) {
                            $(splide_slide).html('<div class="splide__slide__container"><embed width="100%"height="100%" src="assetimages/' + imgs[i].img + '"></div><div class="text-center">' + imgs[i].name + '<div>');
                        } else {
                            $(splide_slide).html('<div class="splide__slide__container"><img src="assetimages/' + imgs[i].img + '"></div><div class="text-center">' + imgs[i].name + '<div>');
                        }
                        $(splide_div).find('.splide__list').append(splide_slide);
                    }

                    let thumbs = $(splide_div)[0].cloneNode(true);
                    $(splide_div).addClass('main-slider');
                    $(thumbs).addClass('thumbnail-slider');

                    $(clone).find('.imgSec').append(splide_div);
                    $(clone).find('.imgSec').append('<br>');
                    $(clone).find('.imgSec').append(thumbs);

                    let main_slider = new Splide(splide_div, {
                        type: 'fade',
                        rewind: true,
                        pagination: false,
                        arrows: false,
                        fixedHeight: 450,
                        cover: true,
                    });

                    let thumb_slidr = new Splide(thumbs, {
                        fixedWidth: 100,
                        fixedHeight: 60,
                        gap: 10,
                        rewind: true,
                        pagination: false,
                        cover: true,
                        isNavigation: true,
                        breakpoints: {
                            600: {
                                fixedWidth: 60,
                                fixedHeight: 44,
                            },
                        },
                    });

                    main_slider.sync(thumb_slidr);
                    main_slider.mount();
                    thumb_slidr.mount();
                }

                const otherDetails = ['CODE', 'REG NO', 'CR NO', 'CR Status', 'LOT NO', 'Vehicle Type', 'Body Type', 'Condition', 'Make', 'Model', 'Country', 'YOM', 'Fuel', 'Engine Capacity', 'Transmission', 'Engine No', 'Chassis No', 'Engine Condition', 'Body Condition', 'Body Color', 'Millage', 'First Registration', 'Last Registration', 'Extras', 'Options']

                otherDetails.forEach(function (key) {
                    let tem = '<div class="form-group col-12 col-xl-6 col-lg-6">' +
                            '<label class="col-sm-12 col-form-label">' + key + '</label>' +
                            '<div class="col-sm-12">' + (asset.details[key] || '-') + '</div>' +
                            '</div>';
                    $(clone).find('.detailSec').append(tem);
                });

                if (asset.details.valuation_1) {
                    let valuation = asset.details.valuation_1;
                    Object.keys(valuation).forEach(function (key) {
                        if (key == 'doc') {
                            $(clone).find('.viewValuatuion').attr('href', 'assetimages/' + valuation[key]);
                            return;
                        }
                        let tem = '<div class="form-group row m-b-0">' +
                                '<label class="col-sm-3 col-form-label">' + key + ' </label>' +
                                '<div class="col-sm-9" style="padding-top: calc(0.5rem - 1px * 2);padding-bottom: calc(0.5rem - 1px * 2);">' + (valuation[key] || '') + '</div>' +
                                '</div>';
                        $(clone).find('.valuationSec1').append(tem);
                    });
                }

                if (asset.details.valuation_2) {
                    let valuation = asset.details.valuation_2;
                    Object.keys(valuation).forEach(function (key) {
                        if (key == 'doc') {
                            $(clone).find('.viewSecondValuatuion').attr('href', 'assetimages/' + valuation[key]);
                            return;
                        }
                        let tem = '<div class="form-group row m-b-0">' +
                                '<label class="col-sm-3 col-form-label">' + key + ' </label>' +
                                '<div class="col-sm-9" style="padding-top: calc(0.5rem - 1px * 2);padding-bottom: calc(0.5rem - 1px * 2);">' + (valuation[key] || '') + '</div>' +
                                '</div>';
                        $(clone).find('.valuationSec2').append(tem);
                    });
                }

            }

            if (asset.broker) {
                $(clone).find('.broker').html(asset.broker_txt);
            }
            if (asset.vendor) {
                $(clone).find('.vendor').html(asset.vendor_txt);
            }
            const insuranceItems = [
                {name: 'Insurance Done By', id: 'insured_by'},
                {name: 'Insurance Type', id: 'insurance_type', type: 'select'},
                {name: 'Insurance Company', id: 'insurance_company_txt', type: 'select'},
                {name: 'Policy Type', id: 'policy_type', type: 'select'},
                {name: 'Policy No', id: 'policy_no'},
                {name: 'Start Date', id: 'start_date', type: 'date'},
                {name: 'End Date', id: 'end_date', type: 'date'},
                {name: 'Grace Period', id: 'grace_period', type: 'int'},
                {name: 'Sum Insured', id: 'sum_insured', type: 'double'},
                {name: 'Total Premium', id: 'total_premium', type: 'double'},
                {name: 'Basic Premium', id: 'basic_premium', type: 'double'},
                {name: 'SRCC', id: 'rcc', type: 'double'},
                {name: 'TC', id: 'tcc', type: 'double'},
                {name: 'NBT', id: 'nbt', type: 'double'},
                {name: 'Admin Fee', id: 'admin_fee', type: 'double'},
                {name: 'Policy Fee', id: 'policy_fee', type: 'double'},
                {name: 'VAT', id: 'vat', type: 'double'},
                {name: 'Road Safety Tax', id: 'road_safety_tax', type: 'double'},
                {name: 'Stamp Duty', id: 'stamp_duty', type: 'double'},
                {name: 'Business Type', id: 'business_type', type: 'select'},
                {name: 'Insurance Document', id: 'document'}
            ]
//            if (modifyInsurance) {
            let ins_temp = document.getElementById("insuranceTemplate");
            let ins_clone = ins_temp.content.cloneNode(true);
            $(clone).find('#insuranceSec').append(ins_clone);

            let insurance_company_sel = new SlimSelect({
                select: $(clone).find('[name="insurance_company"]')[0],
                placeholder: "Select an Insurance Company",
                ajax: function (search, callback) {
                    $.post('leasing/insuranceCompanySearch', {q: search}, function (res) {
                        callback(JSON.parse(res));
                    });
                },
                allowDeselect: true,
                deselectLabel: '<span class="red">✖</span>'
            });

            var insured_by_sel = new SlimSelect({
                select: $(clone).find('[name="insured_by"]')[0],
                placeholder: "Please Select", allowDeselect: true, deselectLabel: '<span class="red">✖</span>', showSearch: false
            });

            var insurance_type_sel = new SlimSelect({
                select: $(clone).find('[name="insurance_type"]')[0],
                placeholder: "Please Select",
                allowDeselect: true,
                deselectLabel: '<span class="red">✖</span>', showSearch: false
            });

            var policy_type_sel = new SlimSelect({
                select: $(clone).find('[name="policy_type"]')[0],
                placeholder: "Please Select",
                allowDeselect: true,
                deselectLabel: '<span class="red">✖</span>', showSearch: false
            });

            var business_type_sel = new SlimSelect({
                select: $(clone).find('[name="business_type"]')[0],
                placeholder: "Please Select",
                allowDeselect: true,
                deselectLabel: '<span class="red">✖</span>', showSearch: false
            });

            if (asset.insurance) {
                let insurance = asset.insurance;
                if (insurance.insurance_company != '') {
                    insurance_company_sel.setData([{value: insurance.insurance_company, text: insurance.insurance_company_txt}]);
                    insurance_company_sel.set(insurance.insurance_company);
                }

                insured_by_sel.set(insurance.insured_by);
                insurance_type_sel.set(insurance.insurance_type);
                policy_type_sel.set(insurance.policy_type);
                business_type_sel.set(insurance.business_type);

                $(clone).find('[name="policy_no"]').eq(0).val(insurance.policy_no);
                $(clone).find('[name="insurance_start_date"]').eq(0).val(insurance.start_date);
                $(clone).find('[name="insurance_end_date"]').eq(0).val(insurance.end_date);
                $(clone).find('[name="grace_period"]').eq(0).val(insurance.grace_period);
                $(clone).find('[name="sum_insured"]').eq(0).val(insurance.sum_insured);
                $(clone).find('[name="total_premium"]').eq(0).val(insurance.total_premium);
                $(clone).find('[name="basic_premium"]').eq(0).val(insurance.basic_premium);
                $(clone).find('[name="rcc"]').eq(0).val(insurance.rcc);
                $(clone).find('[name="tcc"]').eq(0).val(insurance.tcc);
                $(clone).find('[name="nbt"]').eq(0).val(insurance.nbt);
                $(clone).find('[name="admin_fee"]').eq(0).val(insurance.admin_fee);
                $(clone).find('[name="policy_fee"]').eq(0).val(insurance.policy_fee);
                $(clone).find('[name="vat"]').eq(0).val(insurance.vat);
                $(clone).find('[name="road_safety_tax"]').eq(0).val(insurance.road_safety_tax);
                $(clone).find('[name="stamp_duty"]').eq(0).val(insurance.stamp_duty);

                if (!(insurance.document === null || insurance.document === '')) {
                    let doc_el = '<div class="row m-1 file-el" style="background-color: #e5e5e5;border-radius: 4px;">'
                            + '<div class="col-2 text-center justify-content-center align-self-center">'
                            + '<span class="pcoded-micon" style="font-size: 25px"><i class="feather icon-file"></i></span>'
                            + '</div>'
                            + '<div class="col-8 justify-content-center align-self-center">'
                            + '<a href="leasedocs/' + insurance.document + '" target="_blank">Click to View</a>'
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
                    $(clone).find('[name="document"]').eq(0).after($(doc).children());
                    $(clone).find('[name="document"]').eq(0).hide();
                }

            } else {
                insured_by_sel.set('');
                insurance_type_sel.set('');
                policy_type_sel.set('');
                business_type_sel.set('');
            }

            if (!modifyInsurance) {
                insurance_company_sel.disable();
                $(clone).find('[name="sum_insured"]').attr('readonly', true);
                $(clone).find('[name="total_premium"]').attr('readonly', true);
                $(clone).find('[name="basic_premium"]').attr('readonly', true);
                $(clone).find('[name="rcc"]').attr('readonly', true);
                $(clone).find('[name="tcc"]').attr('readonly', true);
                $(clone).find('[name="nbt"]').attr('readonly', true);
                $(clone).find('[name="nbt"]').attr('readonly', true);
                $(clone).find('[name="admin_fee"]').attr('readonly', true);
                $(clone).find('[name="policy_fee"]').attr('readonly', true);
                $(clone).find('[name="vat"]').attr('readonly', true);
                $(clone).find('[name="road_safety_tax"]').attr('readonly', true);
                $(clone).find('[name="stamp_duty"]').attr('readonly', true);
            }

//            } else {
//                if (asset.insurance) {
//                    insuranceItems.forEach(function (key) {
//                        let tem = '<div class="form-group col-12 ' + ((key.name == 'Insurance Company' | key.name == 'Insurance Document') ? 'col-xl-4 col-lg-4' : 'col-xl-2 col-lg-2') + '">' +
//                                '<label class="col-sm-12 col-form-label">' + key.name + '</label>' +
//                                '<div class="col-sm-12">' + (key.name == 'Insurance Document' && (typeof asset.insurance[key.id] !== 'undefined' && asset.insurance[key.id] != null) ? '<a href="leasedocs/' + asset.insurance[key.id] + '" target="_blank"><span class="pcoded-micon" style="font-size: 16px"><i class="feather icon-file"></i></span> <span class="pcoded-mtext">Click to View</span></a>' : (asset.insurance[key.id] || '-')) + '</div>' +
//                                '</div>';
//                        $(clone).find('#insuranceSec').append(tem);
//                    });
//                }
//            }

            $('#assetList').append(clone);
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
        $('#groupExposure tbody').append('<tr><td colspan="2">Current Facility</td><td class="text-right">' + formatDouble(data.exposure || 0) + '</td></tr>');
        totExp += parseFloat(data.exposure) || 0;
        $('#groupExposure tfoot').find('th').last().html(formatDouble(totExp));
    }
}

function setPaymentInstrctions(data) {
    if (data.payment_instructions) {
        let payment_instructions = data.payment_instructions;
        for (var i = 0; i < payment_instructions.length; i++) {
            $('#payInstructions tbody').append('<tr><td>' + payment_instructions[i].payee_txt + '</td><td class="text-right">' + formatDouble(payment_instructions[i].amount) + '</td></tr>')
        }
    }
}

function setPaymentSchedule(data) {
    let schedule = data.payment_schedule;
    let capitalTot = 0;
    let interestTot = 0;
    let installmentTot = 0;
    let outstanding = parseFloat(data.finance_amount.replace(new RegExp(",", 'g'), '')) + parseFloat(data.amortized.replace(new RegExp(",", 'g'), ''));
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

$(document).on('click', '.file-name', function () {
    var win = window.open($(this).data('url'));
});

$(document).on('click', '.viewSanction', function () {
    let id = $(this).parents('tr').first().data('id');
    let win = window.open('view-lease?id=' + id, '_blank');
});