require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/contacts/show.html.haml" do
  include ContactsHelper

  before(:each) do
    login_and_assign
    assigns[:contact] = Factory(:contact, :id => 42)
    assigns[:users] = [ @current_user ]
    assigns[:comment] = Comment.new
  end

  it "should render contact landing page" do
    template.should_receive(:render).with(hash_including(:partial => "comments/new"))
    template.should_receive(:render).with(hash_including(:partial => "common/timeline"))
    template.should_receive(:render).with(hash_including(:partial => "common/tasks"))
    template.should_receive(:render).with(hash_including(:partial => "opportunities/opportunity"))

    render "/contacts/show.html.haml"

    response.should have_tag("div[id=edit_contact]")
  end

end

