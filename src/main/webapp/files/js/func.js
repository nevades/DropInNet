
function Table(jsar) {
    this.rows = jsar;
    this.title = [];
    this.cb;
    this.getRow = function (x) {
        return this.rows[x];
    };

    this.setCallback = function (x) {
        this.cb = x;
    };

    this.getCol = function (r, c) {
        return this.rows[r][c];
    };

    this.addRow = function (ary) {
        return this.rows[this.rows.length] = ary;
    };

    this.setTitle = function (ary) {
        return this.title = ary;
    };

    this.display = function () {
        var tbl = document.createElement('table');
        $(tbl).addClass('table table-hover table-bordered');
        var thead = document.createElement('thead');
        var tr = document.createElement('tr');

        for (var i = 0; i < this.title.length; i++) {
            var th = document.createElement('th');
            th.innerHTML = this.title[i];
            tr.appendChild(th);
        }

        thead.appendChild(tr);
        tbl.appendChild(thead);

        var tbod = document.createElement('tbody');
        for (var i = 0; i < this.rows.length; i++) {
            var trr = document.createElement('tr');
            for (var x = 0; x < this.rows[i].length; x++) {
                var td = document.createElement('td');
                td.innerHTML = this.rows[i][x];
                trr.appendChild(td);
            }
            tbod.appendChild(trr);
        }
        tbl.appendChild(tbod);

        //this.cb();
        return tbl;
    };

}

function Tbl(dat) {
    this.rows = dat.rows;
    this.title = dat.thead;
    this.cb;
    this.getRow = function (x) {
        return this.rows[x];
    };

    this.setCallback = function (x) {
        this.cb = x;
    };


    this.getCel = function (r, c) {
        return this.rows[r][c];
    };

    this.getCol = function (cols, cole) {
        var thead = [];
        var rows = [];
        for (var i = cols; i < cole; i++) {
            thead[thead.length] = this.title[i];

        }

        for (var j = 0; j < this.rows.length; j++) {
            var r = [];
            for (var i = cols; i < cole; i++) {
                r[r.length] = this.rows[j][i];
            }
            rows[rows.length] = r;

        }

        var rtnobj = {thead: thead, rows: rows};
        return rtnobj;
    };

    this.appendCol = function (coldata) {
        for (var i = 0; i < coldata.thead.length; i++) {
            this.title[ this.title.length] = coldata.thead[i];
        }
        console.log(coldata);
        for (var i = 0; i < coldata.rows.length; i++) {
            for (var j = 0; j < coldata.rows[i].length; j++) {
                this.rows[i][this.rows[i].length] = coldata.rows[i][j];
            }
        }
    };

    this.addRow = function (ary) {
        return this.rows[this.rows.length] = ary;
    };

    this.setTitle = function (ary) {
        this.title = ary;
    };

    this.display = function () {
        var tbl = document.createElement('table');
        $(tbl).addClass('table table-hover table-bordered');
        var thead = document.createElement('thead');
        var tr = document.createElement('tr');

        for (var i = 0; i < this.title.length; i++) {
            var th = document.createElement('th');
            th.innerHTML = this.title[i];
            tr.appendChild(th);
        }

        thead.appendChild(tr);
        tbl.appendChild(thead);

        var tbod = document.createElement('tbody');
        for (var i = 0; i < this.rows.length; i++) {
            var trr = document.createElement('tr');
            for (var x = 0; x < this.rows[i].length; x++) {
                var td = document.createElement('td');
                td.innerHTML = this.rows[i][x];
                trr.appendChild(td);
            }
            tbod.appendChild(trr);
        }
        tbl.appendChild(tbod);

        //this.cb();
        return tbl;
    };

}

