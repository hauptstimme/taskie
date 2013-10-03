require "spec_helper"

describe TaskMailer do
  describe "new_task" do
    let(:mail) { TaskMailer.new_task }

    it "renders the headers" do
      mail.subject.should eq("New task")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
