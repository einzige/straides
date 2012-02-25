require 'spec_helper'

describe Straides do
  class TestController
  end

  it "works" do
    TestController.should_receive(:rescue_from).once.with(Straides::ReturnHttpCodeError, :with => :show_error)
    TestController.send :include, Straides
  end

  describe "instance methods" do
    subject { TestController.new }

    it { should respond_to(:error) }
    it { should respond_to(:show_error) }

    describe "#error" do
      it "raises an exception with options" do
        subject.should_receive(:raise).with(Straides::ReturnHttpCodeError, {:text => 'error', :status => 404})
        subject.send(:error, 404, :text => 'error')
      end
    end

    describe "#show_error" do
      after :each do
        subject.send(:show_error, error)
      end

      context "error has template set" do
        let(:error) { Straides::ReturnHttpCodeError.new(:text => 'error') }

        it "renders given template" do
          subject.should_receive(:render).once.with(:text => 'error')
        end
      end

      context "error hasn't template" do
        let(:error) { Straides::ReturnHttpCodeError.new(:status => 404) }

        context "on html request" do
          it "renders default html view" do
            subject.stub_chain("request.format.html?").and_return(true)
            subject.should_receive(:render).once.with(:file => 'public/404', :formats => [:html], :status => 404)
          end
        end

        context "on json request" do
          it "renders default html view" do
            subject.stub_chain("request.format.html?").and_return(false)
            subject.should_receive(:render).once.with(:nothing => true, :status => 404)
          end
        end
      end
    end
  end
end