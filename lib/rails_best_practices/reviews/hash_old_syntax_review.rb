# encoding: utf-8
module RailsBestPractices
  module Reviews
    # Check ruby 1.9 style hash and suggest to change hash syntax to old.
    #
    # Review process:
    #   check hash nodes in all files,
    #   if the sexp type of hash key nodes is not :@lable,
    #   then the hash is ruby 1.9 style.
    class HashOldSyntaxReview < Review
      interesting_nodes :hash, :bare_assoc_hash
      interesting_files ALL_FILES

      # check hash node to see if it is ruby 1.9 style.
      add_callback :start_hash, :start_bare_assoc_hash do |node|
        if !empty_hash?(node) && hash_is_new?(node)
          add_error "change Hash Syntax to old"
        end
      end

      protected
        def empty_hash?(node)
          s(:hash, nil) == node || s(:bare_assoc_hash, nil) == node
        end

        def hash_is_new?(node)
          pair_nodes = :hash == node.sexp_type ? node[1][1] : node[1]
          return false if pair_nodes.blank?

          pair_nodes.any? { |pair_node| :@label == pair_node[1].sexp_type }
        end
    end
  end
end
