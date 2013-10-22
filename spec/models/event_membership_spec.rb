require 'spec_helper'

describe EventMembership do
  [ :event_id, :user_id ].each do |field|
    it { should respond_to field }
    it { should_not allow_mass_assignment_of field }
  end

  it { should belong_to :user }
  it { should belong_to :event }
end
