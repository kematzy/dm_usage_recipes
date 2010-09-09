
require "#{File.dirname(File.dirname(__FILE__))}/../init"

Bundler.require(:default, :dm_migrations)
Bundler.require(:default, :dm_types)

# Load the models
load_models(:post)

class Post 
  property :authors, Yaml; 
end


setup_db_and_migrate('dm-types-yaml')

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
    
    describe "#options" do 
      
      before(:each) do 
        @yaml_post = Post.create(:title => "Post title", :body => "Post body", :authors => [:a,:b,:c] )
      end
      
      # --- 
      # - :a
      # - :b
      # - :c
      
      describe "as YAML..." do 
        
        it "should return an Array" do 
          @yaml_post.authors.should be_a_kind_of(Array)
        end
        
        it "should be of the correct value" do 
          @yaml_post.authors.should == [:a,:b,:c]
        end
        
        it "should dump the YAML value" do 
          YAML.dump(@yaml_post.authors).should == "--- \n- :a\n- :b\n- :c\n"
        end
        
      end #/ 
      
      describe "when adding YAML formatted text" do 
        
        before(:each) do 
          yml = "--- \nfname: Joe \nlname: Blogs \n"
          @yaml_post.authors = yml
          @yaml_post.save
          @yaml_post.reload
        end
        
        it "should return a Hash after reload" do 
          @yaml_post.authors.should == { "lname"=>"Blogs", "fname"=>"Joe" }
        end
        
      end #/ when adding YAML formatted text
      
    end #/ #options
    
  end #/ @post
  
  describe "Post" do 
    it_should_behave_like "Post -> associations -> relationships -> empty"
  end #/ Post
  
end #/ dm-core


