
require "#{File.dirname(File.dirname(__FILE__))}/../init"

Bundler.require(:default, :dm_migrations)
Bundler.require(:default, :dm_types)

# Load the models
load_models(:post)

class Post
  property :options, Json
end


setup_db_and_migrate('dm-types-json')


Bundler.require(:default,:test)


load_shared_specs_for(:post)


describe "dm-core" do 
  
  it_should_behave_like "Post -> init"
  
  describe "Post.new" do 
  end #/ Post.new
  
  describe "@post" do 
    it_should_behave_like "Post -> fields"
    it_should_behave_like "Post -> NOT respond_to(:valid?)"
    
    describe "#options" do 
      
      before(:each) do 
        @json_post = Post.create(:title => "Post title", :body => "Post body", :options => [:a,:b,:c] )
      end
      
      describe "stored as JSON" do 
        
        it "should return an Array" do 
          @json_post.options.should be_a_kind_of(Array)
        end
        
        it "should be of the correct value" do 
          @json_post.options.should == [:a,:b,:c]
        end
        
      end #/ 
      
      describe "when adding nil value" do 
        
        before(:each) do 
          @json_post.options = nil
          @json_post.save
          @json_post.reload
        end
        
        it "should return a nil value after reload" do 
          @json_post.options.should == nil
        end
        
      end #/ when adding nil value
      
      describe "when adding JSON formatted text" do 
        
        before(:each) do 
          json = %Q[{"lname":"Blogs","fname":"Joe"}]
          @json_post.options = json
          @json_post.save
          @json_post.reload
        end
        
        it "should return a Hash after reload" do 
          @json_post.options.should == { "lname"=>"Blogs", "fname"=>"Joe" }
        end
        
      end #/ when adding JSON formatted text
      
      describe "when providing invalid JSON formatted text" do 
        before(:each) do 
          @json = %Q[ lname:"Blogs", fname:"Joe" ]
        end
        
        it "should raise an Exception with JSON::ParserError"  do 
          lambda { 
            @json_post.options = @json
          }.should raise_error(Exception, /source(.*)not in JSON!/)
        end
        
      end #/ when providing invalid JSON formatted text
      
    end #/ #options
    
  end #/ @post
  
  describe "Post" do 
    it_should_behave_like "Post -> associations -> relationships -> empty"
  end #/ Post
  
end #/ dm-core


