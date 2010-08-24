require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "Proc#to_source from { ... } block (w nested hash)" do

  should 'handle simple' do
    (
      lambda {
        {:a => 1, :b => 2}
      }
    ).should.be having_code(%Q\
      proc do
        {:a => 1, :b => 2}
      end
    \)
  end

  should 'handle nested' do
    (
      lambda {
        {:a => 1, :b => {:c => 3}}
      }
    ).should.be having_code(%Q\
      proc do
        {:a => 1, :b => {:c => 3}}
      end
    \)
  end

  if RUBY_VERSION.include?('1.9.')
    require File.join(File.dirname(__FILE__), '19x_extras')
    behaves_like 'Proc#to_source from { ... } block (w nested hash (w label-key))'
  end

end
