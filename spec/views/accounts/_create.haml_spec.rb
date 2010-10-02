require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/accounts/_create.html.haml" do
  include AccountsHelper
  
  before(:each) do
    login_and_assign
    assigns[:account] = Account.new
    assigns[:users] = [ @current_user ]
  end

  it "should render [create account] form" do
    template.should_receive(:render).with(hash_including(:partial => "accounts/top_section"))
    template.should_receive(:render).with(hash_including(:partial => "accounts/contact_info"))
    template.should_receive(:render).with(hash_including(:partial => "accounts/permissions"))

    render "/accounts/_create.html.haml"
    response.should have_tag("form[class=new_account]")
  end

  it "should render background info field if settings require so" do
    Setting.background_info = [ :account ]

    render "/accounts/_create.html.haml"
    response.should have_tag("textarea[id=account_background_info]")
  end

  it "should not render background info field if settings do not require so" do
    Setting.background_info = []

    render "/accounts/_create.html.haml"
    response.should_not have_tag("textarea[id=account_background_info]")
  end

end


