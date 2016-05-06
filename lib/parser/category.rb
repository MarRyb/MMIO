require 'nokogiri'
require 'open-uri'

module Parser
	class Category
		def funct_parsing
			uls_size = uls.length
			uls[0..uls_size-2].each do |ul|
				ul.css("a").each do |a|
					category = Kategory.where(title: a.content).first_or_create
					link = 'http://www.calorizator.ru/'+a['href']
					Parser::Product.new(category, link).funct_parsing
				end
			end
		end

		private 

		def doc
			@_doc ||= Nokogiri::HTML open('http://www.calorizator.ru/product')
		end
		def uls
			@_uls ||= doc.css("ul.product")
		end
		def rows
			table.css("tr")
		end
	end
end
