/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


// wordings

var a = ['', 'One ', 'Two ', 'Three ', 'Four ', 'Five ', 'Six ', 'Seven ', 'Eight ', 'Nine ', 'Ten ', 'Eleven ', 'Twelve ', 'Thirteen ', 'Fourteen ', 'Fifteen ', 'Sixteen ', 'Seventeen ', 'Eighteen ', 'Nineteen '];
var b = ['', '', 'Twenty', 'Thirty', 'Forty', 'Fifty', 'Sixty', 'Seventy', 'Eighty', 'Ninety'];

function inWords(num) {

    if ((num = num.toString()).length > 10)
        return 'overflow';
    n = ('0000000000' + num).substr(-10).match(/^(\d{4})(\d{1})(\d{2})(\d{1})(\d{2})$/);

    if (!n) {
        return;
    }
    var str = '';

    str += (n[1] != 0) ? (a[Number(n[1])] || b[n[1][0]] + ' ' + a[n[1][1]]) + 'Million ' : '';
    str += (n[2] != 0) ? (a[Number(n[2])] || b[n[2][0]] + ' ' + a[n[2][1]]) + 'Hundred Thousand ' : '';
    str += (n[3] != 0) ? (a[Number(n[3])] || b[n[3][0]] + ' ' + a[n[3][1]]) + 'Thousand ' : '';
    str += (n[4] != 0) ? (a[Number(n[4])] || b[n[4][0]] + ' ' + a[n[4][1]]) + 'Hundred ' : '';
    str += (n[5] != 0) ? ((str != '') ? 'and ' : '') + (a[Number(n[5])] || b[n[5][0]] + ' ' + a[n[5][1]]) + 'only ' : '';
    console.log(n);
    return str;
}


// main table approved list

let proposals2 = $('#maintable2').DataTable({
    "bLengthChange": true,
    "bInfo": true,
    "aLengthMenu": [[5, 10, 15], [5, 10, 15]],
    "ordering": true,
    "autoWidth": false,
    "processing": true,
    "serverSide": true,
    "order": [[0, "desc"]],
    "ajax": {
        "url": "Letter/searchApproved",
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
        {"data": "pid"},
        {"data": "id"},
        {"data": "product"},
        {"data": "cusType"},
        {"data": "cusName"},
        {"data": "amount"},
        {"data": "cid"},
    ], "language": {
        'loadingRecords': '&nbsp;',
        'processing': '<div class="loader2"></div>'
    }, "createdRow": function (row, data) {
        let action_td = document.createElement('td');
        $(action_td).addClass('text-center');
        $(row).find('td').eq(6).hide();
        //console.log(data);
        if (data.product == 'Trade Finance') {
            $(action_td).append('<a href="javascript:void(0)" class="offer_letter_commodities"><i class="f-w-600 f-16 m-r-10 text-c-blue">OLC</i></a><a href="javascript:void(0)" class="offer_letter_vehicle"><i class="f-w-600 f-16 m-r-10 text-c-blue">OLV</i></a><a href="javascript:void(0)" class="general_letter"><i class="f-w-600 f-16 m-r-10 text-c-blue">GC</i></a>');

        } else {
            $(action_td).append('<a href="javascript:void(0)" class="offer_letter"><i class="f-w-600 f-16 m-r-10 text-c-blue">OL</i></a><a href="javascript:void(0)" class="general_letter"><i class="f-w-600 f-16 m-r-10 text-c-blue">GC</i></a>');

        }

        $(row).append(action_td);
    }
});



