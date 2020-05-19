package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

// Test the Terraform module in examples/complete using Terratest.
func TestExamplesComplete(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../../example/",
		Upgrade:      true,
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	roleName := terraform.Output(t, terraformOptions, "role_name")
	roleArn := terraform.Output(t, terraformOptions, "role_arn")
	resultDocument := terraform.Output(t, terraformOptions, "role_policy")
	// Verify we're getting back the outputs we expect
	assert.Contains(t, roleName, "cp-test-app")
	assert.Contains(t, roleArn, "cp-test-app")
	assert.Contains(t, resultDocument, "\"Sid\": \"BaseAccess\"")
	assert.Contains(t, resultDocument, "\"Sid\": \"FullAccess\"")
}
