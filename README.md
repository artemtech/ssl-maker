# ssl-maker
Simple script to create self signed certificate SSL with self CA

## Usage
```bash
#1 create working directory for storing your ca
mkdir myca

#2 create ca key
./01-gen-cakey.sh myca

#3 generate config for ca
cp example-ca.conf myca.conf
nano myca.conf

#4 create your ca
./02-create-rootca.sh myca.conf myca/

#5 generate config for server certificate
cp example-server.conf myserver.conf
nano myserver.conf
mkdir myserver

#6 generate your server csr
./03-create-server-cert.sh myserver.conf myserver/

#7 sign server.csr with root ca
./04-sign-server-cert.sh myserver.conf myserver/ myca/

#8 your server cert will generated in myserver/ folder
- server.crt
- server.key
- server-bundle.pem (server.crt + ca.crt)

```


### reference
- https://openssl-ca.readthedocs.io/en/latest/sign-server-and-client-certificates.html