$(document).on('click', '.offer_letter', function () {

    let proposal_id = $(this).parents('tr').first().find('td').eq(0).html().trim();
    let product_id = $(this).parents('tr').first().find('td').eq(1).html().trim();
    let product_type = $(this).parents('tr').first().find('td').eq(2).html().trim();
    let cus_type = $(this).parents('tr').first().find('td').eq(3).html().trim();
    let cus_id = $(this).parents('tr').first().find('td').eq(6).html().trim();

    if (product_type == 'Revolving Loan' && cus_type == 'Retail') {

        $('#cusname_revo_indi').html("");
        $('#revo_curDate').html("");
        $('#addrs1_revo').html("");
        $('#addrs2_revo').html("");
        $('#city_revo').html("");
        $('#limit_revo').html("");
        $('#ftype_revo_indi').html("");
        $('#pupose_revo_indi').html("");
        $('#facility_amt_revo_indi1').html("");
        $('#facility_amt_revo_indi2').html("");
        $('#Availability_Period').html("");
        $('#Rate_1').html("");
        $('#Rate_2').html("");
        $('#secur1').html("");
        $('#secur2').html("");
        $('#sec_amt1').html("");
        $('#sec_amt2').html("");
        $('#repayment_indi').html("");

        $.post('offer_letters', {type: "get_letterData", proposal_id: proposal_id, cus_id: cus_id, product_id: product_id}, function (res) {

            console.log(JSON.parse(res));

            let data = JSON.parse(res);
            let curdate = data.curdate;
            let addr1 = data.ad1;
            let addr2 = data.ad2;
            let city = data.city;
            let cusname = data.cusname;
            let PURPOSE = data.purpose;
            let facility_type = data.facility_type;
            let facility_amt = data.facility_amt;
            let Availability_Period = data.Availability_Period;
            let Rate = data.Rate;
            let secur1 = data.secur1;
            let secur2 = data.secur2;
            let secur1_amt = data.secur1_amt;
            let secur2_amt = data.secur2_amt;
            let repayment_plan = data.repayment_plan;



            $('#cusname_revo_indi').html(cusname);
            $('#revo_curDate').html(curdate)
            $('#addrs1_revo').html(addr1);
            $('#addrs2_revo').html(addr2);
            $('#city_revo').html(city);
            $('#limit_revo').html(facility_amt);
            $('#ftype_revo_indi').html(facility_type);
            $('#pupose_revo_indi').html(PURPOSE);
            $('#facility_amt_revo_indi1').html(facility_amt);
            $('#Availability_Period').html(Availability_Period);
            $('#Rate_1').html(Rate);
            $('#Rate_2').html(Rate);
            $('#secur1').html(secur1);
            $('#secur2').html(secur2);
            $('#sec_amt1').html(secur1_amt);
            $('#sec_amt2').html(secur2_amt);
            $('#repayment_indi').html(repayment_plan);


        });

        $('#revo_individual_modal').modal('show');

    } else if (product_type == 'Revolving Loan' && cus_type == 'Corporate') {

        $('#curdate_revo_corpo').html("");
        $('#adr1').html("");
        $('#adr2').html("");
        $('#city_corpo').html("");
        $('#limit_corpo').html("");
        $('#ftype_revo_corpo').html("");
        $('#pupose_revo_corpo').html("");
        $('#facility_amt_revo_corpo1').html("");
        $('#facility_amt_revo_corpo2').html("");
        $('#Availability_Period_corpo').html("");
        $('#revo_rate_1').html("");
        $('#revo_rate_2').html("");
        $('#revo_secu1').html("");
        $('#revo_secu2').html("");
        $('#revo_secu1_amt1').html("");
        $('#revo_secu1_amt2').html("");
        $('#revo_secu1_amt2').html("");
        $('#repayment_corpo').html("");

        $.post('offer_letters', {type: "get_letterData", proposal_id: proposal_id, cus_id: cus_id, product_id: product_id}, function (res) {

            console.log(JSON.parse(res));

            let data = JSON.parse(res);
            let curdate = data.curdate;
            let addr1 = data.ad1;
            let addr2 = data.ad2;
            let city = data.city;
            let limit = data.limit;
            let PURPOSE = data.purpose;
            let facility_type = data.facility_type;
            let facility_amt = data.facility_amt;
            let Availability_Period = data.Availability_Period;
            let Rate = data.Rate;
            let secur1 = data.secur1;
            let secur2 = data.secur2;
            let secur1_amt = data.secur1_amt;
            let secur2_amt = data.secur2_amt;
            let repayment_plan = data.repayment_plan;

            $('#curdate_revo_corpo').html(curdate)
            $('#adr1').html(addr1);
            $('#adr2').html(addr2);
            $('#city_corpo').html(city);
            //$('#limit_corpo').html(limit);
            $('#limit_corpo').html(facility_amt);
            $('#ftype_revo_corpo').html(facility_type);
            $('#pupose_revo_corpo').html(PURPOSE);
            $('#facility_amt_revo_corpo1').html(facility_amt);
            $('#facility_amt_revo_corpo2').html(facility_amt);
            $('#Availability_Period_corpo').html(Availability_Period);
            $('#revo_rate_1').html(Rate);
            $('#revo_rate_2').html(Rate);
            $('#revo_secu1').html(secur1);
            $('#revo_secu2').html(secur2);
            $('#revo_secu1_amt1').html(secur1_amt);
            $('#revo_secu1_amt2').html(secur2_amt);
            $('#repayment_corpo').html(repayment_plan);

        });


        $('#revo_corporate_modal').modal('show');

    } else if (product_type == 'Term Loan' && cus_type == 'Retail') {

        $('#t_i_lno2').html($('#t_i_lno').html());

        $('#term_indi_curdate').html("");
        $('#term_indi_name').html("");
        $('#term_ad1').html("");
        $('#term_ad2').html("");
        $('#term_city').html("");
        $('#term_indi_limit').html("");
        $('#ftype_term_indi').html("");
        $('#pupose_term_indi').html("");
        $('#facility_amt_term_indi1').html("");
        $('#facility_amt_term_indi2').html("");
        $('#Availability_Period_term_indi').html("");
        $('#Rate_1_term_indi').html("");
        $('#Rate_2_term_indi').html("");
        $('#secur1_term_indi').html("");
        $('#term_indi_title').html("");
        //$('#secur2_term_indi').html("");
        //$('#sec_amt1_term_indi').html("");
        //$('#sec_amt2_term_indi').html("");

        $.post('offer_letters', {type: "get_letterData", proposal_id: proposal_id, cus_id: cus_id, product_id: product_id}, function (res) {

            console.log(JSON.parse(res));

            let data = JSON.parse(res);
            let curdate = data.curdate;
            let fname = data.cusname;
            let tr_title = data.title;
            let addr1 = data.ad1;
            let addr2 = data.ad2;
            let city = data.city;
            let PURPOSE = data.purpose;
            let facility_type = data.facility_type;
            let facility_amt = data.facility_amt;
            let facility_amtW = data.facility_amt.replace(".00", "").replace(new RegExp(",", 'g'), '');
            let repayment_plan_t_i = data.repayment_plan;
            let Availability_Period = data.Availability_Period;
            let Rate = data.Rate;
            let t_i_nic = data.nic;
            let letter_data_t_i = data.letter_data;


            $('#term_indi_curdate').html(curdate);
            $('#term_indi_title').html(tr_title);
            $('#term_indi_name').html(fname);
            $('#t_i_name2').html(fname);
            $('#term_ad1').html(addr1);
            $('#term_ad2').html(addr2);
            $('#term_city').html(city);
            $('#term_indi_limit').html(facility_amt);
            $('#ftype_term_indi').html(facility_type);
            $('#pupose_term_indi').html(PURPOSE);
            $('#facility_amt_term_indi1').html(facility_amt);
            $('#facility_amt_term_indi2').html(inWords(facility_amtW));

            $('#Availability_Period_term_indi').html(Availability_Period);
            $('#Availability_Period_term_indi_word').html(inWords(parseInt(Availability_Period)).replace('only',' '));
            $('#Rate_1_term_indi').html(Rate);
            $('#Rate_1_term_indi2').html(inWords(parseInt(Rate)).replace('only',' '));
            var d = $('#secur1_term_indi').html(letter_data_t_i);
            $('#secur1_term_indi').html(d.find('span').html());
            $('#I_nameLast').html(fname);
            $('#I_nicLast').html(t_i_nic);
            $('#I_dateLast').html(curdate);


            // $('#secur2_term_indi').html(secur2);
            //$('#sec_amt1_term_indi').html(secur1_amt);
            //$('#sec_amt2_term_indi').html(secur2_amt);
            $('#term_indi_repaybl').html(repayment_plan_t_i);
            $('#t_i_nic2').html(t_i_nic);

        });

        $('#termLoan_individual_modal').modal('show');

    } else if (product_type == 'Term Loan' && cus_type == 'Corporate') {


        $('#term_cor_curdate').html("");
        $('#adr_cor1').html("");
        $('#adr_cor2').html("");
        $('#city_terrm_cor').html("");
        $('#term_cor_limit').html("");
        $('#ftype_term_cor').html("");
        $('#pupose_term_cor').html("");
        $('#facility_amt_term_cor1').html("");
        $('#facility_amt_term_cor2').html("");
        $('#Availability_Period_term_cor').html("");
        $('#Rate_1_term_cor').html("");
        $('#Rate_2_term_cor').html("");
        $('#secur1_term_cor').html("");
        $('#secur2_term_cor').html("");



        $.post('offer_letters', {type: "get_letterData", proposal_id: proposal_id, cus_id: cus_id, product_id: product_id}, function (res) {

            console.log(JSON.parse(res));

            let data = JSON.parse(res);
            let curdate = data.curdate;
            let addr1 = data.ad1;
            let addr2 = data.ad2;
            let city = data.city;
            let PURPOSE = data.purpose;
            let facility_type = data.facility_type;
            let facility_amt = data.facility_amt;
            let Availability_Period = data.Availability_Period;
            let Rate = data.Rate;
            let secur1 = data.secur1;
            let secur2 = data.secur2;
//            let secur1_amt = data.secur1_amt;
//            let secur2_amt = data.secur2_amt;
//            let repayment_plan = data.repayment_plan;

            $('#term_cor_curdate').html(curdate)
            $('#adr_cor1').html(addr1);
            $('#adr_cor2').html(addr2);
            $('#city_terrm_cor').html(city);

            $('#term_cor_limit').html(facility_amt);
            $('#ftype_term_cor').html(facility_type);
            $('#pupose_term_cor').html(PURPOSE);
            $('#facility_amt_term_cor1').html(facility_amt);
            $('#facility_amt_term_cor2').html(facility_amt);
            $('#Availability_Period_term_cor').html(Availability_Period);
            $('#Rate_1_term_cor').html(Rate);
            $('#Rate_2_term_cor').html(Rate);
            $('#secur1_term_cor').html(secur1);
            $('#secur2_term_cor').html(secur2);


        });

        $('#termLoan_corporate_modal').modal('show');

    }




});

$(document).on('click', '.offer_letter_commodities', function () {

    $('#commodities_modal').modal('show');
});

$(document).on('click', '.offer_letter_vehicle', function () {

    $('#vehicles_modal').modal('show');
});

$(document).on('click', '.general_letter', function () {

    let id = $(this).parents('tr').first().find('td').eq(0).html().trim();
    let product_type = $(this).parents('tr').first().find('td').eq(2).html().trim();
    let cus_type = $(this).parents('tr').first().find('td').eq(3).html().trim();

    if (product_type == 'Revolving Loan') {
        $('#revo_general_modal').modal('show');

    } else if (product_type == 'Term Loan') {
        $('#termLoan_general_modal').modal('show');

    } else if (product_type == 'Trade Finance') {
        $('#TF_general_modal').modal('show');

    } else if (product_type == 'Pledge Loans') {
        $('#pledgeLoan_general_modal').modal('show');

    }

});



      