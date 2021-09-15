# Terraform state pull/push
- terraform state pull is used to manually download and output the state from remote state.
  - This also works with local state.
  - This command will download the state from its current location and output the raw format to stdout.
- terraform state push is used to manually upload the local state file to remote state.
```
#terraform state pull --> state info will be displayed as stdout
#terraform state push
```

# Terraform force-unlock
- Manually unlock the state for the defined configuration
- This will not modify your infrastructure
- This command removes the lock on the state for the current configuration
- The behavior of this lock is dependent on the backened beding used.
Note: Local state files can't be unlocked by another process.
```
#terraform force-unlock <lock-id>
```