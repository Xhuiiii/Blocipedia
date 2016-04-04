module ApplicationHelper
	def markdown(text)
		Redcarpet::Markdown.new(Redcarpet::Render::HTML,
			no_intra_emphasis: true,
			fenced_code_blocks: true,
			disable_indented_code_blocks: true,
			quote: true,
			underline: true,
			highlight: true
			).render(text).html_safe
	end
end
