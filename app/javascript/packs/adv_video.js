export class AdvVideo {

    constructor() {
        this.reload()
    }

    reload(){
        this.video = document.getElementById("js-full-video");
        const adv_status = $('.js-adv-status').val()
        if (adv_status === 'during') {
            this.play()
        } else {

            this.play()
            this.moveCenter()
            this.show()

        }
    }

    show() {
        this.video.style.display = 'block'
    }

    play() {
        try {
            this.video.play()
        } catch (e) {
            
        }
    }

    openFullscreen() {
        if (this.video.requestFullscreen) {
            this.video.requestFullscreen();
        } else if (this.video.webkitRequestFullscreen) { /* Safari */
            this.video.webkitRequestFullscreen();
        } else if (this.video.msRequestFullscreen) { /* IE11 */
            this.video.msRequestFullscreen();
        }
    }

    moveCenter() {
        $('video').css('height', `${window.innerHeight - document.querySelector('.navbar').offsetHeight}px`)
        $('#js-full-video').css('width', $('#js-full-video').width())
        $('#js-full-video').css('margin', '0px auto')
    }
}
