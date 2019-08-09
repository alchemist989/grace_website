

#!/bin/bash
OPERATION=""

usage() {
    cat <<EOM
    The following options are available:
        --save | -sv         Save current repository to GitHub
        --load | -ld         Load data from Github

    Examples:

       1: ./xue_code.sh -sv

       2: ./xue_code.sh -ld

       2: ./xue_code.sh --save

EOM
}

# Process the command line arguments
for i in "$@"
do
case $i in
    --save | -sv)
        OPERATION="save"
        shift 1
    ;;
    --load | -ld)
        OPERATION="load"
        shift 1
    ;;
    -h|--help|*)
        usage
        exit 0
    ;;
esac
done


save() 
{
    # Check if git is initalized
    git status
    if [[ $? != 0 ]]; then
        echo "Initialize Git"
        git init
    fi
    # Stage the changed files
    git add .

    # Create the commit from the staged files
    git commit -m "Website Progress"
    # Check if remote has been created
    git remote -v | grep origin
    if [[ $? == 1 ]]; then
        echo "push first commit to git"
        git remote add origin https://github.com/alchemist989/grace_website.git
        git push -u origin master
    else
        echo "pushing commit to git"
        git push origin master
    fi
}


load()
{
    # Clean all changed files
    git checkout -- .

    # Grab the newest changes from GitHub
    git pull origin master
}



if [[ $OPERATION == "save" ]]; then
    save
elif [[ $OPERATION == "load" ]]; then
    load
else
    echo "Unknown Operation"
fi


