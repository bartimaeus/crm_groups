require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/campaigns/show.html.haml" do
  include CampaignsHelper

  before(:each) do
    login_and_assign
    assigns[:campaign] = Factory(:campaign, :id => 42)
    assigns[:users] = [ @current_user ]
    assigns[:comment] = Comment.new
  end

  it "should render campaign landing page" do
    template.should_receive(:render).with(hash_including(:partial => "comments/new"))
    template.should_receive(:render).with(hash_including(:partial => "common/timeline"))
    template.should_receive(:render).with(hash_including(:partial => "common/tasks"))
    template.should_receive(:render).with(hash_including(:partial => "leads/lead"))
    template.should_receive(:render).with(hash_including(:partial => "opportunities/opportunity"))

    render "/campaigns/show.html.haml"

    response.should have_tag("div[id=edit_campaign]")
  end

end

