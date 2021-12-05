import fcntl
import os
import boto3
import json

TOKEN_FILE_PATH = '/mnt/statics/WaitForProceed/token/taskToken'

def get_token():
    try:
        with open(TOKEN_FILE_PATH, 'r') as token_file:
            fcntl.flock(token_file, fcntl.LOCK_SH)
            token_binary = token_file.read()
            fcntl.flock(token_file, fcntl.LOCK_UN)
        return str(token_binary).split("\n")[0]
    except Exception as err:
        raise err

STATICS_FILE_PATH = '/mnt/statics/WaitForProceed/statics/statics'

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
    statics = get_statics()
    clean = bool(statics["clean"])
    cleanAll = bool(statics["cleanAll"])
    badEndingList = str(statics["badEndingList"])
    foundEntries = str(statics["foundEntries"])
    selectedEntries = str(statics["selectedEntries"])
    countBadEntries = int(statics["countBadEntries"])
    ###statics initializer end

    
    #passthrough inserted information from the lambda event parameter
    clean = bool(event["clean"])
    cleanAll = bool(event["cleanAll"])
    selectedEntries = str(event["selectedEntries"])
        

    ###statics assigner
    outputJson = {
        "clean": bool(clean),
        "cleanAll": bool(cleanAll),
        "badEndingList": str(badEndingList),
        "foundEntries": str(foundEntries),
        "selectedEntries": str(selectedEntries),
        "countBadEntries": int(countBadEntries),
    }

    boto3.client('stepfunctions').send_task_success(
        taskToken=get_token(),
        output=json.dumps(outputJson)
    )
    ###statics assigner end