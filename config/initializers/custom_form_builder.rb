class CustomFormBuilder < ActionView::Helpers::FormBuilder
  def text_field(attribute, options={})
    super(attribute, options.reverse_merge(class: "form-control"))
  end

  def select(object_name, method_name, template_object, options={})
    super(object_name, method_name, template_object, options.reverse_merge(class: "form-control"))
  end

  def number_field(attribute, options={})
  super(attribute, options.reverse_merge(class: "form-control"))
  end
end