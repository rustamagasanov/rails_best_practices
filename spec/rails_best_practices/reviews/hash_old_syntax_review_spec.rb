require 'spec_helper'

module RailsBestPractices
  module Reviews
    describe HashOldSyntaxReview do
      let(:runner) { Core::Runner.new(:reviews => HashOldSyntaxReview.new) }

      it "should find new Hash with symbol" do
        content =<<-EOF
        class User < ActiveRecord::Base
          CONST = { foo: :bar }
        end
        EOF
        runner.review('app/models/user.rb', content)
        runner.should have(1).errors
        runner.errors[0].to_s.should == "app/models/user.rb:2 - change Hash Syntax to old"
      end

      it "should not alert on old Syntax" do
        content =<<-EOF
        class User < ActiveRecord::Base
          CONST = { :foo => :bar }
        end
        EOF
        runner.review('app/models/user.rb', content)
        runner.should have(0).errors
      end

      xit "should ignore haml_out" do
        content =<<-EOF
%div{ class: "foo1" }
.div{ class: "foo2" }
#div{ class: "foo3" }
        EOF
        runner.review('app/views/files/show.html.haml', content)
        runner.should have(0).errors
      end

    end
  end
end
