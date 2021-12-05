import fcntl
import boto3
import json
import os

def get_statics():
    dynamodb = boto3.resource('dynamodb', region_name='eu-central-1')

    table = os.environ.get('DynamoDBGlobalTableRef')

    table_ref = dynamodb.Table(table)

    response = table_ref.get_item(Key={
        'variables': "d",
    })
    return json.loads(response['Item']['aVariable'])

def lambda_handler(event, context):

    ###statics initializer
    d = float(event["Input"]["d"])
    ###statics initializer end

    d = get_statics()

    ###statics assigner
    return float(d)
    ###statics assigner end