# Module Testing Experiment using Terraform Test :

# Terraform Test

Ref : https://www.terraform.io/docs/language/modules/testing-experiment.html

# Terraform CLI v0.15.0

Current extension to Terraform for this experimental feature consists of the following parts:

1) Temporary experimental provider **terraform.io/builtin/test**, which acts as a placeholder for potential new language features related to test assertions.
2) A new terraform test command for more conveniently running multiple tests in a single action.
3) An experimental convention of placing test configurations in subfolders of a tests directory within your module, which terraform test will then discover and run.

# WRITING TESTS FOR A MODULE

Current implementation arranges module tests into test suites, each of which is a root Terraform module which includes a module block calling the module under test, and ideally also a number of test assertions to verify that the module outputs match expectations.

To get started create a subfolder called tests/ in the same directory where you keep your module’s .tf and/or .tf.json source files. In that directory, make another directory which will serve as your first test suite, with a directory name that concisely describes what the suite is aiming to test.

```
So an example of a typical directory structure with the addition of a test suite called defaults would look like:

main.tf
outputs.tf
providers.tf
variables.tf
versions.tf
tests/
defaults/
test_defaults.tf
```
The tests/defaults/test_defaults.tf file contains a call to the main module with a suitable set of arguments and also one or more resources that will serve as the temporary syntax for defining test assertions.

Here are few sample tests which I had created for testing the feasibilities of Helm, Docker and an AWS Resource.

 # Repo's : https://github.build.ge.com/apmm-devops/pelican-smoke-test/tree/terraform-test/terraform-test

# Helm

# Docker

# AWS Resource - Namespace & S3



You can also create additional directories alongside the defaults/ directory to define additional test suites that pass different variable values into the main module, and then include assertions that verify that the result has changed in the expected way.

# RUNNING YOUR TESTS

To check all our test suites we can just run terraform test and that would get us output of testing results (errors or success).

The current experimental command expects to be run from your main module directory and not the specific test suite directory containing test cases files

Because these test suites are integration tests rather than unit tests, you will need to set up any credentials files or environment variables needed by the providers your module uses before running terraform test. When run the test command will, for each suite:

1) Install the providers and any external modules the test configuration depends on.
2) Create an execution plan to create the objects declared in the module.
3) Apply that execution plan to create the objects in the real remote system.
4) Collect all of the test results from the apply step, which would also have “created” the test_assertions resources.
5) Destroy all of the objects recorded in the temporary test state, as if running terraform destroy against the test configuration.

# Example output:

# successful cases

```
GC02XD0C8JG5HE:RBAC admin$ terraform test

│ Warning: The "terraform test" command is experimental
│
│ We'd like to invite adventurous module authors to write integration tests for their modules using this command, but all of the behaviors of this command are currently experimental and may change based on feedback.
│
│ For more information on the testing experiment, including ongoing research goals and avenues for feedback, see:
│     https://www.terraform.io/docs/language/modules/testing-experiment.html
╵
╷
│ Warning: Backend configuration ignored

Success! All of the test assertions passed.
```
# Failed cases
```
GC02XD0C8JG5HE:RBAC Arun$ terraform test

│ Warning: The "terraform test" command is experimental
│
│ We'd like to invite adventurous module authors to write integration tests for their modules using this command, but all of the behaviors of this command are currently experimental and may change based on feedback.
│
│ For more information on the testing experiment, including ongoing research goals and avenues for feedback, see:
│     https://www.terraform.io/docs/language/modules/testing-experiment.html
╵
╷
│ Warning: Backend configuration ignored
─── Failed: defaults.ns_id2.id2 (Check id2) ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
wrong value
    got:  "cloudservices"
    want: "hub"

─── Failed: defaults.rb-ns2.name (Check the Role Binding for NS - cs) ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
wrong value
    got:  "hub/hub-ns-viewer"
    want: "cloudservices/cloudservices-ns-viewer"

─── Failed: defaults.rb-ns3.name (Check the Role Binding for NS - paas) ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
wrong value
    got:  "apm/apm-ns-viewer"
    want: "hub/hub-ns-viewer"

─── Failed: defaults.rb-ns1.name (Check the Role Binding for NS apm) ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
wrong value
    got:  "cloudservices/cloudservices-ns-viewer"
    want: "hub/hub-ns-viewer"

─── Failed: defaults.ns_id1.id1 (Check id1) ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
wrong value
    got:  "hub"
    want: "cloudservices"

─── Failed: defaults.ns_name2.name (Check the ns) ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
wrong value
    got:  "hub"
    want: "cloudservices"

─── Failed: defaults.ns_name1.name (Check the ns) ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
wrong value
    got:  "cloudservices"
    want: "hub"

```