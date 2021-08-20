# AWS S3 bucket to host static website
## Manual steps
- AWS console --> S3 service
- Create bucket
  - Bucket name
  - Region
  - Default for all other options for now (like Bucket Public Access, Encryption, Tags etc.,)
  - Click on "Create Bucket"
- Lets enable static website hosting for the bucket created above
  - S3 service --> Buckets --> click on the bucket name
  - Properties Tab --> At the end of the page
  - Edit to enable "Static Website Hosting"
    - Hosting Type --> Host a static website
    - Index document --> give "index.html"
  - Click on "Save Changes"
- Change the Permission for the Bucket
  - Go to Permission Tab
  - Block public access --> Edit
  - click on Diable and Save the changes (conform)
- Now lets add Policy to the Bucket as mentioned below
```
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Sid": "PublicReadGetObject",
          "Effect": "Allow",
          "Principal": "*",
          "Action": [
              "s3:GetObject"
          ],
          "Resource": [
              "arn:aws:s3:::${var.bucket_name}/*"
          ]
      }
  ]
}
```
  - S3 bucket --> Permission Tab
  - Bucket Policy --> Edit
  - Copy paste the above policy with changing the name of the bucket as per your name of the bucket
  - Save Changes
- Finally, upload one index.html file to the bucket
  - S3 bucket --> Click on the bucket name
  - Objects tab --> Upload
  - Add files --> browser the file of index.html file form local and upload
  - Click on "Upload"

## Terraform configuration files
```
#Terraform Initialize
terraform init

#Validate & Format
terraform validate && terraform fmt

#Terraform plan
terraform plan

#Terraform apply
terraform apply -auto-approve

- Upload the index.html page to the bucket
- Now check the website with s3 bucket domain endpoint in the browser
```

## Terraform module for above configuration files
- We are going to create module folder and in that we are going to create a module named "aws-s3-static-website-bucket".
- We will copy required files previous section for this respesctive module.
```
- All modules are placed under modules/aws-s3-static-website-bucket

terraform init
terraform validate/fmt
terraform plan
terraform apply -auto-approve
```