resource "aws_iam_user" "demousers" {
    for_each = toset(["sudheer", "adithya", "prakash"])
    name     = each.key // we can also use each.value
}