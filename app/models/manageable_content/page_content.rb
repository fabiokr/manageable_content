class ManageableContent::PageContent < ActiveRecord::Base
  belongs_to :page, :touch => true

  attr_accessible :content

  validates :page_id, :presence => true
  validates :key,     :presence => true

  default_scope order('short DESC, key ASC')
end