# CodeClimate Test Reporter is failing on CodeShip because it expects a
# .git/ directory to be present.
#
# Issue desc: https://github.com/codeclimate/ruby-test-reporter/issues/115
# Patch: https://gist.github.com/dukedave/970061908075bfac46dd2f253d3786a4

module Extensions
  module Git
    module ClassMethods
      def info
        {
          head:         head,
          committed_at: committed_at_or_now,
          branch:       branch_from_git_or_ci
        }
      end

      def committed_at_or_now
        committed_at || Time.now.to_i
      end
    end
  end
end

CodeClimate::TestReporter::Git.singleton_class.prepend(
  Extensions::Git::ClassMethods
)
CodeClimate::TestReporter::Formatter.new.format SimpleCov.result
