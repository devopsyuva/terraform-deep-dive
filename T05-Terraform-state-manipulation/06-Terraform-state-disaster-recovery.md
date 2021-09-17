# Terraform State Disaster Recovery

## Terraform state pull/push
- terraform state pull is used to manually download and output the state from remote state.
  - This also works with local state.
  - This command will download the state from its current location and output the raw format to stdout.
- terraform state push is used to manually upload the local state file to remote state.
- Terraform will perform a number of safety checks to prevent you from making changes that appear to be unsafe:
  - **Differing lineage:** If the "lineage" value in the state differs, Terraform will not allow you to push the state. A differing lineage suggests that the states are completely different and you may lose data.
  - **Higher remote serial:** If the "serial" value in the destination state is higher than the state being pushed, Terraform will prevent the push. A higher serial suggests that data is in the destination state that isn't accounted for in the local state being pushed.
  - **-force** flag will be used to disable the safety check, which is not recommended.

```
#terraform state pull --> state info will be displayed as stdout
#terraform state push
```

## Terraform force-unlock
- Manually unlock the state for the defined configuration
- This will not modify your infrastructure
- This command removes the lock on the state for the current configuration
- The behavior of this lock is dependent on the backened being used.
Note: Local state files can't be unlocked by another process.
```
#terraform force-unlock <lock-id>
```