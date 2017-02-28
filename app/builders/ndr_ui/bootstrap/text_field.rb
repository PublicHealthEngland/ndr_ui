module NdrUi
  module Bootstrap
    # Provides a form builder method for the text_field plugin
    module TextField
      # Creates a Bootstrap Text Field
      
      def text_field(method, options = {})
        return method_not_defined(method) unless object.respond_to?(method)
        options = options.stringify_keys
        prepend = options.delete('prepend')
        append = options.delete('append')

        if prepend.blank? && append.blank?
          super
        else
          div_content  = ''.html_safe

          unless prepend.blank?
            div_content << @template.content_tag(:span, prepend, :class => 'input-group-addon').html_safe
          end

          div_content << text_field_without_inline_errors(method, options)

          unless append.blank?
            div_content << @template.content_tag(:span, append, :class => 'input-group-addon').html_safe
          end

          #div_content << inline_errors_and_warnings(method)

          @template.content_tag(:div, div_content, :class => 'input-group')
        end
      end
    end
  end
end
