# encoding: utf-8
module RailsBestPractices
  module Lexicals
    # Make sure there are no obscene words in files.
    class RemoveObsceneWordsCheck < Core::Check
      interesting_files ALL_FILES

      attr_reader :words

      def initialize(options = {})
        super
        @words = options['words'] || []
      end

      # check if the content of file contains an obscene words.
      #
      # @param [String] filename name of the file
      # @param [String] content content of the file
      def check(filename, content)
        words.each do |obscene_word|
          if content =~ /#{ obscene_word }/m
            line_no = $`.count("\n") + 1
            add_error("remove #{ obscene_word }", filename, line_no)
          end
        end
      end

    end
  end
end
