## Create Backend bucket 

Cope Git Repo into the Cloud Shell
Run the terraform config files.

Error:
```bash
Your version of Terraform is out of date! The latest version
is 1.9.8. 
```

1. Install tfenv
```bash
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

```

2. Install the Latest Terraform Version:

```bash
tfenv install latest

```

3. Set the Latest Version as Default:
```bash
tfenv use latest
```

4. Verify the Installation:

```bash
terraform version
```