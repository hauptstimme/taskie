require 'spec_helper'

describe Project do
  let(:project) { FactoryGirl.build(:project) }
  subject { project }

  it { should be_valid }

  describe "validations" do
    describe "without name" do
      let(:project) { FactoryGirl.build(:project, name: "") }
      it { should_not be_valid }
    end
  end
end
