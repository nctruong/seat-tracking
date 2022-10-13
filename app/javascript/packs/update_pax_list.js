import toastr from "toastr";
import { UpdateWithReload } from "./update_with_reload";

export class UpdatePaxList {
    constructor() {
        this.call()
    }
    call() {
        $(document).on('click', '.js-update-pax-list', function() {
            new UpdateWithReload('/passenger/update_passenger_list', {trip_id: window.trip_id})
        })
    }
}