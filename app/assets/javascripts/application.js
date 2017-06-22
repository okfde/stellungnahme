// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require Tabby/dist/js/tabby.min
//= require_tree .

var applyFilter = function(ev) {
  ev.preventDefault();
  var filter = this.dataset.filter;
  if (typeof filter === "undefined") {
    return;
  }

  var cl = document.querySelector('.comments-list').classList;
  cl.remove('only-published');
  cl.remove('only-unpublished');
  if (filter !== "all") {
    cl.add('only-' + filter);
  }

  [].forEach.call(document.querySelectorAll('.filter-link'), function(a) {
    a.classList.remove('active');
  });
  this.classList.add('active');
};

document.addEventListener("turbolinks:load", function() {
  tabby.init();
  if (location.search != "") {
    tabby.toggleTab(location.search);
  }

  [].forEach.call(document.querySelectorAll('.filter-link'), function(a) {
    a.addEventListener("click", applyFilter, false);
  });
}, false);
