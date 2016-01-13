module ApplicationHelper
  def add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    # fields is an HTML form that uses the f template
    fields = f.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
  end
end
