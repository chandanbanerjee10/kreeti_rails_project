// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "channels"


$(document).ready(function() {
    $(".dropdown-toggle").dropdown();
    scroll_bottom();       
});