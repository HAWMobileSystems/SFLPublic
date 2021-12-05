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

    
    #mockup compare database entries with malicious list
    #getAllIdsWhichMatch()
    import random
    num_list = random.sample(range(0, 200), random.randint(5, 15))
    foundEntries = ",".join(map(str, num_list))
        

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