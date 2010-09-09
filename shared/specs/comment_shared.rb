
share_examples_for "Comment -> init" do 
  before(:each) do 
    @comment = Comment.create(:poster => "joe", :body => "Comment 1", :post => @post)
  end
  
  after(:each) do
    @comment.destroy
  end
end 

share_examples_for "Comment -> fields" do 
  
  describe "#poster" do 
    it "should respond to :poster" do 
      @comment.should respond_to(:poster)
    end
    it "should return the correct information" do 
      @comment.poster.should == 'joe'
    end
  end #/ #poster
  
  describe "#body" do 
    it "should respond to :body" do 
      @comment.should respond_to(:body)
    end
    it "should return the correct information" do 
      @comment.body.should == 'Comment 1'
    end
  end #/ #body
  
end 

share_examples_for "Comment -> associations -> relationships" do 
  describe "associations" do  
    
    describe "belongs_to :post" do 
      
      describe "#relationships" do 
        it "should be defined in :relationships " do 
          Comment.relationships.should have_key(:post)
        end
      end #/ #relationships
      
      describe "Model.post" do 
        
        it "should respond to #post" do 
          @comment.should respond_to(:post)
        end
        
        it "should return a Post" do 
          @comment.post.should be_a_kind_of(Post)
        end
        
      end #/ #post
      
    end #/ belongs_to :post
  end #/ associations
end 

share_examples_for "Comment -> respond_to(:valid?)" do 
  it "should respond to :valid? if dm-validations is loaded" do 
    @comment.should respond_to(:valid?)
  end
end 

share_examples_for "Comment -> NOT respond_to(:valid?)" do 
  it "should NOT respond to :valid? unless dm-validations is loaded" do 
    @comment.should_not respond_to(:valid?)
  end
end 

