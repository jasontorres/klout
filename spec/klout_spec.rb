require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Klout" do
  
  before do
    Klout.api_key = ENV['API_KEY'] || ""
  end
  
  it "should assign the correct API key" do
    Klout.api_key.should == ENV['API_KEY'] || ""
  end
  
  context "klout score request" do
    before do
      @score_request ||= lambda {
        Klout.klout_score('jasontorres')
      }
      
      @score_result ||= @score_request.call
    end
    
    it "should score!" do
      @score_result.should be_instance_of(Hash)
    end
    
    it "should have the required keys" do
      @score_result['user'] = @score_result["users"].first
      
      @score_result.has_key?('user').should == true
      @score_result['user'].has_key?('kscore').should == true
    end
  end
  
  context "show user request" do
    before do
      @profile_request ||= lambda {
        Klout.show_user('jasontorres')
      }
      @profile_result ||= @profile_request.call
    end
    
    it "should have a profile" do
      @profile_result.should be_instance_of(Hash)
    end
    
    it "should have the required keys" do
      @profile_result['users'] = @profile_result["users"].first
      @profile_result.has_key?('users').should == true
      @profile_result['users'].has_key?('twitter_id').should == true
      @profile_result['users'].has_key?('twitter_screen_name').should == true

      @profile_result['users'].has_key?('score').should == true
      @profile_result['users']['score'].has_key?('slope').should == true
      @profile_result['users']['score'].has_key?('kscore').should == true
      @profile_result['users']['score'].has_key?('kclass').should == true
      @profile_result['users']['score'].has_key?('true_reach').should == true
      @profile_result['users']['score'].has_key?('amplification_score').should == true
      @profile_result['users']['score'].has_key?('kscore_description').should == true
      @profile_result['users']['score'].has_key?('network_score').should == true
      @profile_result['users']['score'].has_key?('kclass_description').should == true
    end
    
  end
  
  context "topics request" do
    before do
      @profile_request ||= lambda {
        Klout.topics('jasontorres')
      }
      @profile_result ||= @profile_request.call
    end
    
    it "should have a profile" do
      @profile_result.should be_instance_of(Hash)
    end
    
    it "should have the required keys" do
      @profile_result['users'] = @profile_result["users"].first
      @profile_result.has_key?('users').should == true
      @profile_result['users'].has_key?('topics').should == true
    end
    
  end
  
  context "profile request influenced by" do
    before do
      @profile_request ||= lambda {
        Klout.influenced_by('markmcspadden')
      }
      @profile_result ||= @profile_request.call
    end
    
    it "should have a profile" do
      @profile_result.should be_instance_of(Hash)
    end
    
    it "should have the required keys" do      
      @profile_result['user'] = @profile_result["users"].first["influencers"].first
      @profile_result.has_key?('user').should == true
      @profile_result['user'].has_key?('twitter_screen_name').should == true
      @profile_result['user'].has_key?('kscore').should == true
    end
    
  end
  
  context "profile request influencer of" do
    before do
      @profile_request ||= lambda {
        Klout.influencer_of('markmcspadden')
      }
      @profile_result ||= @profile_request.call
    end
    
    it "should have a profile" do
      @profile_result.should be_instance_of(Hash)
    end
    
    it "should have the required keys" do      
      @profile_result['user'] = @profile_result["users"].first["influencees"].first
      @profile_result.has_key?('user').should == true
      @profile_result['user'].has_key?('twitter_screen_name').should == true
      @profile_result['user'].has_key?('kscore').should == true
    end
    
  end
  
end
