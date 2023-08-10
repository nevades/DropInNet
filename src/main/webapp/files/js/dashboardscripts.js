
function reloadTable() {
    document.getElementById("main_table").innerHTML = "";
    document.getElementById("main_table").innerHTML = "      <div class=\"loader2\"></div>  ";

}



   function loadDashboardData() {
        $.post('dashboardControl/getDashboardLeasingData', function (response) {
            var data = "";
            data = JSON.parse(response);
            //document.getElementById('pending_id').innerHTML = data.pending_leasing;
            //document.getElementById('approved_id').innerHTML = data.approved_leasing;
            //document.getElementById('return_id').innerHTML = data.return_leasing;
            //document.getElementById('reject_id').innerHTML = data.reject_leasing;
            //document.getElementById('forward_id').innerHTML = data.forward_leasing;
            //document.getElementById('colamt').innerHTML = data.cash_collection;
            document.getElementById('hott').innerHTML = data.hot;
            document.getElementById('coldd').innerHTML = data.cold;
            document.getElementById('warmm').innerHTML = data.warm;
            document.getElementById('pprospetingl').innerHTML = data.prospecting;
            document.getElementById('inp').innerHTML = data.inp;
            document.getElementById('pcnt').innerHTML = data.credit_approval_cnt;
            document.getElementById('ccount').innerHTML = data.active;
            document.getElementById('devapprovalcnt').innerHTML = data.deviation_cnt;
            document.getElementById('rejectedcnt').innerHTML = data.rejected_cnt;
            document.getElementById('pendingctivationcnt').innerHTML = data.pendingctivationcnt_cnt;
        });
    }

function leadtables(d) {
    $.post('dashboardControl/searchDashboardHotLeads', {d: d}, function (res) {
        var dat = JSON.parse(res);
        console.log(dat);
        var table = new Table(dat.rows);
        table.setTitle(dat.thead);
        $('#main_table').html(table.display());
        $('#main_table').find('table').DataTable({
            "ordering": true,
            "aLengthMenu": [[10, 15, 25], [10, 15, 25]],
            "order": [[0, 'asc']],
            "language": {
                'loadingRecords': '&nbsp;',
                'processing': '<div class="loader2"></div>'
            }, "createdRow": function (row, data) {
                let action_td = document.createElement('td');
                $(action_td).addClass('text-center');
                $(action_td).append('<a href="javascript:void(0)" class="viewLead"><i class="icon feather icon-list f-w-600 f-16 m-r-10 text-c-blue"></i></a>');
                $(row).append(action_td);
                $(row).data('id', data['id']);
                setTableStatus($(row).find('td').eq(9));
                $(row).find('td').eq(8).hide();
            }

        });

    });
}

function leasetables(d) {
    $.post('dashboardControl/searchBranchDashboardLease', {d: d}, function (res) {
        var dat = JSON.parse(res);
        var table = new Table(dat.rows);
        table.setTitle(dat.thead);
        $('#main_table').html(table.display());
        $('#main_table').find('table').DataTable({
            "columnDefs": [
                {className: "text-right", "targets": [4, 5, 6]}
            ],
            "ordering": true,
            "aLengthMenu": [[10, 15, 25], [10, 15, 25]],
            "order": [[0, 'asc']],
            "language": {
                'loadingRecords': '&nbsp;',
                'processing': '<div class="loader2"></div>'
            }, "createdRow": function (row, data) {
                let action_td = document.createElement('td');
                $(action_td).addClass('text-center');
                $(action_td).append('<a href="javascript:void(0)" class="viewSanction"><i class="icon feather icon-list f-w-600 f-16 m-r-10 text-c-blue"></i></a>');
                $(row).append(action_td);
                $(row).data('id', data['id']);
                setTableStatus($(row).find('td').eq(8));
                $(row).find('td').eq(8).hide();
            }
        });
    });
}


