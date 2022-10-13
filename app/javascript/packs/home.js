import "channels"
import 'jquery'
import 'popper.js/dist/popper.min'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap/dist/js/bootstrap.min'
// import 'bootstrap-select/dist/css/bootstrap-select.min.css'
// import 'bootstrap-select/dist/js/bootstrap-select.min'
import 'autocomplete.js'
import "@fortawesome/fontawesome-free/css/all"
import './home.scss'
import 'toastr/toastr.scss'
import 'toastr/toastr.js'
import toastr from "toastr";
import Swal from 'sweetalert2'
import { Wifi } from './wifi'
import { GetTerminalPaxList } from "./get_terminal_pax_list";
import { UpdatePaxList } from './update_pax_list';
import '../channels/index'
import {CleanWithReload} from "./clean_with_reload";
import {EndTrip} from "./end_trip";
import './upload_adv'
import AdvVideoSortable from "./adv_video_sortable"; './adv_video_sortable'

window.jQuery = window.$ = require('jquery')
window.toastr = toastr
window.Swal = Swal
window.toastr.options = {
    "closeButton": false,
    "debug": false,
    "newestOnTop": true,
    "progressBar": false,
    "positionClass": "toast-top-right",
    "preventDuplicates": true,
    "onclick": null,
    "showDuration": "300",
    "hideDuration": "1000",
    "timeOut": "5000",
    "extendedTimeOut": "1000",
    "showEasing": "swing",
    "hideEasing": "linear",
    "showMethod": "fadeIn",
    "hideMethod": "fadeOut"
}

function autoCheckSeat() {
    const names = ["Adam", "Alex", "Aaron", "Ben", "Carl", "Dan", "David", "Edward", "Fred", "Frank", "George", "Hal", "Hank", "Ike", "John", "Jack", "Joe", "Larry", "Monte", "Matthew", "Mark", "Nathan", "Otto", "Paul", "Peter", "Roger", "Roger", "Steve", "Thomas", "Tim", "Ty", "Victor", "Walter"]
    let i = 0
    $('[data-toggle="tooltip"]').each(function (i) {
        doSetTimeout($(this))
    })

    function doSetTimeout($this) {
        setTimeout(function () {
            let name = names[Math.floor(Math.random() * names.length)];
            // $this.attr('title', name)
            // $this.tooltip('show')
            $this.addClass('checked')
        }, i += 1000);
        setTimeout(function () {
            $this.tooltip('hide');
        }, i + 1000);
    }
}

function alertLoseConnection(){
    Swal.fire('Offline', '', 'warning')
}
function alertConnectionBack(){
    toastr.info('Online')
}

function handleShowPassengerInfo() {
    $('.seat').on('click', function(){
        Swal.fire({
            title: '<strong>Seat <u>B18</u></strong>',
            icon: 'info',
            html:
                '<div class="row">' +
                '<div class="row"><div class="col-6">Name</div> <div class="col-6"> <b>Andrew</b></div></div> ' +
                '<div class="row"><div class="col-6">Passport No</div> <div class="col-6"> <b>9876543243</b></div></div> ' +
                '<div class="row"><div class="col-6">Trip No</div> <div class="col-6"> <b>9876543243</b></div></div> ' +
                '<div class="row"><div class="col-6">Phone</div> <div class="col-6"> <b>9876543243</b></div></div> ' +
                '<div class="row"><div class="col-6">Boarding Pass</div> <div class="col-6"> <b>9876543243</b></div></div> ' +
                '</div>',
            // showCloseButton: true,
            // showCancelButton: true,
            // focusConfirm: false,
            // confirmButtonText:
            //     '<i class="fa fa-thumbs-up"></i> Great!',
            // confirmButtonAriaLabel: 'Thumbs up, great!',
            // cancelButtonText:
            //     '<i class="fa fa-thumbs-down"></i>',
            // cancelButtonAriaLabel: 'Thumbs down'
        })
    })
}

window.wifi = new Wifi()

$(document).ready(function () {
    // handleShowPassengerInfo()
    wifi.handleEvent();
    new GetTerminalPaxList();
    new UpdatePaxList()
    new CleanWithReload()
    new EndTrip()
    window.video_sortable = new AdvVideoSortable()
})
