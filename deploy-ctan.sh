#!/usr/bin/env bash

if [[ "$TRAVIS_TAG" ]]; then
  printf "\033[33;1mCommit is tagged with $TRAVIS_TAG, deploying to CTAN...\033[0m\n"
  # 0. Install perl modules
  curl -L https://cpanmin.us | perl - App::cpanminus
  ~/perl5/bin/cpanm local::lib           || exit 1;
  ~/perl5/bin/cpanm WWW::Mechanize       || exit 1;
  ~/perl5/bin/cpanm HTML::TreeBuilder    || exit 1;
  ~/perl5/bin/cpanm HTML::FormatText     || exit 1;
  ~/perl5/bin/cpanm LWP::Protocol::https || exit 1;
  eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"
  # 1. Install ctanupload
  tlmgr install ctanupload || exit 1;
  # 2. Set up and sanity-check environment
  [[ "$CONTRIBUTION" && "$NAME" && "$EMAIL" && "$DIRECTORY" && "$SUMMARY" ]] || exit 2;
  [[ "$LICENSE" ]] || LICENSE="other-nonfree";
  [[ "$LICENSE" == "free" && "$FREEVERSION" ]] || FREEVERSION="other-free";
  # 3. Set the file to upload
  [[ "$1" ]] && FILE="$1"
  [[ "$FILE" ]] || FILE=$(find . -name '*.tar.gz' | head);
  echo "Deploying file $FILE"
  export CONTRIBUTION NAME EMAIL SUMMARY DIRECTORY NOTES LICENSE FREEVERSION FILE SUMMARY
  # 4. Upload package
  ctanupload -y -P --version=$TRAVIS_TAG --notes="Package contains TDS zip file" --DoNotAnnounce=1
fi
