require 'rails_helper'

RSpec.describe Item, type: :model do
  context "association" do
    it { should have_many(:orders)}
    it { should have_many(:ordered_items)}
  end
end
