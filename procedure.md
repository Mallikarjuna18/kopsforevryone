1. Create VPC & Deploy t3.micro #change to your desired instance type Ubuntu Server for Management.
2. Create AWS S3 Bucket of your own choice #store this bucket name for KOPS_CONFIG_STORE
3. Any Domain you owned #use this domain for cluster name
4. Create AWS Route53 Zone using the domain.
5. Create a AWS User with Adminstrator persmission and map to EC2 Instance.
6. Login to Mgmt Server Generate SSH-Keys for root user.
7. Download kops binary to Mgmt Server & provide execution permissions. Dowload to usr/local/bin rename it kops
use : https://github.com/kubernetes/kops/releases/tag/v1.35.0
8. Download kubectl binary to Mgmt Server & provide execution permissions. And Generate ssh-keys
9. Set Environment Variables and generate SSH-Keys
export NAME=pennedbyarjun.blog #change to your cluster name
export KOPS_CONFIG_STORE=s3://k8spractisebucketbyarjun/pennedbyarjun.blog #change to your S3 bucket name and cluster name
kops export kubecfg --name pennedbyarjun.blog #change to your cluster name --admin --state s3://k8spractisebucketbyarjun #change to your S3 bucket name
export KOPS_STATE_STORE=s3://k8spractisebucketbyarjun/pennedbyarjun.blog #change to your S3 bucket name and cluster name
export AWS_REGION=us-east-1 #change to your desired AWS region
export CLUSTER_NAME=pennedbyarjun.blog #change to your cluster name
10. Deploy Kubernetes Server with KOPS.
11. Run the below command by your name and s3 url node and master of your choice

kops create cluster --name=<clusterName> --state=<S3 bucket url> \
    --zones=<desired zones> --node-count=<worker node count> --control-plane-count=<control pane count> \
    --node-size=<required node size> --control-plane-size=<control pans size> --control-plane-zones=<control pane zone> \
    --control-plane-volume-size <voule size required> --node-volume-size <voule size required> --ssh-public-key <ssh keys location> --dns-zone=<dns zone you have created in route 53> --networking calico --dry-run -o yaml
Example:
kops create cluster --name=pennedbyarjun.blog --state=s3://k8spractisebucketbyarjun \
    --zones=us-east-1a,us-east-1b,us-east-1c --node-count=3 --control-plane-count=1 \
    --node-size=t3.medium --control-plane-size=t3.medium --control-plane-zones=us-east-1a \
    --control-plane-volume-size 15 --node-volume-size 15 --ssh-public-key ~/.ssh/id_ed25519.pub --dns-zone=pennedbyarjun.blog --networking calico --dry-run -o yaml
12. If you remove dry run flag and can give yes to proceed or if you want any changes copy that yaml and edit in the yaml file.
13. kops update cluster --name <change to your cluster name> --yes --admin --state <change to your S3 bucket name>
Ex : kops update cluster --name pennedbyarjun.blog --yes --admin --state s3://k8spractisebucketbyarjun
Note : this Yaml file need to run on Admintrator Instance
14. kops delete cluster --name pennedbyarjun.blog --yes
