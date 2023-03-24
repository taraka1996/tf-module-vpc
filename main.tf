resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    tags = merge(
        var.tags,
        { Name = "${var.env}-vpc" }
   )          
}
## public subnets
resource "aws_subnet" "public_subnets" {
    vpc_id = aws_vpc.main.id

    for_each = var.public_subnets
    cidr_block = each.value["cidr_block"]
    availability_zone = each.value["availability_zone"]
    tags   = merge(
     var.tags,
     { Name = "${var.env}-${each.value["name"]}" }

    )
    
}
## public route table
resource "aws_route_table" "public-route-table" {
    vpc_id = aws_vpc.main.id
    
    for_each = var.public_subnets
    tags = merge(
        var.tags, 
        { Name = "${var.env}- ${each.value["name"]}"}
    )
 }

 #resource "aws_route_table_association" "public-association" {
    #for_each = var.public_subnets
    #subnet_id = aws_subnet.public_subnets[each.value["name"]].id
    #route_table_id = aws_route_table.[each.value["name"]].id }

## private subnets
resource "aws_subnet" "private_subnets" {
    vpc_id = aws_vpc.main.id

    for_each = var.private_subnets
    cidr_block = each.value["cidr_block"]
    availability_zone = each.value["availability_zone"]
    tags   = merge(
     var.tags,
     { Name = "${var.env}-${each.value["name"]}" }

    )
    
}

## private route table
resource "aws_route_table" "private-route-table" {
    vpc_id = aws_vpc.main.id
    
    for_each = var.private_subnets
    tags = merge(
        var.tags, 
        { Name = "${var.env}- ${each.value["name"]}"}
    )
 }