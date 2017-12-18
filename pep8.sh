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
    git config --global push.default current # Push only to the current branch.
    git push --quiet
fi
find . -name \*.py -exec pep8 --ignore=E402 {} +