function leaseapprove(d) {

    $.post('dashboardControl/searchDashboardLeasing', {d: d}, function (res) {
        var dat = JSON.parse(res);
        var table = new Table(dat.rows);
        table.setTitle(dat.thead);
        $('#main_table').html(table.display());
        $('#main_table').find('table').DataTable({
            "columnDefs": [
                {className: "text-right", "targets": [3, 4]}
            ],
            "ordering": true,
            "aLengthMenu": [[10, 15, 25], [10, 15, 25]],
            "order": [[0, 'asc']],
            "language": {
                'loadingRecords': '&nbsp;',
                'processing': '<div class="loader2"></div>'
            }, "createdRow": function (row, data) {
                let action_td = document.createElement('td');
                $(action_td).addClass('text-center');
                $(action_td).append('<a href="javascript:void(0)" class="viewSanction"><i class="icon feather icon-list f-w-600 f-16 m-r-10 text-c-blue"></i></a>');
                $(row).append(action_td);
                $(row).data('id', data['id']);
                setTableStatus($(row).find('td').eq(8));
                $(row).find('td').eq(8).hide();
            }
        });
    });
}





$(document).on('click', '.viewSanction', function () {
    var currentRow = $(this).closest("tr");
    var id = currentRow.find("td:eq(8)").text();
    var win = window.open('view-lease?id=' + id, '_blank');
});



$(document).on('click', '.viewLead', function () {
    var currentRow = $(this).closest("tr");
    var code = currentRow.find("td:eq(8)").text();
    var ld_ocde = currentRow.find("td:eq(0)").text();

    $('#upid').val("");
    $('#upid').val(code);
    clear2();
    $('#lead_id').val(ld_ocde);
    loadData(code);
    $('#lead_modal').modal('show');
});
var repayment_type = new SlimSelect({
    select: '#repayment_type',
    placeholder: "Please Select",
    allowDeselect: true,
    deselectLabel: '<span class="red">?</span>'
});

