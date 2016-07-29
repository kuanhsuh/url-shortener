class Link < ActiveRecord::Base
  after_create :generate_slug

  def generate_slug
    self.slug = self.id.to_i.to_s(36).rjust(6, "0")
    self.save
  end

  def to_param
    slug
  end
end
