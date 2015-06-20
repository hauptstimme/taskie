require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.build(:user) }

  subject { user }

  it { is_expected.to be_valid }

  describe "defaults" do
    let(:user) { FactoryGirl.create(:user) }

    it "auto-follows tasks" do
      expect(user.auto_follow_tasks).to be_truthy
    end
  end

  describe "associations" do
    it { is_expected.to respond_to(:comments) }
    it { is_expected.to respond_to(:projects) }
    it { is_expected.to respond_to(:owned_projects) }
    it { is_expected.to respond_to(:created_tasks) }
    it { is_expected.to respond_to(:assigned_tasks) }
    it { is_expected.to respond_to(:followed_tasks) }
  end

  describe "scopes" do
    let!(:using) { FactoryGirl.create(:user, last_sign_in_at: 1.minute.ago) }
    let!(:never_used) { FactoryGirl.create(:user, last_sign_in_at: nil) }

    describe ".active" do
      subject { User.active }

      it { is_expected.to eq([using]) }
    end
  end

  describe "validations" do
    describe "name" do
      describe "invalid" do
        describe "without name" do
          let(:user) { FactoryGirl.build(:user, username: "") }
          it { is_expected.not_to be_valid }
        end

        describe "wrong length" do
          describe "less than three" do
            let(:user) { FactoryGirl.build(:user, username: "jz") }
            it { is_expected.not_to be_valid }
          end

          describe "more than twenty four" do
            let(:user) { FactoryGirl.build(:user, username: "three" * 5) }
            it { is_expected.not_to be_valid }
          end
        end

        describe "wrong format" do
          describe "when first is not a letter" do
            let(:user) { FactoryGirl.build(:user, username: "0pen") }
            it { is_expected.not_to be_valid }
          end

          describe "another format error" do
            let(:user) { FactoryGirl.build(:user, username: "th1s1swr0ng.") }
            it { is_expected.not_to be_valid }
          end
        end

        describe "not unique" do
          before { FactoryGirl.create(:user, username: "unique") }
          let(:user) { FactoryGirl.build(:user, username: "Unique") }
          it { is_expected.not_to be_valid }
        end
      end

      describe "valid" do
        let(:user) { FactoryGirl.build(:user, username: "validCamel") }
        it { is_expected.to be_valid }
      end
    end

    describe "time_zone" do
      describe "invalid" do
        let(:user) { FactoryGirl.build(:user, time_zone: "No such time zone") }
        it { is_expected.not_to be_valid }
      end

      describe "valid" do
        describe "empty" do
          let(:user) { FactoryGirl.build(:user, time_zone: "") }
          it { is_expected.to be_valid }
        end

        describe "existing" do
          let(:user) { FactoryGirl.build(:user, time_zone: "Alaska") }
          it { is_expected.to be_valid }
        end
      end
    end
  end

  describe "hooks" do
    describe "#set_api_key" do
      subject { user.api_key }
      before { user.save }
      it { is_expected.to be_present }
      it { is_expected.to match(/\A[[:xdigit:]]{32}\z/) }
    end
  end

  describe "#reset_api_key" do
    it "renews API key" do
      expect { user.reset_api_key }.to change{ user.api_key }
    end
  end
end
