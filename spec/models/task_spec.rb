require 'spec_helper'

describe Task do
  let(:task) { FactoryGirl.build(:task) }

  subject { task }

  it { is_expected.to be_valid }

  describe "associations" do
    it { is_expected.to respond_to(:creator) }
    it { is_expected.to respond_to(:assignee) }
    it { is_expected.to respond_to(:project) }
    it { is_expected.to respond_to(:milestone) }
    it { is_expected.to respond_to(:comments) }
    it { is_expected.to respond_to(:followers) }
  end

  describe "validations" do
    describe "without name" do
      let(:task) { FactoryGirl.build(:task, name: "") }
      it { is_expected.not_to be_valid }
    end

    describe "without creator" do
      let(:task) { FactoryGirl.build(:task, creator: nil) }
      it { is_expected.not_to be_valid }
    end

    describe "without project" do
      let(:task) { FactoryGirl.build(:task, project: nil) }
      it { is_expected.not_to be_valid }
    end
  end

  describe "scopes", slow: true do
    %i(critical normal).each do |priority|
      %i(completed active).each do |status|
        { recent: Time.current, old: 1.week.ago }.each do |name, time|
          let!(:"#{status}_#{priority}_#{name}") do
            FactoryGirl.create(:task, status: status, priority: priority, updated_at: time)
          end
        end
      end
    end

    describe ".sorted" do
      subject { Task.sorted }

      it do
        is_expected.to eq [
          active_critical_recent,
          active_critical_old,
          active_normal_recent,
          active_normal_old,
          completed_critical_recent,
          completed_critical_old,
          completed_normal_recent,
          completed_normal_old
        ]
      end
    end
  end

  describe "hooks" do
    describe "#notify_assignee" do
      describe "when assignee was changed and is currently present" do
        it "sends an email" do
          expect do
            FactoryGirl.create(:task)
          end.to change { ActionMailer::Base.deliveries.count }.by(1)
        end
      end

      describe "when assignee was changed to nil" do
        it "doesn't send an email" do
          expect do
            FactoryGirl.create(:task, assignee: nil)
          end.not_to change { ActionMailer::Base.deliveries.count }
        end
      end

      describe "when assignee was not changed and is currently present" do
        it "doesn't send an email" do
          task = FactoryGirl.create(:task)
          expect do
            task.update(name: "changing name")
          end.not_to change { ActionMailer::Base.deliveries.count }
        end
      end
    end
  end

  describe "#add_follower" do
    let(:user) { FactoryGirl.create(:user) }

    describe "when doesn't follow" do
      before { task.followers.delete user }

      it "adds" do
        expect { task.add_follower(user) }.to change { task.follower_ids.include? user.id }
      end
    end

    describe "when follows" do
      before { task.add_follower(user) }

      it "doesn't add" do
        expect { task.add_follower(user) }.not_to change { task.follower_ids.include? user.id }
      end
    end

    describe "when auto-following is disabled" do
      before { user.update auto_follow_tasks: false }

      it "doesn't add" do
        expect { task.add_follower(user) }.not_to change { task.follower_ids.include? user.id }
      end
    end
  end

  describe "#name_with_id" do
    subject { task.name_with_id }
    let(:task) { FactoryGirl.create(:task, id: 93, name: "Some weird task") }
    it { is_expected.to eq("#93 Some weird task") }
  end
end
