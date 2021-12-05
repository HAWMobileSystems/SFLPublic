import fcntl
import boto3
import json
import os

def set_token(table, token):
    dynamodb = boto3.resource('dynamodb', region_name='eu-central-1')

    table_ref = dynamodb.Table(table)

    response = table_ref.update_item(
        Key={
            'function': 'WaitForProceed'
        },
        UpdateExpression='SET wrapperToken = :newWrapperToken',
        ExpressionAttributeValues={
            ':newWrapperToken': token
        },
        ReturnValues="UPDATED_NEW"
    )

def set_statics(table, statics):
    dynamodb = boto3.resource('dynamodb', region_name='eu-central-1')

    table_ref = dynamodb.Table(table)

    response = table_ref.update_item(
        Key={
            'function': 'WaitForProceed'
        },
        UpdateExpression='SET statics = :newStaticsJson',
        ExpressionAttributeValues={
            ':newStaticsJson': json.dumps(statics)
        },
        ReturnValues="UPDATED_NEW"
    )

def lambda_handler(event, context):

    set_statics(event["DynamoDBFunctionTableRef"], event["Input"])
    set_token(event["DynamoDBFunctionTableRef"], event["taskToken"])

