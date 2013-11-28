require 'spec_helper'

describe Project do
  let(:project) { FactoryGirl.build(:project) }

  subject { project }

  it { should be_valid }

  describe "assocations" do
    it { should respond_to(:tasks) }
    it { should respond_to(:owner) }
    it { should respond_to(:users) }
  end

  describe "validations" do
    describe "without name" do
      let(:project) { FactoryGirl.build(:project, name: "") }
      it { should_not be_valid }
    end

    describe "without owner" do
      let(:project) { FactoryGirl.build(:project, owner: nil) }
      it { should_not be_valid }
    end
  end

  describe "hooks" do
    describe "#add_owner_to_participants" do
      let(:project) { FactoryGirl.create(:project) }

      it "adds owner to participants" do
        project.user_ids.include?(project.owner_id).should be_true
      end
    end
  end

  describe "#destroy" do
    describe "when there are no tasks" do
      before { project.tasks.destroy }
      it "should not raise an exception" do
        expect {
          project.destroy
        }.not_to raise_exception
      end
    end

    describe "when there are tasks" do
      before { FactoryGirl.create(:task, project: project) }

      it "raises an exception" do
        expect { project.destroy }.to raise_exception(ActiveRecord::DeleteRestrictionError)
      end
    end
  end
end
