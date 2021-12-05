import json

def lambda_handler(event, context):

    ###statics initializer
    x = int(event["x"])
    d = float(event["d"])
    s = str(event["s"])
    ###statics initializer end

    x = x + 1

    ###statics assigner
    return {
        "x": int(x),
        "d": float(d),
        "s": str(s),
    }
    ###statics assigner end