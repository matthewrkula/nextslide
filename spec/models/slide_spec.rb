require 'spec_helper'

describe Slide do
  [ :id, :slideshow_id, :note, :slide_number, :created_at, :updated_at ].each do |field|
    it { should respond_to field }
  end

  [ :note, :slide_number, :slideshow_id ].each do |field|
    it { should allow_mass_assignment_of field }
  end

  [ :id, :created_at, :updated_at ].each do |field|
    it { should_not allow_mass_assignment_of field }
  end

  [ :slide_number, :slideshow_id ].each do |field|
    it { should validate_presence_of field }
  end

  it { should belong_to :slideshow }
end
