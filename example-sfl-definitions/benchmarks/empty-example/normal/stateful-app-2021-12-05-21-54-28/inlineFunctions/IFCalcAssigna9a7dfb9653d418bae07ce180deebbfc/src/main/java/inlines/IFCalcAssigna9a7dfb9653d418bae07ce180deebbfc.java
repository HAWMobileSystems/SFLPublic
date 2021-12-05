package inlines;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.LambdaLogger;

public class IFCalcAssigna9a7dfb9653d418bae07ce180deebbfc implements RequestHandler<HandlerObject, HandlerObject> {

    @Override
    public HandlerObject handleRequest(final HandlerObject event, final Context context) {
        final double d = event.getX() + 1;
        event.setD(d);
        return event;
    }
}
