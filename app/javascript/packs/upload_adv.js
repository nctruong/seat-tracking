import Dropzone from "dropzone";
import "dropzone/dist/dropzone.css";

$(document).ready(function(){
    const dropzone = new Dropzone("#js-upload-zone", {
        url: "/adv/upload",
        uploadMultiple: true
    });
    dropzone.on("addedfile", file => {
        console.log(`File added: ${file.name}`);
        setTimeout(() => {window.location = '/?adv=1'}, 2000)
    });

    $(document).on('click', '#js-btn-upload-zone', function(){
        $('#js-upload-zone').submit()
    })
})
