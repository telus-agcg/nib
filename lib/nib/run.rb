class Nib::Run
  include Nib::Command
  prepend Nib::History

  history_requires_command true
end
