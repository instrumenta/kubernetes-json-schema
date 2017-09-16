import json
import glob

from jsonschema import validate
import pytest


@pytest.fixture(scope='module', params=glob.glob('schemas/*.json'))
def metaschema(request):
    with open(request.param) as schema_data:
        schema = json.load(schema_data)
    return schema


@pytest.mark.parametrize('path', glob.glob('v[0-9].*/*.json'))
def test_valid_jsonschema(metaschema, path):
    with open(path) as data:
        resource = json.load(data)
    validate(resource, metaschema)
