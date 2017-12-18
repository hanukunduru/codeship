#!/bin/bash
num_errors_before=`find . -name \*.py -exec pep8 --ignore=E402 {} + | wc -l`
echo $num_errors_before
git config --global user.email "codeship@example.com"
git config --global user.name "CodeShip"
find . -name \*.py -exec autopep8 --recursive --aggressive --aggressive --in-place {} +
num_errors_after=`find . -name \*.py -exec pep8 --ignore=E402 {} + | wc -l`
echo $num_errors_after
if (( $num_errors_after < $num_errors_before )); then
    git commit -a -m "PEP-8 Fix"
    git checkout –b temp #makes a new branch from current detached HEAD
    git branch –f master temp #update master to point to the new <temp> branch
    git branch –d temp #delete the <temp> branch
    git push origin master
    git config --global push.default simple # Push only to the current branch.
    git push --quiet
fi
find . -name \*.py -exec pep8 --ignore=E402 {} +