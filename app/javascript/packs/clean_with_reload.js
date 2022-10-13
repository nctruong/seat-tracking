import toastr from "toastr";
import { UpdateWithReload } from "./update_with_reload";

export class CleanWithReload {
    constructor() {
        this.run()
    }

    run(){
        $(document).on('click', '.js-clean-with-reload', function() {
            Swal.fire({
                title: 'Do you want to delete all data and load new one?',
                showCancelButton: true,
                confirmButtonText: 'Delete & Load new data',
            }).then((result) => {
                /* Read more about isConfirmed, isDenied below */
                if (result.isConfirmed) {
                    $.ajax({
                        url: '/api/v1/trip/clean_with_reload',
                        data: {},
                        method: 'POST',
                        beforeSend: function() {
                            $('.decks').html('')
                            $('.decks').addClass('loading-icon')
                        },
                        complete: function() {
                            setTimeout(function (){
                                window.location = '/'
                            }, 100)
                        }
                    })
                } else if (result.isDenied) {
                }
            })

        })
    }
}