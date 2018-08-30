#! /bin/bash
echo "Starting helm using command line..."
echo "    /bin/helm serve --repo-path /charts $@"
/bin/helm serve --repo-path /charts "$@"
