# main.tf

resource "null_resource" "foo" {
  triggers = {
    foo = var.project
  }
}

resource "aws_db_instance" "mydb_WkKSSQ7WFfLjA9ny" {
  allocated_storage   = 50
  db_name             = "mydb"
  engine              = "postgres"
  engine_version      = "16.4"
  instance_class      = "db.m1.small"
  username            = "db-username"
  password            = "password"
  skip_final_snapshot = true
}
