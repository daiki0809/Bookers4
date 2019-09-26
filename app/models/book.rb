class Book < ApplicationRecord

	validates :title, presence: true, length: {maximum: 200}
	validates :body, presence: true, length: {maximum: 200}

	belongs_to :user

	def self.search(search)
		return Book.all unless search
		Book.where(['title LIKE?', "%#{search}%"])
	end
end
