import json

def lambda_handler(event, context):

    ###statics initializer
    dataExists = bool(event["dataExists"])
    databaseName = str(event["databaseName"])
    trainingParameters = str(event["trainingParameters"])
    trainingResults = str(event["trainingResults"])
    ###statics initializer end

    #...    

    ###statics assigner
    return {
        "dataExists": bool(dataExists),
        "databaseName": str(databaseName),
        "trainingParameters": str(trainingParameters),
        "trainingResults": str(trainingResults),
    }
    ###statics assigner end