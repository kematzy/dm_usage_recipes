
share_examples_for "Post -> init" do 
  before(:each) do 
    @post = Post.create(:title => "Post title", :body => "Post body")
  end
  after(:each) do
    @post.destroy
  end
end 

share_examples_for "Post -> fields" do 
  describe "#title" do 
    
    it "should respond to :title" do 
      @post.should respond_to(:title)
    end
    
    it "should return the correct information" do 
      @post.title.should == 'Post title'
    end
    
  end #/ #title
  describe "#body" do 
    
    it "should respond to :body" do 
      @post.should respond_to(:body)
    end
    
    it "should return the correct information" do 
      @post.body.should == 'Post body'
    end
    
  end #/ #body
end 

share_examples_for "Post -> associations -> relationships -> empty" do 
  describe "associations" do  
    describe "#relationships" do 
      it "should be an empty Hash" do 
        Post.relationships.should == Hash.new
      end
    end #/ #relationships
  end #/ associations
end 

share_examples_for "Post -> respond_to(:valid?)" do 
  it "should respond to :valid? if dm-validations is loaded" do 
    @post.should respond_to(:valid?)
  end
end 

share_examples_for "Post -> NOT respond_to(:valid?)" do 
  it "should NOT respond to :valid? unless dm-validations is loaded" do 
    @post.should_not respond_to(:valid?)
  end
end 