function loadData(code) {

    loadDiv('#addfrm');
    $('#lease_amt').val("");
    $('#tenor').val("");
    $('#interest').val("");
    $('#rent_amt').val("");
    $('#productNotes').html("");
    repayment_type.set(0);
    sel_product2.set(0);
    $('#tbl').find('tbody').html("");

    $.post('lead/loadData', {id: code}, function (res) {
        var dat = JSON.parse(res);
        console.log(dat);

        $('#nic').val(dat.nic);
        $('#fname').val(dat.fname);
        $('#short_name').val(dat.short_name);
        $('#dob').val(dat.dob);
        $('#email').val(dat.email);
        $('#mobile').val(dat.mobile);
        $('#telephone').val(dat.telephone);
        $('#p_address_l').val(dat.p_address_l);
        $('#p_address_2').val(dat.p_address_2);
        $('#c_address_l').val(dat.c_address_l);
        $('#c_address_2').val(dat.c_address_2);
        $('#followup').val(dat.followup);
        $('#followup_action').val(dat.followup_action);

        $('#lease_amt').val(dat.cal_leaseAmount);
        $('#tenor').val(dat.cal_tenor);
        $('#interest').val(dat.cal_interest);
        //$('#repayment_type').val(dat.cal_repaymentType);


        if (dat.title_val) {
            let p = {};
            p.value = dat.title_val;
            p.text = dat.title_txt;
            let ar = [p];
            console.log(ar);
            sel_title.setData(ar);
            sel_title.set(dat.title_val);
        }
        if (dat.gender_val) {
            let p = {};
            p.value = dat.gender_val;
            p.text = dat.gender_txt;
            let ar = [p];
            console.log(ar);
            sel_gender.setData(ar);
            sel_gender.set(dat.gender_val);
        }
        if (dat.mkofficer_val) {
            let p = {};
            p.value = dat.mkofficer_val;
            p.text = dat.mkofficer_txt;
            let ar = [p];
            console.log(ar);
            sel_mkofficer.setData(ar);
            sel_mkofficer.set(dat.mkofficer_val);
        }
        if (dat.branch_val) {
            let p = {};
            p.value = dat.branch_val;
            p.text = dat.branch_txt;
            let ar = [p];
            console.log(ar);
            sel_branch.setData(ar);
            sel_branch.set(dat.branch_val);
        }
        if (dat.vbranch_val) {
            let p = {};
            p.value = dat.vbranch_val;
            p.text = dat.vbranch_txt;
            let ar = [p];
            console.log(ar);
            sel_vbranch.setData(ar);
            sel_vbranch.set(dat.vbranch_val);
        }
        if (dat.pcity_val) {
            let p = {};
            p.value = dat.pcity_val;
            p.text = dat.pcity_txt;
            let ar = [p];
            console.log(ar);
            sel_p_city.setData(ar);
            sel_p_city.set(dat.pcity_val);
        }
        if (dat.ccity_val) {
            let p = {};
            p.value = dat.ccity_val;
            p.text = dat.ccity_txt;
            let ar = [p];
            console.log(ar);
            sel_c_city.setData(ar);
            sel_c_city.set(dat.ccity_val);
        }
        if (dat.channel_val) {
            let p = {};
            p.value = dat.channel_val;
            p.text = dat.channel_txt;
            let ar = [p];
            console.log(ar);
            sel_channel.setData(ar);
            sel_channel.set(dat.channel_val);
        }
        if (dat.product_val) {
            let p = {};
            p.value = dat.product_val;
            p.text = dat.product_txt;
            let ar = [p];
            console.log(ar);
            sel_product.setData(ar);
            sel_product.set(dat.product_val);
        }
        if (dat.stage_val) {
            let p = {};
            p.value = dat.stage_val;
            p.text = dat.stage_txt;
            let ar = [p];
            console.log(ar);
            sel_stage.setData(ar);
            sel_stage.set(dat.stage_val);
        }
        if (dat.cal_product_val) {
            let p = {};
            p.value = dat.cal_product_val;
            p.text = dat.cal_product_txt;
            let ar = [p];
            console.log(ar);
            sel_product2.setData(ar);
            sel_product2.set(dat.cal_product_val);
        }
        if (dat.cal_repaymentType) {
            let p = {};
            p.value = dat.cal_repaymentType;
            p.text = "Equated Balance";
            let ar = [p];
            console.log(ar);
            repayment_type.setData(ar);
            repayment_type.set(dat.cal_repaymentType);
        }

        $('#stage').click();
        $('#calculateBtn').click();
        finishLoadDiv('#addfrm');
    });
}



function clear2() {
    $('#menu1').find('select').each(function () {
        if ($(this).data('select')) {
            if ($(this).data('select').ajax) {
                $(this).data('select').data.data = [];
            }
            $(this).data('select').set('');
        }
    });
    sel_title.set('');
    $('#fname').val("");
    $('#lead_id').val("");
    $('#short_name').val("");
    sel_gender.set(0);
    $('#dob').val("");
    $('#email').val("");
    $('#mobile').val("");
    $('#telephone').val("");
    sel_mkofficer.set(0);
    sel_branch.set(0);
    sel_vbranch.set(0);
    $('#p_address_l').val("");
    $('#p_address_2').val("");
    sel_p_city.set(0);
    $('#c_address_l').val("");
    $('#c_address_2').val("");
    sel_c_city.set(0);
    sel_channel.set(0);
    sel_product.set(0);
    $('#followup').val("");
    $('#followup_action').val("");
    sel_stage.set(0);
}

