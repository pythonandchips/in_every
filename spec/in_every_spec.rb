require "spec_helper"

describe InEvery do

  context "with 5 occrancies in every 10 executions" do
    Given(:in_every){ 5.times.in_every(10) }

    When do
      @run_count = 0
      in_every.start do
        @run_count += 1
      end
      (1..10).each{in_every.execute}
    end

    Then { @run_count.should eql 4 }
  end

  context "when executing more times than specified" do
    Given(:in_every){ 5.times.in_every(10) }

    When do
      @run_count = 0
      in_every.start do
        @run_count += 1
      end
      (1..20).each{in_every.execute}
    end

    Then { @run_count.should eql 8 }
  end

  context "when the specified time is higher than the execute number" do
    Then do
      lambda{ 10.times.in_every(3) }.should raise_error(InEvery::SetupException, "occurancies must be greater than executions")
    end
  end

end
