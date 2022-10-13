import 'jquery'
import {Controller} from "@hotwired/stimulus"
import 'bootstrap/dist/css/bootstrap.css'
import * as bootstrap from 'bootstrap/dist/js/bootstrap.min'
import Autocomplete from 'autocomplete.js'

window.bootstrap = bootstrap
export default class extends Controller {
    connect() {

    }

    manuallyAssignSeat(e) {
        e.preventDefault()

        const element = '.js-modal-assign-seat'
        $(element + ' .modal-title').text('Assign a seat for ' + e.params.name)
        $(element).modal('show')

        let seats = $('.js-seat-label').val().split(' ')
        let datasrc = []
        seats.forEach((seat, i) => {
            datasrc.push({
                label: seat, value: seat
            })
        })
        let selected_value;
        const ac = new Autocomplete(document.getElementById('js-input-seat'), {
            data: datasrc,
            threshold: 1,
            maximumItems: 11,
            onSelectItem: ({label, value}) => {

            }
        });

        $(element + ' button.js-submit').off('click').on('click', function (ev) {
            ev.preventDefault()
            let value = $('#js-input-seat').val()
            if (seats.indexOf(value) == -1) {
                $('#js-input-seat').val()
                Swal.fire('Invalid seat', '', 'error')
            } else {
                $.post('/passenger/assign_seat', {
                    id: e.params.id,
                    seat: value
                }, (data) => {
                    $('.modal').modal('hide')
                })
            }
        })
    }

    search_passenger(e) {
        e.preventDefault()

        if (e.keyCode == '13') {
            const name = $(e.target).val()
            $.get('/passenger/search', {
                trip_id: e.params.tripId,
                name: name
            }, (data) => {
                setTimeout(() => {
                    $(e.target).focus()
                }, 2000)

            })
        }
    }

    btn_search_passenger(e) {
        e.preventDefault()
        this._trigger_search_input(e);
    }

    clear_search(e) {
        e.preventDefault()
        $('input.js-search-pax').val('')
        this._trigger_search_input(e);
    }

    _trigger_search_input(e) {
        const input = $(e.target).parents('.js-search-group').first().find('input.js-search-pax')
        const name = input.val()
        $.get('/passenger/search', {
            trip_id: input.attr('data-passenger-trip-id-param'),
            name: name
        }, (data) => {
            setTimeout(() => {
                input.focus()
            }, 2000)

        })
    }
}