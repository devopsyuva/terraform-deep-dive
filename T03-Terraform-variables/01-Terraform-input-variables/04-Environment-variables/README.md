# Terraform Environment Variables
- Set environment variables and execute using terraform plan/apply to see/create the overrided values.
- Environment variables will start with TF_VAR_\<var_name\>.
- Export the variables on the terminal before executing #terraform plan/apply.
```
#export TF_VAR_inst_type=t3.large
#export TF_VAR_inst_count=3
#echo $TF_VAR_inst_type $TF_VAR_inst_count --> check if values are printed
#terraform plan --> To check which values are picked
#terraform apply [-auto-approve]
#unset TF_VAR_inst_type
#unset TF_VAR_inst_count
#echo $TF_VAR_inst_type $TF_VAR_inst_count --> empty result after unset variables
```