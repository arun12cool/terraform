# Ref  : https://learn.hashicorp.com/tutorials/terraform/expressions?in=terraform/configuration-language
# If additional tags are required, need to append it to the below locals variable and reference it to common_tags.


#####TAGS###############################################


locals {
  
    App = var.App
    AppOwner = var.AppOwner
    Environment = var.Environment
    Contact = var.Contact
    Name = var.Name
    AppComponent = var.AppComponent
    Creator = var.Creator
    CostCenter = var.CostCenter
    Customer = var.Customer
    Location = var.Location
    Memo = var.Memo
    IAAS_NAME = var.IAAS_NAME
    IAAS_NIC_NAME = var.IAAS_NIC_NAME
    common_tags = {
      App = local.App
      AppOwner = local.AppOwner
      Environment = local.Environment
      Contact = local.Contact
      Name = local.Name
      AppComponent = local.AppComponent
      Creator = local.Creator
      CostCenter = local.CostCenter
      Customer = local.Customer
      Location = local.Location
      Memo = local.Memo
      Iaas_Name = local.IAAS_NAME
      Iaas_Nic_Name = local.IAAS_NIC_NAME
    }
}


#####################TAGS###################################
