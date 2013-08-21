require 'spec_helper'

module RailsBestPractices
  module Lexicals
    describe RemoveObsceneWordsCheck do
      let(:runner) { Core::Runner.new(:lexicals => RemoveObsceneWordsCheck.new('words' => ['badword1', 'badword2'])) }

      it "should remove obscene word" do
        content =<<-EOF
        class User < ActiveRecord::Base
          has_many :projects
          def somemethod
            # badword1.to_a
          end
        end
        EOF
        runner.lexical('app/models/user.rb', content)
        runner.should have(1).errors
        runner.errors[0].to_s.should == "app/models/user.rb:4 - remove badword1"
      end

      it "should remove multiple obscene words" do
        content =<<-EOF
        class User < ActiveRecord::Base
          has_many :projects
          def somemethod
            # badword1 badword2
          end
        end
        EOF
        runner.lexical('app/models/user.rb', content)
        runner.should have(2).errors
        runner.errors[0].to_s.should == "app/models/user.rb:4 - remove badword1"
        runner.errors[1].to_s.should == "app/models/user.rb:4 - remove badword2"
      end

    end
  end
end
