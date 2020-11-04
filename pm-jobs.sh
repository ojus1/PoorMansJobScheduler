#!/bin/bash

function pmrun(){
    source ~/.pm-jobs/pm-jobs.conf;
    option=$1
    if [[ $option = global ]]
    then
        if [[ $remote_user = ""  || $remote_host = "" ]]
        then
            if [[ $# -lt 4 ]]
            then
                echo "HELP: pmrun global [user] [host] [pm-jobs-root (without trailing slash)]";
                # echo "$#"
                return ;
            elif [[ -z $2 || -z $3 || -z $4 ]]
            then
                echo "Unset Argument(s)";
                echo "HELP: pmrun global [user] [host] [pm-jobs-root (without trailing slash)]";
                return ;
            fi
        fi
        sed -i "1s#.*#remote_user=\"${2}\"#" ~/.pm-jobs/pm-jobs.conf;
        sed -i "2s#.*#remote_host=\"${3}\"#" ~/.pm-jobs/pm-jobs.conf;
        sed -i "3s#.*#remote_root=\"${4}\"#" ~/.pm-jobs/pm-jobs.conf;
    elif [[ $option = init ]]
    then
        if [[ -z "$remote_root" || -z $remote_host || -z $remote_user ]]
        then
            echo "Global Settings Unset";
            echo "HELP: pmrun global [user] [host] [pm-jobs-root (without trailing slash)]";
            return ;
        fi
        folder=${PWD##*/};        
        ssh "$remote_user"@"$remote_host" "mkdir $remote_root/$folder";
        touch sync.ignore;
        rsync -a --max-size=192m --exclude-from={'sync.ignore'} ./ "$remote_user"@"$remote_host":"$remote_root"/$folder;
    else
        if [[ -z "$remote_root" || -z $remote_host || -z $remote_user ]]
        then
            echo "Global Settings Unset";
            echo "HELP: pmrun global [user] [host] [pm-jobs-root (without trailing slash)]";
            return ;
        fi
        folder=${PWD##*/};
        touch sync.ignore;
        err=$((rsync -a --max-size=192m --exclude-from={'sync.ignore'} ./ "$remote_user"@"$remote_host":"$remote_root"/$folder) 2>&1);
        if [[ "$err" = "" ]]
        then 
            runoverssh -q $remote_user "cd $remote_root/$folder/ && nohup $option >> pmsrun.log 2>&1 &" $remote_host;
        else
            echo "Run pmrun [init] ... first!";
        fi
    fi
}