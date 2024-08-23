# main.tf

resource "null_resource" "foo" {
  triggers = {
    foo = var.project
  }
}
