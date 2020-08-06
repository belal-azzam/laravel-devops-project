aws cloudformation create-stack --stack-name laravel-devops --template-body file://cluster.json  --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" --region=us-west-2
