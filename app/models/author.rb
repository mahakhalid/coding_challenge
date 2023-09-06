# frozen_string_literal: true
class Author < ApplicationRecord
  validates :name, presence: true

  has_many :authored_courses, class_name: 'Course', foreign_key: 'author_id'
end
