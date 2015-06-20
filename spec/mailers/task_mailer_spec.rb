require "spec_helper"

describe TaskMailer do
  describe "#task_assigned" do
    let(:assignee) { FactoryGirl.create(:user, email: "testing-mailer-assignee@maldoror.tk") }
    let(:task) { FactoryGirl.create(:task, name: "Testing mailer", assignee: assignee) }
    let(:mail) { TaskMailer.task_assigned(task) }

    before { mail.deliver_now }

    it "renders the headers" do
      expect(mail.subject).to eq("Assigned task: Testing mailer")
      expect(mail.to).to eq(["testing-mailer-assignee@maldoror.tk"])
      expect(mail.from).to eq(["taskie@hauptstimme.tk"])
    end
  end

  describe "#new_comment" do
    let(:creator) { FactoryGirl.create(:user, email: "testing-mailer-creator@maldoror.tk") }
    let(:task) { FactoryGirl.create(:task, name: "Testing mailer", creator: creator) }
    let(:comment) { FactoryGirl.create(:comment, task: task) }
    let(:mail) { TaskMailer.new_comment(comment, creator) }

    before { mail.deliver_now }

    it "renders the headers" do
      expect(mail.subject).to eq("New comment in task Testing mailer")
      expect(mail.to).to eq(["testing-mailer-creator@maldoror.tk"])
      expect(mail.from).to eq(["taskie@hauptstimme.tk"])
    end
  end
end
