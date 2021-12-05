package inlines;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.LambdaLogger;

public class IFCalcAssigna804b1c710664ba88650ad574ea2b72e implements RequestHandler<HandlerObject, HandlerObject> {

    @Override
    public HandlerObject handleRequest(final HandlerObject event, final Context context) {
        final double d = event.getX() + 1;
        event.setD(d);
        return event;
    }
}
