package dkconnexus;

import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.google.common.base.Joiner;
import com.googlecode.objectify.ObjectifyFactory;

@Entity
public class EmailTime{
	@Id 
	public long Id;
	static {
		 ObjectifyService.register(EmailTime.class);
	}
	public String EmailFreq;
}
