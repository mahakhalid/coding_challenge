# frozen_string_literal: true
class Talent < ApplicationRecord
  validates :name, presence: true

  has_and_belongs_to_many :courses
  has_and_belongs_to_many :learning_paths
  has_many :authored_courses, class_name: 'Course', foreign_key: 'author_id'
end
