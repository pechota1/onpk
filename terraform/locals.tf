locals {
  image = {
    ubuntu = {
        id = "0fc1152a-4037-4d89-a22a-60f477e2eba0"
        os_username = "ubuntu"
    }
  }
  flavor = {
    onpk_small = {
        id = "7de08105-668c-48c1-8978-5fc40f578d24"
    }
    onpk_large = {
        id = "38786c05-8577-4115-b374-0024ac93b857"
    }
  }
  kis_os_region = "RegionOne"
  kis_os_auth_url = "http://158.193.138.33:5000/v3"
  kis_os_endpoint_overrides = {
    network = "http://158.193.138.33:9696/v2.0/"
    image   = "http://158.193.138.33:9292/v2.0/"
    compute = "http://158.193.138.33:8774/v2.1/"  
  }
  university = {
    network = {
      cidr = "158.193.177.6/32"
    }
  }
  my_public_ip = "${data.http.my_public_ip.response_body}"
}