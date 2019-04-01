FROM python:3.7-slim

RUN PACKER_VERSION=1.3.4 && TERRAFORM_VERSION=0.11.11 && ANSIBLE_VERSION=2.7.9 && \
    apt-get update && apt-get install -yy zip unzip curl dos2unix ssh rsync sudo tar gzip && \
    curl -sS https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip > packer.zip && \
    unzip packer.zip -d /bin && \
    rm -f packer.zip && \
    curl -sS https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform.zip && \
    unzip terraform.zip -d /bin && \
    rm -f terraform.zip && \
    pip install ansible==${ANSIBLE_VERSION} requests pywinrm awscli boto3 boto psycopg2 pymongo && \
    rm -rf /var/lib/apt/lists/* && \
    rm -r /root/.cache && \
    mkdir /work && \
    useradd -d /work -u 1000 automation && \
    chown automation:automation /work && \
    ln -s /usr/local/bin/python /usr/bin/python

#Setup user information for container
USER automation
ENV USER=automation

#Set defaults for working directory, entrypoint, and command
WORKDIR /work
ENTRYPOINT []
CMD ["/bin/bash"]

