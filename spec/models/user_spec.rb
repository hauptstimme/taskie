require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.build(:user) }

  subject { user }

  it { should be_valid }

  describe "associations" do
    it { should respond_to(:comments) }
    it { should respond_to(:projects) }
    it { should respond_to(:owned_projects) }
    it { should respond_to(:created_tasks) }
    it { should respond_to(:assigned_tasks) }
    it { should respond_to(:followed_tasks) }
  end

  describe "scopes" do
    subject { User }
    it { should respond_to(:active) }
  end

  describe "validations" do
    describe "name" do
      describe "invalid" do
        describe "without name" do
          let(:user) { FactoryGirl.build(:user, username: "") }
          it { should_not be_valid }
        end

        describe "wrong length" do
          describe "less than three" do
            let(:user) { FactoryGirl.build(:user, username: "jz") }
            it { should_not be_valid }
          end

          describe "more than twenty four" do
            let(:user) { FactoryGirl.build(:user, username: "three" * 5) }
            it { should_not be_valid }
          end
        end

        describe "wrong format" do
          describe "when first is not a letter" do
            let(:user) { FactoryGirl.build(:user, username: "0pen") }
            it { should_not be_valid }
          end

          describe "another format error" do
            let(:user) { FactoryGirl.build(:user, username: "th1s1swr0ng.") }
            it { should_not be_valid }
          end
        end

        describe "not unique" do
          before { FactoryGirl.create(:user, username: "unique") }
          let(:user) { FactoryGirl.build(:user, username: "Unique") }
          it { should_not be_valid }
        end
      end

      describe "valid" do
        let(:user) { FactoryGirl.build(:user, username: "validCamel") }
        it { should be_valid }
      end
    end

    describe "time_zone" do
      describe "invalid" do
        let(:user) { FactoryGirl.build(:user, time_zone: "No such time zone") }
        it { should_not be_valid }
      end

      describe "valid" do
        describe "empty" do
          let(:user) { FactoryGirl.build(:user, time_zone: "") }
          it { should be_valid }
        end

        describe "existing" do
          let(:user) { FactoryGirl.build(:user, time_zone: "Alaska") }
          it { should be_valid }
        end
      end
    end
  end

  describe "hooks" do
    describe "#set_api_key" do
      subject { user.api_key }
      before { user.save }
      it { should be_present }
      it { should =~ /\A[[:xdigit:]]{32}\z/ }
    end
  end

  describe "#reset_api_key" do
    it "renews API key" do
      expect { user.reset_api_key }.to change{ user.api_key }
    end
  end
end
