# ------------------------------------------------------------------------------
# Have any changes happened inside the actual library code?
# ------------------------------------------------------------------------------
def app_changes?
  !git.modified_files.grep(/lib/).empty?
end

# ------------------------------------------------------------------------------
# Are there an changes to the specs
# ------------------------------------------------------------------------------
def spec_changes?
  !git.modified_files.grep(/spec/).empty?
end

# ------------------------------------------------------------------------------
# Is this declared a work in progress
# ------------------------------------------------------------------------------
def declared_wip?
  github.pr_labels.include?('WIP') || github.pr_labels.include?('wip')
end

# ------------------------------------------------------------------------------
# Is this declared a trivial change?
# ------------------------------------------------------------------------------
def declared_trivial?
  !(github.pr_labels.include? 'trivial')
end

# ------------------------------------------------------------------------------
# Is CHANGELOG modifie?
# ------------------------------------------------------------------------------
def changelog_modified?
  git.modified_files.include?('CHANGELOG.md')
end

# ------------------------------------------------------------------------------
# Is this a version change
# ------------------------------------------------------------------------------
def version_bump?
  git.modified_files.sort == ['CHANGELOG.md', 'lib/nib/version.rb'].sort
end

def strip_doc(doc)
  doc.strip.tr(/\n/, ' ').tr(/  /, '')
end

# ------------------------------------------------------------------------------
# You've made changes to lib, but didn't write any tests?
# ------------------------------------------------------------------------------
if app_changes? && !spec_changes?
  missing_tests_message = <<-MESSAGE
    There are library changes, but not tests. That's OK as long as you're
    refactoring existing code.
  MESSAGE

  warn(strip_doc(missing_tests_message))
end

# ------------------------------------------------------------------------------
# You've made changes to specs, but no library code has changed?
# ------------------------------------------------------------------------------
if !app_changes? && spec_changes?
  missing_code_message = <<-MESSAGE
    We really appreciate pull requests that demonstrate issues, even without a
    fix. That said, the next step is to try and fix the failing tests!
  MESSAGE

  message(strip_doc(missing_code_message))
end

# ------------------------------------------------------------------------------
# Make it more obvious that a PR is a work in progress and shouldn't be merged
# ------------------------------------------------------------------------------
warn('PR is classed as Work in Progress') if declared_wip?

# ------------------------------------------------------------------------------
# Warn when there is a big PR
# ------------------------------------------------------------------------------
warn('Big PR') if git.lines_of_code > 500

# ------------------------------------------------------------------------------
# Requre a CHANGELOG entry for library changes
# ------------------------------------------------------------------------------
if !changelog_modified? && app_changes? && !declared_trivial?
  changelog_message = <<-MESSAGE
    Please include a CHANGELOG entry. You can find it at
    [CHANGELOG.md](https://github.com/techneks/nib/blob/master/CHANGELOG.md).
  MESSAGE

  fail(strip_doc(changelog_message))
end

# ------------------------------------------------------------------------------
# Thank contributors
# ------------------------------------------------------------------------------
message(':tada:') if version_bump? && github.pr_author != 'johnallen3d'

# ------------------------------------------------------------------------------
# Don't let testing shortcuts get into master by accident
# ------------------------------------------------------------------------------
fail('xdescribe left in tests') if `grep -r " xdescribe" spec/unit`.length > 1
fail('xit left in tests') if `grep -r " xit" spec/unit`.length > 1
fail(':focus left in tests') if `grep -r ":focus" spec/unit`.length > 1
