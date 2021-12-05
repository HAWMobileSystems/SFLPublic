package inlines;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.LambdaLogger;

public class IFCalcAssignbda25cb68e8f43dcbad7f6bac21f3fb4 implements RequestHandler<HandlerObject, HandlerObject> {

    @Override
    public HandlerObject handleRequest(final HandlerObject event, final Context context) {
        final double d = event.getX() + 1;
        event.setD(d);
        return event;
    }
}
