require 'test_helper'

# Test bootstrap form builder form labels with translation based tooltips.
class LabelTooltipsTest < ActionView::TestCase
  tests ActionView::Helpers::FormHelper
  include NdrUi::BootstrapHelper

  test 'should include tooltips when translations exist' do
    post = Post.new
    NdrUi::BootstrapBuilder.any_instance.stubs(:display?).returns(true)

    I18n.expects(:translate).
      with(:'tooltips.post.created_at', raise: true).
      returns('Tooltip')

    @output_buffer =
      bootstrap_form_for post do |form|
        form.label :created_at, 'Test'
      end

    assert_select 'span.question-tooltip[title=Tooltip]'
    assert_select 'label[for=post_created_at]'
  end

  test 'should include tooltips when translations exist - nil model object' do
    NdrUi::BootstrapBuilder.any_instance.stubs(:display?).returns(true)

    I18n.expects(:translate).
      with(:'tooltips.bomb', raise: true, default: []).
      returns('Dangerous')

    @output_buffer =
      form_with(url: '/', builder: NdrUi::BootstrapBuilder) do |form|
        form.label :bomb, 'Test'
      end

    assert_select 'span.question-tooltip[title=Dangerous]'
    assert_select 'label'
    assert_select 'label[for=?]', /.+/, 0
  end

  test 'should not include tooltips when there is no translation' do
    post = Post.new
    NdrUi::BootstrapBuilder.any_instance.stubs(:display?).returns(true)

    @output_buffer =
      bootstrap_form_for post do |form|
        form.stubs(:translate_tooltip).returns('translation missing')
        form.label :created_at
      end

    assert_select '.question-tooltip', 0
    assert_select 'label[for=post_created_at]'
  end

  test 'should not include tooltips when there is no translation - nil model object' do
    NdrUi::BootstrapBuilder.any_instance.stubs(:display?).returns(true)

    @output_buffer =
      form_with(url: '/', builder: NdrUi::BootstrapBuilder) do |form|
        form.stubs(:translate_tooltip).returns('translation missing')
        form.label :bomb
      end

    assert_select '.question-tooltip', 0
    assert_select 'label'
    assert_select 'label[for=?]', /.+/, 0
  end

  test 'should not include tooltips when translations is a hash' do
    post = Post.new
    NdrUi::BootstrapBuilder.any_instance.stubs(:display?).returns(true)

    I18n.expects(:translate).
      with(:'tooltips.post.created_at', raise: true).
      returns(one: 'One', other: 'Other')

    @output_buffer =
      bootstrap_form_for post do |form|
        form.label :created_at, 'Test'
      end

    assert_select '.question-tooltip', 0
    assert_select 'label[for=post_created_at]'
  end

  test 'should allow tooltip text to be set explicitly' do
    post = Post.new
    NdrUi::BootstrapBuilder.any_instance.stubs(:display?).returns(true)

    @output_buffer =
      bootstrap_form_for post do |form|
        form.stubs(:translate_tooltip).returns('Tooltip')
        form.label :created_at, tooltip: 'Not the translated value'
      end

    assert_select '.question-tooltip[title="Not the translated value"]'
    assert_select 'label[for=post_created_at]'
  end

  test 'should allow tooltip text to be set explicitly - nil model object' do
    NdrUi::BootstrapBuilder.any_instance.stubs(:display?).returns(true)

    @output_buffer =
      form_with(url: '/', builder: NdrUi::BootstrapBuilder) do |form|
        form.stubs(:translate_tooltip).returns('Tooltip')
        form.label :bomb, tooltip: 'Not the translated value'
      end

    assert_select '.question-tooltip[title="Not the translated value"]'
    assert_select 'label'
    assert_select 'label[for=?]', /.+/, 0
  end

  test 'should allow tooltips to be suppressed' do
    post = Post.new
    NdrUi::BootstrapBuilder.any_instance.stubs(:display?).returns(true)

    @output_buffer =
      bootstrap_form_for post do |form|
        form.label :updated_at
      end

    assert_select '.question-tooltip', title: 'Time post was last updated'
    assert_select 'label[for=post_updated_at]', text: 'Updated'

    @output_buffer =
      bootstrap_form_for post do |form|
        form.label :updated_at, tooltip: false
      end

    assert_select '.question-tooltip', 0
    assert_select 'label[for=post_updated_at]', text: 'Updated'
  end
end
