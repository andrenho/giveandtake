variable "access_key" {}

variable "secret_key" {}

variable "jenkins_password" {}

variable "region" {
    default = "us-east-1"
}

variable "domain" {
    default = "give-and-take.tk"
}

variable "jenkins_job_name" {
    default = "Give and Take"
}

variable "git_repo" {
    default = "https://github.com/andrenho/giveandtake.git"
}

# vim:ts=4:sw=4:sts=4:expandtab:syntax=conf
