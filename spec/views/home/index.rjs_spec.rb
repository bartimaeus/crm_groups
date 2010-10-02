require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/home/index.js.rjs" do
  include HomeHelper
  
  before(:each) do
    login_and_assign
  end

  it "should render [activity] template with @activities collection" do
    assigns[:activities] = [ Factory(:activity, :id => 42, :action => "updated", :subject => Factory(:account)) ]

    render "/home/index.js.rjs"
    response.should have_rjs("activities") do |rjs|
      with_tag("li[id=activity_42]")
    end
  end

  it "should render a message if there're no activities" do
    assigns[:activities] = []
  
    render "/home/index.js.rjs"
    response.should have_rjs("activities")
    response.body.should include("No activity records found.")
  end

end