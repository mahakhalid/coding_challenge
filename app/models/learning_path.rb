# frozen_string_literal: true
class LearningPath < ApplicationRecord
  validates :name, presence: true

  has_and_belongs_to_many :talents
  has_many :courses, -> { order(position: :asc) }, inverse_of: :learning_path
end