
require "#{File.dirname(File.dirname(__FILE__))}/../init"

Bundler.require(:default, :dm_migrations)

# Load the models
load_models(:post)


setup_db_and_migrate('dm-core-basic')


# load test gems
Bundler.require(:test)


load_shared_specs_for(:post)


describe "dm-core" do 
  
  it_should_behave_like "Post -> init"
  
  describe "Post.new" do 
  end #/ Post.new
  
  describe "@post" do 
    it_should_behave_like "Post -> fields"
    it_should_behave_like "Post -> NOT respond_to(:valid?)"
  end #/ @post
  
  describe "Post" do 
    it_should_behave_like "Post -> associations -> relationships -> empty"
  end #/ Post
  
end #/ dm-core


