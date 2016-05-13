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

Beer = {
	type: {
		light: 0.5,
		dark: 0.7
	},
	zakuska: [300, 1000, 300],
	images: ['/beer/1.jpg', '/beer/2.jpg', '/beer/3.jpg', '/beer/4.jpg'],
	setBeerValue: function(type, val, field) {
		var $field = $(field);
		$("#beer-" + type).val(val);
		$field.parents(".row").find(".radio").removeClass("selected");
		$field.addClass("selected");
	},
	addBeerValue: function(type, val, field) {
		$field2 = $(field);
		var $field = $("#beer-" + type);
		var old_val = $field.val();
		var old_val_arr = old_val.split(',');
		old_val_arr = old_val_arr.remove("");

		var del = false;
		for (i = 0; i < old_val_arr.length; i++) {
			if (parseInt(old_val_arr[i]) == val) {
				del = true;
			}
		}
		if (del == true) {
			old_val_arr.remove("" + val);
			$field2.removeClass("selected");
		} else {
			old_val_arr.push(val);
			$field2.addClass("selected");
		}

		var new_val = old_val_arr.join(",");
		$field.val(new_val);
	},
	calculate: function() {
		$type = $("#beer-type");
		$chastota = $("#beer-chastota");
		$count = $("#beer-count");
		$zakuska = $("#beer-zakuska");
		var metabolizm = Beer.type[$type.val()] * ($count.val() * 1000) * $chastota.val();
		var zakuski = $zakuska.val().split(",").remove("");

		var metabolizm_zakuski = 0;
		$.each(zakuski, function(i, z) {
			metabolizm_zakuski += Beer.zakuska[parseInt(z)];
		});

		metabolizm_zakuski = (metabolizm_zakuski * $chastota.val());
		metabolizm += metabolizm_zakuski;

		var z = 0;
		if (metabolizm <= 10000) {
			z = 0;
		} else if (metabolizm <= 30000) {
			z = 1;
		} else if (metabolizm <= 70000) {
			z = 2;
		} else {
			z = 3;
		}

		$(".beer-image").attr('src', Beer.images[z]);
		$("#k").text(metabolizm);
	}
}


$(function(){
	$(".beer-choice.radio").on("click", function() {
		$(this).find("input[type=radio]").click();
	});
});


$(function() {  
var el1 = $('#cat-eye-left'), eyeBall1 = el1.find('div');  
var el2 = $('#cat-eye-right'), eyeBall2 = el2.find('div');  
el1.show();  
el2.show();  
var x1 = el1.offset().left + 37, y1 = el1.offset().top + 15;  
var r = 6, x , y, x2, y2, isEyeProcessed = false;  
$('body').mousemove(function(e) {  
if (!isEyeProcessed) {  
isEyeProcessed = true;  
var x2 = e.pageX, y2 = e.pageY;  
 
y = ((r * (y2 - y1)) / Math.sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1))) + y1;  
x = (((y - y1) * (x2 - x1)) / (y2 - y1)) + x1;  
 
eyeBall1.css({  
marginTop: (y - y1 + 1) + 'px',  
marginLeft: (x - x1) + 'px'  
});  
eyeBall2.css({  
marginTop: (y - y1 - 1) + 'px',  
marginLeft: (x - x1) + 'px'  
});  
isEyeProcessed = false;  
}  
});  
 
$('#cat').mousemove(function(e) {  
e.stopPropagation();  
return false;  
});  

});  

Array.prototype.remove = function() {
    var what, a = arguments, L = a.length, ax;
    while (L && this.length) {
        what = a[--L];
        while ((ax = this.indexOf(what)) !== -1) {
            this.splice(ax, 1);
        }
    }
    return this;
};


Array.prototype.getUnique = function(){
   var u = {}, a = [];
   for(var i = 0, l = this.length; i < l; ++i){
      if(u.hasOwnProperty(this[i])) {
         continue;
      }
      a.push(this[i]);
      u[this[i]] = 1;
   }
   return a;
}