function TbRl(dat, start, end) {
    this.rows = dat.rows;
    this.title = dat.thead;
    this.cb;
    this.getRow = function (x) {
        return this.rows[x];
    };

    this.setCallback = function (x) {
        this.cb = x;
    };


    this.getCol = function (r, c) {
        return this.rows[r][c];
    };

    this.addRow = function (ary) {
        return this.rows[this.rows.length] = ary;
    };

    this.setTitle = function (ary) {
        this.title = ary;
    };

    this.display = function () {
        var tbl = document.createElement('table');
        $(tbl).addClass('table table-hover table-bordered');
        var thead = document.createElement('thead');
        var tr = document.createElement('tr');

        for (var i = start; i < end; i++) {
            var th = document.createElement('th');
            th.innerHTML = this.title[i];
            tr.appendChild(th);
        }

        thead.appendChild(tr);
        tbl.appendChild(thead);

        var tbod = document.createElement('tbody');
        for (var i = 0; i < this.rows.length; i++) {
            var trr = document.createElement('tr');
            for (var x = start; x < end; x++) {
                var td = document.createElement('td');
                td.innerHTML = this.rows[i][x];
                trr.appendChild(td);
            }
            tbod.appendChild(trr);
        }
        tbl.appendChild(tbod);

        //this.cb();
        return tbl;
    };

}

function TbRlaf(dat, start, end, arow) {
    this.rows = dat.rows;
    this.title = dat.thead;
    this.cb;
    this.getRow = function (x) {
        return this.rows[x];
    };

    this.setCallback = function (x) {
        this.cb = x;
    };


    this.getCol = function (r, c) {
        return this.rows[r][c];
    };

    this.addRow = function (ary) {
        return this.rows[this.rows.length] = ary;
    };

    this.setTitle = function (ary) {
        this.title = ary;
    };

    this.display = function () {
        var tbl = document.createElement('table');
        $(tbl).addClass('table table-hover table-bordered');
        var thead = document.createElement('thead');
        var tr = document.createElement('tr');

        var th = document.createElement('th');
        th.innerHTML = this.title[arow];
        tr.appendChild(th);

        for (var i = start; i < end; i++) {
            var th = document.createElement('th');
            th.innerHTML = this.title[i];
            tr.appendChild(th);
        }

        thead.appendChild(tr);
        tbl.appendChild(thead);

        var tbod = document.createElement('tbody');
        for (var i = 0; i < this.rows.length; i++) {
            var trr = document.createElement('tr');
            var td = document.createElement('td');
            td.innerHTML = this.rows[i][arow];
            trr.appendChild(td);
            for (var x = start; x < end; x++) {
                var td = document.createElement('td');
                td.innerHTML = this.rows[i][x];
                trr.appendChild(td);
            }
            tbod.appendChild(trr);
        }
        tbl.appendChild(tbod);

        //this.cb();
        return tbl;
    };

}

function Tblary(dat, ary) {
    this.rows = dat.rows;
    this.title = dat.thead;
    this.cb;
    this.getRow = function (x) {
        return this.rows[x];
    };

    this.setCallback = function (x) {
        this.cb = x;
    };


    this.getCol = function (r, c) {
        return this.rows[r][c];
    };

    this.addRow = function (ary) {
        return this.rows[this.rows.length] = ary;
    };

    this.setTitle = function (ary) {
        this.title = ary;
    };

    this.display = function () {
        var tbl = document.createElement('table');
        $(tbl).addClass('table table-hover table-bordered');
        var thead = document.createElement('thead');
        var tr = document.createElement('tr');

        for (var i = 0; i < ary.length; i++) {
            var th = document.createElement('th');
            th.innerHTML = this.title[ary[i]];
            tr.appendChild(th);
        }

        thead.appendChild(tr);
        tbl.appendChild(thead);

        var tbod = document.createElement('tbody');
        for (var i = 0; i < this.rows.length; i++) {
            var trr = document.createElement('tr');
            for (var x = 0; x < ary.length; x++) {
                var td = document.createElement('td');
                td.innerHTML = this.rows[i][ary[x]];
                trr.appendChild(td);
            }
            tbod.appendChild(trr);
        }
        tbl.appendChild(tbod);

        //this.cb();
        return tbl;
    };

}

