import { UpdateWithReload } from "./update_with_reload";

export class GetTerminalPaxList {
    constructor() {
        this.call()
    }
    call() {
        $(document).on('click', '.js-get-terminal-pax-list', function() {
            new UpdateWithReload('/passenger/get_terminal_pax_list', {trip_id: window.trip_id})
        })
    }

}