# frozen_string_literal: true
class Course < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true

  belongs_to :author, class_name: 'Author', foreign_key: 'author_id', required: true
  has_and_belongs_to_many :talents, class_name: 'Talent'
  belongs_to :learning_path, optional: true
end