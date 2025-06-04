package test

import (
	"math/rand"
	"strconv"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// Test the Terraform module in examples/complete using Terratest.
func TestExamplesComplete(t *testing.T) {
	rand.Seed(time.Now().UnixNano())

	randId := strconv.Itoa(rand.Intn(100000))
	attributes := []string{randId}

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../../examples/complete",
		Upgrade:      true,
		// Variables to pass to our Terraform code using -var-file options
		VarFiles: []string{"fixtures.us-east-2.tfvars"},
		Vars: map[string]interface{}{
			"attributes": attributes,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	keyArn := terraform.Output(t, terraformOptions, "key_arn")
	// Verify we're getting back the outputs we expect
	assert.Contains(t, keyArn, "arn:aws:kms:us-east-2")

	// Run `terraform output` to get the value of an output variable
	aliasName := terraform.Output(t, terraformOptions, "key_alias_name")
	expectedAliasName := "alias/eg-test-iam-role-test-" + randId
	// Verify we're getting back the outputs we expect
	assert.Equal(t, expectedAliasName, aliasName)

	// Run `terraform output` to get the value of an output variable
	s3BucketId := terraform.Output(t, terraformOptions, "bucket_id")
	expectedS3BucketId := "eg-test-iam-role-test-" + randId
	// Verify we're getting back the outputs we expect
	assert.Equal(t, expectedS3BucketId, s3BucketId)

	// Run `terraform output` to get the value of an output variable
	roleName := terraform.Output(t, terraformOptions, "role_name")
	expectedroleName := "eg-test-iam-role-test-" + randId
	// Verify we're getting back the outputs we expect
	assert.Equal(t, expectedroleName, roleName)
}

// Test the Terraform module in examples/complete doesn't attempt to create resources with enabled=false.
func TestExamplesCompleteDisabled(t *testing.T) {
	testNoChanges(t, "../../examples/complete")
}

// Test the module with a custom assume_role_policy
func TestExamplesAssumeRolePolicyDocument(t *testing.T) {

	rand.Seed(time.Now().UnixNano())
	randId := strconv.Itoa(rand.Intn(100000))
	attributes := []string{randId}

	// Minimal valid trust policy
	trustPolicy := `{
	  "Version": "2012-10-17",
	  "Statement": [
	    {
	      "Effect": "Allow",
	      "Principal": {"Service": "ec2.amazonaws.com"},
	      "Action": "sts:AssumeRole"
	    }
	  ]
	}`

	terraformOptions := &terraform.Options{
		TerraformDir: "../../examples/complete",
		Upgrade:      true,
		VarFiles:     []string{"fixtures.us-east-2.tfvars"},
		Vars: map[string]interface{}{
			"attributes":         attributes,
			"assume_role_policy": trustPolicy,
		},
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	roleName := terraform.Output(t, terraformOptions, "role_name")
	expectedRoleName := "eg-test-iam-role-test-" + randId
	assert.Equal(t, expectedRoleName, roleName)
}
