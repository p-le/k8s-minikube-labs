
locals {
  manifest_files = fileset(path.module, "manifests/*.yaml")
}

resource "kubectl_manifest" "manifest_file" {
  for_each  = local.manifest_files
  yaml_body = file(each.value)
}
