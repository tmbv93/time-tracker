class User < ApplicationRecord
  before_validation :generate_slug, on: :create

  private

  def generate_slug
    self.slug = "#{}"
  end
end
