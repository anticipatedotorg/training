provider "dnsimple" {
  token = "blah"
  account = "blah"
}

resource "dnsimple_record" "test" {
  domain = "test.domain.com"
  name = "blah"
  value = "${aws_instance.web.0.public_ip}"
  type = "A"
}
