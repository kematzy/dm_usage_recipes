
require "#{File.dirname(File.dirname(__FILE__))}/../../init"


Bundler.require(:default, :dm_yaml_adapter)

# DataMapper.setup(:default, 'sqlite3::memory:')
DataMapper.setup(:default, "yaml://#{APP_ROOT}/tmp/dm-core/yaml" )
# DataMapper.auto_migrate!

# Load the models
load_models(:post, :comment)

class Post
  has n, :comments 
end 
class Comment
  belongs_to :post
end

# load test gems
Bundler.require(:default, :test)

# load the shared tests
load_shared_specs_for(:post, :comment)


describe "dm-core" do 
  
  describe "adapters" do 
    
    describe "YAML" do 
      
      it_should_behave_like "Post -> init"
      it_should_behave_like "Comment -> init"
      
      describe "DataMapper" do 
        
        it "should raise NoMethodError when trying to :auto_migrate!" do 
          lambda { 
            DataMapper.auto_migrate!
          }.should raise_error(NoMethodError)
        end
          
        it "should raise NoMethodError when trying to :auto_upgrade!" do 
          lambda { 
            DataMapper.auto_upgrade!
          }.should raise_error(NoMethodError)
        end
        
      end #/ DataMapper
      
      describe "@post" do 
        it_should_behave_like "Post -> fields"
        it_should_behave_like "Post -> NOT respond_to(:valid?)"
      end #/ @post
      
      describe "Post" do 
        
        it "should raise NoMethodError when trying to :auto_migrate!" do 
          lambda { 
            Post.auto_migrate!
          }.should raise_error(NoMethodError)
        end
          
        it "should raise NoMethodError when trying to :auto_upgrade!" do 
          lambda { 
            Post.auto_upgrade!
          }.should raise_error(NoMethodError)
        end

      end #/ Post
      
    end #/ YAML
    
  end #/ adapters
  
end #/ dm-core
