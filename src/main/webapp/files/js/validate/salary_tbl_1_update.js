
$('#salaried_main_income_up,#salaried_addtnl_fix_income_up,#salaried_avarage_varialble_up,#salaried_additional_income_up').on('input', function () {
    var a = $('#salaried_main_income_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");
    var b = $('#salaried_addtnl_fix_income_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");
    var c = $('#salaried_avarage_varialble_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");
    var d = $('#salaried_additional_income_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");


    var a1 = parseFloat(a);
    var b1 = parseFloat(b);
    var c1 = parseFloat(c);
    var d1 = parseFloat(d);

    $('#salaried_total_income_label_up').val(a1 + b1 + c1 + d1).focusout();
    f1up();
});
$('#salaried_loan_rental_up,#salaried_od_interest_up,#salaried_credit_cards_up,#salaried_others_up,#salaried_proposed_up').on('input', function () {
    var a = $('#salaried_loan_rental_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");
    var b = $('#salaried_od_interest_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");
    var c = $('#salaried_credit_cards_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");
    var d = $('#salaried_others_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");
    var e = $('#salaried_proposed_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");


    var a1 = parseFloat(a);
    var b1 = parseFloat(b);
    var c1 = parseFloat(c);
    var d1 = parseFloat(d);
    var e1 = parseFloat(e);

    $('#salaried_total_financial_label_up').val(a1 + b1 + c1 + d1 + e1).focusout();
    f1up();
});

function f1up() {
    var t1 = $('#salaried_total_income_label_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");
    var t2 = $('#salaried_total_financial_label_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");

    var a1 = parseFloat(t1);
    var b1 = parseFloat(t2);
    $('#salaried_debit_service_cover_label_up').val(a1 / b1).focusout();
}


$('#salaried_main_income_up').keypress(function (e) {
    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
        return false;
});
$('#salaried_addtnl_fix_income_up').keypress(function (e) {
    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
        return false;
});
$('#salaried_avarage_varialble_up').keypress(function (e) {
    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
        return false;
});
$('#salaried_additional_income_up').keypress(function (e) {
    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
        return false;
});

$('#salaried_loan_rental_up').keypress(function (e) {
    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
        return false;
});
$('#salaried_od_interest_up').keypress(function (e) {
    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
        return false;
});
$('#salaried_credit_cards_up').keypress(function (e) {
    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
        return false;
});
$('#salaried_others_up').keypress(function (e) {
    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
        return false;
});
$('#salaried_proposed_up').keypress(function (e) {
    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
        return false;
});

