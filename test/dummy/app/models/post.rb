class Post < ActiveRecord::Base
  has_many :comments

  def warnings
    @warnings ||= ActiveModel::Errors.new(self)
  end

  def safe?
    @warnings.empty?
  end

  def banner_image
    Struct.new(:url).new
  end
end
