#!/bin/bash
set -ev
if [[ $( git diff --name-only HEAD~1..HEAD webpack/ .travis.yml .babelrc .eslintrc package.json | wc -l ) -ne 0 ]]; then
  npm run test;
  npm run coveralls;
  npm run lint;
fi
