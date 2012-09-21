require File.expand_path('../spec_helper', __FILE__)

describe Sourcify::Proc::Extractor do
  describe 'stripping lambda' do
    extend Sourcify::SpecHelper

    def process(block)
      Sourcify::Proc::Extractor.process(block).strip
    end

    example(%%
    ## wrt args, having no arg
    ##
    #" :thing
    %,(
      b = -> do
        :thing
      end
    ))

    example(%%
    ## wrt args, having 1 arg
    ##
    #" :thing
    %,(
      b = ->(x) do
        :thing
      end
    ))

    example(%%
    ## wrt args, having multiple args
    ##
    #" :thing
    %,(
      b = ->(x, y, z) do
        :thing
      end
    ))

    example(%%
    ## wrt heredoc
    ##
    #" s = <<-EOL
    #"           thing
    #"         EOL
    %,(
      b = -> do
        s = <<-EOL
          thing
        EOL
      end
    ))

    example(%%
    ## wrt one-liner body
    ##
    #" :thing
    %,(
      b = -> { :thing }
    ))

    example(%%
    ## wrt multi-line body
    ##
    #" proc do
    #"   :thing
    #" end
    %,(
      b = -> do
        proc do
          :thing
        end
      end
    ))

  end
end