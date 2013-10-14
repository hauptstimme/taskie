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
end
