
// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
import "jquery3"
import "popper"
import "bootstrap-sprockets"
import "app/assets/stylesheets/application.scss"
import "chartkick"
import "Chart.bundle"
import "chartkick/chart.js"
import "loading_screen"
import "turbolinks"

// $('nav-tab').observe('click', function (event) {
//     alert('Hooray!');
//     event.stop(); // Prevent link from following through to its given href
//   });
$(document).on("turbolinks:click", function(){
    $(".spinner").show();
  });
  
  $(document).on("turbolinks:load", function(){
    $(".spinner").hide();
  });
  document.addEventListener("turbolinks:click", function() {
    alert("clicked")
  })
  document.addEventListener("turbolinks:load", function() {
    alert('loading')
  })