module NdrUi
  module Bootstrap
    # Allows a form to be marked as read-only. Supported field helpers
    # render as a non-editable display instead, allowing a form to be
    # reused as a "show" template.
    #
    # Most helpers have a similar signature, so can be iterated over and
    # enhanced. The reminaining minority have to be manually re-defined.
    module Readonly
      # Tag::Base subclass for generating bootstrap readonly static form control.
      # Allows us to use generate the tag_id properly.
      class StaticValue < ActionView::Helpers::Tags::Base
        def render
          options = @options.symbolize_keys
          readwrite_id =
            if respond_to?(:name_and_id_index, true)
              tag_id(name_and_id_index(options))
            else
              add_default_name_and_id(options.fetch(:html, {}))
            end

          default_to_value = options.fetch(:default_to_value, true)
          readonly_value = options.fetch(:readonly_value,
                                         default_to_value ? object.public_send(@method_name) : nil)
          content_tag(:p, readonly_value, class: 'form-control-static', id: readwrite_id)
        end
      end

      def self.included(base)
        # These have different signatures, or aren't affected by `readonly`:
        not_affected = %i[label fields_for]
        needs_custom = %i[radio_button file_field hidden_field] +
                       base.field_helpers_from_form_options_helper

        (base.field_helpers - needs_custom - not_affected).each do |selector|
          class_eval <<-EVAL, __FILE__, __LINE__ + 1
            def #{selector}(method, options = {}, *rest)
              return super unless readonly?
              StaticValue.new(object_name, method, @template, objectify_options(options)).render
            end
          EVAL
        end

        %i[select time_zone_select].each do |selector|
          class_eval <<-EVAL, __FILE__, __LINE__ + 1
            def #{selector}(method, _something, options = {}, *rest)
              return super unless readonly?
              StaticValue.new(object_name, method, @template, objectify_options(options)).render
            end
          EVAL
        end

        %i[collection_select collection_check_boxes collection_radio_buttons].each do |selector|
          class_eval <<-EVAL, __FILE__, __LINE__ + 1
            def #{selector}(method, collection, value_method, text_method, options = {}, *rest)
              return super unless readonly?
              StaticValue.new(object_name, method, @template, objectify_options(options)).render
            end
          EVAL
        end

        class_eval <<-EVAL, __FILE__, __LINE__ + 1
          # grouped_collection_select takes many other arguments
          def grouped_collection_select(method, collection, group_method, group_label_method, option_key_method, option_value_method, options = {}, html_options = {})
            return super unless readonly?
            StaticValue.new(object_name, method, @template, objectify_options(options)).render
          end

          # radio_button takes another intermediate argument:
          def radio_button(method, tag_value, options = {})
            return super unless readonly?
            StaticValue.new(object_name, method, @template, objectify_options(options)).render
          end

          # For file_field, the readonly value defaults to nil:
          def file_field(method, options = {})
            return super unless readonly?
            options['default_to_value'] = false
            StaticValue.new(object_name, method, @template, objectify_options(options)).render
          end

          # Hidden fields should be suppressed when the form is readonly:
          def hidden_field(*)
            super unless readonly?
          end
        EVAL

        class_eval <<-EVAL, __FILE__, __LINE__ + 1
          # Allow fields_for to inherit `readonly`:
          def fields_for(record_name, record_object = nil, fields_options = {}, &block)
            fields_options[:readonly] ||= readonly
            super
          end
        EVAL
      end

      attr_accessor :readonly
      alias readonly? readonly

      def initialize(*)
        super

        self.readonly = options[:readonly]
      end
    end
  end
end
