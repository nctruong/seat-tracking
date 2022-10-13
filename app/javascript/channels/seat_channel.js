import consumer from "./consumer"

consumer.subscriptions.create({ channel: "SeatChannel" }, {
    connected: function() {
    },
    disconnected: function() {
    },
    received: function(data) {
        $.ajax({
            url: '/passenger/reload_list',
            method: 'POST',
            data: data
        })

    }

})
