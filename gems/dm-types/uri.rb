
require "#{File.dirname(File.dirname(__FILE__))}/../init"

Bundler.require(:default, :dm_migrations)
Bundler.require(:default, :dm_types)

# Load the models
load_models(:post)

class Post
  property :uri,    URI
end


setup_db_and_migrate('dm-types-uri')

# load test gems
Bundler.require(:default, :test)

load_shared_specs_for(:post)


describe "dm-core" do 
  
  it_should_behave_like "Post -> init"
  
  describe "Post.new" do 
  end #/ Post.new
  
  describe "@post" do 
    it_should_behave_like "Post -> fields"
    it_should_behave_like "Post -> NOT respond_to(:valid?)"
    
    describe "#uri" do 
      
      before(:each) do 
        @post = Post.create(:title => "Post title", :body => "Post body", :uri => '' )
      end
      
      describe "as URI..." do 
        
        it "should return an Addressable::URI object" do 
          @post.uri.should be_a_kind_of(Addressable::URI)
        end
        
        it "should return an empty string when no URI is given" do 
          @post.uri.to_s.should == ''
        end
        
      end #/ 
      
      describe "when adding a URI" do 
        
        before(:each) do 
          @post.uri = "http://www.datamapper.org/"
          @post.save
          @post.reload
        end
        
        it "should return the URL after reload using .to_s" do 
          @post.uri.to_s.should == 'http://www.datamapper.org/'
        end
        
        it "should return an Addressable::URI after reload" do 
          @post.uri.should be_a_kind_of(Addressable::URI)
        end
        
      end #/ when adding a URI
      
    end #/ #uri
    
  end #/ @post
  
  describe "Post" do 
    it_should_behave_like "Post -> associations -> relationships -> empty"
  end #/ Post
  
end #/ dm-core


