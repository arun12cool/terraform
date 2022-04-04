#!/bin/bash

#### List of instances in instances.txt ####

#!/bin/bash
username="ec2-user"
script="echo 'test-zeta'"
for server in instances.txt; do
    echo "sshing $username@$server to run $script"
    ssh -i "~/.ssh/id_rsa" -o StrictHostKeyChecking=no $username@$server $script  && wait
    if [ $? = 0 ]
    then 
    echo "executed the command in $server successfully"
    else
    echo "There is an issue in executing the command in the  $server"
    echo "if you want to proceed , type proceed :" read $proceed
     if [ $proceed -eq "proceed" ]
     then
     echo "the loop proceeds"
     else
     exit 0
     fi
    fi

done
