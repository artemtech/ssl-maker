# ssl-maker
Simple script to create self signed certificate SSL with self CA

## Usage
```bash
#1 create empty working directory for storing your ca
mkdir myca

#2 create ca key
./01-gen-cakey.sh myca

#3 generate config for ca
cp example-ca.conf myca.conf
nano myca.conf
# edit dir= , to your full path of myca directory that created in step 1

#4 create your ca
./02-create-rootca.sh myca.conf myca/

#5 generate config for server certificate
cp example-server.conf myserver.conf
nano myserver.conf
mkdir myserver

#6 generate your server csr
./03-create-csr.sh myserver.conf myserver/

#7 sign server.csr with root ca
./04-sign-server-cert.sh myserver.conf myserver/ myca/

#8 your server cert will generated in myserver/ folder
- server.crt
- server.key
- server-bundle.pem (server.crt + ca.crt)

# bonus
# if you want to create certificate for digital signature only,
# step 5
cp example-docsign.conf mydocsign.conf
nano mydocsign.conf
mkdir mydoc-cert

#6 generate csr
./03-create-csr.sh mydocsign.conf mydoc-cert/

#7 sign csr with root ca
./05-sign-docsign-cert.sh mydocsign.conf mydoc-cert/ myca/
```


# bonus creating intermediate certificate and sign new server certificate using intermediate ca
```
0. cp example-intermediate.conf my-intermediate.conf
1. ./03-create-csr-intermediate.sh my-intermediate.conf output/my-intermediate/
2. ./06-sign-intermediate.sh myca.conf output/myca/ output/my-intermediate/

# if you want to create server cert that signed by intermediate:
3. cp example-server.conf myserver-2.conf
4. ./03-create-csr.sh myserver-2.conf output/myserver-2/
5. ./04-sign-server-cert-with-intermediate.sh myserver-2.conf output/myserver-2/ output/my-intermediate/
```


### reference
- https://openssl-ca.readthedocs.io/en/latest/sign-server-and-client-certificates.html
