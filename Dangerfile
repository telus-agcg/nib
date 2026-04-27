fail('Please add a description for your PR') if github.pr_body.to_s.strip.empty?

warn('Big PR') if git.lines_of_code > 500

warn('PR is classed as Work in Progress') if github.pr_title.downcase.include?('[wip]') ||
                                             github.pr_labels.map(&:downcase).include?('wip')

warn('xdescribe left in tests') if `grep -rE "\\bxdescribe\\b" spec | grep -v spec_helper`.lines.count.positive?
warn('xit left in tests') if `grep -rE "\\bxit\\b" spec | grep -v spec_helper`.lines.count.positive?
fail(':focus left in tests') if `grep -r ":focus" spec | grep -v spec_helper`.lines.count.positive?
