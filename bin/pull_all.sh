for i in $(ls -d */); do
    oldcd=$(pwd)
    cd "${i}"
    pwd
    git pull
    cd "${oldcd}"
done
