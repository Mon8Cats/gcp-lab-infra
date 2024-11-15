
resource "google_sql_database" "database" {
  name     = var.database_name
  instance = var.instance_name
}

# Provisioner to create a table using a local exec command
resource "null_resource" "create_table" {
  provisioner "local-exec" {
    command = <<EOF
      gcloud sql connect ${var.instance_name} --user=${var.db_username} --database=${var.database_name} --quiet <<SQL
      CREATE TABLE IF NOT EXISTS employees (
        id SERIAL PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        position VARCHAR(100),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );
SQL
EOF
  }
}
