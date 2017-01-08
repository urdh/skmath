#!/usr/bin/env bash

  printf "\033[33;1mCommit is tagged with $TRAVIS_TAG, deploying to CTAN...\033[0m\n"
  # 1. Install ctanupload
  cpanm WWW::Mechanize     || exit 1;
  cpanm HTML::TreeBuilder  || exit 1;
  cpanm HTML::FormatText   || exit 1;
  tlmgr install ctanupload || exit 1;
if [[ "$TRAVIS_TAG" ]]; then
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
