# STAGE 2: Runtime
FROM alpine

COPY kuard-bin /kuard

# Set non-root nobody:nobody user (using UID:GID to support k8s SecurityContext runAsNonRoot:true)
USER 65534:65534

CMD [ "/kuard" ]
