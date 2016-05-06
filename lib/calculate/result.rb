module Calculate
	class Result

		attr_reader :user_id, :height, :weight, :activnost_id, :product_ids
	
		def initialize(user_id, height, weight, activnost_id, product_ids)
			@user_id = user_id
			@height = height
			@weight = weight
			@activnost_id = activnost_id
			@product_ids = product_ids
		end
	
		def run
			# 1: рассчитать метаболизм (кол-во калорий)
			# 2: посчитать кол-во БЖУ в граммах
			# 3: запустить модуль оптимизации
			p "Метаболизм: #{metabolizm}"
			p "Б: #{belky_gm}мг"
			p "Ж: #{zhiry_gm}мг"
			p "У: #{uglevody_gm}мг"
			p Calculate::GradientSpusk.new(products, prepare_params).run
			# binding.pry
		end
	
	private 
		
		def activnost
			@_activnost ||= Activnost.find(activnost_id) 
		end

		def products
			@_products ||= Product.where(id: product_ids)
		end

		def user
			@_user ||= User.find(user_id)
		end

		def metabolizm
			@_metabolizm ||= (user.gender == 'girl' ? metabolizm_girl : metabolizm_boy) * activnost.activity_coef
		end

		def metabolizm_girl
			655.1 + 9.563 * weight + 1.85 * height - 4.676 * user.age
		end

		def metabolizm_boy
			10 * weight + 6.52 * height - 5 * user.age + 5
		end

		def belky_gm
			@_belky_gm ||= (metabolizm * activnost.belky_percent) / 4
		end

		def zhiry_gm
			@_zhiry_gm ||= (metabolizm * activnost.zhiry_percent) / 9
		end

		def uglevody_gm
			@_uglevody_gm ||= (metabolizm * activnost.uglevody_percent) / 4
		end

		def prepare_products
			products.map {|product| { product: product, gm: 0.0 } }
		end

		def prepare_params
			{ metabolizm: metabolizm, belky_gm: belky_gm, zhiry_gm: zhiry_gm, uglevody_gm: uglevody_gm }
		end

	end
end