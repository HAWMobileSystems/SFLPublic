package inlines;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.LambdaLogger;

public class IFCalcAssign6d34257952af4109b9bd3d82d87f9ce4 implements RequestHandler<HandlerObject, HandlerObject> {

    @Override
    public HandlerObject handleRequest(final HandlerObject event, final Context context) {
        final double d = event.getX() + 1;
        event.setD(d);
        return event;
    }
}
