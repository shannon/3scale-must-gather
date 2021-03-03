FROM quay.io/openshift/origin-must-gather:4.6

# Save original gather script
RUN mv /usr/bin/gather /usr/bin/gather_original

# Use our gather script in place of the original one
COPY gather_3scale /usr/bin/gather
COPY version /usr/bin/version

ENTRYPOINT /usr/bin/gather
