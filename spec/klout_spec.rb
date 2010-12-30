require File.dirname(__FILE__) + '/spec_helper.rb'
FakeWeb.allow_net_connect = false

describe "Klout" do
  
  before do
    Klout.api_key = ""
    
    FakeWeb.register_uri(:get, 
                         'http://api.klout.com/1/klout.json?key=&users=jasontorres', 
                         :body   => '{"users":[{"kscore":37.65,"twitter_screen_name":"jasontorres"}],"status":200}',
                         :status => ["200", "ok"])
    FakeWeb.register_uri(:get, 
                         'http://api.klout.com/1/users/show.json?key=&users=jasontorres', 
                         :body   => "{\"users\":[{\"twitter_screen_name\":\"jasontorres\",\"twitter_id\":\"406073\",\"score\":{\"kscore\":37.65,\"kclass_description\":\"You actively engage in the social web, constantly trying out new ways to interact and network. You're exploring the ecosystem and making it work for you. Your level of activity and engagement shows that you \\\"get it\\\", we predict you'll be moving up.\",\"amplification_score\":17.45,\"slope\":0,\"network_score\":42.58,\"true_reach\":195,\"kscore_description\":\"jasontorres has a low level of influence.\",\"kclass\":\"Explorer\",\"kclass_id\":4,\"description\":\" is effectively using social media to influence their network across a variety of topics.\"}}],\"status\":200}",
                         :status => ["200", "ok"])
  end
  
  it "should assign the correct API key" do
    Klout.api_key.should == ""
  end
  
  context "score request" do
    before do
      @score_request ||= lambda {
        Klout.score('jasontorres')
      }
      
      @score_result ||= @score_request.call
    end
    
    it "should score!" do
      @score_result.should be_instance_of(Hash)
    end
    
    it "should have the required keys" do
      @score_result.has_key?('users').should == true
      @score_result['users'][0].has_key?('kscore').should == true
      @score_result['users'][0].has_key?('twitter_screen_name').should == true
      @score_result.has_key?('status').should == true
    end
  end
  
  context "profile request" do
    before do
      @profile_request ||= lambda {
        Klout.profile('jasontorres')
      }
      @profile_result ||= @profile_request.call
    end
    
    it "should have a profile" do
      @profile_result.should be_instance_of(Hash)
    end
    
    it "should have the required keys" do
      @profile_result.has_key?('users').should == true
      @profile_result['users'][0].has_key?('score').should == true
      @profile_result['users'][0]['score'].has_key?('slope').should == true
      @profile_result['users'][0]['score'].has_key?('kscore').should == true
      @profile_result['users'][0]['score'].has_key?('kclass').should == true
      @profile_result['users'][0]['score'].has_key?('true_reach').should == true
      @profile_result['users'][0]['score'].has_key?('amplification_score').should == true
      @profile_result['users'][0]['score'].has_key?('kscore_description').should == true
      @profile_result['users'][0]['score'].has_key?('network_score').should == true
      @profile_result['users'][0]['score'].has_key?('kclass_description').should == true
      @profile_result['users'][0].has_key?('twitter_screen_name').should == true
      @profile_result['users'][0].has_key?('twitter_id').should == true
      @profile_result.has_key?('status').should == true
    end
    
  end
  
  
end

