require "spec_helper"

describe "Columnist role should appear" do
      subject { FactoryGirl.new(:columnist)}

      it { should respond_to(:name)}
end