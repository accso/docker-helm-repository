#! /bin/bash
echo "Starting helm using command line..."
echo "    /bin/helm serve --repo-path /charts $@"
exec /bin/helm serve --repo-path /charts "$@"
