require 'test_helper'

# Test bootstrap form builder date picker
class DatepickerTest < ActionView::TestCase
  tests ActionView::Helpers::FormHelper
  include NdrUi::BootstrapHelper

  test 'text_field' do
    post = Post.new

    bootstrap_form_for(post) do |form|
      check = '<div class="input-group"><span class="input-group-addon"><span class="' \
              'glyphicon glyphicon-calendar"></span></span><input class="form-control"' \
              ' type="text" name="post[id]" id="post_id" /><span class="input-' \
              'group-addon">no</span></div><span class="help-block" data-feedback-for' \
              '="post_id"><span class="text-danger"></span><span class="text-warning">' \
              '</span></span>'
      calendar = content_tag(:span, '', class: 'glyphicon glyphicon-calendar')
      assert_dom_equal check, form.text_field(:id, append: 'no', prepend: calendar)
    end
  end
end