//var modal_tem = '<div class="modal fade" role="dialog">' +
//        '<div class="modal-dialog modal-lg">' +
//        '<div class="modal-content">' +
//        '<div class="modal-body" id="print_bod">' +
//        '<div class="row">' +
//        '<div class="col-xl-2">' +
//        '<img src="img/logoLast.png" />' +
//        '</div>' +
//        '<div class="col-xl-8 text-center">' +
//        '<h2 id="t1" style="margin-top: 5px;margin-bottom: 5px">Fintrex Finance Ltd</h2>' +
//        '<h4 style="margin-top: 5px;margin-bottom: 5px"></h4>' +
//        '<h4 style="margin-top: 5px;margin-bottom: 5px"></h4>' +
//        '<h5 style="margin-top: 5px;margin-bottom: 5px"></h5>' +
//        '</div>' +
//        '<div class="col-xl-2">' +
//        '<button type="button" class="close" data-dismiss="modal">&times;</button>' +
//        '</div>' +
//        '</div>' +
//        '<div class="container-fluid"><div class="row" style="margin-top:10px;margin-bottom:20px"><div class="col-xl-6 text-left"><h4 id="dateasat">As at </h4></div><div class="col-xl-6 text-right"><h4 id="genby"> </h4></div></div></div>' +
//        '<div class="container-fluid">' +
//        '<div class="tbll row" style="font-size: smaller">' +
//        '</div>' +
//        '<br>' +
//        '<div class="col-xl-12 text-center"><h5>End of Report</h5></div>' +
//        '</div>' +
//        '</div>' +
//        '<div class="modal-footer">' +
//        '<button type="button" class="btn btn-warning copybtn">' +
//        'Copy' +
//        '</button>' +
//        '<button onclick="printDiv()" id="print_btn" type="button" class="btn btn-success">' +
//        'Print' +
//        '</button>' +
//        '</div>' +
//        '</div>' +
//        '</div>' +
//        '</div>';

var modal_tem = '<div class="modal fade" role="dialog">' +
        '<div class="modal-dialog modal-lg">' +
        '<div class="modal-content">' +
        '<div class="modal-body" id="print_bod">' +
        '<div class="row">' +
        '<div class="col-xl-2">' +
        '<img src="http://www.fintrexrecovery.com/images/logo_print.png"/>' +
        '</div>' +
        '<div class="col-xl-8 text-center">' +
        '<h3 id="t1" style="margin-top: 5px;margin-bottom: 5px">Fintrex Finance Ltd</h3>' +
        '<h4 style="margin-top: 5px;margin-bottom: 5px"></h4>' +
        '<h5 style="margin-top: 5px;margin-bottom: 5px"></h5>' +
        '<h6 style="margin-top: 5px;margin-bottom: 5px"></h6>' +
        '</div>' +
        '<div class="col-xl-2">' +
        '<button type="button" class="close" data-dismiss="modal">&times;</button>' +
        '</div>' +
        '</div>' +
        '<div class="container-fluid"><div class="row" style="margin-top:10px;margin-bottom:5px"><div class="col-xl-6 text-left"><h6 id="dateasat">As at </h6></div><div class="col-xl-6 text-right"><h6 id="genby"> </h6></div></div></div>' +
        '<div class="container-fluid">' +
        '<div class="tbll row" style="font-size: smaller">' +
        '</div>' +
        '<br>' +
        '</div>' +
        '</div>' +
        '<div class="modal-footer">' +
        '<button onclick="printDiv()" id="print_btn" type="button" class="btn btn-success btn-sm">' +
        'Print' +
        '</button>' +
        '<button type="button" class="btn btn-primary btn-sm" data-dismiss="modal">' +
        'Close' +
        '</button>' +
        '</div>' +
        '</div>' +
        '</div>' +
        '</div>';

