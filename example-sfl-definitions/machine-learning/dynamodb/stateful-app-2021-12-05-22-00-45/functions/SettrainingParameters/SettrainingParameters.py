import fcntl
import boto3
import json
import os

def set_statics(variable):
    table = os.environ.get('DynamoDBGlobalTableRef')
    dynamodb = boto3.resource('dynamodb', region_name='eu-central-1')

    table_ref = dynamodb.Table(table)

    response = table_ref.update_item(
        Key={
            'variables': 'trainingParameters'
        },
        UpdateExpression='SET aVariable = :newStaticsJson',
        ExpressionAttributeValues={
            ':newStaticsJson': json.dumps(variable)
        },
        ReturnValues="UPDATED_NEW"
    )

def lambda_handler(event, context):

    ###statics initializer
    trainingParameters = str(event["Input"]["trainingParameters"])
    ###statics initializer end

    set_statics(trainingParameters)

    ###statics assigner
    return str(trainingParameters)
    ###statics assigner end