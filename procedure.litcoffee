1. Create VPC & Deploy t3.micro Ubuntu Server for Management.
2. Create AWS S3 Bucket of your own choice
3. Any Domain you owned
4. Create AWS Route53 Zone using the domain.
5. Create a AWS User with Adminstrator persmission and map to EC2 Instance.
6. Login to Mgmt Server Generate SSH-Keys for root user.
7. Download kops binary to Mgmt Server & provide execution permissions.
use : https://github.com/kubernetes/kops/releases/tag/v1.35.0
8. Download kubectl binary to Mgmt Server & provide execution permissions.
9. Set Environment Variables and generate SSH-Keys
export NAME=pennedbyarjun.blog
export KOPS_CONFIG_STORE=s3://k8spractisebucketbyarjun/pennedbyarjun.blog
kops export kubecfg --name pennedbyarjun.blog --admin --state s3://k8spractisebucketbyarjun
export KOPS_STATE_STORE=s3://k8spractisebucketbyarjun/pennedbyarjun.blog
export AWS_REGION=us-east-1
export CLUSTER_NAME=pennedbyarjun.blog
10. Deploy Kubernetes Server with KOPS.
11. Run the below command by your name and s3 url node and master of your choice
kops create cluster --name=pennedbyarjun.blog --state=s3://k8spractisebucketbyarjun \
    --zones=us-east-1a,us-east-1b,us-east-1c --node-count=3 --control-plane-count=1 \
    --node-size=t3.medium --control-plane-size=t3.medium --control-plane-zones=us-east-1a \
    --control-plane-volume-size 15 --node-volume-size 15 --ssh-public-key ~/.ssh/id_ed25519.pub --dns-zone=pennedbyarjun.blog --networking calico --dry-run 
12. If you remove dry run flag and can give yes to proceed or if you want any changes copy that yaml and edit in the yaml file.
13. kops update cluster --name pennedbyarjun.blog --yes --admin --state s3://k8spractisebucketbyarjun
Note : this Yaml file need to run on Admintrator Instance