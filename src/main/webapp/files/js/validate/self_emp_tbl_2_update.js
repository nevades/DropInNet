
$('#selfEmp_monthly_income_up,#selfEmp_netProfitMargin_up').on('input', function () {
    var a = $('#selfEmp_monthly_income_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");
    var b = $('#selfEmp_netProfitMargin_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");
    
    var a1 = parseFloat(a);
    var b1 = parseFloat(b);

    $('#selfEmp_netProfit_up').val((a1 * b1)/100).focusout();
    f2up();
});
$('#selfEmp_netProfit_up,#selfEmp_otherFixed_up,#selfEmp_monthIncome_up,#selfEmp_additionalIncome_up').on('input', function () {
    var a = $('#selfEmp_netProfit_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");
    var b = $('#selfEmp_otherFixed_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");
    var c = $('#selfEmp_monthIncome_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");
    var d = $('#selfEmp_additionalIncome_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");

    var a1 = parseFloat(a);
    var b1 = parseFloat(b);
    var c1 = parseFloat(c);
    var d1 = parseFloat(d);

    $('#selfEmp_total_income_up').val(a1 + b1 + c1 + d1).focusout();
    f2up();
});

$('#selfEmp_loan_rental_up,#selfEmp_od_interest_up,#selfEmp_credit_cards_up,#selfEmp_others_up,#selfEmp_proposed_up').on('input', function () {
    var a = $('#selfEmp_loan_rental_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");
    var b = $('#selfEmp_od_interest_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");
    var c = $('#selfEmp_credit_cards_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");
    var d = $('#selfEmp_others_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");
    var e = $('#selfEmp_proposed_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");

    var a1 = parseFloat(a);
    var b1 = parseFloat(b);
    var c1 = parseFloat(c);
    var d1 = parseFloat(d);
    var e1 = parseFloat(e);

    $('#selfEmp_total_financial_label_up').val(a1 + b1 + c1 + d1 + e1).focusout();
    f2up();
});


function f2up() {
    var t1 = $('#selfEmp_total_income_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");
    var t2 = $('#selfEmp_total_financial_label_up').val().replace(",", "").replace(",", "").replace(",", "").replace(",", "").replace(",", "");

    var a1 = parseFloat(t1);
    var b1 = parseFloat(t2);
    $('#selfEmp_debit_service_cover_label_up').val(a1 / b1).focusout();
}


$('#selfEmp_monthly_income_up').keypress(function (e) {
    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
        return false;
});
$('#selfEmp_netProfitMargin_up').keypress(function (e) {
    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
        return false;
});
$('#selfEmp_netProfit_up').keypress(function (e) {
    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
        return false;
});
$('#selfEmp_otherFixed_up').keypress(function (e) {
    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
        return false;
});

$('#selfEmp_monthIncome_up').keypress(function (e) {
    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
        return false;
});
$('#selfEmp_additionalIncome_up').keypress(function (e) {
    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
        return false;
});
$('#selfEmp_loan_rental_up').keypress(function (e) {
    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
        return false;
});
$('#selfEmp_od_interest_up').keypress(function (e) {
    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
        return false;
});
$('#selfEmp_credit_cards_up').keypress(function (e) {
    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
        return false;
});
$('#selfEmp_others_up').keypress(function (e) {
    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
        return false;
});
$('#selfEmp_proposed_up').keypress(function (e) {
    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
        return false;
});
