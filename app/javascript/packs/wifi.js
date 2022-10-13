import toastr from "toastr";

export class Wifi {
    on(){
        toastr.info('Online')
        $('.status-wifi i').css('color', 'green')
    }
    off(){
        toastr.warning('Offline')
        $('.status-wifi i').css('color', 'grey')
    }
    handleEvent() {
        window.addEventListener('online', () => this.on());
        window.addEventListener('offline', () => this.off());
    }
}