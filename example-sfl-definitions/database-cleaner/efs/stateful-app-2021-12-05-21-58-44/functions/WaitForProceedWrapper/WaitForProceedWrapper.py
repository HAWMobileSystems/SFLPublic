import fcntl
import boto3
import json
import os

TOKEN_FOLDER_PATH = '/mnt/statics/WaitForProceed/token'

TOKEN_FILE_PATH = '/mnt/statics/WaitForProceed/token/taskToken'

def set_token(token):
    try:
        if not os.path.exists(TOKEN_FOLDER_PATH):
            os.makedirs(TOKEN_FOLDER_PATH)

        with open(TOKEN_FILE_PATH, 'w') as token_file:
            fcntl.flock(token_file, fcntl.LOCK_EX)
            token_file.write(token)
            fcntl.flock(token_file, fcntl.LOCK_UN)
    except Exception as err:
        raise err

STATICS_FOLDER_PATH = '/mnt/statics/WaitForProceed/statics'

STATICS_FILE_PATH = '/mnt/statics/WaitForProceed/statics/statics'

def set_statics(statics):
    try:
        if not os.path.exists(STATICS_FOLDER_PATH):
            os.makedirs(STATICS_FOLDER_PATH)

        with open(STATICS_FILE_PATH, 'w') as statics_file:
            fcntl.flock(statics_file, fcntl.LOCK_EX)
            json.dump(statics, statics_file)
            fcntl.flock(statics_file, fcntl.LOCK_UN)
    except Exception as err:
        raise err

def lambda_handler(event, context):

    set_statics(event["Input"])
    set_token(event["taskToken"])

