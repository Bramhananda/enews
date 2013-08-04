require 'spec_helper'

describe Picture do
    it { should respond_to(:title)}
    it { should validate_presence_of :image}
end
