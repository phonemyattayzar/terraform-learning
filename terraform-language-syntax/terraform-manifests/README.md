ဒီ Terraform file မှာ အသုံးများတဲ့ Terraform Block တွေကို ပြထားပါတယ်။

```text
terraform
provider
resource
variable
output
locals
data
module
```

Terraform Project တစ်ခုမှာ အများအားဖြင့် ဒီ Block တွေကို တွေ့ရပါတယ်။

---

# 📌 Block 1: Terraform Block

```hcl
terraform {
  required_version = "~> 1.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}
```

## Terraform Block ဆိုတာဘာလဲ?

Terraform ကိုယ်တိုင်နဲ့ သက်ဆိုင်တဲ့ Setting တွေကို သတ်မှတ်တဲ့ Block ဖြစ်ပါတယ်။

---

## required_version

```hcl
required_version = "~> 1.4"
```

အဓိပ္ပါယ်က

```text
Terraform Version >= 1.4
Terraform Version < 2.0
```

အသုံးပြုလို့ရသော Version များ

```text
1.4
1.5
1.6
1.7
...
```

အသုံးမပြုနိုင်သော Version

```text
2.0
3.0
```

### ဘာကြောင့်သုံးတာလဲ?

Team မှာ Developer အများကြီး ရှိတဲ့အခါ

```text
Developer A -> Terraform 1.4
Developer B -> Terraform 2.0
```

Version မတူရင် Error တက်နိုင်ပါတယ်။

ဒါကြောင့် Version ကို Lock လုပ်ထားတာ ဖြစ်ပါတယ်။

---

## required_providers

```hcl
required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = ">= 4.0"
  }
}
```

Terraform ကို AWS နဲ့ ချိတ်ဖို့ AWS Provider လိုအပ်ပါတယ်။

```text
Terraform
    ↓
AWS Provider
    ↓
AWS API
```

`terraform init` လုပ်တဲ့အခါ AWS Provider ကို Download လုပ်ပေးပါတယ်။

---

## Backend

```hcl
backend "s3" {
  bucket = "terraform-demo"
  key    = "dev2/terraform.tfstate"
}
```

### Backend မသုံးရင်

```text
terraform.tfstate
```

ဖိုင်က Local Laptop ထဲမှာပဲ ရှိမယ်။

---

### Backend သုံးရင်

```text
Laptop
  ↓
Terraform
  ↓
S3 Bucket
  ↓
terraform.tfstate
```

State File ကို AWS S3 ထဲမှာ သိမ်းထားနိုင်ပါတယ်။

---

## DynamoDB State Locking

```hcl
dynamodb_table = "terraform-dev-state-table"
```

ဥပမာ

```text
Engineer A -> terraform apply
Engineer B -> terraform apply
```

နှစ်ယောက်တစ်ချိန်တည်း Run ရင် State File ပျက်နိုင်ပါတယ်။

DynamoDB Locking က

```text
A အလုပ်ပြီးမှ
B ကိုခွင့်ပေးမယ်
```

---

# 📌 Block 2: Provider Block

```hcl
provider "aws" {
  profile = "default"
  region  = "us-east-1"
}
```

Terraform ကို

```text
AWS သုံးမယ်
Profile = default
Region = us-east-1
```

လို့ ပြောပေးတာဖြစ်ပါတယ်။

---

## profile

```hcl
profile = "default"
```

AWS CLI Configuration ထဲက

```bash
~/.aws/credentials
```

ကို အသုံးပြုမယ်။

ဥပမာ

```ini
[default]
aws_access_key_id=xxxx
aws_secret_access_key=xxxx
```

---

# 📌 Block 3: Resource Block

```hcl
resource "aws_instance" "ec2demo" {
  ami           = "ami-04d29b6f966df1537"
  instance_type = var.instance_type
}
```

Terraform မှာ အရေးအကြီးဆုံး Block ဖြစ်ပါတယ်။

---

## Structure

```hcl
resource "<type>" "<name>" {
}
```

ဥပမာ

```hcl
resource "aws_instance" "ec2demo"
```

### aws_instance

EC2 Instance ဖန်တီးမယ်။

### ec2demo

Terraform ထဲမှာ Reference ခေါ်ဖို့ နာမည်။

