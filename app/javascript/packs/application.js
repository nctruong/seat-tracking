import "channels"
import 'jquery'
import 'bootstrap'
import 'popper.js'
import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
Rails.start()
ActiveStorage.start()
window.jQuery = window.$ = require('jquery')
