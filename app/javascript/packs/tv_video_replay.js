import moment from 'moment'
import 'moment-timezone'
export default class TvVideoReplay {
    constructor() {
        // Init URLs
        this.insUrl = $('.js-ins-video').val()
        this._liveGetAdvUrls();

        // Time
        this.loadInsTime = moment.tz($('.js-load-ins-time').val(), "Singapore")

        $('video:visible').on('ended', () => {
            this.playNext()
        })

        // Something wrong, loosing source
        setInterval(() => {
            if ($('video:visible source').attr('src') === undefined) {
                this._playFirstAdv();
            }
        }, 1000)
    }

    playNext() {
        let currentUrl = $('video:visible source').attr('src')
        console.log('current ' + currentUrl)
        this._liveGetAdvUrls();

        if (this._insIsPlaying(currentUrl)) {
            this._playFirstAdv();
        } else {
            let found = false
            this.advUrls.forEach((url,i ) => {
                if (currentUrl === url) {
                    found = true
                    if (this._middleAdvIsPlaying(i)) {
                        this._playMiddleAdv(i);
                    } else if (this._paxListIsNotEmpty()) {
                        this._playInsVideo();
                    } else {
                        this._playFirstAdv();
                    }
                }
            })

            if (!found) {
                this._playFirstAdv();
            }
        }
    }

    _liveGetAdvUrls() {
        $.get('/tv/adv_urls', {}, (data) => {
            console.log(data.urls)
            this.advUrls = data.urls
        })
    }

    _playInsVideo() {
        let currentTime = moment.tz(new Date(), 'Singapore') //.format('DD/MM/YYYY HH:mm')
        if (this.advUrls !== undefined && this.advUrls.length > 0 && this.loadInsTime.format() > currentTime.format()) {
            this._playFirstAdv();
        } else {
            this._play(this.insUrl)
        }
    }

    _playMiddleAdv(i) {
        console.log('play middle video')
        if (this.advUrls[i+1] !== undefined) {
            this._play(this.advUrls[i + 1])
        } else {
            this._playInsVideo()
        }
    }

    _paxListIsNotEmpty() {
        return $('.tv-passenger-list .js-pax-name').length !== 0;
    }

    _middleAdvIsPlaying(i) {
        return this.advUrls[i + 1] !== undefined;
    }

    _playFirstAdv() {
        console.log('play first video')
        if (this.advUrls[0] !== undefined) {
            this._play(this.advUrls[0])
        } else {
            this._playInsVideo();
        }
    }

    _insIsPlaying(currentUrl) {
        return currentUrl === this.insUrl;
    }

    _play(url) {
        if (url !== undefined) {
            $('video:visible source').attr('src', url)
            $('video:visible source').off('error').on('error', () => {
                this.playNext()
            })
            $('video:visible').trigger('load')
            $('video:visible').off('ended').on('ended', () => {
                this.playNext()
            })
        } else {
            this._playInsVideo();
        }
    }
}