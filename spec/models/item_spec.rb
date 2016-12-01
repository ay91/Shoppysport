require 'rails_helper'

RSpec.describe Item, type: :model do
  context "association" do
    it { should have_many(:orders)}
    it { should have_many(:ordered_items)}

    context "validation" do
      it { should validate_presence_of(:title)}
      it { should validate_presence_of(:description)}
      it { should validate_presence_of(:price)}
      it { should validate_presence_of(:image)}
    end
  end
end
