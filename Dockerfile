FROM amazon/aws-cli

RUN yum install jq -y

WORKDIR /app
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
