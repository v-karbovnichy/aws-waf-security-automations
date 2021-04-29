#awsauth
#awsidentity

cd ./deployment 
./run-unit-tests.sh
echo 'press ENTER to continue'
read

export TEMPLATE_OUTPUT_BUCKET=dnn-waf-security-automations-template # Name for the S3 bucket where the template will be located
export DIST_OUTPUT_BUCKET=dnn-waf-security-automations # Name for the S3 bucket where customized code will reside 
export SOLUTION_NAME="dnn-waf-security-automations" # name of the solution 
export VERSION=v1 # version number for the customized code
export AWS_REGION=us-east-1 # region where the distributable is deployed

./build-s3-dist.sh $TEMPLATE_OUTPUT_BUCKET $DIST_OUTPUT_BUCKET $SOLUTION_NAME $VERSION


aws s3 cp ./global-s3-assets s3://$TEMPLATE_OUTPUT_BUCKET/aws-waf-security-automations/$VERSION --recursive --acl bucket-owner-full-control
aws s3 cp ./regional-s3-assets s3://$DIST_OUTPUT_BUCKET-$AWS_REGION/aws-waf-security-automations/$VERSION --recursive --acl bucket-owner-full-control

cd ..
