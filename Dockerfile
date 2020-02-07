FROM alpine:3.11

ENV TERRAFORM_VERSION=0.12.9
ENV PYTHONUNBUFFERED=1
ENV USER=root

ENV PACKER_VERSION=1.3.2 \
    PACKER_OSNAME=linux \
    PACKER_OSARCH=amd64 \
    PACKER_DEST=/usr/local/sbin

# Packer path setup
ENV PACKER_ZIPFILE=packer_${PACKER_VERSION}_${PACKER_OSNAME}_${PACKER_OSARCH}.zip

ADD . /app
WORKDIR /app


RUN adduser -D -g '' paker

# Install packer in path
ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/${PACKER_ZIPFILE} ${PACKER_DEST}/
RUN unzip ${PACKER_DEST}/${PACKER_ZIPFILE} -d ${PACKER_DEST} && \
    rm -rf ${PACKER_DEST}/${PACKER_ZIPFILE}

RUN apk add --no-cache python3 python3-dev build-base sshpass && \
    apk add --no-cache wget gcc libffi-dev openssl-dev bash ca-certificates git openssh && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    rm -r /root/.cache

ENV HELM_FILENAME=helm-${HELM_VERSION}-linux-amd64.tar.gz


RUN apk add --no-cache --virtual .build-deps \
    && rm -rf /var/cache/apk/* /tmp/*

RUN pip install --no-cache-dir -r requirements.txt

ADD https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip .
RUN unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
  chmod +x terraform && \
  mv terraform /usr/bin/terraform

ENV PATH="${PATH}:/root/bin:/out/usr/bin:/out/usr/local/bin"

ENTRYPOINT ["/app/entrypoint.sh"]
