import fcntl
import boto3
import json
import os

STATICS_FILE_PATH = '/mnt/statics/variables/x'

def get_statics():
    try:
        with open(STATICS_FILE_PATH, 'r') as statics_file:
            fcntl.flock(statics_file, fcntl.LOCK_SH)
            data = json.load(statics_file)
            fcntl.flock(statics_file, fcntl.LOCK_UN)
        return data
    except Exception as err:
        raise err

def lambda_handler(event, context):

    ###statics initializer
    x = int(event["Input"]["x"])
    ###statics initializer end

    x = get_statics()

    ###statics assigner
    return int(x)
    ###statics assigner end