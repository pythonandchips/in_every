require "spec_helper"

describe "object extensions" do

  context "once" do

    Given(:enumerator){ once }
    Then{ enumerator.min.should eql 0 }
    Then{ enumerator.max.should eql 0 }

  end

  context "twice" do

    Given(:enumerator){ twice }
    Then{ enumerator.min.should eql 0 }
    Then{ enumerator.max.should eql 1 }

  end
end
