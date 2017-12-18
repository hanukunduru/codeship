#!/bin/bash
# Run pep8 on all .py files in repo. Ignore "E402: module level import not at top of file"
num_errors_before=`find . -name \*.py -exec pycodestyle --ignore=E402 {} + | wc -l`
echo "CodeStyle Errors before auto formatting: " $num_errors_before
git config --global user.email "hanu@openinvest.co"
git config --global user.name "CodeShip"
# Auto format all python files using PEP-8 rules
find . -name \*.py -exec autopep8 --recursive --aggressive --aggressive --in-place {} +
num_errors_after=`find . -name \*.py -exec pycodestyle --ignore=E402 {} + | wc -l`
echo "CodeStyle Errors after auto formatting: " $num_errors_after
if (( $num_errors_after < $num_errors_before )); then
    git commit -a -m "Python PEP-8 Code Style Fix"
    git config --global push.default simple # Push only to the current branch.
    git push origin HEAD:$CI_BRANCH
fi
# List the remaining errors - these will have to be fixed manually
find . -name \*.py -exec pycodestyle --ignore=E402 {} +