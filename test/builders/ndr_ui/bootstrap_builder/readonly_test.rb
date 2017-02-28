require 'test_helper'

# Test bootstrap form builder readonly behaviour
class ReadonlyTest < ActionView::TestCase
  tests ActionView::Helpers::FormHelper
  include NdrUi::BootstrapHelper

  test 'readonly should not be the default' do
    post = Post.new
    bootstrap_form_for post do |form|
      refute form.readonly?
    end
  end

  test 'readonly should be settable' do
    post = Post.new
    bootstrap_form_for post do |form|
      form.readonly = true
      assert form.readonly?
    end

    bootstrap_form_for post, readonly: true do |form|
      assert form.readonly?
    end
  end

  test 'readonly should propagate down to fields_for' do
    post = Post.new
    bootstrap_form_for post, readonly: true do |form|
      form.fields_for(:sub_records) do |sub_form|
        assert sub_form.readonly?
      end
    end
  end

  test 'readonly should not propagate up from fields_for' do
    post = Post.new
    bootstrap_form_for post do |form|
      form.fields_for(:sub_records) do |sub_form|
        sub_form.readonly = true
        assert sub_form.readonly?
        refute form.readonly?
      end
    end

    bootstrap_form_for post do |form|
      form.fields_for(:sub_records, readonly: true) do |sub_form|
        assert sub_form.readonly?
        refute form.readonly?
      end
    end
  end

  test 'readonly fields should show value instead' do
    time = Time.current
    post = Post.new(created_at: time)

    puts "mama"

    @output_buffer =
      bootstrap_form_for post do |form|
        form.text_field :created_at
      end

    assert_select 'input[type=text]#post_created_at'
    assert_select 'p.form-control-static', 0

    @output_buffer =
      bootstrap_form_for post, readonly: true do |form|
        form.text_field :created_at
      end
    assert_select 'input[type=text]#post_created_at', 0
    assert_select 'p.form-control-static', text: time.to_s
  end
end
