class LiquidValidator < ActiveModel::Validator
	def validate(record)
		Liquid::Template.parse(sanitize record.content)
	rescue Liquid::SyntaxError => e
		record.errors.add(:content, e.message)
	end	

	private
	def sanitize(content)
		content.delete("\r").delete("\n") if content
	end
end
