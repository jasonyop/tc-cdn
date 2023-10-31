.PHONY: terraform-test-basic-default
terraform-test-basic-default:
	cd tests && go test -v -timeout 60m basic_test.go -run TestBasicDefault

.PHONY: terraform-test-basic-cn
terraform-test-basic-cn:
	cd tests && go test -v -timeout 60m basic_test.go -run TestBasicCN

.PHONY: terraform-test-basic
terraform-test-basic-th:
	cd tests && go test -v -timeout 60m basic_test.go -run TestBasicTH
