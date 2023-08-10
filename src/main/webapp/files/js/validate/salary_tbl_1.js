
$('#salaried_main_income,#salaried_addtnl_fix_income,#salaried_avarage_varialble,#salaried_additional_income').on('change', function () {
    var a = $('#salaried_main_income').val().trim().replace(new RegExp(",", 'g'), '');
    var b = $('#salaried_addtnl_fix_income').val().trim().replace(new RegExp(",", 'g'), '');
    var c = $('#salaried_avarage_varialble').val().trim().replace(new RegExp(",", 'g'), '');
    var d = $('#salaried_additional_income').val().trim().replace(new RegExp(",", 'g'), '');
    

    var a1 = parseFloat(a);
    var b1 = parseFloat(b);
    var c1 = parseFloat(c);
    var d1 = parseFloat(d);

    $('#salaried_total_income_label').val(a1 + b1 + c1 + d1).focusout();
    f1();
});
$('#salaried_loan_rental,#salaried_od_interest,#salaried_credit_cards,#salaried_others,#salaried_proposed').on('change', function () {
    var a = $('#salaried_loan_rental').val().trim().replace(new RegExp(",", 'g'), '');
    var b = $('#salaried_od_interest').val().trim().replace(new RegExp(",", 'g'), '');
    var c = $('#salaried_credit_cards').val().trim().replace(new RegExp(",", 'g'), '');
    var d = $('#salaried_others').val().trim().replace(new RegExp(",", 'g'), '');
    var e = $('#salaried_proposed').val().trim().replace(new RegExp(",", 'g'), '');

    var a1 = parseFloat(a);
    var b1 = parseFloat(b);
    var c1 = parseFloat(c);
    var d1 = parseFloat(d);
    var e1 = parseFloat(e);

    $('#salaried_total_financial_label').val(a1 + b1 + c1 + d1 + e1).focusout();
    f1();
});

function f1() {
    var t1 = $('#salaried_total_income_label').val().trim().replace(new RegExp(",", 'g'), '');
    var t2 = $('#salaried_total_financial_label').val().trim().replace(new RegExp(",", 'g'), '');

    var a1 = parseFloat(t1);
    var b1 = parseFloat(t2);
    $('#salaried_debit_service_cover_label').val(a1 / b1).focusout();
    
}

//
//$('#salaried_main_income').keypress(function (e) {
//    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
//        return false;
//});
//$('#salaried_addtnl_fix_income').keypress(function (e) {
//    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
//        return false;
//});
//$('#salaried_avarage_varialble').keypress(function (e) {
//    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
//        return false;
//});
//$('#salaried_additional_income').keypress(function (e) {
//    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
//        return false;
//});
//
//$('#salaried_loan_rental').keypress(function (e) {
//    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
//        return false;
//});
//$('#salaried_od_interest').keypress(function (e) {
//    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
//        return false;
//});
//$('#salaried_credit_cards').keypress(function (e) {
//    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
//        return false;
//});
//$('#salaried_others').keypress(function (e) {
//    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
//        return false;
//});
//$('#salaried_proposed').keypress(function (e) {
//    if (isNaN(this.value + "" + String.fromCharCode(e.charCode)))
//        return false;
//});

