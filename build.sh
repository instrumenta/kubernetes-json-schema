#!/bin/bash -xe

# This script uses openapi2jsonschema to generate a set of JSON schemas for
# the specified Kubernetes versions in three different flavours:
#
#   X.Y.Z - URL referenced based on the specified GitHub repository
#   X.Y.Z-standalone - de-referenced schemas, more useful as standalone documents
#   X.Y.Z-local - relative references, useful to avoid the network dependency

REPO="garethr/kubernetes=json-schema"

declare -a arr=(1.6.6
                1.6.5
                1.6.4
                1.6.3
                1.6.2
                1.6.1
                1.6.0
                1.5.6
                1.5.4
                1.5.3
                1.5.2
                1.5.1
                1.5.0
                )

for version in "${arr[@]}"
do
    schema=https://raw.githubusercontent.com/kubernetes/kubernetes/v${version}/api/openapi-spec/swagger.json
    prefix=https://raw.githubusercontent.com/${REPO}/master/v${version}/_definitions.json

    openapi2jsonschema -o "${version}-standalone" --stand-alone "${schema}"
    openapi2jsonschema -o "${version}-local" "${schema}"
    openapi2jsonschema -o "${version}" --prefix "${prefix}" "${schema}"
done
