require 'nokogiri'
require 'open-uri'

module Parser
	class Product
		attr_reader :category, :url
		def initialize(category, url)
			@category = category
			@url = url
		end

		def funct_parsing
			rows.each do |row|
				title = row.css("td")[1].css("a")[0].content
				belky = row.css("td")[2].content.to_f
				zhiry = row.css("td")[3].content.to_f
				uglevody = row.css("td")[4].content.to_f
				kaloriynost = row.css("td")[5].content.to_f

				url = 'http://www.calorizator.ru' + row.css("td")[1].css("a")[0]['href']
				doc2 = Nokogiri::HTML open(url)
				remote_picture_url = doc2.css(".field-field-picture a.imagefield img")[0]['src'] rescue nil
				description = doc2.css(".node-content")[0].to_html

				product = category.products.where(title: title).first_or_create
				product.update belki: belky, zhiri: zhiry, uglevodi: uglevody,
							   calorynost: kaloriynost, remote_picture_url: remote_picture_url,
							   description: description
			end

			if has_pager? && last_pager
				url2 = 'http://www.calorizator.ru' + last_pager.css("a").first["href"]
				Parser::Product.new(category, url2).funct_parsing
			end
		end

		private 

		def doc
			@_doc ||= Nokogiri::HTML open(url)
		end
		def table
			@_table ||= doc.css('table.views-table').first
		end
		def rows
			@_rows ||= table.css('tbody tr')
		end
		def has_pager?
			doc.css("ul.pager").length > 0
		end
		def last_pager
			doc.css('ul.pager li.pager-next').first
		end
	end
end
