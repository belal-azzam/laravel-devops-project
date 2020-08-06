aws cloudformation create-stack --stack-name laravel-devops-nodes --template-body file://cluster-nodes.json  --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" --region=us-west-2
