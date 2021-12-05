import fcntl
import boto3
import json
import os

STATICS_FOLDER_PATH = '/mnt/statics/variables'

STATICS_FILE_PATH = '/mnt/statics/variables/d'

def set_statics(variable):
    try:
        if not os.path.exists(STATICS_FOLDER_PATH):
            os.makedirs(STATICS_FOLDER_PATH)

        with open(STATICS_FILE_PATH, 'w') as statics_file:
            fcntl.flock(statics_file, fcntl.LOCK_EX)
            json.dump(variable, statics_file)
            fcntl.flock(statics_file, fcntl.LOCK_UN)
    except Exception as err:
        raise err

def lambda_handler(event, context):

    ###statics initializer
    d = float(event["Input"]["d"])
    ###statics initializer end

    set_statics(d)

    ###statics assigner
    return float(d)
    ###statics assigner end