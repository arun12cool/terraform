#!/bin/bash
Role_checks () {
kubectl get clusterroles --all-namespaces | awk '{print $1}' |grep -v NAME > new_cluster_roles
kubectl get rolebinding --all-namespaces | awk '{print $2}' |grep -v NAME > new_namespace_roles
create_roles=$(diff old_cluster_roles new_cluster_roles | grep -E "^>" | sed -e 's/> //')
destroy_roles=$(diff old_cluster_roles new_cluster_roles | grep -E "^<" | sed -e 's/< //')
create_crb=$(diff old_cluster_binding new_cluster_binding | grep -E "^>" | sed -e 's/> //')
destroy_crb=$(diff old_cluster_binding new_cluster_binding | grep -E "^<" | sed -e 's/< //')
create_nrb=$(diff old_namespace_roles new_namespace_roles | grep -E "^>" | sed -e 's/> //') 
destroy_nrb=$(diff old_namespace_roles new_namespace_roles | grep -E "^<" | sed -e 's/< //')
if [ -z "$create_roles" ]; then
	    echo "no new  cluster roles created"
else
        echo "========================================================================================="
        echo "||                 Cluster Roles created                                               ||"
        echo "========================================================================================="
        echo "$create_roles                                                                            "
        echo "========================================================================================="
fi
if [ -z "$destroy_roles" ]; then
        echo "no new cluster roles destroyed"
else
        echo "========================================================================================="
        echo "||                Cluster Roles Destroyed                                              ||"
        echo "========================================================================================="
        echo "$destroy_roles                                                                           "
        echo "========================================================================================="
fi

if [ -z "${create_crb}" ]; then
        echo "no new cluster role bindings created"
else
       echo "========================================================================================="
        echo "||               Cluster Role Bindings created                                         ||"
        echo "========================================================================================="
        echo "$create_crb                                                                              "
      echo "========================================================================================="

fi
if [ -z "$destroy_crb" ]; then
        echo "no new cluster role bindings destroyed "
else
        echo "========================================================================================="
        echo "||                 Cluster Role Bindings destroyed                                     ||"
        echo "========================================================================================="
        echo "$destroy_crb"
        echo "========================================================================================="
fi



if [ -z "$create_nrb" ]; then
        echo "no new namespace role bindings created"
else
        echo "========================================================================================="
        echo "||                 namespace role bindings created                                     ||"
        echo "========================================================================================="
        echo "$create_nrb                                                                              "
        echo "========================================================================================="
fi
if [ -z "$destroy_nrb" ]; then
        echo "no new namespace role bindings destroyed"
else
        echo "========================================================================================="
        echo "||                namespace role bindings destroyed                                    ||"
        echo "========================================================================================="
        echo "$destroy_nrb                                                                             "
        echo "========================================================================================="
fi
}
Role_checks