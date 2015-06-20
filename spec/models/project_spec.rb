require 'spec_helper'

describe Project do
  let(:project) { FactoryGirl.build(:project) }

  subject { project }

  it { is_expected.to be_valid }

  describe "assocations" do
    it { is_expected.to respond_to(:tasks) }
    it { is_expected.to respond_to(:owner) }
    it { is_expected.to respond_to(:users) }
    it { is_expected.to respond_to(:milestones) }
  end

  describe "validations" do
    describe "without name" do
      let(:project) { FactoryGirl.build(:project, name: "") }
      it { is_expected.not_to be_valid }
    end

    describe "without owner" do
      let(:project) { FactoryGirl.build(:project, owner: nil) }
      it { is_expected.not_to be_valid }
    end
  end

  describe "hooks" do
    describe "#add_owner_to_participants" do
      let(:project) { FactoryGirl.create(:project) }

      it "adds owner to participants" do
        expect(project.user_ids.include?(project.owner_id)).to be_truthy
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
