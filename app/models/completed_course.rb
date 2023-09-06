# frozen_string_literal: true
class CompletedCourse < ApplicationRecord
  belongs_to :course
  belongs_to :talent

  validates_presence_of :course_id
  validates_presence_of :talent_id
  validates_uniqueness_of :course_id, scope: :talent_id
end

