
$('#selfEmp_monthly_income,#selfEmp_netProfitMargin').on('change', function () {
    var a = $('#selfEmp_monthly_income').val().trim().replace(new RegExp(",", 'g'), '');
    var b = $('#selfEmp_netProfitMargin').val().trim().replace(new RegExp(",", 'g'), '');
    
    var a1 = parseFloat(a);
    var b1 = parseFloat(b);

    $('#selfEmp_netProfit').val((a1 * b1)/100).focusout();
    f2();
});
$('#selfEmp_netProfit,#selfEmp_otherFixed,#selfEmp_monthIncome,#selfEmp_additionalIncome').on('change', function () {
    var a = $('#selfEmp_netProfit').val().trim().replace(new RegExp(",", 'g'), '');
    var b = $('#selfEmp_otherFixed').val().trim().replace(new RegExp(",", 'g'), '');
    var c = $('#selfEmp_monthIncome').val().trim().replace(new RegExp(",", 'g'), '');
    var d = $('#selfEmp_additionalIncome').val().trim().replace(new RegExp(",", 'g'), '');

    var a1 = parseFloat(a);
    var b1 = parseFloat(b);
    var c1 = parseFloat(c);
    var d1 = parseFloat(d);

    $('#selfEmp_total_income').val(a1 + b1 + c1 + d1).focusout();
    f2();
});

$('#selfEmp_loan_rental,#selfEmp_od_interest,#selfEmp_credit_cards,#selfEmp_others,#selfEmp_proposed').on('change', function () {
    var a = $('#selfEmp_loan_rental').val().trim().replace(new RegExp(",", 'g'), '');
    var b = $('#selfEmp_od_interest').val().trim().replace(new RegExp(",", 'g'), '');
    var c = $('#selfEmp_credit_cards').val().trim().replace(new RegExp(",", 'g'), '');
    var d = $('#selfEmp_others').val().trim().replace(new RegExp(",", 'g'), '');
    var e = $('#selfEmp_proposed').val().trim().replace(new RegExp(",", 'g'), '');

    var a1 = parseFloat(a);
    var b1 = parseFloat(b);
    var c1 = parseFloat(c);
    var d1 = parseFloat(d);
    var e1 = parseFloat(e);

    $('#selfEmp_total_financial_label').val(a1 + b1 + c1 + d1 + e1).focusout();
    f2();
});


function f2() {
    var t1 = $('#selfEmp_total_income').val().trim().replace(new RegExp(",", 'g'), '');
    var t2 = $('#selfEmp_total_financial_label').val().trim().replace(new RegExp(",", 'g'), '');

    var a1 = parseFloat(t1);
    var b1 = parseFloat(t2);
    $('#selfEmp_debit_service_cover_label').val(a1 / b1).focusout();
}

//
//$('#selfEmp_monthly_income').keypress(function (e) {
//    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
//        return false;
//});
//$('#selfEmp_netProfitMargin').keypress(function (e) {
//    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
//        return false;
//});
//$('#selfEmp_netProfit').keypress(function (e) {
//    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
//        return false;
//});
//$('#selfEmp_otherFixed').keypress(function (e) {
//    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
//        return false;
//});
//
//$('#selfEmp_monthIncome').keypress(function (e) {
//    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
//        return false;
//});
//$('#selfEmp_additionalIncome').keypress(function (e) {
//    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
//        return false;
//});
//$('#selfEmp_loan_rental').keypress(function (e) {
//    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
//        return false;
//});
//$('#selfEmp_od_interest').keypress(function (e) {
//    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
//        return false;
//});
//$('#selfEmp_credit_cards').keypress(function (e) {
//    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
//        return false;
//});
//$('#selfEmp_others').keypress(function (e) {
//    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
//        return false;
//});
//$('#selfEmp_proposed').keypress(function (e) {
//    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
//        return false;
//});
