require 'spec_helper'

describe Task do
  let(:task) { FactoryGirl.build(:task) }

  subject { task }

  it { should be_valid }

  describe "associations" do
    it { should respond_to(:creator) }
    it { should respond_to(:assignee) }
    it { should respond_to(:project) }
    it { should respond_to(:milestone) }
    it { should respond_to(:comments) }
    it { should respond_to(:followers) }
  end

  describe "validations" do
    describe "without name" do
      let(:task) { FactoryGirl.build(:task, name: "") }
      it { should_not be_valid }
    end

    describe "without creator" do
      let(:task) { FactoryGirl.build(:task, creator: nil) }
      it { should_not be_valid }
    end

    describe "without project" do
      let(:task) { FactoryGirl.build(:task, project: nil) }
      it { should_not be_valid }
    end

    describe "without priority" do
      let(:task) { FactoryGirl.build(:task, priority: nil) }
      it { should_not be_valid }
    end

    describe "without status" do
      let(:task) { FactoryGirl.build(:task, priority: nil) }
      it { should_not be_valid }
    end
  end

  describe "scopes" do
    subject { Task }

    it { should respond_to(:sorted) }
    it { should respond_to(:active) }
    it { should respond_to(:completed) }
    it { should respond_to(:without_project) }
  end

  describe "hooks" do
    describe "#notify_assignee" do
      describe "when assignee was changed and is currently present" do
        it "sends an email" do
          expect {
            FactoryGirl.create(:task)
          }.to change{ ActionMailer::Base.deliveries.count }.by(1)
        end
      end

      describe "when assignee was changed to nil" do
        it "doesn't send an email" do
          expect {
            FactoryGirl.create(:task, assignee: nil)
          }.not_to change{ ActionMailer::Base.deliveries.count }
        end
      end

      describe "when assignee was not changed and is currently present" do
        it "doesn't send an email" do
          task = FactoryGirl.create(:task)
          expect {
            task.update(name: "changing name")
          }.not_to change{ ActionMailer::Base.deliveries.count }
        end
      end
    end
  end

  describe "#add_follower" do
    let(:user) { FactoryGirl.create(:user) }

    describe "when doesn't follow" do
      before { task.followers.delete user }

       it "adds" do
        expect{ task.add_follower(user) }.to change{ task.follower_ids.include? user.id }
      end
    end

    describe "when follows" do
      before { task.add_follower(user) }

       it "doesn't add" do
        expect{ task.add_follower(user) }.not_to change{ task.follower_ids.include? user.id }
      end
     end

    describe "when auto-following is disabled" do
      before { user.update auto_follow_tasks: false }

      it "doesn't add" do
       expect{ task.add_follower(user) }.not_to change{ task.follower_ids.include? user.id }
      end
    end
  end

  describe "#name_with_id" do
    subject { task.name_with_id }
    let(:task) { FactoryGirl.create(:task, id: 93, name: "Some weird task") }
    it { should == "#93 Some weird task" }
  end
end
