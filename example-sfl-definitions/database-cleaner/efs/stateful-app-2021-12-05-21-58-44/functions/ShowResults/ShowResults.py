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

    
    #mockup show foundEntries as selectable mail addresses list and the total count of malicious emails
    #showOnWebPage()
    countBadEntries = len(foundEntries.split(','))
        

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