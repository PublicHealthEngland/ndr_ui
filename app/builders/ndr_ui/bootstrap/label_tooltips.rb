module NdrUi
  module Bootstrap
    # This extension adds I18n based tooltips to form labels.
    module LabelTooltips
      # Generates a form label tag and appends a question_tooltip if an appropriate translation
      # is found in the locale file. Tooltip translation can be overriden by passing the :tooltip
      # option with the desired text.
      #
      # The content for a label_tag is sourced from either the passed block, the passed text or
      # the tag builder's underlying translations, in that order. We inject our own block
      # that recreates that same logic whilst tacking on our tooltip, so that form.label continues
      # to work as one might expect from reading the documentation.
      # See the source code for ActionView::Helpers::Tags::Label for more.
      #
      # QUESTION: Parameterise the tooltip so we're not just bound to a question_tooltip ?
      def label(method, text = nil, **options, &block)
        tooltip_text = options.delete(:tooltip)

        super(method, text, options) do |builder|
          output = block ? block.call : text
          output ||= builder.translation

          tooltip = question_tooltip(method, tooltip_text)

          @template.safe_join([output, tooltip].compact, ' ')
        end
      end

      private

      def question_tooltip(method, text = nil)
        # Suppress a tooltip if you really want/need to...
        return if text == false
        text ||= translate_tooltip(method)
        return unless text.is_a?(String)
        return if text =~ /translation missing/

        @template.content_tag(:span, title: text.strip, class: 'question-tooltip') do
          @template.bootstrap_icon_tag('question-sign')
        end
      end

      # QUESTION: Should this be a method on a model (e.g. Model.attribute_tooltip) similar to
      # Model.human_attribute_name, or is it irrelevant/overkill?
      def translate_tooltip(attribute)
        scope        = 'tooltips'
        search_paths = ["#{scope}.#{attribute}"]

        if @object.present?
          @object.class.lookup_ancestors.map do |ancestor|
            search_paths.unshift("#{scope}.#{ancestor.model_name.i18n_key}.#{attribute}")
          end

          search_paths.unshift("#{scope}.#{@object.class.model_name.i18n_key}.#{attribute}")
        end

        search_paths.map!(&:to_sym)

        @template.t(search_paths.shift, default: search_paths)
      end
    end
  end
end
