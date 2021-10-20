terraform {
  required_providers {
    multispace = {
      source = "mitchellh/multispace"
      version = "0.1.0"
    }
  }
}

resource "multispace_run" "root" {
  # Use string workspace names here and not data sources so that
  # you can define the multispace runs before the workspace even exists.
  organization = "bluebelt-dev"
  workspace    = "tfc"
}

resource "multispace_run" "physical" {
  organization = "bluebelt-dev"
  workspace    = "k8s-physical"
  depends_on   = [multispace_run.root]
}

resource "multispace_run" "core" {
  organization = "bluebelt-dev"
  workspace    = "k8s-core"
  depends_on   = [multispace_run.physical]
}

resource "multispace_run" "dns" {
  organization = "bluebelt-dev"
  workspace    = "dns"
  depends_on   = [multispace_run.root]
}

resource "multispace_run" "ingress" {
  organization = "bluebelt-dev"
  workspace    = "ingress"
  depends_on   = [multispace_run.core, multispace_run.dns]
}
