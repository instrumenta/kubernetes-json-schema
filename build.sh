#!/bin/bash -xe

# This script uses openapi2jsonschema to generate a set of JSON schemas for
# the specified Kubernetes versions in three different flavours:
#
#   X.Y.Z - URL referenced based on the specified GitHub repository
#   X.Y.Z-standalone - de-referenced schemas, more useful as standalone documents
#   X.Y.Z-standalone-strict - de-referenced schemas, more useful as standalone documents, additionalProperties disallowed
#   X.Y.Z-local - relative references, useful to avoid the network dependency

declare -a arr=(
    master
    v1.14.0
    v1.13.5
    v1.13.4
    v1.13.3
    v1.13.2
    v1.13.1
    v1.13.0
    v1.12.6
    v1.12.5
    v1.12.4
    v1.12.3
    v1.12.2
    v1.12.1
    v1.12.0
    v1.11.9
    v1.11.8
    v1.11.7
    v1.11.6
    v1.11.5
    v1.11.4
    v1.11.3
    v1.11.2
    v1.11.1
    v1.11.0
    v1.10.9
    v1.10.8
    v1.10.7
    v1.10.6
    v1.10.5
    v1.10.4
    v1.10.3
    v1.10.2
    v1.10.1
    v1.10.0
    v1.9.8
    v1.9.7
    v1.9.6
    v1.9.5
    v1.9.4
    v1.9.3
    v1.9.2
    v1.9.1
    v1.9.0
    v1.8.13
    v1.8.12
    v1.8.11
    v1.8.10
    v1.8.9
    v1.8.8
    v1.8.7
    v1.8.6
    v1.8.5
    v1.8.4
    v1.8.3
    v1.8.2
    v1.8.1
    v1.8.0
    v1.7.16
    v1.7.15
    v1.7.14
    v1.7.13
    v1.7.12
    v1.7.11
    v1.7.10
    v1.7.9
    v1.7.8
    v1.7.7
    v1.7.6
    v1.7.5
    v1.7.4
    v1.7.3
    v1.7.2
    v1.7.1
    v1.7.0

    v1.6.13
    v1.6.12
    v1.6.11
    v1.6.10
    v1.6.9
    v1.6.8
    v1.6.7
    v1.6.6
    v1.6.5
    v1.6.4
    v1.6.3
    v1.6.2
    v1.6.1
    v1.6.0
    v1.5.8
    v1.5.7
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
prefix=https://kubernetesjsonschema.dev/${version}/_definitions.json

openapi2jsonschema -o "${version}-standalone-strict" --expanded --kubernetes --stand-alone --strict "${schema}"
openapi2jsonschema -o "${version}-standalone" --expanded --kubernetes --stand-alone "${schema}"
openapi2jsonschema -o "${version}-local" --expanded --kubernetes "${schema}"
openapi2jsonschema -o "${version}" --expanded --kubernetes --prefix "${prefix}" "${schema}"
openapi2jsonschema -o "${version}-standalone-strict" --kubernetes --stand-alone --strict "${schema}"
openapi2jsonschema -o "${version}-standalone" --kubernetes --stand-alone "${schema}"
openapi2jsonschema -o "${version}-local" --kubernetes "${schema}"
openapi2jsonschema -o "${version}" --kubernetes --prefix "${prefix}" "${schema}"
done
