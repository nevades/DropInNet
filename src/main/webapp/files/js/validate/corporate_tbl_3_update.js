
$('#coporate_annual_income_up').on('input', function () {
    var a = $('#coporate_annual_income_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");
    var b = $('#coporate_proposed_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");

    var a1 = parseFloat(a);
    var b1 = parseFloat(b);

    $('#coporate_average_monthly_calculation_up').val(a1 / 12).focusout();
    f3up();
});
$('#coporate_average_monthly_calculation_up,#coporate__other_mnt_income_up,#coporate_addtional_mnth_income_up').on('input', function () {
    var a = $('#coporate_average_monthly_calculation_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");
    var b = $('#coporate__other_mnt_income_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");
    var c = $('#coporate_addtional_mnth_income_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");

    var a1 = parseFloat(a);
    var b1 = parseFloat(b);
    var c1 = parseFloat(c);

    $('#coporate_total_income_up').val(a1 + b1 + c1).focusout();
    f3up();
});

$('#coporate_proposed_up').on('input', function () {
    var a = $('#coporate_average_monthly_calculation_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");
    var b = $('#coporate__other_mnt_income_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");
    var c = $('#coporate_addtional_mnth_income_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");

    var a1 = parseFloat(a);
    var b1 = parseFloat(b);
    var c1 = parseFloat(c);

    $('#coporate_total_income_up').val(a1 + b1 + c1).focusout();
    f3up();
});

$('#coporate_annual_income_up').on('input', function () {
    var a = $('#coporate_average_monthly_calculation_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");
    var b = $('#coporate__other_mnt_income_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");
    var c = $('#coporate_addtional_mnth_income_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");

    var a1 = parseFloat(a);
    var b1 = parseFloat(b);
    var c1 = parseFloat(c);

    $('#coporate_total_income_up').val(a1 + b1 + c1).focusout();
    f3up();
});

$('#coporate_loan_rental_up,#coporate_od_interest_up,#coporate_others_up,#coporate_proposed_up').on('input', function () {
    var a = $('#coporate_loan_rental_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");
    var b = $('#coporate_od_interest_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");
    var d = $('#coporate_others_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");
    var e = $('#coporate_proposed_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");

    var a1 = parseFloat(a);
    var b1 = parseFloat(b);
    var d1 = parseFloat(d);
    var e1 = parseFloat(e);

    $('#coporate_total_financial_label_up').val(a1 + b1 + d1 + e1).focusout();
    f3up();
});

function f3up() {
    var t1 = $('#coporate_total_income_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");
    var t2 = $('#coporate_total_financial_label_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");

    var a1 = parseFloat(t1);
    var b1 = parseFloat(t2);
    $('#coporate_debit_service_cover_label_up').val(a1 / b1).focusout();
}


$('#coporate_annual_income_up').keypress(function (e) {
    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
        return false;
});
$('#coporate__other_mnt_income_up').keypress(function (e) {
    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
        return false;
});
$('#coporate_addtional_mnth_income_up').keypress(function (e) {
    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
        return false;
});
$('#coporate_loan_rental_up').keypress(function (e) {
    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
        return false;
});

$('#coporate_loan_rental_od_interest_up').keypress(function (e) {
    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
        return false;
});
$('#coporate_loan_rental_od_interest_up').keypress(function (e) {
    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
        return false;
});
$('#coporate_credit_cards_up').keypress(function (e) {
    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
        return false;
});
$('#coporate_others_up').keypress(function (e) {
    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
        return false;
});
$('#coporate_proposed_up').keypress(function (e) {
    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
        return false;
});



