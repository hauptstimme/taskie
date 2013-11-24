require "spec_helper"

describe TaskMailer do
  describe "#task_assigned" do
    let(:assignee) { FactoryGirl.create(:user, email: "testing-mailer-assignee@maldoror.tk") }
    let(:task) { FactoryGirl.create(:task, name: "Testing mailer", assignee: assignee) }
    let(:mail) { TaskMailer.task_assigned(task) }

    before { mail.deliver }

    it "renders the headers" do
      mail.subject.should eq("Assigned task: Testing mailer")
      mail.to.should eq(["testing-mailer-assignee@maldoror.tk"])
      mail.from.should eq(["taskie@hauptstimme.tk"])
    end
  end

  describe "#new_comment" do
    let(:creator) { FactoryGirl.create(:user, email: "testing-mailer-creator@maldoror.tk") }
    let(:task) { FactoryGirl.create(:task, name: "Testing mailer", creator: creator) }
    let(:comment) { FactoryGirl.create(:comment, task: task) }
    let(:mail) { TaskMailer.new_comment(comment, creator) }

    before { mail.deliver }

    it "renders the headers" do
      mail.subject.should eq("New comment in task Testing mailer")
      mail.to.should eq(["testing-mailer-creator@maldoror.tk"])
      mail.from.should eq(["taskie@hauptstimme.tk"])
    end
  end
end
