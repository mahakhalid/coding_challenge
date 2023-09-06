# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CompletedCourse, type: :model do
  describe 'associations' do
    it { should belong_to(:course) }
    it { should belong_to(:talent) }
  end

  describe 'validations' do
    it { should validate_presence_of(:course_id) }
    it { should validate_presence_of(:talent_id) }

    it 'validates uniqueness of course_id scoped to talent_id' do
        talent = create(:talent)  # Create a talent record
        author = create(:author)  # Create an author record
      
        # Create a valid course record with the associated author
        course = create(:course, author: author)
      
        # Create an existing CompletedCourse record with the talent and course
        create(:completed_course, talent: talent, course: course)
      
        # Attempt to create another CompletedCourse record with the same talent and course
        duplicate_completed_course = build(:completed_course, talent: talent, course: course)
        expect(duplicate_completed_course).not_to be_valid
      end
  end
end
