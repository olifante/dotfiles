for i in $(ls -d */); do
    oldcd=$(pwd)
    cd "${i}"
    pwd
    git fetch --all
    cd "${oldcd}"
done
