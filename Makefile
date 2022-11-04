.PHONY: build deploy
.ONESHELL:

build:
	@ $(if $(AWS_PROFILE),$(call assume_role))
	packer build packer.json

# Dynamically assumes role and injects credentials into environment
define assume_role
  export AWS_DEFAULT_REGION=$$(aws configure get region)
  eval $$(aws sts assume-role --role-arn=$$(aws configure get role_arn) \
    --role-session-name=$$(aws configure get role_session_name) \
    --query "Credentials.[ \
        [join('=',['export AWS_ACCESS_KEY_ID',AccessKeyId])], \
        [join('=',['export AWS_SECRET_ACCESS_KEY',SecretAccessKey])], \
        [join('=',['export AWS_SESSION_TOKEN',SessionToken])] \
      ]" \
    --output text)
endef

deploy:
  export AWS_PROFILE=prod
  #aws cloudformation deploy --template-file stack.yml --stack-name test-stack --parameter-overrides $(cat dev.cfg) --capabilities CAPABILITY_NAMED_IAM
  aws cloudformation deploy --template-file stack.yml --stack-name test-stack --parameter-overrides \
    $(cat dev.json | jq -r '.Parameters|to_entries[]|.key+"="+.value') --capabilities CAPABILITY_NAMED_IAM

