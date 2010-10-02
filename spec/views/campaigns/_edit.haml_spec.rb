require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/campaigns/_edit.html.haml" do
  include CampaignsHelper

  before(:each) do
    login_and_assign
    assigns[:campaign] = @campaign = Factory(:campaign)
    assigns[:users] = [ @current_user ]
  end

  it "should render [edit campaign] form" do
    template.should_receive(:render).with(hash_including(:partial => "campaigns/top_section"))
    template.should_receive(:render).with(hash_including(:partial => "campaigns/objectives"))
    template.should_receive(:render).with(hash_including(:partial => "campaigns/permissions"))

    render "/campaigns/_edit.html.haml"
    response.should have_tag("form[class=edit_campaign]") do
      with_tag "input[type=hidden][id=campaign_user_id][value=#{@campaign.user_id}]"
    end
  end

  it "should render background info field if settings require so" do
    Setting.background_info = [ :campaign ]

    render "/campaigns/_create.html.haml"
    response.should have_tag("textarea[id=campaign_background_info]")
  end

  it "should not render background info field if settings do not require so" do
    Setting.background_info = []

    render "/campaigns/_create.html.haml"
    response.should_not have_tag("textarea[id=campaign_background_info]")
  end
end


