require 'spec_helper'

describe Comment do
  let(:comment) { FactoryGirl.create(:comment) }

  subject { comment }

  it { should be_valid }

  describe "associations" do
    it { should respond_to(:task) }
    it { should respond_to(:user) }
  end

  describe "validations" do
    describe "without task" do
      let(:comment) { FactoryGirl.build(:comment, task: nil) }
      it { should_not be_valid }
    end

    describe "without user" do
      let(:comment) { FactoryGirl.build(:comment, user: nil) }
      it { should_not be_valid }
    end

    describe "without text" do
      let(:comment) { FactoryGirl.build(:comment, text: "") }
      it { should_not be_valid }
    end
  end

  describe "#update" do
    subject { comment.update(text: "Updated text") }

    describe "comment is more that one day old" do
      before { comment.update_column :created_at, 25.hours.ago }
      it "doesn't change the comment" do
        expect {
          comment.update(text: "Updated text")
        }.not_to change{ Comment.find(comment.id).text }
      end
    end

    describe "comment is less than one day old" do
      before { comment.update_column :created_at, 23.hours.ago }
      it "changes the comment" do
        expect {
          comment.update(text: "Updated text")
        }.to change{ Comment.find(comment.id).text }.to("Updated text")
      end
    end
  end

  describe "#modifiable?" do
    subject { comment.modifiable? }

    describe "more than one day ago" do
      let(:comment) { FactoryGirl.build(:comment, created_at: 25.hours.ago) }
      it { should be_false }
    end

    describe "less than one day ago" do
      let(:comment) { FactoryGirl.build(:comment, created_at: 23.hours.ago) }
      it { should be_true }
    end
  end

  describe "#notify" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) { task.save }

    describe "when assignee is not present" do
      let(:task) { FactoryGirl.create(:task, creator: user, assignee: nil) }

      describe "when author of comment is a task creator" do
        let(:comment) { FactoryGirl.build(:comment, task: task, user: user) }

        it "should not send an email" do
          expect { comment.save }.not_to change { ActionMailer::Base.deliveries.count }
        end
      end

      describe "when author of comment is not a task creator" do
        let(:comment) { FactoryGirl.build(:comment, task: task) }

        it "should send one email" do
          expect { comment.save }.to change { ActionMailer::Base.deliveries.count }.by(1)
        end
      end
    end

    describe "when assignee and creator are the same person" do
      let(:task) { FactoryGirl.create(:task, creator: user, assignee: user) }

      describe "when author of comment is a task creator" do
        let(:comment) { FactoryGirl.build(:comment, user: user, task: task) }

        it "should not send an email" do
          expect { comment.save }.not_to change { ActionMailer::Base.deliveries.count }
        end
      end

      describe "when author of comment is not a task creator" do
        let(:comment) { FactoryGirl.build(:comment, task: task) }

        it "should send one emails" do
          expect { comment.save }.to change { ActionMailer::Base.deliveries.count }.by(1)
        end
      end
    end

    describe "when assignee and creator are the different persons" do

      describe "when author of comment is a task creator" do
        let(:task) { FactoryGirl.create(:task, creator: user) }
        let(:comment) { FactoryGirl.build(:comment, user: user, task: task) }

        it "should send one email" do
          expect { comment.save }.to change { ActionMailer::Base.deliveries.count }.by(1)
        end
      end

      describe "when author of comment is a task assignee" do
        let(:task) { FactoryGirl.create(:task, assignee: user) }
        let(:comment) { FactoryGirl.build(:comment, user: user, task: task) }

        it "should send one email" do
          expect { comment.save }.to change { ActionMailer::Base.deliveries.count }.by(1)
        end
      end

      describe "when author of comment is not a task creator or task assignee" do
        let(:task) { FactoryGirl.create(:task) }
        let(:comment) { FactoryGirl.build(:comment, task: task) }

        it "should send two emails" do
          expect { comment.save }.to change { ActionMailer::Base.deliveries.count }.by(2)
        end
      end
    end
  end
end
