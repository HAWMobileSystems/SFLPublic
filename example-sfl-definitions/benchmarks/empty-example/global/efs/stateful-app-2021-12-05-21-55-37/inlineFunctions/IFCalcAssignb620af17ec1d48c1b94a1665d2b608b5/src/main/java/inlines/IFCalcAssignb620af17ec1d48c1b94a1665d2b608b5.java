package inlines;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.LambdaLogger;

public class IFCalcAssignb620af17ec1d48c1b94a1665d2b608b5 implements RequestHandler<HandlerObject, HandlerObject> {

    @Override
    public HandlerObject handleRequest(final HandlerObject event, final Context context) {
        final double d = event.getX() + 1;
        event.setD(d);
        return event;
    }
}
