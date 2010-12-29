module Rap
  module Transport
    
    shared_examples_for 'a Rap::Transport implementation' do
      it "responds_to :get" do
        subject.should respond_to(:get)
      end
      
      it "responds_to :put" do
        subject.should respond_to(:put)
      end
      
      it "responds_to :create_directory" do
        subject.should respond_to(:create_directory)
      end
      
      it "responds_to :remove_directory" do
        subject.should respond_to(:remove_directory)
      end
      
      it "responds_to :list" do
        subject.should respond_to(:list)
      end
      
      it "responds_to :exists?" do
        subject.should respond_to(:exists?)
      end
      
    end

  end
end
