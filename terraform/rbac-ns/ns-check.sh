
  
#!/bin/bash
Namespace_checks () {
kubectl get namespace |awk '{print $1}' |grep -v NAME > new_ns
creation_ns=$(diff old_ns new_ns | grep -E "^>" | sed -e 's/>//')
destroy_ns=$(diff old_ns new_ns | grep -E "^<" | sed -e 's/<//')
if [ -z "$creation_ns" ]; then
	echo "no new namespaces created"
else
    echo "========================================================================================="
    echo "||                NameSpaces created                                                   ||"
    echo "========================================================================================="
    echo "$creation_ns                                                                             "
    echo "========================================================================================="
fi
if [ -z "$destroy_ns" ]; then
	echo "no new namespaces destroyed"
else
    echo "========================================================================================="
    echo "||                NameSpaces Destroyed                                                 ||"
    echo "========================================================================================="
    echo "$destroy_ns                                                                              "
    echo "========================================================================================="
fi
}
Namespace_checks