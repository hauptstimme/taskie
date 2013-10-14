require 'spec_helper'

describe Task do
  let(:task) { FactoryGirl.create(:task) }
  subject { task }

  it { should be_valid }

  describe "validations" do
    describe "without name" do
      let(:task) { FactoryGirl.build(:task, name: "") }
      it { should_not be_valid }
    end
  end

  describe "scopes" do
    subject { Task }

    it { should respond_to(:active) }
    it { should respond_to(:completed) }
  end

  describe "#name_with_id" do
    subject { task.name_with_id }
    let(:task) { FactoryGirl.create(:task, id: 93, name: "Some weird task") }
    it { should == "#93 Some weird task" }
  end
end
