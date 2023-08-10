function AuditRow(date, username, name, action) {
    let div = document.createElement('div');
    $(div).addClass('col-12');
    let el = `<div class="media"><a class="media-left" href="javascript:void(0);"><img class="media-object img-radius m-r-10 img-60" onerror="this.onError=null;this.src='files/images/user.png';" src="userimages/${username}.jpg"></a><div class="media-body b-b-theme social-client-description"><span>${date}</span><div class="chat-header">${action} - ${name}</div></div></div>`;
    $(div).html(el);
    return div;
}