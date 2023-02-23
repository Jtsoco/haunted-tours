// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { Application } from '@hotwired/stimulus'
import Lightbox from 'stimulus-lightbox'

const application = Application.start()
application.register('lightbox', Lightbox)

import BookingController from "./booking_controller"
application.register("booking", BookingController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)
