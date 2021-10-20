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
  workspace    = "multispace-home"
}

resource "multispace_run" "physical" {
  organization = "bluebelt-dev"
  workspace    = "multispace-physical"
  depends_on   = [multispace_run.root]
}

resource "multispace_run" "core" {
  organization = "bluebelt-dev"
  workspace    = "multispace-core"
  depends_on   = [multispace_run.physical]
}

resource "multispace_run" "dns" {
  organization = "bluebelt-dev"
  workspace    = "multispace-dns"
  depends_on   = [multispace_run.root]
}

resource "multispace_run" "ingress" {
  organization = "bluebelt-dev"
  workspace    = "multispace-ingress"
  depends_on   = [multispace_run.core, multispace_run.dns]
}
