import "channels"
import 'jquery'
import 'popper.js/dist/popper.min'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap/dist/js/bootstrap.min'
import "@fortawesome/fontawesome-free/css/all"
import './home.scss'
import 'toastr/toastr.scss'
import 'toastr/toastr.js'
import toastr from "toastr";
import Swal from 'sweetalert2'
import moment from 'moment'
import 'moment-timezone'
import {Wifi} from './wifi'
import {GetTerminalPaxList} from "./get_terminal_pax_list";
import {UpdatePaxList} from './update_pax_list';
import '../channels/index'
import './tv.scss'
import {AdvVideo} from './adv_video'
import TvVideoReplay from "./tv_video_replay";

window.AdvVideo = AdvVideo
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

$(document).ready(function () {
    let adv_status = $('.js-adv-status').val()
    console.log(adv_status)
    if (adv_status === 'during') {
        document.title = 'pax'
    } else {
        document.title = 'adv'
    }

    window.video = new AdvVideo()
    let replay = new TvVideoReplay()
})