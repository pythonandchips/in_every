require "spec_helper"

describe "enumertor extensions" do

  Given(:enumerator){ 5.times }
  When(:result){ enumerator.in_every(10) }
  Then { result.should be_kind_of InEvery }

end
