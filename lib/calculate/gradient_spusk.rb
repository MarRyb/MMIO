module Calculate
	class GradientSpusk
	
		EPS = 1E-3 # погрешность
		DX  = 1E-6

		attr_reader :products, :params
		
		# products
		# { product: Object, gm: 0.0 }
		# 
		# params
		# { metabolizm: _, belky_gm: _, uglevody_gm: _, zhiry_gm: _ }

		def initialize(products, params)
			@products = products
			@params   = params
		end

		def run
			x = products.map { 0.0 }
			iteration_count = 0
			h0 = 1.0
			h = *h0
			@beta = 10.0

			begin
				x0 = *x
				h = h0
				iteration_count += 1
				k = 0

				zx = z(x)
				grad = gradient(x)
				norma_gradient = norma(grad)

				inner_iterations_count = 0

				while (norma_gradient > EPS && h > EPS && inner_iterations_count < 10)
					inner_iterations_count += 1
					x1 = x.enum_for(:each_with_index).map {|xi, i| xi - h*grad[i]/norma_gradient }
					# x1 = x.map {|xi| xi > 0.0 ? xi : 0.0 }
					# x = *x0
					zx1 = z(x1)

					if zx1 < zx
						x = x1
						zx = zx1
						grad = gradient(x)
						norma_gradient = norma(grad)
						h *= 10.0
						k += 1
					else
						h *= 0.5
					end
				end

				dx = []
				x.each_with_index { |xi, i| dx[i] = xi - x0[i] }
				@beta *= 10.0
			end until norma(dx) < EPS
			p "belki: #{sum_belki(x)}"
			p "zhiri: #{sum_zhiri(x)}"
			p "uglevodi: #{sum_uglevodi(x)}"
			p "metabolizm: #{sum_metabolizm(x)}"
			return x
		end

	private

		def f(x)
			return x.sum
		end

		def g(x)
			res = []

			res << (sum_belki(x) - params[:belky_gm]) ** 2
			res << (sum_zhiri(x) - params[:zhiry_gm]) ** 2
			res << (sum_uglevodi(x) - params[:uglevody_gm]) ** 2
			res << (sum_metabolizm(x) - params[:metabolizm]) ** 2
			
			return res.sum
		end

		def sum_metabolizm(x)
			temp = []
			x.each_with_index do |xi, i|
				temp << xi * (products[i].calorynost / 100)
			end
			return temp.sum
		end

		def sum_belki(x)
			temp = []
			x.each_with_index do |xi, i|
				temp << xi * (products[i].belki / 100)
			end
			return temp.sum
		end

		def sum_zhiri(x)
			temp = []
			x.each_with_index do |xi, i|
				temp << xi * (products[i].zhiri / 100)
			end
			return temp.sum
		end

		def sum_uglevodi(x)
			temp = []
			x.each_with_index do |xi, i|
				temp << xi * (products[i].uglevodi / 100)
			end
			return temp.sum
		end

		def z(x)
			return f(x) + @beta * g(x)
		end

		def gradient(x)
			zx = z(x)
			grad = []
			x.each_with_index do |xi, i|
				x[i] = xi + DX
				grad[i] = (z(x) - zx) / DX
				x[i] = xi
			end
			return grad
		end

		def norma(grad)
			ng = grad.inject(0) {|ng, xi| ng += xi**2 }
			return Math.sqrt(ng)
		end

	end
end