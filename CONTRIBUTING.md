# Contributing to nib

nib is work of [several contributors](https://github.com/technekes/nib/graphs/contributors). You're encouraged to submit [pull requests](https://github.com/technekes/nib/pulls), [propose features and discuss issues](https://github.com/technekes/nib/issues).

#### Fork the Project

Fork the [project on Github](https://github.com/technekes/nib) and check out your copy.

```
git clone https://github.com/contributor/nib.git
cd nib
git remote add upstream https://github.com/technekes/nib.git
```

#### Create a Topic Branch

Make sure your fork is up-to-date and create a topic branch for your feature or bug fix.

```
git checkout master
git pull upstream master
git checkout -b my-feature-branch
```

#### Write Code

Implement your feature or bug fix.

#### Write Documentation

Document any external behavior in the [README](README.md). The help system defines commands in [`./script/_help`](script/_help), if you're adding a new command pleas add it there as well.

#### Commit Changes

Make sure git knows your name and email address:

```
git config --global user.name "Your Name"
git config --global user.email "contributor@example.com"
```

Writing good commit logs is important. A commit log should describe what changed and why.

```
git add ...
git commit
```

#### Push

```
git push origin my-feature-branch
```

#### Make a Pull Request

Go to https://github.com/technekes/nib/compare and select your feature branch. Click the 'Create pull request' button and fill out the form. Pull requests are usually reviewed within a few days.

#### Rebase

If you've been working on a change for a while, rebase with upstream/master.

```
git fetch upstream
git rebase upstream/master
git push origin my-feature-branch -f
```

#### Be Patient

It's likely that your change will not be merged and that the nitpicky maintainers will ask you to do more, or fix seemingly benign problems. Hang on there!

#### Thank You

Please do know that we really appreciate and value your time and work. We love you, really.
