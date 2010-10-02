require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/accounts/index.html.haml" do
  include AccountsHelper
  
  before(:each) do
    login_and_assign
  end

  [ :account, :campaign, :contact, :lead, :opportunity ].each do |model|
    it "should render autocomplete list if #{model} matches found" do
      @auto_complete = if model == :lead
        Factory(:lead, :first_name => "Billy", :last_name => "Bones", :company => "Hello, World!")
      elsif model == :contact
        Factory(:contact, :first_name => "Billy", :last_name => "Bones")
      else
        Factory(model, :name => "Hello, World!")
      end
      assigns[:auto_complete] = [ @auto_complete ]
      
      render "common/auto_complete.html.haml"
      response.should have_tag("ul", :count => 1) do |list|
        unless model == :lead
          list.should have_tag("li", :id => @auto_complete.id, :text => @auto_complete.name)
        else
          list.should have_tag("li", :id => @auto_complete.id, :text => "#{@auto_complete.name} (#{@auto_complete.company})")
        end
      end
    end

    it "should render a message if #{model} doesn't match the query" do
      assigns[:query] = "Hello"
      assigns[:auto_complete] = []

      render "common/auto_complete.html.haml"
      response.should have_tag("ul", :count => 1) do |list|
        with_tag("li", :id => nil, :count => 1, :text => /^No/)
      end
    end

  end

end