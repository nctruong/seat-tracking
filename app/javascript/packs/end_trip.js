export class EndTrip {
    constructor() {
        this.run()
    }

    run() {
        $(document).on('click', '.js-end-trip', function () {
            let decks
            $.ajax({
                url: '/api/v1/trip/end_trip',
                data: {trip_id: window.trip_id},
                method: 'POST',
                beforeSend: function () {
                    decks = $('.decks').html()
                    $('.decks').html('')
                    $('.decks').addClass('loading-icon')
                },
                complete: function () {
                    setTimeout(function () {
                        $('.decks').html(decks)
                        $('.decks').removeClass('loading-icon')
                    }, 100)
                }
            })


        })
    }
}