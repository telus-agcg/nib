fail('Please add a description for your PR') if github.pr_body.empty?

warn('Big PR') if git.lines_of_code > 500

warn('PR is classed as Work in Progress') if github.pr_title.downcase.include?('[wip]') ||
                                             github.pr_labels.map(&:downcase).include?('wip')

warn('xdescribe left in tests') if `grep -r " xdescribe" spec | grep -v ._helper`.length > 1
warn('xit left in tests') if `grep -r " xit" spec | grep -v ._helper`.length > 1
fail(':focus left in tests') if `grep -r ":focus" spec | grep -v ._helper`.length > 1
