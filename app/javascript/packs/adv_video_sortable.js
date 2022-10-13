import Sortable from 'sortablejs/modular/sortable.complete.esm.js';

export default class AdvVideoSortable {

    constructor() {
        this.makeSortable()
        this.values = []
        this.collect()
    }

    makeSortable() {
        new Sortable(jsVideos, {
            animation: 150,
            ghostClass: 'blue-background-class',
            onChange: this.collect
        });
    }

    collect(e) {
        let values = []
        $('.js-cbx-select-video:checked').each((i, el) => {
            values.push($(el).val())
        })
        console.log(values)
        this.values = values
    }
}