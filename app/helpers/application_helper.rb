#
module ApplicationHelper
  def primary_link_to(*args, &block)
    options = add_btn_classes_to_options(args.extract_options!, :primary, :block)
    link_to(*(args << options), &block)
  end

  def secondary_link_to(*args, &block)
    options = add_btn_classes_to_options(args.extract_options!, :secondary, :block)
    link_to(*(args << options), &block)
  end

  def add_btn_classes_to_options(options, *btn_names)
    btn_classes = [:btn]
    btn_classes += btn_names.map { |btn_name| :"btn-#{btn_name}" }
    add_class_to_options(options, btn_classes)
  end

  def add_class_to_options(options, data)
    case options[:class]
    when nil, ''
      options[:class] = data
    when Array
      options[:class] << Array.wrap(data)
    when String
      options[:class] << " #{Array.wrap(data).join(' ')}"
      options[:class].strip!
    end
  end
end
