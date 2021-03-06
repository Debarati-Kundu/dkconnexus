package dkconnexus;

import java.util.Date;

import com.google.common.base.Joiner;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity
public class ConnexusImage implements Comparable<ConnexusImage> {

	@Id
	public Long id;
	public Long streamId;
	public String comments;
	public String bkUrl;
	public Date createDate;

	@SuppressWarnings("unused")
	private ConnexusImage() {
	}

	public ConnexusImage(Long streamId, String user, String content, String bkUrl) {
		this.streamId = streamId;
		this.bkUrl = bkUrl;
		this.comments = content;
		createDate = new Date();
	}
	
	@Override
	public String toString() {
		// Joiner is from google Guava (Java utility library), makes the toString method a little cleaner
		Joiner joiner = Joiner.on(":");
		System.out.println(id);
		System.out.println(streamId);
		System.out.println(bkUrl);
		System.out.println(createDate.toString());
		return joiner.join(id.toString(), streamId, comments, bkUrl==null ? "null" : bkUrl, createDate.toString());
	}

	// Need this for sorting images by date
	@Override
	public int compareTo(ConnexusImage other) {
		if (createDate.after(other.createDate)) {
			return 1;
		} else if (createDate.before(other.createDate)) {
			return -1;
		}
		return 0;
	}
	
}
