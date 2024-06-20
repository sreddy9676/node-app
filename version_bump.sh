#/bin/bash
grep "$1" $2

if [ "$?" == 0 ];then
    #npm install showdown -g    
    test -e .VERSION || (echo $(git describe --abbrev=0 --tags | tr -d v) > .VERSION && touch .NORELEASE)
    cat .VERSION
    showdown makehtml -i $CI_PROJECT_DIR/CHANGELOG.md -o releasenotes.html
    echo "NO_RELEASE=true" >> build.env
else
    echo "No version bump found. Skipping semantic release for this changes."
    echo "NO_RELEASE=false" >> build.env
    echo " " >> .VERSION
    exit 0
fi
