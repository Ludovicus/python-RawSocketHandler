#!/bin/bash

GIT_FETCH_ORIGIN=`git remote -v | grep -E 'origin.*fetch' | awk '{print $2}'`
GIT_REPO="git@github.com:Ludovicus/python-RawSocketHandler.git"
PYPI="$1"; [[ -z $PYPI ]] && PYPI=cargometrics

if [ $GIT_FETCH_ORIGIN == "$GIT_REPO" ]; then
  echo "Assembling a small crane"
  function build_python {
      TIMEOUT=100
      NUMTRIES=1
      RETVAL=0
      while [[ ($NUMTRIES -lt $TIMEOUT) && ($RETVAL -ne 1) ]]
      do
          echo "Pypi registration attempt #${NUMTRIES}"
          echo "python setup.py register -r $PYPI"
          RETVAL=$(python setup.py register -r $PYPI | grep "Server response (200): OK" | wc -l)
          (( NUMTRIES += 1 ))
      done

      if [ $RETVAL -lt 1 ]; then
          echo "Unable to register egg after $TIMEOUT attempts!"
          echo "Quitting"
          exit 99;
      fi

      python setup.py sdist upload -r $PYPI
  }

  if [ ! -f ~/.pypirc ]; then
      echo "Fatal exception: .pypirc file is missing!"
      exit 98;
  fi

  # Build the python service package and upload it
  build_python

else
  echo "NOP for packaging $GIT_REPO, not in main repo: $GIT_FETCH_ORIGIN"
fi
