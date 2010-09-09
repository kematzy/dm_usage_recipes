
require "#{File.dirname(File.dirname(__FILE__))}/../../init"

Bundler.require(:default, :dm_migrations)
Bundler.require(:default, :dm_validations)

# Load the models
load_models(:post, :comment)

class Post
  has n, :comments 
end 
class Comment
  belongs_to :post
end


setup_db_and_migrate #('dm-types-yaml')

# load test gems
Bundler.require(:default, :test)

# load the shared tests
load_shared_specs_for(:post, :comment)


describe "dm-core" do 
  
  describe "associations" do 
    
    it_should_behave_like "Post -> init"
    it_should_behave_like "Comment -> init"
    
    describe "@post" do 
      it_should_behave_like "Post -> fields"
      it_should_behave_like "Post -> respond_to(:valid?)"
    end #/ @post
    
    describe "Post" do 
      
      describe "has n, :comments" do 
        
        it "should be defined in :relationships " do 
          Post.relationships.should have_key(:comments)
        end
        
        describe "#comments" do 
          
          it "should respond to #comments" do 
            @post.should respond_to(:comments)
          end
          
          it "should return an Array with Comments" do 
            @post.comments.should be_a_kind_of(Array)
            @post.comments.first.should be_a_kind_of(Comment)
          end
          
        end #/ #comments
        
      end #/ associations

    end #/ Post
    
    describe "@comment" do 
      it_should_behave_like "Comment -> fields"
      it_should_behave_like "Comment -> respond_to(:valid?)"
      
    end #/ @comment
    
    describe "Comment" do 
      
      describe "belongs_to :post" do 
        
        it "should be defined in :relationships " do 
          Comment.relationships.should have_key(:post)
        end
        
        describe "Model.post" do 
          
          it "should respond to #post" do 
            @comment.should respond_to(:post)
          end
          
          it "should return a Post" do 
            @comment.post.should be_a_kind_of(Post)
          end
          
        end #/ #post
        
      end #/ belongs_to :post
      
    end #/ Comment
    
  end #/ associations
  
end #/ dm-core
