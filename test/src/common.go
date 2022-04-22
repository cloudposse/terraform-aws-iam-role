package test

import (
	"math/rand"
	"strconv"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func testNoChanges(t *testing.T, terraformDir string) {
	rand.Seed(time.Now().UnixNano())
	randID := strconv.Itoa(rand.Intn(100000))
	attributes := []string{randID}

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: terraformDir,
		Upgrade:      true,
		// Variables to pass to our Terraform code using -var-file options
		VarFiles: []string{"fixtures.us-east-2.tfvars"},
		// We always include a random attribute so that parallel tests
		// and AWS resources do not interfere with each other
		Vars: map[string]interface{}{
			"enabled":    false,
			"attributes": attributes,
		},
	})

	terraform.Init(t, terraformOptions)
	plan := terraform.Plan(t, terraformOptions)

	assert.Contains(t, plan, "No changes.")
}
