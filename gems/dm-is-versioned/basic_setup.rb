
require "#{File.dirname(File.dirname(__FILE__))}/../init"

Bundler.require(:default, :dm_migrations)
Bundler.require(:default, :dm_validations)
Bundler.require(:default,:dm_is_versioned)

# Bundler.require(:default,:dm_timestamps)

# Load the models
load_models(:post)

class Post
  # timestamps :at
  property :updated_at, DateTime
  
  is_versioned :on => :updated_at
  
  ## this syntax also works
  # is :versioned, :on => :updated_at
  
  ## PLEASE NOTE!!
  # Always make sure that the is versioned trigger (:updated_at) is filled,
  # or else the versioning does NOT work.
  # 
  # This should normally be done by dm-timestamps when it's loaded.
  # 
  # before(:save) { self.updated_at = Time.now }
  # 
  before :save do 
    # For the sake of these tests, we make sure the updated_at value is always unique
    if dirty?
      time = self.updated_at ? self.updated_at + 1 : Time.now
      self.updated_at = time
    end
  end
  
end


setup_db_and_migrate('dm-is-versioned')


# load test gems
Bundler.require(:default,:test)


load_shared_specs_for(:post)


describe "dm-is-versioned" do 
  
  it_should_behave_like "Post -> init"
  
  describe "Post.new" do 
  end #/ Post.new
  
  
  describe "@post" do 
    
    it_should_behave_like "Post -> fields"
    it_should_behave_like "Post -> respond_to(:valid?)"
    
    it "should have a :title attribute" do 
      @post.title.should == "Post title"
    end
    
    it "should have an :updated_at attribute" do 
      @post.updated_at.should_not == nil
    end
    
    it "should allow updating of attributes" do 
      @post.title = "An updated title"
      @post.save
      @post.reload
      @post.title.should == "An updated title"
    end
    
    describe "#versions" do 
      
      it "should return an empty Array when there are no previous versions" do 
        @post.versions.should == []
      end
      
      it "should return an Array of versions when there are previous versions" do 
        post = Post.create(:title => 'A versioned Post title', :body => "A versioned Post body")
        post.should be_saved
        
        post.versions.should == []
        
        post.title = "An updated & versioned Post title"
        post.save.should == true
        post.errors.on(:title).should == nil # just sanity checking
        post.versions.should_not == []
        post.versions.size.should == 1
      end
      
      it "should handle multiple versions of the same record" do 
        post = Post.create(:title => 'A versioned Post title', :body => "A versioned Post body")
        post.should be_saved
        
        post.versions.should == []
        post.title = "An updated & versioned Post title"
        post.save.should == true
        post.versions.size.should == 1
        
        post.reload
        
        post.title = "Another updated & versioned Post title"
        
        pending "Fails with [ 'columns id, updated_at are not unique' ]. Why can't we save the same Post twice ??"
        post.save.should == true
        post.versions.size.should == 2
        
      end
      
    end #/ #versions
    
  end #/ @post
  
  describe "Post" do 
    it_should_behave_like "Post -> associations -> relationships -> empty"
  end #/ Post
  
end #/ dm-is-versioned
