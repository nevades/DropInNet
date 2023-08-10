<%@ page pageEncoding="UTF-8" %>
<script type="text/javascript" src="files/jquery/js/jquery.min.js"></script>
<script type="text/javascript" src="files/js/popper.min.js"></script>
<script type="text/javascript" src="files/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="files/js/jquery.slimscroll.js"></script>
<script src="files/js/pcoded.min.js" type="text/javascript"></script>
<script src="files/js/horizontal-layout.min.js" type="text/javascript"></script>
<script src="files/js/jquery.mCustomScrollbar.concat.min.js" type="text/javascript"></script>
<script type="text/javascript" src="files/js/script.js"></script>
<script>

    fetch('pages')
            .then(response => response.json())
            .then(pages_l1 => {
                pages_l1.sort((a, b) => (a.odr > b.odr) ? 1 : ((b.odr > a.odr) ? -1 : 0));
                for (var i = 0; i < pages_l1.length; i++) {
                    if (pages_l1[i].url) {
                        let l1_menu = createMenu(pages_l1[i]);
                        $('#navpages').append(l1_menu);
                    } else {
                        let l1_menu = createMenu(pages_l1[i], true);
                        let pages_l2 = pages_l1[i].pages;
                        pages_l2.sort((a, b) => (a.odr > b.odr) ? 1 : ((b.odr > a.odr) ? -1 : 0));

                        let ul = document.createElement('ul');
                        $(ul).addClass('pcoded-submenu');

                        for (var j = 0; j < pages_l2.length; j++) {
                            if (pages_l2[j].url) {
                                let l2_menu = createMenu(pages_l2[j]);
                                $(ul).append(l2_menu);
                            } else {
                                let l2_menu = createMenu(pages_l2[j], true);
                                let pages_l3 = pages_l2[j].pages;
                                pages_l3.sort((a, b) => (a.odr > b.odr) ? 1 : ((b.odr > a.odr) ? -1 : 0));

                                let ul3 = document.createElement('ul');
                                $(ul3).addClass('pcoded-submenu');
                                for (var k = 0; k < pages_l3.length; k++) {
                                    let l3_menu = createMenu(pages_l3[k]);
                                    $(ul3).append(l3_menu);
                                }
                                $(l2_menu).append(ul3);
                                $(ul).append(l2_menu);
                            }
                        }
                        $(l1_menu).append(ul);
                        $('#navpages').append(l1_menu);
                    }
                }
                applyMenuStyles();
                $('.pcoded-item').find('li').removeClass('active');
                let spt = $(location).attr('pathname').toString().split("/");
                $('a[href="' + spt[spt.length - 1] + $(location).attr('search') + '"]').parent().addClass('active');
                $('a[href="' + spt[spt.length - 1] + $(location).attr('search') + '"]').parents('.pcoded-hasmenu').addClass('active');
                $('a[href="' + spt[spt.length - 1] + $(location).attr('search') + '"]').parents('.pcoded-submenu').show();

                $(function () {
                    $('[data-toggle="tooltip"]').tooltip()
                })
                $('.theme-loader').fadeOut('slow', function () {
                    $(this).remove();
                });
            })
            .catch((err) => {
                console.log(err);
                applyMenuStyles();
                $('.pcoded-item').find('li').removeClass('active');
                let spt = $(location).attr('pathname').toString().split("/");
                $('a[href="' + spt[spt.length - 1] + $(location).attr('search') + '"]').parent().addClass('active');
                $('a[href="' + spt[spt.length - 1] + $(location).attr('search') + '"]').parents('.pcoded-hasmenu').addClass('active');
                $('a[href="' + spt[spt.length - 1] + $(location).attr('search') + '"]').parents('.pcoded-submenu').show();

                $(function () {
                    $('[data-toggle="tooltip"]').tooltip()
                })
                $('.theme-loader').fadeOut('slow', function () {
                    $(this).remove();
                });
            });

    function createMenu(data, sub = false) {
        let a = document.createElement('a');
        if (data.url) {
            $(a).attr('href', data.url);
        } else {
            $(a).attr('href', 'javascript:void(0)');
        }

        if (data.icon) {
            let span1 = document.createElement('span');
            $(span1).addClass('pcoded-micon');
            $(span1).html('<i class="' + data.icon + '">');
            $(a).append(span1);
        }

        let span2 = document.createElement('span');
        $(span2).addClass('pcoded-mtext');
        $(span2).html(data.name)
        $(a).append(span2);

        let li = document.createElement('li');

        if (sub) {
            $(li).addClass('pcoded-hasmenu');
            $(li).attr('dropdown-icon', 'style1');
            $(li).attr('subitem-icon', 'style1');
        }
        $(li).append(a);
        return li;
    }

    function loadDiv(card) {
        var $this = $(card);
        $this.addClass("div-load");
        $this.append('<div class="div-loader"><i class="loader2"></div>');
    }
    function finishLoadDiv(card) {
        var $this = $(card);
        $this.children(".div-loader").remove();
        $this.removeClass("div-load");
    }

    $('#searchBar').on('keypress', function (e) {
        let txt = $(this).val();
        if (e.which === 13) {
            window.location.href = 'search?txt=' + txt;
        }
    });

</script>
