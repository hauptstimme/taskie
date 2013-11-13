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
end