var bs = false;
var rs = false;
var dbdata = null;
function  loadBusinessSpeedo(data) {
    if (!bs) {
        $('#cmb').find('.card-body').prepend('<canvas id="spd_1"  height="100" ></canvas>');
        var s_1 = $('#spd_1')[0];



        if (data.lccm) {
            $('#lctable').find('td').eq(1).html(data.lccm);
            $('#lctable').find('td').eq(1).attr("style", "cursor:pointer");
            $('#lctable').find('td').eq(1).click(function () {
                loadLcContracts("cm");
            });
        }

        if (data.lcytd) {
            $('#lctable').find('td').eq(2).html(data.lcytd);
            $('#lctable').find('td').eq(2).attr("style", "cursor:pointer");
            $('#lctable').find('td').eq(2).click(function () {
                loadLcContracts("ytd");
            });
        }

        $('#cashcol').find('tbody').find('tr').each(function () {
            $(this).find('td').css('cursor', 'pointer');
            $(this).find('td').hover(function () {
                $(this).css("color", "blue");
                $(this).css("font-weight", "bold");
            }, function () {
                $(this).css("color", "");
                $(this).css("font-weight", "");
            });
            let dir = $(this).attr("id").replace("m", "");
            $(this).find('td').click(function () {
                let bkt = $(this).index();
                loadMovement(bkt, dir);
            });
        });
        bs = true;
    }
}




function loadDashboard() {
    $.post('company', {action: 'c1'}, function (res) {

        var data = JSON.parse(res);
        dbdata = data;


    });
}


let helpSvg = `<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-question-circle-fill" viewBox="0 0 16 16">
                                                                    <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM5.496 6.033h.825c.138 0 .248-.113.266-.25.09-.656.54-1.134 1.342-1.134.686 0 1.314.343 1.314 1.168 0 .635-.374.927-.965 1.371-.673.489-1.206 1.06-1.168 1.987l.003.217a.25.25 0 0 0 .25.246h.811a.25.25 0 0 0 .25-.25v-.105c0-.718.273-.927 1.01-1.486.609-.463 1.244-.977 1.244-2.056 0-1.511-1.276-2.241-2.673-2.241-1.267 0-2.655.59-2.75 2.286a.237.237 0 0 0 .241.247zm2.325 6.443c.61 0 1.029-.394 1.029-.927 0-.552-.42-.94-1.029-.94-.584 0-1.009.388-1.009.94 0 .533.425.927 1.01.927z"/>
                                                                    </svg>`;
$('.helper').append(helpSvg);
try {
    loadDashboard();
} catch (e) {
}



