#!/bin/bash
export AWS_PROFILE=prod
aws cloudformation deploy --template-file stack.yml --stack-name test-stack --parameter-overrides $(cat dev.cfg) --capabilities CAPABILITY_NAMED_IAM
