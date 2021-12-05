import json

def lambda_handler(event, context):

    ###statics initializer
    x = int(event["x"])
    d = float(event["d"])
    s = str(event["s"])
    ###statics initializer end

    
    if s == "zero":
        s = "one"
    elif s == "one":
        s = "two"
    elif s == "two":
        s = "three"
    elif s == "three":
        s = "four"
    elif s == "four":
        s = "five"
    elif s == "five":
        s = "six"
    elif s == "six":
        s = "seven"
    elif s == "seven":
        s = "eight"
    elif s == "eight":
        s = "nine"
    elif s == "nine":
        s = "ten"
        

    ###statics assigner
    return {
        "x": int(x),
        "d": float(d),
        "s": str(s),
    }
    ###statics assigner end