function createHeader(data,closebtn) {

    var elem = document.createElement('div');
    elem.innerHTML = '<div class="row">' +
            '<div class="col-xl-2">' +
            '<img src="http://www.fintrexrecovery.com/images/logo_print.png"/>' +
            '</div>' +
            '<div class="col-xl-8 text-center">' +
            '<h3 style="margin-top: 5px;margin-bottom: 5px">Fintrex Finance Ltd</h3>' +
            '<h4 style="margin-top: 5px;margin-bottom: 5px"></h4>' +
            '<h5 style="margin-top: 5px;margin-bottom: 5px"></h5>' +
            '<h6 style="margin-top: 5px;margin-bottom: 5px"></h6>' +
            '</div>' +
            '<div class="col-xl-2">' +
            '<button type="button" class="close">&times;</button>' +
            '</div>' +
            '</div><div class="row" style="margin-top:10px;margin-bottom:5px"><div class="col-xl-6 text-left"><h6 id="dateasat">As at </h6></div><div class="col-xl-6 text-right"><h6 id="genby"> </h6></div></div>';

    if (data.t2) {
        $(elem).find('h4').eq(0).html(data.t2);
    }
    if (data.t3) {
        $(elem).find('h4').eq(1).html(data.t3);
    }
    if (data.t4) {
        $(elem).find('h5').eq(0).html(data.t4);
    }
    if (data.t5) {
        $(elem).find('h6').eq(0).html(data.t5);
    }
    if (data.rdate) {
        $(elem).find('#dateasat').html(data.rdate);
    }
    if (data.genby) {
        $(elem).find('#genby').html('Report Generated by - ' + data.genby);
    }
    
     if (closebtn) {
        $(elem).find('button').click(function (e) {
            e.preventDefault();
            closebtn();
        });
    }

    return elem;

}

function getModal(data, backbt) {
    var elem = document.createElement('div');
    elem.innerHTML = modal_tem;

    if (data.t2) {
        $(elem).find('h4').eq(0).html(data.t2);
    }
    if (data.t3) {
        $(elem).find('h4').eq(1).html(data.t3);
    }
    if (data.t4) {
        $(elem).find('h5').eq(0).html(data.t4);
    }
    if (data.t5) {
        $(elem).find('h6').eq(0).html(data.t5);
    }
    if (data.rdate) {
        $(elem).find('#dateasat').html(data.rdate);
    }
    if (data.genby) {
        $(elem).find('#genby').html('Report Generated by - ' + data.genby);
    }


    if (backbt) {
        var dv = document.createElement('div');
        dv.innerHTML = '<button type="button" class="btn btn-primary">Back</button>';
        $(dv).find('button').click(function (e) {
            e.preventDefault();
            backbt();
        });

        $(elem).find('.modal-footer').children().first().before($(dv).find('button'));
    }

    return $(elem).find('.modal');
}



function createModal(data, backbt) {
    var elem = document.createElement('div');
    elem.innerHTML = modal_tem;

    if (data.t2) {
        $(elem).find('h4').eq(0).html(data.t2);
    }
    if (data.t3) {
        $(elem).find('h4').eq(1).html(data.t3);
    }
    if (data.t4) {
        $(elem).find('h5').eq(0).html(data.t4);
    }
    if (data.t5) {
        $(elem).find('h6').eq(0).html(data.t5);
    }
    if (data.rdate) {
        $(elem).find('#dateasat').html(data.rdate);
    }
    if (data.genby) {
        $(elem).find('#genby').html('Report Generated by - ' + data.genby);
    }

    if (backbt) {
        var dv = document.createElement('div');
        dv.innerHTML = '<button type="button" class="btn btn-primary">Back</button>';
        $(dv).find('button').click(function (e) {
            e.preventDefault();
            backbt();
        });

        $(elem).find('.modal-footer').children().first().before($(dv).find('button'));
    }

    var tbl = new Tbl(data);

    var dvv = document.createElement('div');
    $(dvv).append(tbl.display());

    $(dvv).addClass('col-md-12 col-xs-12');
    // $(dvv).css('overflow-x', "auto");
    $(dvv).css('padding-left', '1px');
    $(dvv).css('padding-right', '1px');

    $(elem).find('.tbll').append(dvv);


    $(elem).find('.copybtn').click(function () {
        var source = $(this).parent().parent().find('table')[0];
        var range = document.createRange();
        var selection = window.getSelection();

        range.selectNodeContents(source);
        selection.removeAllRanges();
        selection.addRange(range);

        try {
            var successful = document.execCommand('copy');
            //  var callback = successful ? 'onSuccess' : 'onError';
            //  settings[callback]($element, source, selection.toString());
        } catch (err) {
        }
        selection.removeAllRanges();
    });

    return $(elem).find('.modal');

}