$(document).on('click', '.approvebtn', function () {
    //      document.getElementById("addCard").style.display="block";
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

function clearFields() {
    $('#coBorrowerList').find('tbody').html('');
    $('#guarantorList').find('tbody').html('');
    $('#chargeTable tbody').html('');
    $('#assetList').html('');
    $('#deviations tbody').html('');
    $('#documents tbody').find('tr').each(function () {
        $(this).find('td').last().replaceWith('<td class="text-center">NO</td>');
    });
}

function fillData(data) {
    clearFields();
    $('#astTab').click();
    Object.keys(data).forEach(function (key) {
        if (['billing_proof', 'original_document'].includes(key)) {
            let td = document.createElement('td');
            $(td).addClass('text-center').html('YES').attr('style', 'cursor:pointer;');
            $(td).click(function () {
                var win = window.open('leasedocs/' + data.id + "_" + data[key]);
            });
            $(document).find('#' + key).find('td').last().replaceWith(td);
            return;
        }
        let el = $(document).find('#' + key);
        $(el).html(data[key]);
    });

    if (data.crib_doc) {
        addDocument(data.customer_txt + " CRIB", true, data.crib_doc);
    } else {
        addDocument(data.customer_txt + " CRIB", false);
    }

    if (data.co_borrowers) {
        let co_borrowers = JSON.parse(data.co_borrowers);
        for (var i = 0; i < co_borrowers.length; i++) {
            $('#coBorrowerList').find('tbody').append('<tr><td>' + co_borrowers[i].name + '</td><td>' + co_borrowers[i].nic + '</td><td>' + co_borrowers[i].relationship_txt + '</td><td>' + co_borrowers[i].address + '</td><td>' + co_borrowers[i].dscr + '</td><td>' + co_borrowers[i].ndia + '</td></tr>');
            if (co_borrowers[i].crib_doc) {
                addDocument(co_borrowers[i].name + " CRIB", true, co_borrowers[i].crib_doc);
            } else {
                addDocument(co_borrowers[i].name + " CRIB", false)
            }
        }
        $('#coBorrowerList').show();
    } else {
        $('#coBorrowerList').hide();
    }

    if (data.guarantors) {
        let guarantors = JSON.parse(data.guarantors);
        for (var i = 0; i < guarantors.length; i++) {
            $('#guarantorList').find('tbody').append('<tr><td>' + guarantors[i].name + '</td><td>' + guarantors[i].nic + '</td><td>' + guarantors[i].relationship_txt + '</td><td>' + guarantors[i].address + '</td><td>' + guarantors[i].dscr + '</td><td>' + guarantors[i].ndia + '</td></tr>');
            if (guarantors[i].crib_doc) {
                addDocument(guarantors[i].name + " CRIB", true, guarantors[i].crib_doc);
            } else {
                addDocument(guarantors[i].name + " CRIB", false);
            }
        }
        $('#guarantorList').show();
    } else {
        $('#guarantorList').hide();
    }

    if (data.recommendation) {
        let jo = JSON.parse(data.recommendation);
        for (var i = 0; i < jo.length; i++) {
            let tem = '<div class="col-12"><div class="media">' +
                    '<a class="media-left" href="#">' +
                    '    <img class="media-object img-radius m-r-10 img-60" src="files/images/user.png">' +
                    '</a>' +
                    '<div class="media-body b-b-theme social-client-description">' +
                    '<span>' + jo[i].rec_date + '</span>' +
                    '<div class="chat-header">' + jo[i].r_from + ' Recommended to ' + jo[i].r_to + '</div>' +
                    '<p>' + jo[i].rec_comment + '</p>' +
                    '</div>' +
                    '</div></div>';

            if (['return', 'approve', 'reject'].includes(jo[i].app_type)) {
                let action = jo[i].app_type;
                if (jo[i].app_type == 'approve') {
                    action = 'approv';
                }
                tem += '<div class="col-12"><div class="media">' +
                        '<a class="media-left" href="#">' +
                        '    <img class="media-object img-radius m-r-10 img-60" src="files/images/user.png">' +
                        '</a>' +
                        '<div class="media-body b-b-theme social-client-description">' +
                        '<span>' + jo[i].app_date + '</span>' +
                        '<div class="chat-header">' + jo[i].r_to + ' ' + action + 'ed the Proposal </div>' +
                        '<p>' + jo[i].app_comment + '</p>' +
                        '</div>' +
                        '</div></div>';
            }


            $('#app_hist_').append(tem);
        }
        $('#app_hist_').parent().show();
    } else {
        $('#app_hist_').parent().hide();
    }

    if (data.charges) {
        current_charges = JSON.parse(data.charges);
        let tot_amt = 0;
        let tot_charge = 0;
        for (var i = 0; i < current_charges.length; i++) {
            let charge = current_charges[i];
            let tr = document.createElement('tr');
            $(tr).append('<td>' + charge.name + '</td>');
            $(tr).data('id', charge.id);
            $(tr).data('name', charge.name);
            tot_amt += parseFloat(charge.org_charge);
            tot_charge += parseFloat(charge.charge);
            if (charge.rate) {
                $(tr).data('rate', charge.rate);
                $(tr).data('minimum', charge.minimum);
                $(tr).append('<td class="text-right">' + formatDouble(charge.rate) + '</td>');
                $(tr).append('<td class="text-right">-</td>');
                $(tr).append('<td class="text-right">' + formatDouble(charge.minimum) + '</td>');
                $(tr).append('<td class="text-right">' + formatDouble(charge.org_charge) + '</td>');
                $(tr).append('<td class="text-right">' + charge.adjustment + '</td>');
                $(tr).append('<td class="text-right">' + formatDouble(charge.charge) + '</td>');
            } else {
                $(tr).data('flat', charge.flat);
                $(tr).append('<td class="text-right">-</td>');
                $(tr).append('<td class="text-right">' + formatDouble(charge.flat) + '</td>');
                $(tr).append('<td class="text-right">-</td>');
                $(tr).append('<td class="text-right">' + formatDouble(charge.org_charge) + '</td>');
                $(tr).append('<td class="text-right">' + charge.adjustment + '</td>');
                $(tr).append('<td class="text-right">' + formatDouble(charge.charge) + '</td>');
            }
            if (charge.payee) {
                $(tr).append('<td class="text-center">' + charge.payee_txt + '</td>');
            } else {
                $(tr).append('<td class="text-center">-</td>');
            }
            if (charge.method) {
                $(tr).append('<td class="text-center">' + charge.method_txt + '</td>');
            } else {
                $(tr).append('<td class="text-center">-</td>');
            }
            $('#chargeTable').find('tbody').append(tr);
            $('#chargeTable').find('thead').last().find('th').eq(4).html(formatDouble(tot_amt));
            $('#chargeTable').find('tfoot').find('th').eq(6).html(formatDouble(tot_charge));
        }
    }

    if (data.assets) {
        let assets = JSON.parse(data.assets);
        for (var i = 0; i < assets.length; i++) {
            var temp = document.getElementById("assetTemplate");
            var clone = temp.content.cloneNode(true);
            let asset = assets[i];
            $(clone).find('th').eq(0).html('Asset ' + (i + 1));
            if (asset.details) {
                Object.keys(asset.details).forEach(function (key) {
                    if (key == 'Image') {
                        $(clone).find('.asst-img').attr('style', "min-height: 370px;height: 100%;background:url('assetimages/" + asset.details[key] + "'),url('files/images/image-not-found.png')no-repeat;background-size: cover;background-position: center;");
                        return;
                    }
                    let tem = '<div class="form-group col-auto col-xl-auto">' +
                            '<label class="col-sm-12 col-form-label">' + key + '</label>' +
                            '<div class="col-sm-12">' + asset.details[key] + '</div>' +
                            '</div>';
                    $(clone).find('.ast_details').append(tem);
                });
            }
            if (asset.valuation) {
                Object.keys(asset.valuation).forEach(function (key) {
                    if (key.startsWith("s_")) {
                        let tem = '<div class="form-group col-auto col-xl-auto">' +
                                '<label class="col-sm-12 col-form-label">' + key.substr(2) + '</label>' +
                                '<div class="col-sm-12">' + asset.valuation[key] + '</div>' +
                                '</div>';
                        $(clone).find('.second-valuation').append(tem);
                    } else {
                        let tem = '<div class="form-group col-auto col-xl-auto">' +
                                '<label class="col-sm-12 col-form-label">' + key + '</label>' +
                                '<div class="col-sm-12">' + asset.valuation[key] + '</div>' +
                                '</div>';
                        $(clone).find('.valuation').append(tem);
                    }
                });
            }
            if (asset.broker) {
                $(clone).find('.broker').html(asset.broker_txt);
            }
            if (asset.vendor) {
                $(clone).find('.vendor').html(asset.vendor_txt);
            }
            $('#assetList').append(clone);
        }
    }

    if (data.documents) {
        let doc = JSON.parse(data.documents);
        for (var i = 0; i < doc.length; i++) {
            addDocument(doc[i].name, true, doc[i].doc);
        }
    }

    let auth = true;
    if (data.deviation) {
        $('#deviations tbody').html('');
        let jo = JSON.parse(data.deviation);
        for (var i = 0; i < jo.length; i++) {
            $('#deviations').find('tbody').append('<tr><td>' + jo[i].deviation + '</td><td class="text-center">' + jo[i].auth + '</td></tr>');
            if (jo[i].auth == 'No') {
                auth = false;
            }
        }
        $('#deviations').parent().show();
    } else {
        $('#deviations').parent().hide();
    }

    if (data.approval) {
        let jo = JSON.parse(data.approval);
        for (var i = 0; i < jo.length; i++) {
            let tr = document.createElement('tr');
            $(tr).append('<td>' + jo[i].product + '</td>');
            $(tr).append('<td class="text-right">' + jo[i].proposed + '</td>');
            $(tr).append('<td class="text-right">' + jo[i].max + '</td>');
            $(tr).append('<td class="text-center">' + jo[i].auth + '</td>');
            $('#mda').find('tbody').append(tr);
            if (jo[i].auth == 'No') {
                auth = false;
            }
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
    action = new SlimSelect({
        select: '#action',
        placeholder: "Select an Option",
        allowDeselect: true,
        deselectLabel: '<span class="red">?</span>',
        showSearch: false,
    });

}



function loadDiv(card) {
    var $this = $(card);
    $this.addClass("div-load");
    $this.append('<div class="div-loader"><i class="loader2"></div>');
}


function addDocument(name, exists, url) {
    if (exists) {
        $('#documentList').append('<div class="row m-b-5"><div class="col-11"><a href="leasedocs/' + url + '" target="_blank">' + name + '</a></div><div class="col-1"><i class="icon feather icon-check-circle f-w-600 f-16 text-success"></i></div></div>');
    } else {
        $('#documentList').append('<div class="row m-b-5"><div class="col-11"><a href="javascript:void(0)">' + name + '</a><</div><div class="col-1"><i class="icon feather icon-x-circle f-w-600 f-16 text-danger"></i></div></div>');
    }
}



function formatDouble(val) {
    if (parseFloat(val)) {
        // return parseFloat(val).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
        return parseFloat(val).toLocaleString('en-US', {minimumFractionDigits: 0, maximumFractionDigits: 2});
    } else {
        return val;
    }
}



var action = new SlimSelect({
    select: '#action',
    placeholder: "Select an Option",
    allowDeselect: true,
    deselectLabel: '<span class="red">?</span>',
    showSearch: false,
});

var fwd_to = new SlimSelect({
    select: '#fwd_to',
    placeholder: "Select an User",
    ajax: function (search, callback) {
        $.post('leasing/userSearch', {q: search}, function (res) {
            callback(JSON.parse(res));
        });
    },
    allowDeselect: true,
    deselectLabel: '<span class="red">?</span>'
});
$('#fwd_to').data('select', fwd_to);

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




$('#submitbtn').click(function () {
    if ($('#action').val() === null || $('#action').val() === '') {
        Swal.fire('No Action !', 'Please select an action !', 'warning');
        return;
    }
    if ($('#action').val() === 'forward' && ($('#fwd_to').val() === null || $('#fwd_to').val() === '')) {
        Swal.fire('No User Selected !', 'Please select a user  to forward!', 'warning');
        return;
    }

    const formData = new FormData();
    formData.append('lid', $('#submitbtn').data('id'));
    formData.append('action', $('#action').val());
    formData.append('fwd_to', $('#fwd_to').val());
    formData.append('comment', $('#rec_comment').val());

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
            return fetch('leasing/approve', {
                method: 'POST',
                body: formData
            });
        }
    }).then(response => response.value.text()).then((response) => {
        let res = JSON.parse(response);
        if (res.status === 'success') {
            Swal.fire('Successfull !', res.msg, 'success');
            main_table.ajax.reload();
            $('#tableCard').fadeIn();
            $('#addCard').hide();
        } else if (res.status == 'error') {
            Swal.fire('Error !', res.msg, 'error');
        } else {
            Swal.fire('Error !', 'Something Went Wrong', 'error');
        }

    });

});


