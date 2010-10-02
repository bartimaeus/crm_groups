require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/accounts/show.html.haml" do
  include AccountsHelper

  before(:each) do
    login_and_assign
    assigns[:account] = Factory(:account, :id => 42)
    assigns[:users] = [ @current_user ]
    assigns[:comment] = Comment.new
  end

  it "should render account landing page" do
    template.should_receive(:render).with(hash_including(:partial => "comments/new"))
    template.should_receive(:render).with(hash_including(:partial => "common/timeline"))
    template.should_receive(:render).with(hash_including(:partial => "common/tasks"))
    template.should_receive(:render).with(hash_including(:partial => "contacts/contact"))
    template.should_receive(:render).with(hash_including(:partial => "opportunities/opportunity"))

    render "/accounts/show.html.haml"

    response.should have_tag("div[id=edit_account]")
  end

end

