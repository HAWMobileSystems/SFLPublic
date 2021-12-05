import fcntl
import os
import boto3
import json

def get_token():
    dynamodb = boto3.resource('dynamodb', region_name='eu-central-1')

    table = os.environ.get('DynamoDBFunctionTableRef')

    table_ref = dynamodb.Table(table)

    response = table_ref.get_item(Key={
        'function': "WaitForProceed",
    })
    return response['Item']['wrapperToken']

def get_statics():
    dynamodb = boto3.resource('dynamodb', region_name='eu-central-1')

    table = os.environ.get('DynamoDBFunctionTableRef')

    table_ref = dynamodb.Table(table)

    response = table_ref.get_item(Key={
        'function': "WaitForProceed",
    })
    return json.loads(response['Item']['statics'])

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