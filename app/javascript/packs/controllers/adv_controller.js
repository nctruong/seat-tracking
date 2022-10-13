import 'jquery'
import {Controller} from "@hotwired/stimulus"
import 'bootstrap/dist/css/bootstrap.css'
import * as bootstrap from 'bootstrap/dist/js/bootstrap.min'
import AdvVideoSortable from "../adv_video_sortable";

window.bootstrap = bootstrap
export default class extends Controller {
    static targets = ['btnPlay', 'btnPlayLabel', 'btnPlayIcon', 'cbxSelectVideo', 'cbxSelectAll']

    connect() {
        this.playing = false
    }

    selectAll(e) {
        e.preventDefault()
        console.log('select all')
        $('.js-cbx-select-video').prop('checked', $(e.target).is(':checked'))
    }

    play(e) {
        // this.sendAdvSeq()
        this.playing = !this.playing;
        if (this.playing) {
            this.btnPlayLabelTarget.innerHTML = 'Stop'
            $(this.btnPlayTarget).removeClass('btn-green').addClass('btn-dark')
            $(this.btnPlayIconTarget).removeClass('fa-play').addClass('fa-pause')
            $.get('/tv/reload')
            this.playVideoBySeq()
        } else {
            this.btnPlayLabelTarget.innerHTML = 'Play'
            $(this.btnPlayTarget).removeClass('btn-dark').addClass('btn-green')
            $(this.btnPlayIconTarget).removeClass('fa-pause').addClass('fa-play')
            $('.js-video').unbind('ended')
            $('.js-video').trigger('pause')
        }
    }

    playVideoBySeq() {
        const video_sortable = new AdvVideoSortable()
        $.post('adv/play_list', {seq: video_sortable.values}, (data) => {
            toastr.success('Sequence updated')
            $('.js-cbx-select-video:checked').each((i, el) => {
                let video = $(el).parents('li').find('.js-video')

                if (i === 0) {
                    video.trigger('play')
                }

                video.on('ended', () => {
                    if ($('.js-cbx-select-video:checked')[i+1] !== undefined) {
                        $($('.js-cbx-select-video:checked')[i+1]).parents('li').find('.js-video').trigger('play')
                    }
                })
            })
        })
    }

    delete(e) {
        let ids = []
        $('.js-cbx-select-video:checked').each((i, el) => { ids.push($(el).val())})
        $.ajax({
            url: '/adv/destroy',
            data: {ids: ids},
            method: 'DELETE',
            success: (data) => {
                data.ids.forEach((id) => {
                    $(`#js-li-video-${id}`).remove()
                    new AdvVideoSortable()
                    $.get('/tv/reload')
                })
            }
        })
    }
}