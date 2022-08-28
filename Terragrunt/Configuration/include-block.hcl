include "region" {
    name           = region_data
    path           = find_in_parent_folders("region.hcl") #find_in_parent_folders()
    expose         = true
    merge_strategy = "no_merge" # shallow (default), deep
}