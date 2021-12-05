import fcntl
import boto3
import json
import os

def get_statics():
    dynamodb = boto3.resource('dynamodb', region_name='eu-central-1')

    table = os.environ.get('DynamoDBGlobalTableRef')

    table_ref = dynamodb.Table(table)

    response = table_ref.get_item(Key={
        'variables': "s",
    })
    return json.loads(response['Item']['aVariable'])

def lambda_handler(event, context):

    ###statics initializer
    s = str(event["Input"]["s"])
    ###statics initializer end

    s = get_statics()

    ###statics assigner
    return str(s)
    ###statics assigner end