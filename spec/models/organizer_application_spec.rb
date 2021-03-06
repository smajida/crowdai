require 'rails_helper'

RSpec.describe OrganizerApplication, type: :model do
  context 'fields' do
    it { is_expected.to respond_to :contact_name }
    it { is_expected.to respond_to :email }
    it { is_expected.to respond_to :phone }
    it { is_expected.to respond_to :organization }
    it { is_expected.to respond_to :organization_description }
    it { is_expected.to respond_to :challenge_description }
  end
end
