class Quest < ActiveRecord::Base
	validates :title, :presence => true,
					  :length => { :minimum => 5 }
	validates :start, :presence => true
	validates :enddate,   :presence => true
	validates :description, :presence => true
					  
	has_many :comments, :dependent => :destroy
	has_many :reverse_experiences,  :foreign_key => "joined_id",
									:class_name => "Experience",
									:dependent => :destroy
	has_many :joiners, :through => :reverse_experiences, :source => :joiner
	has_one :user
	
	has_attached_file :photo,
		:styles => { :thumb => "50x50#",
					 :small => "100x100>",
					 :original => "150x150>" },
		:default_url => 'photos/missing_:style.png',
  #      :url  => "/system/photos/:id/:style/:basename.:extension",
  #      :path => ":rails_root/public/system/photos/:id/:style/:basename.:extension"
		:storage => :s3,
		:s3_credentials => "#{Rails.root}/config/s3.yml",
		:path => ":attachment/:id/:style.:extension"


				  
	validates_attachment_size :photo, :less_than => 5.megabytes
	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/gif']	
	

	
	def self.search(search)
	  if search
		where 'title LIKE ? OR description LIKE ?', "%#{search}%", "%#{search}%"
	  else
		scoped
	  end
	end

end
