require 'spec_helper'

describe Tag do
  let(:tag) { FactoryGirl.create(:tag) }

  subject { tag }

  it { should be_valid }

  describe "associations" do
    it { should respond_to(:tasks) }
  end
end
