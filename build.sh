#!/bin/bash -xe

# This script uses openapi2jsonschema to generate a set of JSON schemas for
# the specified Kubernetes versions in three different flavours:
#
#   X.Y.Z - URL referenced based on the specified GitHub repository
#   X.Y.Z-standalone - de-referenced schemas, more useful as standalone documents
#   X.Y.Z-local - relative references, useful to avoid the network dependency

REPO="garethr/kubernetes-json-schema"

declare -a arr=(master
                v1.7.3
                v1.7.2
                v1.7.1
                v1.7.0
                v1.6.8
                v1.6.7
                v1.6.6
                v1.6.5
                v1.6.4
                v1.6.3
                v1.6.2
                v1.6.1
                v1.6.0
                v1.5.6
                v1.5.4
                v1.5.3
                v1.5.2
                v1.5.1
                v1.5.0
                )

for version in "${arr[@]}"
do
    schema=https://raw.githubusercontent.com/kubernetes/kubernetes/${version}/api/openapi-spec/swagger.json
    prefix=https://raw.githubusercontent.com/${REPO}/master/${version}/_definitions.json

    openapi2jsonschema -o "${version}-standalone" --kubernetes --stand-alone "${schema}"
    openapi2jsonschema -o "${version}-local" --kubernetes "${schema}"
    openapi2jsonschema -o "${version}" --kubernetes --prefix "${prefix}" "${schema}"
done
