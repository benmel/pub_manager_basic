# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless User.where(email: "user@example.com").exists?
	user = User.new(email: "user@example.com", password: "password", password_confirmation: "password")
	user.save!
end

user = User.where(email: "user@example.com").first

biography_template = user.liquid_templates.find_or_create_by(name: "Biography description") do |liquid_template|
	liquid_template.template_type = "description"
	liquid_template.content = "{% if marketplace == 'kindle' %}<h2>Learn about the inspirational story of {{ title }}</h2>"\
	"{% else %}<b>Learn about the inspirational story of {{ title }}</b>{% endif %}"\
	"<p>In <i>{{ title }}: {{ subtitle }}</i> you will learn about {{ title }}. {{ content }}</p>"\
	"{% if chapters.size > 0 %}<b>Here is a preview of this biography:</b>"\
	"<p><ul>{% for chapter in chapters %}<li>{{ chapter }}</li>{% endfor %}</ul></p>{% endif %}"\
	"{% unless excerpt == blank %}{% unless marketplace == 'acx' %}<b>Here is an excerpt from the book:</b>"\
	"<p><i>{{ excerpt }}</i></p>{% endunless %}{% endunless %}"
end

lifestyle_template = user.liquid_templates.find_or_create_by(name: "Lifestyle description") do |liquid_template|
	liquid_template.template_type = "description"
	liquid_template.content = "This is a book about {{ topic }}"
end

lifestyle_template.liquid_template_parameters.find_or_create_by(name: "topic")

front_template = user.liquid_templates.find_or_create_by(name: "Standard front") do |liquid_template|
	liquid_template.template_type = "front_section"
	liquid_template.content = "<h1>{{ title }}</h1>"\
		"<h2>{{ subtitle }}</h2>"\
		"<p>Copyright © 2016 {{ author }}</p>"\
		"<p>Written with {{ writer }}</p>"\
		"<p>All rights reserved. Neither this book nor any portion thereof may be reproduced or used in any manner "\
		"whatsoever without the express written permission. Published in the United States of America.</p>"
end

front_template.liquid_template_parameters.find_or_create_by(name: "writer")

toc_template = user.liquid_templates.find_or_create_by(name: "Standard TOC") do |liquid_template|
	liquid_template.template_type = "toc_section"
	liquid_template.content = "<h1>Table of Contents</h1>"\
		"<ul><li>Chapter 1</li><li>Chapter 2</li><li>Chapter 3</li></ul>"
end

body_template = user.liquid_templates.find_or_create_by(name: "Standard body") do |liquid_template|
	liquid_template.template_type = "body_section"
	liquid_template.content = "{{ content }}"
end

about_template = user.liquid_templates.find_or_create_by(name: "About the Author") do |liquid_template|
	liquid_template.template_type = "body_section"
	liquid_template.content = "{{ author }} is a resident of Los Angeles. He has been a writer for 10 years."
end

einstein_project = user.projects.find_or_create_by(title: "Albert Einstein") do |project|
	project.subtitle = "A Biography"
	project.author = "Benjamin Southerland"
	project.keywords = "scientist"
	project.isbn10 = "1234567890"
	project.isbn13 = "1234567890123"
end

unless einstein_project.cover
	einstein_project.create_cover(photographer: "John Smith", license: "CC BY-SA 4.0")
end

unless einstein_project.description
	einstein_project.build_description(
		content: "Learn about Einstein's incredible discoveries.", 
		chapter_list: "Introduction;Body;Conclusion",
		excerpt: "This is the introduction to the book.")
	einstein_project.description.build_filled_liquid_template(content: biography_template.content)
	einstein_project.description.save!
end

unless einstein_project.book
	einstein_project.build_book
	einstein_project.book.build_front_section
	einstein_project.book.front_section.build_filled_liquid_template(content: front_template.content)
	einstein_project.book.front_section.filled_liquid_template.filled_liquid_template_parameters.build(name: "writer", value: "Jack Davis")
	einstein_project.book.build_toc_section
	einstein_project.book.toc_section.build_filled_liquid_template(content: toc_template.content)
	einstein_project.book.body_sections.build(name: "Body", content: "This is the content of the book.")
	einstein_project.book.body_sections.first.build_filled_liquid_template(content: body_template.content)
	einstein_project.book.body_sections.build(name: "About the Author")
	einstein_project.book.body_sections.last.build_filled_liquid_template(content: about_template.content)
	einstein_project.book.save!
end
