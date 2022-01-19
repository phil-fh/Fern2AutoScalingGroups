module "fooservice-1" {
  source = "./modules/fooservice"
  fooservice_name = "first"
  container_version = "latest"
}
module "fooservice-2" {
  source = "./modules/fooservice"
  fooservice_name = "second"
  container_version = "latest"
}
output "first-url" {
  value = module.fooservice-1.your-url
}
output "second-url" {
  value = module.fooservice-2.your-url
}