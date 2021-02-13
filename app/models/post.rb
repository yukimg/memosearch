class Post < ApplicationRecord
    validates :word, presence: true, length: { maximum: 255 }
    validates :description, presence: true, length: { maximum: 500 }
end
