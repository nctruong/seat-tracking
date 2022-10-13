export class UpdateWithReload {
    constructor(url, data, method) {
        this.run(url, data, method)
    }
    run(url, data, method) {
        $.ajax({
            url: url,
            method: method === undefined ? 'GET' : method,
            data: data,
            success: function(){

            },
            beforeSend: function() {
                $('#decks').addClass('loading-icon')
                $('#decks .deck.row').hide()
                $('#passenger-list').addClass('loading-icon')
                $('#passenger-list .passenger-list').hide()
            },
            complete: function() {
                setTimeout(function (){
                    $('#passenger-list').removeClass('loading-icon')
                    $('#decks').removeClass('loading-icon')
                    $('#passenger-list .passenger-list').show()

                    $('li.nav-item button').removeClass('active')
                    $('li.nav-item button[data-bs-target="#passenger-list"]').addClass('active')
                    $('#decks.tab-pane').removeClass('show active')
                    $('#passenger-list.tab-pane').addClass('show active')
                    $('.deck').show()
                    $('#decks .seat.checked').removeClass('checked')
                }, 100)
            }
        })
    }
}