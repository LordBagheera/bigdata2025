# build-base.ps1
$ErrorActionPreference = "Stop"
# Set image name and tag
$StackName = "bdsa2025/bdsa2025"
$tag = "3.4.1"

#build the base image
podman build --format docker -t $StackName-base:$tag .\base\
#build the spark hive base image
podman build --format docker -t $StackName-spark-hive:$tag .\spark-hive\
# build the namenode image
podman build --format docker -t $StackName-namenode:$tag .\namenode\
#build the datanode image
podman build --format docker -t $StackName-datanode:$tag .\datanode\
#build the resourcemanager image
podman build --format docker -t $StackName-resourcemanager:$tag .\resourcemanager\
#build the nodemanager image
podman build --format docker -t $StackName-nodemanager:$tag .\nodemanager\
#build the historyserver image
podman build --format docker -t $StackName-historyserver:$tag .\historyserver\
#build the edge-spark image
podman build --format docker -t $StackName-edge-spark:$tag .\edge-spark\
#build the hive server image
podman build --format docker -t $StackName-hive:$tag .\hive\
#build the Nifi server image
podman build --format docker -t $StackName-nifi:$tag .\nifi\
