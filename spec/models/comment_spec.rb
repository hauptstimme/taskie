require 'spec_helper'

describe Comment do
  let(:comment) { FactoryGirl.build(:comment) }

  subject { comment }

  it { is_expected.to be_valid }

  describe "associations" do
    it { is_expected.to respond_to(:task) }
    it { is_expected.to respond_to(:user) }
  end

  describe "validations" do
    describe "without task" do
      let(:comment) { FactoryGirl.build(:comment, task: nil) }
      it { is_expected.not_to be_valid }
    end

    describe "without user" do
      let(:comment) { FactoryGirl.build(:comment, user: nil) }
      it { is_expected.not_to be_valid }
    end

    describe "without text" do
      let(:comment) { FactoryGirl.build(:comment, text: "") }
      it { is_expected.not_to be_valid }
    end
  end

  describe "#update" do
    describe "comment is more that one day old" do
      before do
        comment.save
        Timecop.travel 25.hours.from_now
      end

      it "doesn't change the comment" do
        expect { comment.update(text: "Updated text") }.not_to change { comment.reload.text }
      end
    end

    describe "comment is less than one day old" do
      before do
        comment.save
        Timecop.travel 23.hours.from_now
      end

      it "changes the comment" do
        expect { comment.update(text: "Updated text") }.to change { comment.reload.text }.to("Updated text")
      end
    end
  end

  describe "#modifiable?" do
    subject { comment.modifiable? }

    describe "more than one day ago" do
      let(:comment) { FactoryGirl.build(:comment, created_at: 25.hours.ago) }
      it { is_expected.to be_falsey }
    end

    describe "less than one day ago" do
      let(:comment) { FactoryGirl.build(:comment, created_at: 23.hours.ago) }
      it { is_expected.to be_truthy }
    end
  end

  describe "hooks" do
    describe "#notify_followers" do
      let(:user) { FactoryGirl.create(:user) }
      let(:task) { FactoryGirl.create(:task, creator: user, assignee: user) }
      let(:users) { FactoryGirl.create_list(:user, 3) }

      before do
        task.follower_ids = users.map(&:id)
        task.save
      end

      describe "when commenter is one of the followers" do
        let(:comment) { FactoryGirl.create(:comment, task: task, user: users.first) }

        it "sends two emails" do
          expect { comment.save }.to change { ActionMailer::Base.deliveries.count }.by(2)
        end
      end

      describe "when commenter is not one of the followers" do
        let(:comment) { FactoryGirl.create(:comment, task: task) }

        it "sends three emails" do
          expect { comment.save }.to change { ActionMailer::Base.deliveries.count }.by(3)
        end
      end
    end
  end
end
