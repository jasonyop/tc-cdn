package tests

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

var retryableTerraformErrors = map[string]string{}

// Basic test
func TestBasicDefault(t *testing.T) {
	tfOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir:             "../examples/basic/default",
		RetryableTerraformErrors: retryableTerraformErrors,
	})

	// Clean up resources with "terraform destroy" at the end of the test.
	defer terraform.Destroy(t, tfOptions)

	// Run "terraform init" and "terraform apply". Fail the test if there are any errors.
	_, err := terraform.InitAndApplyE(t, tfOptions)
	assert.Equal(t, err, nil)
}

func TestBasicCN(t *testing.T) {
	tfOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir:             "../examples/basic/cn",
		RetryableTerraformErrors: retryableTerraformErrors,
	})

	// Clean up resources with "terraform destroy" at the end of the test.
	defer terraform.Destroy(t, tfOptions)

	// Run "terraform init" and "terraform apply". Fail the test if there are any errors.
	_, err := terraform.InitAndApplyE(t, tfOptions)
	assert.Equal(t, err, nil)
}

func TestBasicTH(t *testing.T) {
	tfOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir:             "../examples/basic/th",
		RetryableTerraformErrors: retryableTerraformErrors,
	})

	// Clean up resources with "terraform destroy" at the end of the test.
	defer terraform.Destroy(t, tfOptions)

	// Run "terraform init" and "terraform apply". Fail the test if there are any errors.
	_, err := terraform.InitAndApplyE(t, tfOptions)
	assert.Equal(t, err, nil)
}
