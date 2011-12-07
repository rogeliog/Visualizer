require 'spec_helper'

describe Dataset do
  let(:dataset){Factory(:dataset)}

  describe '.add' do
  end

  describe '.parse_result' do
    context 'When a matcher is not a number' do
      it 'Returns zero' do
        dataset.parse_result('123','not-number').should == 0
      end
    end
    context 'When both matchers are not a number' do
      it 'Returns zero' do
        dataset.parse_result('not-a-number','not-number').should == 0
      end
    end
    context 'When both matchers are a number' do
      it 'Retuns the division (matcher_1/matcher_1)' do
        dataset.parse_result('123.456','678.912').should == (123.456/678.912).round(3)
      end
    end

  end
end
