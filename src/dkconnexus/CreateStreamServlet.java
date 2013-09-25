package dkconnexus;

import java.io.IOException;
import javax.servlet.http.*;
import java.util.HashSet;
import java.util.LinkedList;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import static com.googlecode.objectify.ObjectifyService.ofy;

// Backs up create.jsp form submission. Trivial since there's no image uploaded, just a URL
@SuppressWarnings("serial")
public class CreateStreamServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		
		UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();
        
        String tags = req.getParameter("tags"); 
        String subs = req.getParameter("subs"); 
        
		Stream s = new Stream(req.getParameter("streamName"), user.getEmail(),
				/*req.getParameter("tags"),*/ req.getParameter("url"));
		
		s.subscribers = new LinkedList<String>();
		s.tags = new HashSet<String>();
		System.out.println("Hello2");
        for (String tag : tags.split("#")) { 
			tag = tag.replace(" ", ""); 
	    	s.tags.add(tag);
		} 
        for (String sub : subs.split(",")) { 
			sub = sub.replace(" ", ""); 
			if(!s.subscribers.contains(sub))
				s.subscribers.add(sub);
		} 
        System.out.println("Hello1");
		// persist to datastore
		ofy().save().entity(s).now();
		resp.sendRedirect("/view_stream.jsp");
		System.out.println("Hello3");
	}
}