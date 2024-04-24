#!/bin/bash

set -e

export AWS_DEFAULT_REGION=eu-west-1
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test

endpoint="--endpoint-url=http://localhost:4566"

echo "Creating TF Backend bucket and table ..."

aws $endpoint s3api create-bucket \
   --bucket "tf-s3-backend-0000" \
   --create-bucket-configuration LocationConstraint="$AWS_DEFAULT_REGION"

aws $endpoint dynamodb create-table \
   --table-name "tf-db-backend-0000" \
   --attribute-definitions AttributeName=LockID,AttributeType=S \
   --key-schema AttributeName=LockID,KeyType=HASH \
   --billing-mode PAY_PER_REQUEST

echo "TF backend created!"
