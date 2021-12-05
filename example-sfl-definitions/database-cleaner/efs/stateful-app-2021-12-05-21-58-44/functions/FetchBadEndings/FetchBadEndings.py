import json

def lambda_handler(event, context):

    ###statics initializer
    clean = bool(event["clean"])
    cleanAll = bool(event["cleanAll"])
    badEndingList = str(event["badEndingList"])
    foundEntries = str(event["foundEntries"])
    selectedEntries = str(event["selectedEntries"])
    countBadEntries = int(event["countBadEntries"])
    ###statics initializer end

    
    #mockup get malicious list
    badEndingList = "forbidden.com, xyz.com, bad.eu"
        

    ###statics assigner
    return {
        "clean": bool(clean),
        "cleanAll": bool(cleanAll),
        "badEndingList": str(badEndingList),
        "foundEntries": str(foundEntries),
        "selectedEntries": str(selectedEntries),
        "countBadEntries": int(countBadEntries),
    }
    ###statics assigner end