---

ဥပမာ

```hcl
aws_instance.ec2demo.id
```

EC2 ရဲ့ ID ကို ပြန်ယူတာ ဖြစ်ပါတယ်။

---

# 📌 Block 4: Variable Block

```hcl
variable "instance_type" {
  default = "t2.micro"
  type = string
}
```

Variable ဆိုတာ Parameter လိုမျိုး ဖြစ်ပါတယ်။

---

မသုံးရင်

```hcl
instance_type = "t2.micro"
```

သုံးရင်

```hcl
instance_type = var.instance_type
```

---

အကျိုးကျေးဇူး

```text
Reusable
Flexible
Easy to maintain
```

---

# 📌 Block 5: Output Block

```hcl
output "ec2_instance_publicip" {
  value = aws_instance.ec2demo.public_ip
}
```

`terraform apply` ပြီးတဲ့အခါ

```text
ec2_instance_publicip = 44.xxx.xxx.xxx
```

ပြပေးမယ်။

---

အသုံးများတာ

```text
Public IP
VPC ID
Subnet ID
Load Balancer DNS
S3 Bucket Name
```

---

# 📌 Block 6: Locals Block

```hcl
locals {
  bucket_name_prefix = "${var.app_name}-${var.environment_name}"
}
```

Locals ဆိုတာ Terraform ထဲက Variable အမျိုးအစားတစ်ခု ဖြစ်ပါတယ်။

---

ဥပမာ

```hcl
locals {
  full_name = "dev-web-server"
}
```

အသုံးပြု

```hcl
local.full_name
```

---

Result

```text
dev-web-server
```

---

# 📌 Block 7: Data Source Block

```hcl
data "aws_ami" "amzlinux" {
}
```

Data Source ဆိုတာ

```text
Create မလုပ်ဘူး
Read ပဲလုပ်တယ်
```

---

Resource

```hcl
resource "aws_instance"
```

AWS ထဲမှာ Resource အသစ် ဖန်တီးတယ်။

---

Data Source

```hcl
data "aws_ami"
```

AWS ထဲက ရှိပြီးသား Resource ကို ဖတ်တယ်။

---

ဒီ Code က

```text
Latest Amazon Linux 2 AMI ကို ရှာပေး
Owner = amazon
Architecture = x86_64
```

---

အသုံးပြု

```hcl
data.aws_ami.amzlinux.id
```

Result

```text
ami-xxxxxxxx
```

---

# 📌 Block 8: Module Block

```hcl
module "ec2_cluster" {
  source = "terraform-aws-modules/ec2-instance/aws"
}
```

Module ဆိုတာ Reusable Terraform Code ဖြစ်ပါတယ်။

---

Programming Language မှာ

```python
create_ec2()
```

Function သုံးသလို

Terraform မှာ

```hcl
module "ec2_cluster"
```

သုံးတာ ဖြစ်ပါတယ်။

---

## Source

```hcl
source = "terraform-aws-modules/ec2-instance/aws"
```

Terraform Registry ကနေ Module Download လုပ်မယ်။

---

## Version

```hcl
version = "~> 2.0"
```

Version 2.x ကို အသုံးပြုမယ်။

---

## instance_count

```hcl
instance_count = 2
```

Result

```text
EC2-1
EC2-2
```

EC2 နှစ်လုံး ဖန်တီးပေးမယ်။

---

## AMI

```hcl
ami = data.aws_ami.amzlinux.id
```

Data Source က ရလာတဲ့ Latest Amazon Linux AMI ကို အသုံးပြုမယ်။

---

## user_data

```hcl
user_data = file("apache-install.sh")
```

Server Boot တက်တာနဲ့

```bash
yum install httpd -y
systemctl start httpd
```

လို Command တွေ Run ပေးမယ်။

---


| Block | Purpose |
|---------|---------|
| terraform | Terraform Setting |
| provider | AWS နှင့် ချိတ်ဆက် |
| resource | Resource ဖန်တီး |
| variable | Input Parameter |
| output | Result ပြသ |
| locals | Internal Variable |
| data | Existing Resource ဖတ် |
| module | Reusable Code |
| backend | Remote State Storage |

---
