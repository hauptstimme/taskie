require 'spec_helper'

describe Milestone do
  let(:milestone) { FactoryGirl.build(:milestone) }

  subject { milestone }

  it { should be_valid }

  describe "associations" do
    it { should respond_to(:tasks) }
  end

  describe "validations" do
    describe "without project" do
      let(:milestone) { FactoryGirl.build(:milestone, project: nil) }
      it { should_not be_valid }
    end

    describe "without title" do
      let(:milestone) { FactoryGirl.build(:milestone, title: "") }
      it { should_not be_valid }
    end
  end

  describe "#destroy" do
    describe "when there are tasks" do
      let(:task) { FactoryGirl.create(:task, milestone: milestone) }

      before { task.save }

      it "nullifies task's milestone" do
        milestone.destroy
        task.reload.milestone.should_not be_present
      end
    end
  end
end
