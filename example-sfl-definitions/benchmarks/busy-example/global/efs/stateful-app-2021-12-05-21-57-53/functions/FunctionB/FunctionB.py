import json

def lambda_handler(event, context):

    ###statics initializer
    x = int(event["x"])
    d = float(event["d"])
    s = str(event["s"])
    ###statics initializer end

    
    i = 0
    while i < 1_000_000 :
        i += 1
    
    d = d + 0.5
        

    ###statics assigner
    return {
        "x": int(x),
        "d": float(d),
        "s": str(s),
    }
    ###statics assigner end