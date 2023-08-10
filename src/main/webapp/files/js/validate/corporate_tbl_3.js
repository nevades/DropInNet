
$('#coporate_annual_income').on('change', function () {
    var a = $('#coporate_annual_income').val().trim().replace(new RegExp(",", 'g'), '');
    var b = $('#coporate_proposed').val().trim().replace(new RegExp(",", 'g'), '');

    var a1 = parseFloat(a);
    var b1 = parseFloat(b);

    $('#coporate_average_monthly_calculation').val(a1 / 12).focusout();
    f3();
});
$('#coporate_average_monthly_calculation,#coporate__other_mnt_income,#coporate_addtional_mnth_income').on('change', function () {
    var a = $('#coporate_average_monthly_calculation').val().trim().replace(new RegExp(",", 'g'), '');
    var b = $('#coporate__other_mnt_income').val().trim().replace(new RegExp(",", 'g'), '');
    var c = $('#coporate_addtional_mnth_income').val().trim().replace(new RegExp(",", 'g'), '');

    var a1 = parseFloat(a);
    var b1 = parseFloat(b);
    var c1 = parseFloat(c);

    $('#coporate_total_income').val(a1 + b1 + c1).focusout();
    f3();
});

$('#coporate_proposed').on('change', function () {
    var a = $('#coporate_average_monthly_calculation').val().trim().replace(new RegExp(",", 'g'), '');
    var b = $('#coporate__other_mnt_income').val().trim().replace(new RegExp(",", 'g'), '');
    var c = $('#coporate_addtional_mnth_income').val().trim().replace(new RegExp(",", 'g'), '');

    var a1 = parseFloat(a);
    var b1 = parseFloat(b);
    var c1 = parseFloat(c);

    $('#coporate_total_income').val(a1 + b1 + c1).focusout();
    f3();
});

$('#coporate_annual_income').on('change', function () {
    var a = $('#coporate_average_monthly_calculation').val().trim().replace(new RegExp(",", 'g'), '');
    var b = $('#coporate__other_mnt_income').val().trim().replace(new RegExp(",", 'g'), '');
    var c = $('#coporate_addtional_mnth_income').val().trim().replace(new RegExp(",", 'g'), '');

    var a1 = parseFloat(a);
    var b1 = parseFloat(b);
    var c1 = parseFloat(c);

    $('#coporate_total_income').val(a1 + b1 + c1).focusout();
    f3();
});

$('#coporate_loan_rental,#coporate_od_interest,#coporate_others,#coporate_proposed').on('change', function () {
    var a = $('#coporate_loan_rental').val().trim().replace(new RegExp(",", 'g'), '');
    var b = $('#coporate_od_interest').val().trim().replace(new RegExp(",", 'g'), '');
    var d = $('#coporate_others').val().trim().replace(new RegExp(",", 'g'), '');
    var e = $('#coporate_proposed').val().trim().replace(new RegExp(",", 'g'), '');

    var a1 = parseFloat(a);
    var b1 = parseFloat(b);
    var d1 = parseFloat(d);
    var e1 = parseFloat(e);

    $('#coporate_total_financial_label').val(a1 + b1 + d1 + e1).focusout();
    f3();
});

function f3() {
    var t1 = $('#coporate_total_income').val().trim().replace(new RegExp(",", 'g'), '');
    var t2 = $('#coporate_total_financial_label').val().trim().replace(new RegExp(",", 'g'), '');

    var a1 = parseFloat(t1);
    var b1 = parseFloat(t2);

    if (a1 == '0' & b1 == '0') {
        $('#coporate_debit_service_cover_label').val(0).focusout();
    } else {
        $('#coporate_debit_service_cover_label').val(a1 / b1).focusout();
    }

}

//
//$('#coporate_annual_income').keypress(function (e) {
//    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
//        return false;
//});
//$('#coporate__other_mnt_income').keypress(function (e) {
//    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
//        return false;
//});
//$('#coporate_addtional_mnth_income').keypress(function (e) {
//    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
//        return false;
//});
//$('#coporate_loan_rental').keypress(function (e) {
//    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
//        return false;
//});
//
//$('#coporate_loan_rental_od_interest').keypress(function (e) {
//    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
//        return false;
//});
//$('#coporate_loan_rental_od_interest').keypress(function (e) {
//    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
//        return false;
//});
//$('#coporate_credit_cards').keypress(function (e) {
//    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
//        return false;
//});
//$('#coporate_others').keypress(function (e) {
//    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
//        return false;
//});
//$('#coporate_proposed').keypress(function (e) {
//    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
//        return false;
//});



