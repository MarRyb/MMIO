// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require velocity.min
//= require velocity.ui
//= require welcome

var selectedCategory = {};
var selectedProducts = [];

Category = {
	select: function(category){
		selectedCategory = category;
		this._renderProductsList();
		// return false;
	},
	_renderProductsList: function(){
		$.ajax({
			url: '/load_products',
			data: { category_id: selectedCategory.id },
			dataType: 'script',
			method: 'get',
			success: function(data) {
				console.log('ajax request `load_products` completed successfully');
			}
		});
	}
}

Product = {
	select: function(product_id) {
		$.ajax({
			url: '/products/' + product_id + '/select',
			dataType: 'script',
			method: 'post',
			success: function(data) {
				console.log('ajax request `products#select` completed successfully');
			}
		});
	},
	remove: function(product_id) {
		$.ajax({
			url: '/products/' + product_id + '/remove',
			dataType: 'script',
			method: 'post',
			success: function(data) {
				console.log('ajax request `products#remove` completed successfully');
			}
		});
	},
	backToCategories: function(){
		$.ajax({
			url: '/load_categories',
			dataType: 'script',
			method: 'get',
			success: function(data) {
				console.log('ajax request `load_categories` completed successfully');
			}
		});
	}
}