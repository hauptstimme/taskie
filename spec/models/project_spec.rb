require 'spec_helper'

describe Project do
  let(:project) { FactoryGirl.build(:project) }

  subject { project }

  it { should be_valid }

  describe "assocations" do
    it { should respond_to(:tasks) }
    it { should respond_to(:owner) }
    it { should respond_to(:users) }
    it { should respond_to(:milestones) }
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
    describe "when there are no tasks and milestones" do
      before do
        project.tasks.destroy
        project.milestones.destroy
      end

      it "doesn't raise an exception" do
        expect { project.destroy }.not_to raise_exception
      end
    end

    describe "when there are tasks" do
      before { FactoryGirl.create(:task, project: project) }

      it "raises an exception" do
        expect { project.destroy }.to raise_exception(ActiveRecord::DeleteRestrictionError)
      end
    end

    describe "when there are milestones" do
      before { FactoryGirl.create(:milestone, project: project) }

      it "raises an exception" do
        expect { project.destroy }.to raise_exception(ActiveRecord::DeleteRestrictionError)
      end
    end
  end
end
