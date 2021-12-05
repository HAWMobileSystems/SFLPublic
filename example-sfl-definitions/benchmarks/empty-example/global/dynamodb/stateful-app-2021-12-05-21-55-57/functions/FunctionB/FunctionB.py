import json

def lambda_handler(event, context):

    ###statics initializer
    x = int(event["x"])
    d = float(event["d"])
    s = str(event["s"])
    ###statics initializer end

    
    d = d + 0.5
        

    ###statics assigner
    return {
        "x": int(x),
        "d": float(d),
        "s": str(s),
    }
    ###statics assigner end