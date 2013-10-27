# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.wrappers :semanticui, class: :field, hint_class: :field_with_hint, error_class: :error do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label_input
    b.use :error, wrap_with: { tag: :div, class: 'ui red pointing above label' }
  end

  # The default wrapper to be used by the FormBuilder.
  config.default_wrapper = :semanticui

  # You can define the class to use on all forms. Default is simple_form.
  config.form_class = 'ui form'

  # CSS class for buttons
  config.button_class = 'ui button'

  # CSS class to add for error notification helper.
  config.error_notification_class = 'ui error message'

  # How the label text should be generated altogether with the required text.
  config.label_text = lambda { |label, _| label }

  # You can define the class to use on all labels. Default is nil.
  config.label_class = nil

  # You can define which elements should obtain additional classes
  config.generate_additional_classes_for = [:input]
end
